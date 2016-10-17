package com.hrofirst.util;

import java.util.Arrays;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;
import javax.crypto.spec.IvParameterSpec;

import org.apache.commons.codec.binary.Base64;


/**
 * 
 * @project mdos
 * @author huangzb
 * @company ShenZhen Montnets Technology CO.,LTD.
 * @datetime 2015-3-1 上午11:42:12
 * @description 通信协议加解密。消息的加密算法：Base64(DES(MD5(消息体)+消息体))。密钥，系统生成的密钥为24位的Base64字符，由两部分构成：12位Key(密钥密码
 *              )＋12位的IV(初始化向量)。
 */

public class TripleDES {

  // 算法名称
  public static final String KEY_ALGORITHM = "DESede";
  // 算法名称/加密模式/填充方式
  public static final String CIPHER_MODE = "DESede/CBC/PKCS5Padding";

  public static String encryptString(String message, String key, String vi) throws Exception {

    if (message == null || message.length() == 0) {
      throw new IllegalArgumentException("传入message参数不正确。");
    } else if (key == null || key.length() == 0) {
      throw new IllegalArgumentException("传入key参数不正确。");
    }

    byte[] keyArray = key.getBytes();
    String s = message;

    Cipher cipher = Cipher.getInstance(CIPHER_MODE);
    DESedeKeySpec deSedeKeySpec = new DESedeKeySpec(keyArray);
    SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(KEY_ALGORITHM);
    SecretKey secretKey = keyFactory.generateSecret(deSedeKeySpec);

    // 获取key后12位字节数组
    byte[] ivArray = vi.getBytes();
    IvParameterSpec iv = new IvParameterSpec(ivArray);
    cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);

    // DES加密后的字节数组
    byte[] encryptbyte = cipher.doFinal(s.getBytes("utf-8"));
    return Base64.encodeBase64String(encryptbyte);
  }

  public static byte[] getPaddedBytes(String s) throws java.io.UnsupportedEncodingException {
    int n = s.length();
    n = n + (8 - (n % 8));
    byte[] src = s.getBytes("UTF-8");
    byte[] dst = Arrays.copyOf(src, n);
    return dst;
  }

  public static String decryptString(String message, String key, String vi) throws Exception {

    if (message == null || message.length() == 0) {
      throw new IllegalArgumentException("传入message参数不正确。");
    } else if (key == null || key.length() == 0) {
      throw new IllegalArgumentException("传入key参数不正确。");
    }

    byte[] keyArray = key.getBytes();

    // 转为DES加密的字节数组
    byte[] bytesrc = Base64.decodeBase64(message);
    Cipher cipher = Cipher.getInstance(CIPHER_MODE);
    DESedeKeySpec deSedeKeySpec = new DESedeKeySpec(keyArray);
    SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(KEY_ALGORITHM);
    SecretKey secretKey = keyFactory.generateSecret(deSedeKeySpec);

    byte[] ivArray = vi.getBytes();
    IvParameterSpec iv = new IvParameterSpec(ivArray);
    cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);

    System.out.println("------------------" + secretKey);
    // 获取MD5加密+消息明文的字节数组
    byte[] retByte = cipher.doFinal(bytesrc);
    String r = new String(retByte);
    // 截取消息明文并返回
    return r;
  }

  public static byte[] getPaddedBytes(byte[] s) throws java.io.UnsupportedEncodingException {
    int n = s.length;
    n = n + (8 - (n % 8));
    byte[] dst = Arrays.copyOf(s, n);
    return dst;
  }

  public static void main(String[] args) {
    String key = "nih#328b2*323bhewh8@2b20";
    String iv = "j932(22o";
    try {
      // String encodeTxt = EncryptOrDecrypt.decryptString("/cp333tFHQs=", key, vi);
      // System.out.println(encodeTxt);
      // System.out.println(new String(Base64.decode(encodeTxt)));

      // String decodeText = EncryptOrDecrypt.decryptString("Ii6lIpzV4Y7N5LLBulITpQ==", key, vi);
      // System.out.println(new String(Base64.decode(decodeText)));
      System.out
          .println(TripleDES.encryptString("hello", key, iv));
      System.out
          .println(TripleDES.encryptString("我是袋袋", key, iv));
      //
      // System.out.println(EncryptOrDecrypt.decryptString(
      // EncryptOrDecrypt.encryptString("我是袋袋", "123456789009876543211234", "20160317"),
      // "123456789009876543211234", "20160317"));
      
      
      
      System.out.println(TripleDES.decryptString("g9CNozwDm4100EalsN1akg==", key, iv));//g9CNozwDm4100EalsN1akg==
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }
}
