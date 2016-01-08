package com.service.provider;

import java.util.Map;

import com.service.provider.entity.ReturnS;

/**
 * 模板消息
 *
 * @version $Id: TemplateMessage.java, 
 * v 0.1 2015年12月21日 下午4:26:57 
 * <pre>
 * @author steven.chen
 * @date 2015年12月21日 下午4:26:57 
 * </pre>
 */
public interface TemplateMessage {
	/**
	 * 发送模板消息
	 * <pre>
	 * @author steven.chen
	 * @date 2015年12月21日 下午5:53:28 
	 * </pre>
	 *
	 * @param appType  类型
	 * @param userName 用户名
	 * @param templateCode 模板Code 
	 * @param templateUrl 模板URL 可以为空
	 * @param data 消息内容
	 * @return
	 */
	public ReturnS sendTemplateMessage(String appType , String userName, String templateCode,
			String templateUrl, Map<String, Object> data);
	
	

}
