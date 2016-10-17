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
import com.service.provider.WeiXinNewsService;
import com.service.provider.entity.ReturnS;


/**
 * 新闻模板接口 
 *
 * @version $Id: NewsServiceImpl.java, 
 * v 0.1 2016年5月23日 下午3:51:53 
 * <pre>
 * @author steven.chen
 * @date 2016年5月23日 下午3:51:53 
 * </pre>
 */
@Service
public class WeiXinNewsServiceImpl implements WeiXinNewsService {
	
	@Autowired
	private TemplateMessage templateMessage;
	@Autowired
	public WeChatService weChatService;
	
	private final String templateCode="TM00898";
	private static final Logger logger = LoggerFactory.getLogger(WeiXinNewsServiceImpl.class);

	
	@Override
	public ReturnS sendWeiXinNews(Map<String,Object> map) {	
		ReturnS returnS = new ReturnS();
		Map<String,Object> data  = new HashMap<String,Object>();
		if(map ==null || map.isEmpty() || map.get("userName")==null ||  map.get("appType")==null){
			returnS.setSuccess(false);
			returnS.setReturnCode("500");
			returnS.setMsg("参数不可为空");
			return returnS;
		}
		// 获取用户信息
		WeChatUser weChatUser = weChatService.getWeChatUserByZhiYangUserName(map.get("userName").toString(),
				map.get("appType").toString());
		if (weChatUser == null || StringUtils.isBlank(weChatUser.getUsername())) {
			logger.error("获取用户失败,zhiyangUserNane"+map.get("userName"));
			returnS.setSuccess(false);
			returnS.setReturnCode("500");
			returnS.setMsg("获取用户失败");
			return returnS;
		}	
		
		
		data.put("frist", "亲爱的用户，您收到一则企业资讯");
		data.put("Good", "企业资讯");
		data.put("contentType", map.get("newsTitle"));
		Map<String, String> app = new HashMap<String, String>();
		app.put("appId", "wxf8fc9a730a1c3dce"); 
		app.put("secret","cf1752d9f8176af79f6d9f6281ac2947");
		ApiConfig config = new ApiConfig(app.get("appId"), app.get("secret"));
		TemplateAPI templateAPI = new TemplateAPI(config);	
		//转为短链接 
		String link = templateAPI.likeConvert( map.get("contentType").toString());
		if(StringUtils.isNotBlank(link)){
			// data.put("remark", link); 
		}else{
			link=map.get("contentType").toString();
			// data.put("remark", map.get("contentType").toString());
		}
		
		
		return templateMessage.sendTemplateMessage(weChatUser.getApptype(),weChatUser.getUsername(), templateCode, link, data);		
	}

}
