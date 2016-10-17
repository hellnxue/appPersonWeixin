package com.hrofirst.util;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;

public class BaobeikejiClient {
  String uri ="http://tp.baobeikeji.cn/data/getData";// Config.getBaobeikejiUrl();//"http://tp.baobeikeji.cn/data/getData"公积金接口地址
  String key = "nih#328b2*323bhewh8@2b20";//"nih#328b2*323bhewh8@2b20";
  String iv = "j932(22o";//"j932(22o";
  
//青岛  10 天津 11 武汉 12 94814986300 105213

  public static void main(String[] args) throws Exception {
    BaobeikejiClient baobeikejiClient = new BaobeikejiClient();
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("sKey", "f05ebcc0eb47cfdd8d4aee4b584e0b7c");
    map.put("type", "10");
    map.put("cardNo", "110521859575");
    map.put("pwd", "456789");
    map.put("loginType", "1");
     map.put("idcard", "37142219900318602X");
   String result = baobeikejiClient.invoke(map);
    System.out.println(result);
  }

  public String invoke(Map<String, Object> paramter) throws Exception {

    Map<String, Object> result = null;
    
    String json = toJSON(paramter);
    String content = null;
    CloseableHttpClient httpclient = HttpClients.createDefault();
    HttpPost httpPost = new HttpPost(uri);
    List<NameValuePair> nvps = new ArrayList<NameValuePair>();
    nvps.add(new BasicNameValuePair("arguJson", TripleDES.encryptString(json, key, iv)));
    String response = null;
    try {
      httpPost.setEntity(new UrlEncodedFormEntity(nvps));
      CloseableHttpResponse response2 = httpclient.execute(httpPost);
      HttpEntity entity2 = response2.getEntity();
      response = EntityUtils.toString(entity2);
      response = TripleDES.decryptString(response, key, iv);
      result = toMap(response);

    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    return JSON.toJSONString(result);
  }

  public static String toJSON(Object object) {
    ObjectMapper mapper = new ObjectMapper();
    StringWriter writer = new StringWriter();
    try {
      mapper.writeValue(writer, object);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
    return writer.toString();
  }

  public static Map<String, Object> toMap(String json) {
    if (json == null) {
      return new HashMap<String, Object>();
    }
    ObjectMapper mapper = new ObjectMapper();
    try {
      JavaType javaType =
          mapper.getTypeFactory().constructParametrizedType(LinkedHashMap.class, Map.class,
              String.class, Object.class);
      return mapper.readValue(json, javaType);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
  }
  


}
