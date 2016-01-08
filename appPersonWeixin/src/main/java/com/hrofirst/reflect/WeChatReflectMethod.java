package com.hrofirst.reflect;

import com.alibaba.druid.util.Base64;
import com.fnst.es.common.utils.SpringUtils;
import com.github.sd4324530.fastweixin.message.TextMsg;
import com.github.sd4324530.fastweixin.message.req.ImageReqMsg;
import com.github.sd4324530.fastweixin.message.req.TextReqMsg;
import com.hrofirst.entity.WeChatUser;
import com.hrofirst.service.MenuService;
import com.hrofirst.service.WeChatService;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HTTP;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by qixb.fnst on 2015/03/23.
 */
public class WeChatReflectMethod {
    private static WeChatService weChatService = SpringUtils.getBean(WeChatService.class);
    private static MenuService menuService = SpringUtils.getBean(MenuService.class);
    private static final String isIDCard = "^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})([0-9]|X|x)$";
    private static final Pattern idcardPattern = Pattern.compile(isIDCard);
    private static final Logger log = LoggerFactory.getLogger(WeChatReflectMethod.class);
    private static final int MB = 1024 * 1024;
    
    @SuppressWarnings("unused")
	private static TextMsg bindIdCard(TextReqMsg msg) {
        TextMsg textMsg = new TextMsg();
        Subject currentUser = SecurityUtils.getSubject(); 
		Session session = currentUser.getSession();
		String apptype=(String)session.getAttribute("appType");
        WeChatUser wechat = weChatService.findWeChatUser(msg.getFromUserName(),apptype);
        if (wechat != null) {
            if (wechat.getIdCard() != null) {
                textMsg.addln("您的身份证号已经绑定,暂时不支持解绑功能").add("您的身份证号为：")
                        .add(wechat.getIdCard().toString()).addln();
            } else {
                Matcher matcher = idcardPattern.matcher(msg.getContent());
                if (matcher.find()) {
                    wechat.setIdCard(msg.getContent());
                    wechat = weChatService.save(wechat);
                    textMsg.addln("您的身份证号已经绑定").add("您的身份证号为：")
                            .add(msg.getContent()).addln();
                } else {
                    textMsg.addln("请输入正确的身份证号");
                }
            }
        }
        return textMsg;
    }

    private static final TextMsg errorUploadMsg = new TextMsg("您的图片上传失败！\ue40e");


    @SuppressWarnings("unused")
	private static TextMsg uploadImage(String url, ImageReqMsg msg) {
    	 Subject currentUser = SecurityUtils.getSubject(); 
 		Session session = currentUser.getSession();
 		String apptype=(String)session.getAttribute("appType");
        WeChatUser wechat = weChatService.findWeChatUser(msg.getFromUserName(),apptype);
        log.info("url:" + msg.getPicUrl());
        if (wechat == null) {
            return errorUploadMsg;
        }
        if (wechat.getIdCard() == null) {
            return new TextMsg("请先绑定您的身份证号！");
        }
        HttpClient httpclient = HttpClientBuilder.create().build();
        BasicHttpContext context = new BasicHttpContext();
        HttpGet httpGet = new HttpGet(msg.getPicUrl());
        byte[] bytes = new byte[MB];
        int length = 0;
        try {
            HttpResponse response = httpclient.execute(httpGet, context);
            InputStream is = response.getEntity().getContent();
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            while ((length = is.read(bytes, 0, MB)) > 0) {
                baos.write(bytes, 0, length);
            }

            bytes = baos.toByteArray();
        } catch (IOException ignored) {
        } finally {
            httpGet.releaseConnection();
        }
        //请求处理页面
        HttpPost httppost = new HttpPost(url);
        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("type", String.valueOf(wechat.getCurrentMenu())));
        params.add(new BasicNameValuePair("saction", "imgupload"));
        params.add(new BasicNameValuePair("certid", wechat.getIdCard()));
        String temp = Base64.byteArrayToBase64(bytes);
        params.add(new BasicNameValuePair("imgbyte", temp));
        try {
            //发出HTTP request
            httppost.setEntity(new UrlEncodedFormEntity(params, HTTP.UTF_8));
            HttpResponse httpResponse = httpclient.execute(httppost, context);
            bytes = new byte[(int) httpResponse.getEntity().getContentLength()];
            httpResponse.getEntity().getContent().read(bytes);
            String str = new String(bytes, "UTF-8");
            if (str.equals("success")) {
                return new TextMsg("您的").addLink("图片", msg.getPicUrl()).add("已成功上传\ue056");
            }
        } catch (UnsupportedEncodingException e) {
            log.error(e.getMessage(), e);
        } catch (ClientProtocolException e) {
            log.error(e.getMessage(), e);
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        } finally {
            httppost.releaseConnection();
        }
        return errorUploadMsg;
    }
}
