package com.service.provider.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.common.EnumConstents.AppType;
import org.apache.shiro.common.EnumConstents.TemplateCode;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.dubbo.config.annotation.Service;
import com.github.sd4324530.fastweixin.api.TemplateAPI;
import com.github.sd4324530.fastweixin.api.config.ApiConfig;
import com.github.sd4324530.fastweixin.api.enums.ResultType;
import com.hrofirst.entity.WeChatUser;
import com.hrofirst.service.WeChatService;
import com.service.provider.TemplateMessage;
import com.service.provider.entity.ReturnS;

/**
 * 模板消息
 *
 * @version $Id: TemplateMessage.java, v 0.1 2015年12月21日 下午4:26:57
 * 
 *          <pre>
 * @author steven.chen
 * @date 2015年12月21日 下午4:26:57
 * </pre>
 */
@Service
public class TemplateMessageImpl implements TemplateMessage {

	@Autowired
	public WeChatService weChatService;

	/**
	 * 发送模板消息
	 * 
	 * <pre>
	 * @author steven.chen
	 * @date 2015年12月21日 下午5:53:28
	 * </pre>
	 *	 
	 * @param appType
	 *            类型
	 * @param userName
	 *            用户名
	 * @param templateCode
	 *            模板Code
	 * @param templateUrl
	 *            模板URL 可以为空
	 * @param data
	 *            消息内容
	 * @return
	 */
	@Override
	public ReturnS sendTemplateMessage(String appType, String userName,
			String templateCode, String templateUrl, Map<String, Object> data) {
		ReturnS returnS = new ReturnS();
		if (checkParams(appType, userName, templateCode, data)) {
			returnS.setSuccess(false);
			returnS.setReturnCode("500");
			returnS.setMsg("参数不正确");
			return returnS;
		}
		
		Map<String, String> app = new HashMap<String, String>();
		app = getAppIdByAppType(appType);
		ApiConfig config = new ApiConfig(app.get("appId"), app.get("secret"));
		TemplateAPI templateAPI = new TemplateAPI(config);
		
		// 获取用户信息
		WeChatUser weChatUser = weChatService.getWeChatUserOpenId(userName,
				appType);
		if (weChatUser == null || StringUtils.isBlank(weChatUser.getUsername())) {
			returnS.setSuccess(false);
			returnS.setReturnCode("500");
			returnS.setMsg("获取用户失败");
			return returnS;
		}

		// 根据模板编号获取模板
		String templateId = templateAPI.getTemplateId(templateCode);
		if (StringUtils.isBlank(templateId)) {
			returnS.setSuccess(false);
			returnS.setReturnCode("500");
			returnS.setMsg("获取消息模板失败");
			return returnS;
		}		
		data = getMessageByTemplateCode(templateAPI, templateCode, data);
		// 发送消息
		ResultType resultType = templateAPI.sendTemplateMessage(
				weChatUser.getUsername(), templateId, templateUrl, data);
		if (resultType == null
				|| StringUtils.isBlank(resultType.getCode().toString())) {
			returnS.setSuccess(false);
			returnS.setReturnCode("300");
			returnS.setMsg("发送失败");
			return returnS;
		}
		if ("0".equals(resultType.getCode().toString().trim())) {
			returnS.setSuccess(true);
			returnS.setReturnCode("200");
			returnS.setMsg("发送成功");
			return returnS;
		} else {
			returnS.setSuccess(false);
			returnS.setReturnCode("400");
			returnS.setMsg("发送失败");
			return returnS;
		}
		
	}

	/**
	 * 参数有为空的时候返回true
	 * 
	 * <pre>
	 * @author steven.chen
	 * @date 2015年12月22日 上午9:33:31
	 * </pre>
	 *
	 * @param appType
	 * @param userName
	 * @param templateCode
	 * @param data
	 * @return
	 */
	private boolean checkParams(String appType, String userName,
			String templateCode, Map<String, Object> data) {
		if (StringUtils.isBlank(appType) || StringUtils.isBlank(userName)
				|| StringUtils.isBlank(templateCode) || data.isEmpty()) {
			return true;
		}
		if (!AppType.WEIXIN_HR.getValue().equals(appType)
				|| !AppType.WEIXIN_HRO_FIRST.getValue().equals(appType)
				|| !AppType.WEIXIN_ORG.getValue().equals(appType)
				|| !AppType.WEIXIN_PERSON.getValue().equals(appType)) {
			return true;
		}
		return false;
	}

