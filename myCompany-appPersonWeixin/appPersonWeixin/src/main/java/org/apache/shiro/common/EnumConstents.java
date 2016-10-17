package org.apache.shiro.common;

/**
 * 枚举常量类
 *
 * @version $Id: EnumConstents.java, 
 * v 0.1 2015年12月21日 下午5:34:11 
 * <pre>
 * @author steven.chen
 * @date 2015年12月21日 下午5:34:11 
 * </pre>
 */
public class EnumConstents {
	
	
	/**
	 * 模板消息编号
	 *
	 * @version $Id: EnumConstents.java, 
	 * v 0.1 2015年12月23日 上午11:05:01 
	 * <pre>
	 * @author steven.chen
	 * @date 2015年12月23日 上午11:05:01 
	 * </pre>
	 */
	public enum TemplateCode {
		
		/** 订单状态更新模板编号 */
		ORDER_STATUS_UPDATE("TM00017"),
		/** 工资发放通知 */
		MESSAGE_OF_PAYMENT("OPENTM203806592"),
		/**  服务状态提醒 */
		SERVICE_STATE_MESSAGE("TM00898"),
		/**  积分状态提醒 */
		JIFEN_STATE_MESSAGE("TM00335");
	
		TemplateCode(String value) {
			this.value = value;
		}
	
		private String value;
	
		public String getValue() {
			return value;
		}
	
		public void setValue(String value) {
			this.value = value;
		}

	}
	
	
	
	/**
	 * 微信App类型
	 *
	 * @version $Id: EnumConstents.java, 
	 * v 0.1 2015年12月23日 上午10:41:10 
	 * <pre>
	 * @author steven.chen
	 * @date 2015年12月23日 上午10:41:10 
	 * </pre>
	 */
	public enum AppType {
		
		/** weixinHR */
		WEIXIN_HR("weixinHR"),
		/** weixinHROFirst */
		WEIXIN_HRO_FIRST("weixinHROFirst"),
		/** weixinORG */
		WEIXIN_ORG("weixinORG"),
		/** weixinPerson */
		WEIXIN_PERSON("weixinPerson");
	
		AppType(String value) {
			this.value = value;
		}
	
		private String value;
	
		public String getValue() {
			return value;
		}
	
		public void setValue(String value) {
			this.value = value;
		}

	}
	

}
