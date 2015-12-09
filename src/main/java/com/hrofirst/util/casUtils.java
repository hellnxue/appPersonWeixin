package com.hrofirst.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HTTP;

import com.hrofirst.util.ssl.HttpClientConnectionManager;

/**
 * 
 * @ClassName: casUtils
 * @Description: 模拟CAS单点登录
 * @author hsx
 * @date 2015年6月26日 下午3:54:18
 */
public class casUtils {

	/**
	 * 对外接口，执行cas模拟登录，成功后把cas的CASTGC cookie，放入HttpServletResponse中
	 * @param response
	 * @param server
	 * @param username
	 * @param password
	 */
	public javax.servlet.http.Cookie processCASLogin(String server, String username, String password){
		
		Cookie cookie;
		try {
			cookie = getTicketGrantingTicket(server, username, password);

			if(cookie!=null){
				return convertToServletCookie(cookie);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public boolean processCASLogout(String server){
		
		try {
			DefaultHttpClient client;
			// 接受任何证书的浏览器客户端
			client = new DefaultHttpClient();
			client = (DefaultHttpClient) HttpClientConnectionManager
					.getSSLInstance(client);
			
			HttpPost post = new HttpPost(server.replaceAll("login", "logout"));

			HttpResponse response = client.execute(post);
			System.out.println(response.getEntity().getContent());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	private final int BUFFER_SIZE = 1024 * 1024;
	/**
	 * 流转换字符串
	 * @param in
	 * @param encoding
	 * @return
	 * @throws Exception
	 */
	private String inputStreamTOString(InputStream in, String encoding)
			throws Exception {

		ByteArrayOutputStream outStream = new ByteArrayOutputStream();
		byte[] data = new byte[BUFFER_SIZE];
		int count = -1;
		while ((count = in.read(data, 0, BUFFER_SIZE)) != -1)
			outStream.write(data, 0, count);

		data = null;
		String temp = new String(outStream.toByteArray(), encoding);
		outStream.close();
		return temp;
	}

	/**
	 * 使用提供server，cas参数(lt，execution)，用户名和密码，实行post操作，模拟CAS登录，返回CASTGC cookie值
	 * @param client
	 * @param server
	 * @param param
	 * @param username
	 * @param password
	 * @return
	 */
	private String doLogin(DefaultHttpClient client, String server, HashMap<String, String> param, String username, String password){
		
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("username", username));
		nvps.add(new BasicNameValuePair("password", password));
		nvps.add(new BasicNameValuePair("lt", param.get("lt")));
		nvps.add(new BasicNameValuePair("execution", param.get("execution")));
		nvps.add(new BasicNameValuePair("_eventId", "submit"));
		
		try {
			HttpPost post = new HttpPost(server);
			post.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));

			HttpResponse response = client.execute(post);
			
			Cookie cookie = getCookieValue(client, "CASTGC");
			if (cookie != null){
				response.getEntity().consumeContent();
				return "success";
			}
			
			InputStream stream = null;
			stream = response.getEntity().getContent();
			return inputStreamTOString(stream, "UTF-8");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
	
	/**
	 * 执行cas登录，获取CASTGC cookie
	 * @param server
	 * @param username
	 * @param password
	 * @return
	 * @throws IOException
	 */
	private Cookie getTicketGrantingTicket(final String server,
			final String username, final String password) throws IOException {
		
		DefaultHttpClient httpclient;
		// 接受任何证书的浏览器客户端
		httpclient = new DefaultHttpClient();
		httpclient = (DefaultHttpClient) HttpClientConnectionManager
				.getSSLInstance(httpclient);

		String content = doCasLogin(httpclient, server);
		
		
		for(int i=0; i<10; i++){
			HashMap<String, String> result = parse(content);
			content = doLogin(httpclient, server, result, username, password);
			
			if (content.equals("success") || content.indexOf("Log In Successful")>0){
				
				Cookie cookie = getCookieValue(httpclient, "CASTGC");
				if (cookie != null){
					return cookie;
				}
			}
		}
		return null;
	}

	/**
	 * 遍历httpclient中的cookie，查询指定名字的cookie值
	 * @param httpclient
	 * @param name
	 * @return
	 */
	private Cookie getCookieValue(DefaultHttpClient httpclient,
			String name) {
		List<Cookie> cookies = httpclient.getCookieStore().getCookies();
		if (cookies.isEmpty()) {
			return null;
		} else {
			for (int i = 0; i < cookies.size(); i++) {
				Cookie cookie = cookies.get(i);
				if (cookie.getName().equalsIgnoreCase(name)) {
					return cookie;
				}
			}
		}
		return null;
	}

	/**
	 * 分析文本，获取lt和execution值
	 * @param content
	 * @return
	 */
	private HashMap<String, String> parse(String content){
		String s = "<input type=\"hidden\" name=\"lt\" value=\"";
		String q = "<input type=\"hidden\" name=\"execution\" value=\"";
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		try{
			int index = content.indexOf(s);
			String s1 = content.substring(index + s.length());
			int index1 = s1.indexOf("\"");
			if (index1 != -1)
				map.put("lt", s1.substring(0, index1));
			
			int indexQ = content.indexOf(q);
			String s1Q = content.substring(indexQ + q.length());
			int indexQ1 = s1Q.indexOf("\"");
			if (indexQ1 != -1)
				map.put("execution", s1Q.substring(0, indexQ1));
			
		}catch(Exception e){
			e.printStackTrace();
		}

		return map;
	}
	
	/**
	 * 
	 * @param httpclient
	 * @param url
	 * @return
	 */
	private String doCasLogin(DefaultHttpClient httpclient, String url) {
		HashMap<String, String> result = new HashMap<String, String>();
		HttpGet httpget = new HttpGet(url);
		HttpResponse response;
		try {
			response = httpclient.execute(httpget);
			InputStream stream = null;
			stream = response.getEntity().getContent();
			return inputStreamTOString(stream, "UTF-8");
			
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}	
	
	/**
	 * 执行cookie类型转换
	 * @param cookie
	 * @return
	 */
	private javax.servlet.http.Cookie convertToServletCookie(Cookie cookie) {
		javax.servlet.http.Cookie retCookie = new javax.servlet.http.Cookie(
				cookie.getName(), cookie.getValue());
//		retCookie.setComment(cookie.getComment());
		retCookie.setDomain(cookie.getDomain());
//		retCookie.setSecure(false);
		retCookie.setPath(cookie.getPath());
//		retCookie.setVersion(cookie.getVersion());
//		retCookie.setMaxAge((int) ((cookie.getExpiryDate().getTime() - System
//				.currentTimeMillis()) / 1000));
		return retCookie;
	}
}