	/**
	 * 根据appType 获取相应的appId secret
	 * 
	 * <pre>
	 * @author steven.chen
	 * @date 2015年12月23日 上午10:27:03
	 * </pre>
	 *
	 * @param appType
	 * @return
	 */
	private Map<String, String> getAppIdByAppType(String appType) {

		Map<String, String> app = new HashMap<String, String>();
		if (AppType.WEIXIN_HR.getValue().equals(appType)) {
			// 测试环境
			app.put("appId", "wx087432b58f4685db");
			app.put("secret", "0d9c1a7b885d89024e77bd080abe469e");
			// 正式环境
			/*
			 * app.put("appId", "wx0d9683313e7d027d"); app.put("secret",
			 * "6a615d03896313b85baee07b477d4487");
			 */
			return app;
		}
		if (AppType.WEIXIN_HRO_FIRST.getValue().equals(appType)) {
			// 测试环境
			app.put("appId", "wx087432b58f4685db");
			app.put("secret", "0d9c1a7b885d89024e77bd080abe469e");
			// 正式环境
			/*
			 * app.put("appId", "wx00bd6c8fa058c39f"); app.put("secret",
			 * "9a487465fb98ab18beb430078daa636a");
			 */
			return app;
		}
		if (AppType.WEIXIN_ORG.getValue().equals(appType)) {
			// 测试环境
			app.put("appId", "wx72a253ad4430a1f5");
			app.put("secret", "295e8a24b58420e68a48907ff802c964");
			// 正式环境
			/*
			 * app.put("appId", "wx6de3d7446f40a5c5"); app.put("secret",
			 * "31c1c188f8a57541949b984717b2fe61");
			 */
			return app;
		}
		if (AppType.WEIXIN_PERSON.getValue().equals(appType)) {
			// 测试环境
			app.put("appId", "wx72a253ad4430a1f5");
			app.put("secret", "295e8a24b58420e68a48907ff802c964");
			// 正式环境
			/*
			 * app.put("appId", "wxf8fc9a730a1c3dce"); app.put("secret",
			 * "cf1752d9f8176af79f6d9f6281ac2947");
			 */
			return app;
		}
		return app;
	}

	/**
	 * 根据模板Code 包装消息内容
	 * 
	 * <pre>
	 * @author steven.chen
	 * @date 2015年12月23日 上午10:24:01
	 * </pre>
	 *
	 * @param templateAPI
	 * @param templateCode
	 * @param data
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private Map<String, Object> getMessageByTemplateCode(
			TemplateAPI templateAPI, String templateCode,
			Map<String, Object> data) {
		Map result = new HashMap<String, Object>();
		// 订单状态更新
		if (TemplateCode.ORDER_STATUS_UPDATE.getValue().equals(templateCode)) {
			result.put("frist",
					templateAPI.getParam1(data.get("frist").toString()));
			result.put("OrderSn",
					templateAPI.getParam1(data.get("OrderSn").toString()));
			result.put("OrderStatus",
					templateAPI.getParam1(data.get("OrderStatus").toString()));
			result.put("remark",
					templateAPI.getParam1(data.get("remark").toString()));
			return result;

		} else if (TemplateCode.MESSAGE_OF_PAYMENT.getValue().equals(templateCode)) {// 工资发放通知
			result.put("frist",
					templateAPI.getParam1(data.get("frist").toString()));
			result.put("keyword1",
					templateAPI.getParam1(data.get("keyword1").toString()));
			result.put("keyword2",
					templateAPI.getParam1(data.get("keyword2").toString()));
			result.put("keyword3",
					templateAPI.getParam1(data.get("keyword3").toString()));
			result.put("remark",
					templateAPI.getParam1(data.get("remark").toString()));
			return result;

		} else if (TemplateCode.SERVICE_STATE_MESSAGE.getValue().equals(templateCode)) {// 服务状态提醒
			result.put("frist",
					templateAPI.getParam1(data.get("frist").toString()));
			result.put("Good",
					templateAPI.getParam1(data.get("Good").toString()));
			result.put("contentType",
					templateAPI.getParam1(data.get("contentType").toString()));
			result.put("remark",
					templateAPI.getParam1(data.get("remark").toString()));
			return result;

		}
		return result;
	}

}
