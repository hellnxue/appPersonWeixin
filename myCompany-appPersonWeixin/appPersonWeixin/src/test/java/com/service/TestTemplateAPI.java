package com.service;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;

import com.github.sd4324530.fastweixin.api.TemplateAPI;
import com.github.sd4324530.fastweixin.api.config.ApiConfig;
import com.github.sd4324530.fastweixin.api.enums.ResultType;

public class TestTemplateAPI {

	/**
	 * 员工帮手公众号测试
	 */
	@Test
	public void test() {
		// wx72a253ad4430a1f5
		// 295e8a24b58420e68a48907ff802c964
		String appid = "wx72a253ad4430a1f5";
		String secret = "295e8a24b58420e68a48907ff802c964";
		ApiConfig config = new ApiConfig(appid, secret);
		TemplateAPI api = new TemplateAPI(config);
		/*
		 * ResultType c = api.setIndustry("1", "2");
		 * System.out.println(c.toString());
		 */

		String b = api.getTemplateId("TM00020");
		System.out.println(b);
		String template_id = "eyP2bOiJ0lwuATFThLWkROzu18Bh92_OLnyk0TIgg_Q";
		// String template_id = b;
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("first", api.getParam1("您的订单已提交成功，开始为您打包商品，您在收货时还需要支付49元。"));
		data.put("reason", api.getParam1("12345678"));
		data.put("refund", api.getParam1("30.00元"));
		data.put("remark", api.getParam1("预计送达：11月11日下午"));
		ResultType a = api.sendTemplateMessage("oz8Lsw1scoRraWsfbKhCfMBshmyM",
				template_id, "http://mp.weixin.qq.com/wiki/5/6dde9eaa909f83354e0094dc3ad99e05.html", data);
		System.out.println(a.toString());
	}
}
