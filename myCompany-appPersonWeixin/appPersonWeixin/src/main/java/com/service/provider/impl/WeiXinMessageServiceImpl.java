package com.service.provider.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.dubbo.config.annotation.Service;
import com.github.sd4324530.fastweixin.api.TemplateAPI;
import com.github.sd4324530.fastweixin.api.config.ApiConfig;
import com.hrofirst.entity.WeChatUser;
import com.hrofirst.service.WeChatService;
import com.service.provider.TemplateMessage;
import com.service.provider.WeiXinMessageService;
import com.service.provider.entity.ReturnS;

@Service
public class WeiXinMessageServiceImpl implements WeiXinMessageService{

	@Autowired
	private TemplateMessage templateMessage;
	@Autowired
	public WeChatService weChatService;
	
	private final String templateCode="TM00335";
	private static final Logger logger = LoggerFactory.getLogger(WeiXinMessageServiceImpl.class);

	
	@Override
	public ReturnS sendWeiXinMessage(Map<String,Object> data ,String mobile ,String url ,String apptype) {	
		ReturnS returnS = new ReturnS();
		if(data ==null || data.isEmpty() || mobile==null || apptype ==null){
			returnS.setSuccess(false);
			returnS.setReturnCode("500");
			returnS.setMsg("参数不可为空");
			return returnS;
		}
		// 获取用户信息
		WeChatUser weChatUser = weChatService.getWeChatUserByZhiYangUserName(mobile,apptype);
		if (weChatUser == null || StringUtils.isBlank(weChatUser.getUsername())) {
			logger.error("获取用户失败,zhiyangUserNane"+mobile);
			returnS.setSuccess(false);
			returnS.setReturnCode("500");
			returnS.setMsg("获取用户失败");
			return returnS;
		}	
		Map<String, String> app = new HashMap<String, String>();
		app.put("appId", "wxf8fc9a730a1c3dce"); 
		app.put("secret","cf1752d9f8176af79f6d9f6281ac2947");
		ApiConfig config = new ApiConfig(app.get("appId"), app.get("secret"));
		TemplateAPI templateAPI = new TemplateAPI(config);	
		//转为短链接 
		String link = "";
		if(StringUtils.isNotEmpty(url)){
		link = templateAPI.likeConvert(url);
		}
		
		return templateMessage.sendTemplateMessage(weChatUser.getApptype(),weChatUser.getUsername(), templateCode, link, data);		
	}


}
