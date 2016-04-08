package com.hrofirst.controller;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.sd4324530.fastweixin.handle.EventHandle;
import com.github.sd4324530.fastweixin.handle.MessageHandle;
import com.github.sd4324530.fastweixin.message.BaseMsg;
import com.github.sd4324530.fastweixin.message.TextMsg;
import com.github.sd4324530.fastweixin.message.req.BaseEvent;
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
import com.github.sd4324530.fastweixin.servlet.WeixinControllerSupport;
import com.hrofirst.entity.WeChatUser;
import com.hrofirst.service.WeChatService;
import com.hrofirst.util.Config;

/**
 * 员工帮手
 * @ClassName: WeChatPersonController
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @author hsx
 * @date 2015年7月1日 上午10:04:29
 */
@RestController
@RequestMapping("/weChatPerson")
public class WeChatPersonController extends WeixinControllerSupport{

    private static final Logger log = LoggerFactory.getLogger(WeChatPersonController.class);
    private static final String TOKEN = Config.getWechatToken();

    @Autowired
    private WeChatService weChatService;


    //设置TOKEN，用于绑定微信服务器
    @Override
    protected String getToken() {
        return TOKEN;
    }

    //使用安全模式时设置：APPID
    @Override
    protected String getAppId() {
        return null;
    }

    //使用安全模式时设置：密钥
    @Override
    protected String getAESKey() {
        return null;
    }

    //重写父类方法，处理对应的微信消息
    @Override
    protected BaseMsg handleTextMsg(TextReqMsg msg) {
        return weChatService.checkPersonUserAndResponseMenu(msg);
    }

    @Override
    protected BaseMsg handleImageMsg(ImageReqMsg msg) {
        return weChatService.checkPersonUserAndResponseMenu(msg);
    }

    @Override
    protected BaseMsg handleVoiceMsg(VoiceReqMsg msg) {
        return weChatService.checkPersonUserAndResponseMenu(msg);
    }

    @Override
    protected BaseMsg handleVideoMsg(VideoReqMsg msg) {
        return weChatService.checkPersonUserAndResponseMenu(msg);
    }

    @Override
    protected BaseMsg handleLocationMsg(LocationReqMsg msg) {
        return weChatService.checkPersonUserAndResponseMenu(msg);
    }

    @Override
    protected BaseMsg handleLinkMsg(LinkReqMsg msg) {
        return weChatService.checkPersonUserAndResponseMenu(msg);
    }

    @Override
    protected BaseMsg handleQrCodeEvent(QrCodeEvent event) {
        return super.handleQrCodeEvent(event);
    }

    @Override
    protected BaseMsg handleLocationEvent(LocationEvent event) {
        return super.handleLocationEvent(event);
    }
    //菜单点击事件处理  
    @Override
    protected BaseMsg handleMenuClickEvent(MenuEvent event) {
    	String key = event.getEventKey();
    	String weichatId = event.getFromUserName();
    	WeChatUser user=null;
    	if(weichatId!=null){
        	 user = weChatService.findWeChatUser(weichatId, "weixinPerson");
    	}
    	//激活账号的用户可以上传资料
    	if(user!=null){
    		//上传资料
        	if (key.equals("uploadFiles")){
	    			TextReqMsg msg = new TextReqMsg("0");//显示所有菜单项
	    			msg.setFromUserName(event.getFromUserName());
	    			msg.setMsgId(event.getMsgType());
	    			msg.setCreateTime(event.getCreateTime());
	    			msg.setToUserName(event.getToUserName());
	        	    return weChatService.checkPersonUserAndResponseMenu(msg);
            	}else{
            		return super.handleMenuClickEvent(event);
            	}
    	}else{
    		return new TextMsg("请先激活账号！");
    	}
    }

    @Override
    protected BaseMsg handleMenuViewEvent(MenuEvent event) {
        return super.handleMenuViewEvent(event);
    }

    //关注员工帮手
    @Override
    protected BaseMsg handleSubscribe(BaseEvent event) {
        //weChatService.saveFollowTime(event.getFromUserName());
    	 String weichatId = event.getFromUserName();
         if (weichatId != null) {
        	 WeChatUser user = weChatService.findWeChatUser(weichatId, "weixinPerson");
	    	 if (user == null) {
             	 //创建用户
                 user = new WeChatUser(weichatId);
             }
             user.setApptype("weixinPerson");
             //修改时间
             user.setLastAccessDate(new Date());
             user = weChatService.save(user);
         }
        //只显示欢迎词
         TextMsg tm=new  TextMsg();
         tm.add("亲，终于等到您！欢迎关注员工帮手！").addln();
         tm.add( "如果您是首次使用员工帮手服务号，请先登录并激活账号，即刻享受社保公积金信息查询等服务。"
          		+ "如无法激活，请联系您的人事经理或专属客服。员工帮手是您更专业、更贴心的个人信息管家！").addln();
         return tm;
    }

    //取消关注员工帮手
    @Override
    protected BaseMsg handleUnsubscribe(BaseEvent event) {
        weChatService.unSubscribe(event.getFromUserName(),"weixinPerson");
        return super.handleUnsubscribe(event);
    }

    @Override
    protected BaseMsg handleDefaultMsg(BaseReqMsg msg) {
        return super.handleDefaultMsg(msg);
    }

    @Override
    protected BaseMsg handleDefaultEvent(BaseEvent event) {
        return super.handleDefaultEvent(event);
    }

    @Override
    protected List<MessageHandle> initMessageHandles() {
        return super.initMessageHandles();
    }

    @Override
    protected List<EventHandle> initEventHandles() {
        return super.initEventHandles();
    }
}
