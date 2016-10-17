package com.hrofirst.util;

import java.io.UnsupportedEncodingException;

import org.apache.commons.codec.binary.Base64;

public class SimpleTextEncryption {
  static int key = 65997; //密钥
  /**
   * 解密操作
   * @param encoded 密文
   * @return
   */
  public static String decrypt(String encoded) {
    byte[] encodedBytes = Base64.decodeBase64(encoded);
    byte[] decodeBytes = new byte[encodedBytes.length];
    for (int i = 0; i < encodedBytes.length; i++) {
      decodeBytes[i] = xorByte(encodedBytes[i]);
    }
    try {
      return new String(decodeBytes, "UTF-8");
    } catch (UnsupportedEncodingException e) {
      throw new RuntimeException(e);
    }
  }
 /**
 * 加密操作
 * @param plain 需加密字符串
 * @return
 */
  public static String encrypt(String plain) {
    String encoded = null;
    try {
      byte[] bytes = plain.getBytes("UTF-8");
      byte[] result = new byte[bytes.length];
      for (int i = 0; i < bytes.length; i++) {
        result[i] = xorByte(bytes[i]);
      }
      encoded = Base64.encodeBase64String(result);
    } catch (UnsupportedEncodingException e) {
      throw new RuntimeException(e);
    }
    return encoded;
  }

  static byte xorByte(byte b) {
    int intB = (int) b;
    int xor = key ^ intB;

    byte result = (byte) (0xff & xor);
    return result;
  }

  static void show(String text) {
    String encoded = encrypt(text);
    String decoded = decrypt(encoded);
    System.out.println("text: " + text + ", encoded: " + encoded + ", decoded: " + decoded);
  }

  public static void main(String[] args) {
    show("612301198208010019");
    show("410105198709280151");
    show("370784198009083200");
     

  }
}
