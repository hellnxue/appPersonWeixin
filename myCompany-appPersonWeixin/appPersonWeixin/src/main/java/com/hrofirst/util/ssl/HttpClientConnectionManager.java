package com.hrofirst.util.ssl;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.protocol.BasicHttpContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
@SuppressWarnings("deprecation")
public class HttpClientConnectionManager {
	private static final Logger LOG = LoggerFactory.getLogger(HttpClientConnectionManager.class);
	/**
	 * 获取SSL验证的HttpClient
	 * 
	 * @param httpClient
	 * @return
	 */
	public static HttpClient getSSLInstance(HttpClient httpClient) {
		ClientConnectionManager ccm = httpClient.getConnectionManager();
		SchemeRegistry sr = ccm.getSchemeRegistry();
		sr.register(new Scheme("https", MySSLSocketFactory.getInstance(), 443));
		httpClient = new DefaultHttpClient(ccm, httpClient.getParams());
		return httpClient;
	}
	
	/**
	 * 模拟浏览器post提交
	 * 
	 * @param url
	 * @return
	 */
	public static HttpPost getPostMethod(String url) {
		HttpPost pmethod = new HttpPost(url); // 设置响应头信息
		pmethod.addHeader("Connection", "keep-alive");
		pmethod.addHeader("Accept", "*/*");
		pmethod.addHeader("Content-Type",
				"application/x-www-form-urlencoded; charset=UTF-8");
		pmethod.addHeader("Host", "mp.weixin.qq.com");
		pmethod.addHeader("X-Requested-With", "XMLHttpRequest");
		pmethod.addHeader("Cache-Control", "max-age=0");
		pmethod.addHeader("User-Agent",
				"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0) ");
		return pmethod;
	}

	/**
	 * 模拟浏览器GET提交
	 * 
	 * @param url
	 * @return
	 */
	public static HttpGet getGetMethod(String url) {
		HttpGet pmethod = new HttpGet(url);
		// 设置响应头信息
		pmethod.addHeader("Connection", "keep-alive");
		pmethod.addHeader("Cache-Control", "max-age=0");
		pmethod.addHeader("User-Agent",
				"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0) ");
		pmethod.addHeader("Accept",
				"text/html,application/xhtml+xml,application/xml;q=0.9,*/;q=0.8");
		return pmethod;
	}

	/**
	 * get方式请求
	 * 
	 * @param url
	 *            请求url
	 * @param params
	 *            请求参数
	 * @return
	 */
	public static String getHttpGet(String url, Map<String, Object> params) {
		return getHttpRequest(url, params, 0);
	}

	/**
	 * post方式请求
	 * 
	 * @param url
	 *            请求url
	 * @param params
	 *            请求参数
	 * @return
	 */
	public static String getHttpPost(String url, Map<String, Object> params) {
		return getHttpRequest(url, params, 1);
	}

	/**
	 * 提交请求
	 * 
	 * @param url
	 *            请求url
	 * @param params
	 *            请求参数
	 * @param type
	 *            请求类型，0-get，1-post
	 * @return
	 */
	private static String getHttpRequest(String url,
			Map<String, Object> params, int type) {
		HttpClient client = HttpClientBuilder.create().build();
		// client = getSSLInstance(client);
		String paramsString = "";
		// 判断参数是否为空
		if (MapUtils.isNotEmpty(params)) {
			// 循环取参数的key、value并拼接成url后缀
			Set<Entry<String, Object>> entrySet = params.entrySet();
			for (Entry<String, Object> entry : entrySet) {
				paramsString += entry.getKey() + "=" + entry.getValue() + "&";
			}
		}
		// 判断拼接的url后缀是否为空，并进行处理使之符合正常的url
		if (StringUtils.isNotEmpty(paramsString)) {
			url += "?" + paramsString.substring(0, paramsString.length() - 1);
		}
		HttpResponse res = null;
		InputStream stream = null;
		try {
			if (type == 0) {
				HttpGet get = new HttpGet(url);
				res = client.execute(get, new BasicHttpContext());
			} else if (type == 1) {
				HttpPost post = new HttpPost(url);
				res = client.execute(post, new BasicHttpContext());
			} else {
				LOG.error("请求方式错误！");
				return "请求方式错误！";
			}
		} catch (ClientProtocolException e1) {
			e1.printStackTrace();
			LOG.error("返回的头文件中location值指向之前重复地址");
			return "返回的头文件中location值指向之前重复地址";
		} catch (IOException e1) {
			e1.printStackTrace();
			LOG.error("IO异常");
			return "IO异常";
		}
		try {
			int status = res.getStatusLine().getStatusCode();
			if (status==200) {
				stream = res.getEntity().getContent();
				String resString = inputStreamTOString(stream, "UTF-8");
				LOG.info(resString);
				return resString;
			}else if (status==404) {
				LOG.error("接口url错误");
				return "接口url错误";
			}else if (status==500) {
				LOG.error("代码异常");
				return "代码异常";
			}else {
				LOG.error("其他异常");
				return "其他异常";
			}
		} catch (IOException e) {
			e.printStackTrace();
			LOG.error("IO异常");
			return "IO异常";
		} finally {
			if (stream != null) {
				try {
					stream.close();
				} catch (IOException e) {
					e.printStackTrace();
					LOG.error("IO异常");
					return "IO异常";
				}
			}
		}
	}

	private static final int BUFFER_SIZE = 1024 * 1024;

	public static String inputStreamTOString(InputStream in, String encoding)
			throws IOException {

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
}
