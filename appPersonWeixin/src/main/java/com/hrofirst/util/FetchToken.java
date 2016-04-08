package com.hrofirst.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class FetchToken {
  private String authUrl;
  private String clientId;
  private String clientSecret;

  public FetchToken(String authUrl, String clientId, String clientSecret) {
    this.clientId = clientId;
    this.clientSecret = clientSecret;
    this.authUrl = authUrl;
  }

  public Map<String, Object> fetch() throws Exception {
    String auth = clientId + ":" + clientSecret; // 拼接client id 及 client secret
    String encodedAuth = new String(Base64.encodeBase64(auth.getBytes())); // base64转码

    // 构建POST请求
    HttpPost httpost = new HttpPost(authUrl);
    httpost.addHeader("Content-Type", "application/x-www-form-urlencoded");

    // 添加Header 验证信息
    httpost.addHeader("Authorization", "Basic " + encodedAuth);

    // 添加BODY，固定值
    List<NameValuePair> formparams = new ArrayList<NameValuePair>();
    formparams.add(new BasicNameValuePair("grant_type", "client_credentials"));
    UrlEncodedFormEntity entity = new UrlEncodedFormEntity(formparams, "UTF-8");
    httpost.setEntity(entity);

    // 发送请求
    CloseableHttpClient httpclient = HttpClients.createDefault();
    HttpResponse response = httpclient.execute(httpost);

    // 打印返回值
    Map<String, Object> map = new HashMap<String, Object>();
    String resp = EntityUtils.toString(response.getEntity(), "UTF-8");
    if (StringUtils.isNotEmpty(resp)) {
      ObjectMapper mapper = new ObjectMapper();
      TypeReference<HashMap<String, Object>> typeRef =
          new TypeReference<HashMap<String, Object>>() {};
      map = mapper.readValue(resp, typeRef);
    }
    return map;
  }

  public static void main(String[] args) throws Exception {

  }

}
