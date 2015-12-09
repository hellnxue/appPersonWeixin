package com.hrofirst.util;


import java.io.File;

public class ConstantsUtils {


    public static final String FORWARD = "forward:/";
    public static final String REDIRECT = "redirect:/";
    public static int DEPLOY_STATUS_PRODUCTION = 2;

    public static final String DEFAULT_PASSWORD = "123456";


    public static final String ANDROID_PUSH_MESSAGE_TITLE = "新任务";

    public static final String ANDROID_PUSH_MESSAGE_CONTENT_TASK = "您有新的任务消息，请更新";

    public static String IOS_CERTIFICATE_PATH = System.getProperty("amaze.root")
            + "WEB-INF" + File.separator + Config.getIosPushPath();

    public static String IOS_CERTIFICATE_PASSWORD = Config.getIosPushPassword();

    public static final String IOS_PUSH_MESSAGE_TITLE = ANDROID_PUSH_MESSAGE_TITLE;

    public static final String IOS_PUSH_MESSAGE_CONTENT_TASK = ANDROID_PUSH_MESSAGE_CONTENT_TASK;

    public static final String IOS_PUSH_MESSAGE_CONTENT_SCHEDULE = "您有新的排班消息，请更新！";

    public static final String ANDROID_PUSH_MESSAGE_CONTENT_MAIL = "您有新的内部消息，请查看！";
    public static final String IOS_PUSH_MESSAGE_CONTENT_MAIL = ANDROID_PUSH_MESSAGE_CONTENT_MAIL;

    public static final String CLOSED = "closed";
    public static final String OPEN = "open";
    public static final String EMPTY_STRING = "";
    public static final String STRING_SPLIT = ",";
    public static final int REST_IN_MINUTE = 30;

    // 版本升级相关
    public static final String ANDROID_VERSION = "android_version";
    public static final String ANDROID_HTTP = "android_http";
    public static final String IOS_VERSION = "ios_version";
    public static final String IOS_HTTP = "ios_http";
    // 迟到或早退
    public static final String DELAY_MINUTES = "delay_minutes";
    public static final String FORBID_SIGN_MINUTES = "forbid_sign_minutes";


    public static String COMMER = ",";
    public static final int PUSH_TYPE_SCHEDULE = 1;
    public static final int PUSH_TYPE_TASK = 2;
    public static final String PUSH_TYPE_KEY = "type";


    public static final int MAX_RECORD_SIGN_SHOW = 2;

    /**
     * 创建排班开始时间距离当时最小的小时数
     */

    public static final int DEFAULT_PAGE_COUNT = 10;

    public static final String MOBILE_ONLY = "mobileOnly";


}
