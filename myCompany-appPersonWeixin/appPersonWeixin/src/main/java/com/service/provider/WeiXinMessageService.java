package com.service.provider;

import java.util.Map;

import com.service.provider.entity.ReturnS;

public interface WeiXinMessageService {

	/**
	 * 发送模板消息
	 * <pre>
	 * @author steven.chen
	 * @date 2016年5月23日 下午6:02:06 
	 * </pre>
	 *
	 * @return
	 */
	public ReturnS sendWeiXinMessage(Map<String,Object> map ,String mobile ,String url ,String apptype);
}
