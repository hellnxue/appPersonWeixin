package com.hrofirst.util;

import java.io.IOException;
import java.net.URLDecoder;



import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;

public class HttpClientUtil {
	 private static Logger logger = LoggerFactory.getLogger(HttpClientUtil.class);    //日志记录
	 
	    /**
	     * httpPost
	     * @param url  路径
	     * @param jsonParam 参数
	     * @return
	     */
	    public static JSONObject httpPost(String url,JSONObject jsonParam){
	        return httpPost(url, jsonParam, false);
	    }
	 
	    /**
	     * post请求
	     * @param url         url地址
	     * @param jsonParam     参数
	     * @param noNeedResponse    不需要返回结果
	     * @return
	     */
	    public static JSONObject httpPost(String url,JSONObject jsonParam, boolean noNeedResponse){
	        //post请求返回结果
	        DefaultHttpClient httpClient = new DefaultHttpClient();
	        JSONObject jsonResult = null;
	        HttpPost method = new HttpPost(url);
	        try {
	            if (null != jsonParam) {
	                //解决中文乱码问题
	                StringEntity entity = new StringEntity(jsonParam.toString(), "utf-8");
	                entity.setContentEncoding("UTF-8");
	                entity.setContentType("application/json");
	                method.setEntity(entity);
	            }
	            HttpResponse result = httpClient.execute(method);
	            url = URLDecoder.decode(url, "UTF-8");
	            /**请求发送成功，并得到响应**/
	            if (result.getStatusLine().getStatusCode() == 200) {
	                String str = "";
	                try {
	                    /**读取服务器返回过来的json字符串数据**/
	                    str = EntityUtils.toString(result.getEntity());
	                    if (noNeedResponse) {
	                        return null;
	                    }
	                    /**把json字符串转换成json对象**/
	                    jsonResult = JSONObject.parseObject(str);
	                } catch (Exception e) {
	                    logger.error("post请求提交失败:" + url, e);
	                }
	            }
	        } catch (IOException e) {
	            logger.error("post请求提交失败:" + url, e);
	        }
	        return jsonResult;
	    }
}
