/*
 * Copyright © 2014 FNST Co., Ltd. All Rights Reserved.
 */

package com.hrofirst.push;

import com.alibaba.fastjson.JSON;
import com.baidu.yun.channel.auth.ChannelKeyPair;
import com.baidu.yun.channel.client.BaiduChannelClient;
import com.baidu.yun.channel.exception.ChannelClientException;
import com.baidu.yun.channel.exception.ChannelServerException;
import com.baidu.yun.channel.model.*;
import com.baidu.yun.core.log.YunLogEvent;
import com.baidu.yun.core.log.YunLogHandler;
import com.hrofirst.util.Config;
import org.apache.log4j.Logger;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by qixb.fnst on 2014/10/08.
 */
public class PushUtils {
    private final static String apiKey = Config.getBaeApiKey();
    private final static String secretKey = Config.getBaeSecretKey();
    private final static ChannelKeyPair pair = new ChannelKeyPair(apiKey, secretKey);
    private static Logger logger = Logger.getLogger(PushUtils.class);

    public static List<BindInfo> queryBindInfo(String userName) {
        BaiduChannelClient channelClient = new BaiduChannelClient(pair);

        // 3. 若要了解交互细节，请注册YunLogHandler类
        channelClient.setChannelLogHandler(new YunLogHandler() {
            @Override
            public void onHandle(YunLogEvent event) {
                logger.info(event.getMessage());
            }
        });
        try {
            // 4. 创建请求类对象
            // 手机端的UserId， 先用1111111111111代替，用户需替换为自己的
            QueryBindListRequest request = new QueryBindListRequest();
            request.setUserId(userName);

            // 5. 调用queryBindList接口
            QueryBindListResponse response = channelClient
                    .queryBindList(request);

            // 6. 对返回的结果对象进行操作
            return response.getBinds();

        } catch (ChannelClientException e) {
            // 处理客户端错误异常
            logger.error(PushUtils.class, e);
        } catch (ChannelServerException e) {
            // 处理服务端错误异常
            logger.error(String.format(
                    "request_id: %d, error_code: %d, error_message: %s",
                    e.getRequestId(), e.getErrorCode(), e.getErrorMsg()));
        }
        return null;
    }

    public static boolean sendToUser(Device device, String message, PushType pushType) {
       /* if (user.getDeviceToken() == null) return false;
        if (user.getChannelId() == null) {
            List<BindInfo> bindInfos = queryBindInfo(user.getDeviceToken());
            return !(bindInfos == null || bindInfos.size() == 0) &&
                    sendToUser(device, bindInfos.get(0).getChannelId(), user.getDeviceToken(), message, pushType);
        } else {
            return sendToUser(device, user.getChannelId(), user.getDeviceToken(), message, pushType);
        }*/
        return false;

    }

    public static boolean sendToUser(Device device, long channelId, String userId, String message, PushType pushType) {
        // 2. 创建BaiduChannelClient对象实例
        BaiduChannelClient channelClient = new BaiduChannelClient(pair);

        // 3. 若要了解交互细节，请注册YunLogHandler类
        channelClient.setChannelLogHandler(new YunLogHandler() {
            @Override
            public void onHandle(YunLogEvent event) {
                logger.info(event.getMessage());
            }
        });

        try {

            // 4. 创建请求类对象
            // 手机端的ChannelId， 手机端的UserId， 先用1111111111111代替，用户需替换为自己的
            PushUnicastMessageRequest request = new PushUnicastMessageRequest();
            request.setDeviceType(device.getValue()); // device_type => 1: web 2: pc 3:android
            // 4:ios 5:wp
            if (device.equals(Device.Ios)) {
                request.setDeployStatus(Config.getIosDeployStatus()); // DeployStatus => 1: Developer 2:
                // Production
            }
            request.setChannelId(channelId);
            request.setUserId(userId);
            BaiduPushMessage push = new BaiduPushMessage();
            push.setTitle(Config.getMessageTitle());
            push.setDescription(message);
            Map<String, String> map = new HashMap<String, String>(1);
            push.setCustom_content(map);
            message = JSON.toJSONString(push);
            request.setMessageType(Config.getBaiduPushType());
            request.setMessage(message);

            // 5. 调用pushMessage接口
            PushUnicastMessageResponse response = channelClient
                    .pushUnicastMessage(request);

            // 6. 认证推送成功
            logger.info("push amount : " + response.getSuccessAmount());

        } catch (ChannelClientException e) {
            // 处理客户端错误异常
            logger.error(PushUtils.class, e);
            return false;
        } catch (ChannelServerException e) {
            // 处理服务端错误异常
            logger.error(String.format(
                    "request_id: %d, error_code: %d, error_message: %s",
                    e.getRequestId(), e.getErrorCode(), e.getErrorMsg()));
            return false;
        }
        return true;
    }

    public enum Device {
        Web(1), Pc(2), Android(3), Ios(4), Wp(5);
        private int value;

        private Device(int value) {
            this.value = value;
        }

        public int getValue() {
            return value;
        }
    }

    public enum PushType {
        Schedule(1), Task(2), Mail(3),Task_Finished(4);
        private int value;

        private PushType(int value) {
            this.value = value;
        }

        public int getValue() {
            return value;
        }
    }

    public static class BaiduPushMessage {
        private String title;
        private String description;
        private Integer notification_builder_id;
        private Integer notification_basic_style;
        private Integer open_type;
        private Integer net_support;
        private Integer user_confirm;
        private Integer url;
        private String pkg_content;
        private String pkg_name;
        private String pkg_version;
        private Map<String, String> custom_content;

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public Integer getNotification_builder_id() {
            return notification_builder_id;
        }

        public void setNotification_builder_id(Integer notification_builder_id) {
            this.notification_builder_id = notification_builder_id;
        }

        public Integer getNotification_basic_style() {
            return notification_basic_style;
        }

        public void setNotification_basic_style(Integer notification_basic_style) {
            this.notification_basic_style = notification_basic_style;
        }

        public Integer getOpen_type() {
            return open_type;
        }

        public void setOpen_type(Integer open_type) {
            this.open_type = open_type;
        }

        public Integer getNet_support() {
            return net_support;
        }

        public void setNet_support(Integer net_support) {
            this.net_support = net_support;
        }

        public Integer getUser_confirm() {
            return user_confirm;
        }

        public void setUser_confirm(Integer user_confirm) {
            this.user_confirm = user_confirm;
        }

        public Integer getUrl() {
            return url;
        }

        public void setUrl(Integer url) {
            this.url = url;
        }

        public String getPkg_content() {
            return pkg_content;
        }

        public void setPkg_content(String pkg_content) {
            this.pkg_content = pkg_content;
        }

        public String getPkg_name() {
            return pkg_name;
        }

        public void setPkg_name(String pkg_name) {
            this.pkg_name = pkg_name;
        }

        public String getPkg_version() {
            return pkg_version;
        }

        public void setPkg_version(String pkg_version) {
            this.pkg_version = pkg_version;
        }

        public Map<String, String> getCustom_content() {
            return custom_content;
        }

        public void setCustom_content(Map<String, String> custom_content) {
            this.custom_content = custom_content;
        }
    }
}
