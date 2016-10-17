package com.hrofirst.util;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.digest.DigestUtils;


/** 
 * 1、先排除参数中value为null、value=""、key为"sign"的参数
 * 2、将key按照首字母排序，通过&号拼接成字符串
 * 3、把字符串按照MD5加密，盐值为hfl-shop，默认编码格式UTF-8
 */
public class MD5Sign {

	private static final String INPUT_CHARSET = "UTF-8";

	/** 
	 * 除去数组中的空值和签名参数
	 * @param params 签名参数组
	 * @return 去掉空值与签名参数后的新签名参数组
	 */
	private static Map<String, String> paraFilter(Map<String, Object> params) {

		Map<String, String> result = new HashMap<String, String>();

		if (params.isEmpty())
			return result;

		for (String key : params.keySet()) {

			String value = (String) params.get(key);
			if (value == null || value.equals("") || key.equalsIgnoreCase("sign"))
				continue;
 
			result.put(key, value);
		}
		return result;
	}

	/** 
	 * 把数组所有元素排序，并按照“参数=参数值”的模式用“&”字符拼接成字符串
	 * @param params 需要排序并参与字符拼接的参数组
	 * @return 拼接后字符串
	 */
	private static String createLinkString(Map<String, String> params) {

		List<String> keys = new ArrayList<String>(params.keySet());
		Collections.sort(keys);

		String prestr = "";

		for (int i = 0; i < keys.size(); i++) {
			String key = keys.get(i);
			String value = (String) params.get(key);

			if (i == keys.size() - 1) {//拼接时，不包括最后一个&字符
				prestr = prestr + key + "=" + value;
			} else {
				prestr = prestr + key + "=" + value + "&";
			}
		}
		return prestr;
	}

	/**
	* 签名字符串
	* @param text 需要签名的字符串
	* @param key 密钥
	* @param input_charset 编码格式
	* @return 签名结果
	*/
	public static String sign(Map<String, Object> params, String key, String input_charset) {
		String text = createLinkString(paraFilter(params));
		text = text + key;
		return DigestUtils.md5Hex(getContentBytes(text, input_charset));
	}

	/**
	* 签名字符串
	* @param text 需要签名的字符串
	* @param key 密钥
	* @return 签名结果
	*/
	public static String sign(Map<String, Object> params, String key) {
		String text = createLinkString(paraFilter(params));
		text = text + key;
		return DigestUtils.md5Hex(getContentBytes(text, INPUT_CHARSET));
	}

	/**
	 * 签名字符串
	 * @param text 需要签名的字符串
	 * @param sign 签名结果
	 * @param key 密钥
	 * @param input_charset 编码格式
	 * @return 签名结果
	 */
	public static boolean verify(Map<String, Object> params, String sign, String key, String input_charset) {
		String text = createLinkString(paraFilter(params));
		text = text + key;
		String mysign = DigestUtils.md5Hex(getContentBytes(text, input_charset));
		if (mysign.equals(sign)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 签名字符串
	 * @param text 需要签名的字符串
	 * @param sign 签名结果
	 * @param key 密钥
	 * @return 签名结果
	 */
	public static boolean verify(Map<String, Object> params, String sign, String key) {
		String text = createLinkString(paraFilter(params));
		text = text + key;
		String mysign = DigestUtils.md5Hex(getContentBytes(text, INPUT_CHARSET));
		if (mysign.equals(sign)) {
			return true;
		} else {
			return false;
		}
	}

	private static byte[] getContentBytes(String content, String charset) {
		if (charset == null || "".equals(charset)) {
			return content.getBytes();
		}
		try {
			return content.getBytes(charset);
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("MD5签名过程中出现错误,指定的编码集不对,您目前指定的编码集是:" + charset);
		}
	}
}
