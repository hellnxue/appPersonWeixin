package com.hrofirst.util;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class RequestService {
  private String uri;
  private FetchToken fetchToken;

  public RequestService(String uri, FetchToken fetchToken) {
    this.uri = uri;
    this.fetchToken = fetchToken;
  }

  public Map<String, Object> invoke(String type, Object entity) throws Exception {

    // 构建POST请求
    HttpPost httpost = new HttpPost(uri);
    httpost.addHeader("Content-Type", "application/json");

    Map<String, Object> tokenInfo = fetchToken.fetch();

    // 添加Header 验证信息
    httpost.addHeader("Authorization", "Bearer " + tokenInfo.get("access_token"));

    // 添加BODY，固定值

    Map<String, Object> body = new HashMap<String, Object>();
    body.put("type", type);
    body.put("data", entity);

    ObjectMapper mapper = new ObjectMapper();
    String json = mapper.writeValueAsString(body);
    HttpEntity httpEntity = new StringEntity(json, "utf-8");
    httpost.setEntity(httpEntity);

    // 发送请求
    CloseableHttpClient httpclient = HttpClients.createDefault();
    HttpResponse response = httpclient.execute(httpost);

    // 打印返回值
    Map<String, Object> map = new HashMap<String, Object>();
    String resp = EntityUtils.toString(response.getEntity(), "UTF-8");
    if (StringUtils.isNotEmpty(resp)) {
      TypeReference<HashMap<String, Object>> typeRef =
          new TypeReference<HashMap<String, Object>>() {};
      map = mapper.readValue(resp, typeRef);
    }
    return map;
  }

  public static void main(String[] args) throws Exception {
    String server = "http://neice.ezhiyang.com";
    FetchToken fetchToken =
        new FetchToken(server + "/open/authorize", "aiyuangong",
            "02b06c0c-da69-44a6-ab15-4bf2e819ba57");
    RequestService requestService = new RequestService(server + "/open/rest", fetchToken);
    Map<String, Object> entity = new HashMap<String, Object>();
    entity.put("name", "Bing");
    Map<String, Object> result = requestService.invoke("uploadFileToEmp", entity);
    System.out.println(result);
  }
}
