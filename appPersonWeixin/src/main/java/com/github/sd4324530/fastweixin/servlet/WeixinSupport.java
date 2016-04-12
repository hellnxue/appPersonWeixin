package com.github.sd4324530.fastweixin.servlet;

import com.github.sd4324530.fastweixin.handle.EventHandle;
import com.github.sd4324530.fastweixin.handle.MessageHandle;
import com.github.sd4324530.fastweixin.message.BaseMsg;
import com.github.sd4324530.fastweixin.message.TextMsg;
import com.github.sd4324530.fastweixin.message.aes.AesException;
import com.github.sd4324530.fastweixin.message.aes.WXBizMsgCrypt;
import com.github.sd4324530.fastweixin.message.req.BaseEvent;
import com.github.sd4324530.fastweixin.message.req.BaseReq;
import com.github.sd4324530.fastweixin.message.req.BaseReqMsg;
import com.github.sd4324530.fastweixin.message.req.ImageReqMsg;
import com.github.sd4324530.fastweixin.message.req.LinkReqMsg;
import com.github.sd4324530.fastweixin.message.req.LocationEvent;
import com.github.sd4324530.fastweixin.message.req.LocationReqMsg;
import com.github.sd4324530.fastweixin.message.req.MenuEvent;
import com.github.sd4324530.fastweixin.message.req.QrCodeEvent;
import com.github.sd4324530.fastweixin.message.req.TextReqMsg;
import com.github.sd4324530.fastweixin.message.req.VideoReqMsg;
import com.github.sd4324530.fastweixin.message.req.VoiceReqMsg;
import com.github.sd4324530.fastweixin.util.BeanUtil;
import com.github.sd4324530.fastweixin.util.CollectionUtil;
import com.github.sd4324530.fastweixin.util.MessageUtil;
import com.github.sd4324530.fastweixin.util.SignUtil;
import com.github.sd4324530.fastweixin.util.StrUtil;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class WeixinSupport
{
  private static final Logger LOG = LoggerFactory.getLogger(WeixinSupport.class);

  private static final Object LOCK = new Object();
  private static List<MessageHandle> messageHandles;
  private static List<EventHandle> eventHandles;

  protected List<MessageHandle> initMessageHandles()
  {
    return null;
  }

  protected List<EventHandle> initEventHandles()
  {
    return null;
  }

  protected abstract String getToken();

  protected abstract String getAppId();

  protected abstract String getAESKey();

  protected String processRequest(HttpServletRequest request)
  {
    Map reqMap = MessageUtil.parseXml(request, getToken(), getAppId(), getAESKey());
    String fromUserName = (String)reqMap.get("FromUserName");
    String toUserName = (String)reqMap.get("ToUserName");
    String msgType = (String)reqMap.get("MsgType");

    LOG.debug("收到消息,消息类型:{}", msgType);

    BaseMsg msg = null;

    if (msgType.equals("event")) {
      String eventType = (String)reqMap.get("Event");
      String ticket = (String)reqMap.get("Ticket");
      QrCodeEvent qrCodeEvent = null;
      if (StrUtil.isNotBlank(ticket)) {
        String eventKey = (String)reqMap.get("EventKey");
        LOG.debug("eventKey:{}", eventKey);
        LOG.debug("ticket:{}", ticket);
        qrCodeEvent = new QrCodeEvent(eventKey, ticket);
        buildBasicEvent(reqMap, qrCodeEvent);
        if (eventType.equals("SCAN")) {
          msg = handleQrCodeEvent(qrCodeEvent);
          if (BeanUtil.isNull(msg)) {
            msg = processEventHandle(qrCodeEvent);
          }
        }
      }
      if (eventType.equals("subscribe")) {
        BaseEvent event = new BaseEvent();
        if (qrCodeEvent != null)
          event = qrCodeEvent;
        else {
          buildBasicEvent(reqMap, event);
        }
        msg = handleSubscribe(event);
        if (BeanUtil.isNull(msg))
          msg = processEventHandle(event);
      }
      else if (eventType.equals("unsubscribe")) {
        BaseEvent event = new BaseEvent();
        buildBasicEvent(reqMap, event);
        msg = handleUnsubscribe(event);
        if (BeanUtil.isNull(msg))
          msg = processEventHandle(event);
      }
      else if (eventType.toLowerCase().equals("click")) {
        String eventKey = (String)reqMap.get("EventKey");
        LOG.debug("eventKey:{}", eventKey);
        MenuEvent event = new MenuEvent(eventKey);
        buildBasicEvent(reqMap, event);
        msg = handleMenuClickEvent(event);
        if (BeanUtil.isNull(msg))
          msg = processEventHandle(event);
      }
      else if (eventType.equals("VIEW")) {
        String eventKey = (String)reqMap.get("EventKey");
        LOG.debug("eventKey:{}", eventKey);
        MenuEvent event = new MenuEvent(eventKey);
        buildBasicEvent(reqMap, event);
        msg = handleMenuViewEvent(event);
        if (BeanUtil.isNull(msg))
          msg = processEventHandle(event);
      }
      else if (eventType.equals("LOCATION")) {
        double latitude = Double.parseDouble((String)reqMap.get("Latitude"));
        double longitude = Double.parseDouble((String)reqMap.get("Longitude"));
        double precision = Double.parseDouble((String)reqMap.get("Precision"));
        LocationEvent event = new LocationEvent(latitude, longitude, precision);

        buildBasicEvent(reqMap, event);
        msg = handleLocationEvent(event);
        if (BeanUtil.isNull(msg)) {
          msg = processEventHandle(event);
        }
      }
    }
    else if (msgType.equals("text")) {
      String content = (String)reqMap.get("Content");
      LOG.debug("文本消息内容:{}", content);
      TextReqMsg textReqMsg = new TextReqMsg(content);
      buildBasicReqMsg(reqMap, textReqMsg);
      msg = handleTextMsg(textReqMsg);
      if (BeanUtil.isNull(msg))
        msg = processMessageHandle(textReqMsg);
    }
    else if (msgType.equals("image")) {
      String picUrl = (String)reqMap.get("PicUrl");
      String mediaId = (String)reqMap.get("MediaId");
      ImageReqMsg imageReqMsg = new ImageReqMsg(picUrl, mediaId);
      buildBasicReqMsg(reqMap, imageReqMsg);
      msg = handleImageMsg(imageReqMsg);
      if (BeanUtil.isNull(msg))
        msg = processMessageHandle(imageReqMsg);
    }
    else if (msgType.equals("voice")) {
      String format = (String)reqMap.get("Format");
      String mediaId = (String)reqMap.get("MediaId");
      String recognition = (String)reqMap.get("Recognition");
      VoiceReqMsg voiceReqMsg = new VoiceReqMsg(mediaId, format, recognition);

      buildBasicReqMsg(reqMap, voiceReqMsg);
      msg = handleVoiceMsg(voiceReqMsg);
      if (BeanUtil.isNull(msg))
        msg = processMessageHandle(voiceReqMsg);
    }
    else if (msgType.equals("video")) {
      String thumbMediaId = (String)reqMap.get("ThumbMediaId");
      String mediaId = (String)reqMap.get("MediaId");
      VideoReqMsg videoReqMsg = new VideoReqMsg(mediaId, thumbMediaId);
      buildBasicReqMsg(reqMap, videoReqMsg);
      msg = handleVideoMsg(videoReqMsg);
      if (BeanUtil.isNull(msg))
        msg = processMessageHandle(videoReqMsg);
    }
    else if (msgType.equals("location")) {
      double locationX = Double.parseDouble((String)reqMap.get("Location_X"));
      double locationY = Double.parseDouble((String)reqMap.get("Location_Y"));
      int scale = Integer.parseInt((String)reqMap.get("Scale"));
      String label = (String)reqMap.get("Label");
      LocationReqMsg locationReqMsg = new LocationReqMsg(locationX, locationY, scale, label);

      buildBasicReqMsg(reqMap, locationReqMsg);
      msg = handleLocationMsg(locationReqMsg);
      if (BeanUtil.isNull(msg))
        msg = processMessageHandle(locationReqMsg);
    }
    else if (msgType.equals("link")) {
      String title = (String)reqMap.get("Title");
      String description = (String)reqMap.get("Description");
      String url = (String)reqMap.get("Url");
      LOG.debug("链接消息地址:{}", url);
      LinkReqMsg linkReqMsg = new LinkReqMsg(title, description, url);
      buildBasicReqMsg(reqMap, linkReqMsg);
      msg = handleLinkMsg(linkReqMsg);
      if (BeanUtil.isNull(msg)) {
        msg = processMessageHandle(linkReqMsg);
      }
    }

    String result = "";
    if (BeanUtil.nonNull(msg)) {
      msg.setFromUserName(toUserName);
      msg.setToUserName(fromUserName);
      result = msg.toXml();
      if (StrUtil.isNotBlank(getAESKey())) {
        try {
          WXBizMsgCrypt pc = new WXBizMsgCrypt(getToken(), getAESKey(), getAppId());
          result = pc.encryptMsg(result, request.getParameter("timestamp"), request.getParameter("nonce"));
          LOG.debug("加密后密文:{}", result);
        } catch (AesException e) {
          LOG.error("加密异常", e);
        }
      }
    }
    //注释掉此处并且在服务器重写的自动回复return null时，自动回复消息会取消.服务器不回复用户任何消息的时候，重写的回复方法返回null即可。有点啰嗦......但也很好懂。
//    if (result.equals("")){
//    	result = "FromUserName:"+fromUserName+",ToUserName:"+toUserName+",MsgType:"+msgType;
//    	
//    	if (msgType.equals("event")) {
//    		result = result + ",Event:"+(String)reqMap.get("Event")+",EventKey:"+(String)reqMap.get("EventKey");
//    	}
//    }
    return result;
  }

  private BaseMsg processMessageHandle(BaseReqMsg msg) {
    if (CollectionUtil.isEmpty(messageHandles)) {
      synchronized (LOCK) {
        messageHandles = initMessageHandles();
      }
    }
    if (CollectionUtil.isNotEmpty(messageHandles)) {
      for (MessageHandle messageHandle : messageHandles) { BaseMsg resultMsg = null;
        boolean result;
        try {
          result = messageHandle.beforeHandle(msg);
        } catch (Exception e) {
          result = false;
        }
        if (result) {
          resultMsg = messageHandle.handle(msg);
        }
        if (BeanUtil.nonNull(resultMsg)) {
          return resultMsg;
        }
      }
    }
    return null;
  }

  private BaseMsg processEventHandle(BaseEvent event) {
    if (CollectionUtil.isEmpty(eventHandles)) {
      synchronized (LOCK) {
        eventHandles = initEventHandles();
      }
    }
    if (CollectionUtil.isNotEmpty(eventHandles)) {
      for (EventHandle eventHandle : eventHandles) { BaseMsg resultMsg = null;
        boolean result;
        try {
          result = eventHandle.beforeHandle(event);
        } catch (Exception e) {
          result = false;
        }
        if (result) {
          resultMsg = eventHandle.handle(event);
        }
        if (BeanUtil.nonNull(resultMsg)) {
          return resultMsg;
        }
      }
    }
    return null;
  }

  protected BaseMsg handleTextMsg(TextReqMsg msg)
  {
    return handleDefaultMsg(msg);
  }

  protected BaseMsg handleImageMsg(ImageReqMsg msg)
  {
    return handleDefaultMsg(msg);
  }

  protected BaseMsg handleVoiceMsg(VoiceReqMsg msg)
  {
    return handleDefaultMsg(msg);
  }

  protected BaseMsg handleVideoMsg(VideoReqMsg msg)
  {
    return handleDefaultMsg(msg);
  }

  protected BaseMsg handleLocationMsg(LocationReqMsg msg)
  {
    return handleDefaultMsg(msg);
  }

  protected BaseMsg handleLinkMsg(LinkReqMsg msg)
  {
    return handleDefaultMsg(msg);
  }

  protected BaseMsg handleQrCodeEvent(QrCodeEvent event)
  {
    return handleDefaultEvent(event);
  }

  protected BaseMsg handleLocationEvent(LocationEvent event)
  {
    return handleDefaultEvent(event);
  }

  protected BaseMsg handleMenuClickEvent(MenuEvent event)
  {
    return handleDefaultEvent(event);
  }

  protected BaseMsg handleMenuViewEvent(MenuEvent event)
  {
    return handleDefaultEvent(event);
  }

  protected BaseMsg handleSubscribe(BaseEvent event)
  {
    return new TextMsg("感谢您的关注!");
  }

  protected BaseMsg handleUnsubscribe(BaseEvent event)
  {
    return null;
  }

  protected BaseMsg handleDefaultMsg(BaseReqMsg msg) {
    return null;
  }

  protected BaseMsg handleDefaultEvent(BaseEvent event) {
    return null;
  }

  private void buildBasicReqMsg(Map<String, String> reqMap, BaseReqMsg reqMsg) {
    addBasicReqParams(reqMap, reqMsg);
    reqMsg.setMsgId((String)reqMap.get("MsgId"));
  }

  private void buildBasicEvent(Map<String, String> reqMap, BaseEvent event) {
    addBasicReqParams(reqMap, event);
    event.setEvent((String)reqMap.get("Event"));
  }

  private void addBasicReqParams(Map<String, String> reqMap, BaseReq req) {
    req.setMsgType((String)reqMap.get("MsgType"));
    req.setFromUserName((String)reqMap.get("FromUserName"));
    req.setToUserName((String)reqMap.get("ToUserName"));
    req.setCreateTime(Long.parseLong((String)reqMap.get("CreateTime")));
  }

  protected boolean isLegal(HttpServletRequest request) {
    String signature = request.getParameter("signature");
    String timestamp = request.getParameter("timestamp");
    String nonce = request.getParameter("nonce");
    return SignUtil.checkSignature(getToken(), signature, timestamp, nonce);
  }
}