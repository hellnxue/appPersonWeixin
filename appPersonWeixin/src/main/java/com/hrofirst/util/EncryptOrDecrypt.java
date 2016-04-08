package com.hrofirst.util;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * 
 * @project mdos
 * @author huangzb
 * @company ShenZhen Montnets Technology CO.,LTD.
 * @datetime 2015-3-1 上午11:42:12
 * @description 通信协议加解密。消息的加密算法：Base64(DES(MD5(消息体)+消息体))。密钥，系统生成的密钥为24位的Base64字符，由两部分构成：12位Key(密钥密码)＋12位的IV(初始化向量)。
 */

public class EncryptOrDecrypt {
	
	// 算法名称    
    public static final String KEY_ALGORITHM = "DES";    
    // 算法名称/加密模式/填充方式
    public static final String CIPHER_MODE = "DES/CBC/PKCS5Padding";
	
	public static String encryptString(String message, String key, String vi) throws Exception {
		
		if(message == null || message.length() == 0){
			throw new IllegalArgumentException("传入message参数不正确。");
		}
		else if(key == null || key.length() == 0){
			throw new IllegalArgumentException("传入key参数不正确。");
		}

		byte[] keyArray = key.getBytes( );
		String s = message;
		
		Cipher cipher = Cipher.getInstance(CIPHER_MODE);
		DESKeySpec desKeySpec = new DESKeySpec(keyArray);
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(KEY_ALGORITHM);
		SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
		
		//获取key后12位字节数组
		byte[] ivArray = vi.getBytes( );
		IvParameterSpec iv = new IvParameterSpec(ivArray);
		cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);
		
		//DES加密后的字节数组
		byte[] encryptbyte = cipher.doFinal(s.getBytes("UTF-8"));
		BASE64Encoder base64Encoder = new BASE64Encoder();
		//转为Base64返回
		return base64Encoder.encode(encryptbyte);
	}

	public static String decryptString(String message, String key, String vi) throws Exception {
		
		if(message == null || message.length() == 0){
			throw new IllegalArgumentException("传入message参数不正确。");
		}
		else if(key == null || key.length() == 0){
			throw new IllegalArgumentException("传入key参数不正确。");
		}
		
		byte[] keyArray = key.getBytes();
		
		BASE64Decoder base64Decoder = new BASE64Decoder();
		//转为DES加密的字节数组
		byte[] bytesrc = base64Decoder.decodeBuffer(message);
		Cipher cipher = Cipher.getInstance(CIPHER_MODE);
		DESKeySpec desKeySpec = new DESKeySpec(keyArray);
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(KEY_ALGORITHM);
		SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
		
		byte[] ivArray = vi.getBytes();
		IvParameterSpec iv = new IvParameterSpec(ivArray);
		cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);
		
		System.out.println("------------------"+secretKey);
		//获取MD5加密+消息明文的字节数组
		byte[] retByte = cipher.doFinal(bytesrc);
		String r = new String(retByte);
		//截取消息明文并返回
		return r;
	}
	
	public static void main(String[] args) {
//		
//      try {
//			
//			
//			String mw=EncryptOrDecrypt.encryptString("我是袋袋", "123456789009876543211234", "20160317");
//			System.out.println(mw);
//			
//			String jm=EncryptOrDecrypt.decryptString(mw, "123456789009876543211234", "20160317");
//			System.out.println(jm);
//		
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		try {
			
			
			String mw=EncryptOrDecrypt.encryptString("我是袋袋", "nih#328b2*323bhewh8@2b20", "j932(22o");
			System.out.println(mw);
			
			String jm=EncryptOrDecrypt.decryptString(mw, "nih#328b2*323bhewh8@2b20", "j932(22o");
			System.out.println(jm);
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}