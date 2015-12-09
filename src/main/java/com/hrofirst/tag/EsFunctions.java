package com.hrofirst.tag;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
public class EsFunctions {
    private static final String QQ_LINK = "http://wpa.qq.com/msgrd?v=3&uin={0}&site=oicqzone.com&menu=yes";

    public static String qqFunction(String qq) {
        return QQ_LINK.replace("{0}", qq);
    }
}
