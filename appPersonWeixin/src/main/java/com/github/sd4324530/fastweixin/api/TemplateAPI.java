package com.github.sd4324530.fastweixin.api;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;
import com.github.sd4324530.fastweixin.api.config.ApiConfig;
import com.github.sd4324530.fastweixin.api.enums.ResultType;
import com.github.sd4324530.fastweixin.api.response.BaseResponse;
import com.github.sd4324530.fastweixin.util.BeanUtil;
import com.github.sd4324530.fastweixin.util.JSONUtil;


public class TemplateAPI extends BaseAPI {
	private static final Logger LOG = LoggerFactory
			.getLogger(TemplateAPI.class);

	public TemplateAPI(ApiConfig config) {
		super(config);
	}

	/**
	 * 设置所属行业，每月只能设置一次
	 * 
	 * @param industry_id1
	 *            公众号模板消息所属行业编号
	 * @param industry_id2
	 *            公众号模板消息所属行业编号
	 * @return 调用结果
	 */
	public ResultType setIndustry(String industry_id1, String industry_id2) {
		BeanUtil.requireNonNull(industry_id1, "industry_id1 is null");
		BeanUtil.requireNonNull(industry_id2, "industry_id2 is null");
		LOG.debug("设置所属行业.....");
		String url = BASE_API_URL
				+ "cgi-bin/template/api_set_industry?access_token=#";
		Map<String, String> param = new HashMap<String, String>();
		param.put("industry_id1", industry_id1);
		param.put("industry_id2", industry_id2);
		BaseResponse response = executePost(url, JSONUtil.toJson(param));
		return ResultType.get(response.getErrcode());
	}

	/**
	 * 获取模板id
	 * 
	 * @param templateIdShort
	 *            模板编号
	 * @return
	 */
	public String getTemplateId(String templateIdShort) {
		BeanUtil.requireNonNull(templateIdShort, "templateIdShort is null");
		LOG.debug("获取模板ID.....");
		String url = BASE_API_URL 
				+ "cgi-bin/template/api_add_template?access_token=#";
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("template_id_short", templateIdShort);
		BaseResponse r = executePost(url, JSONUtil.toJson(param));
		if (!"0".equals(r.getErrcode())) {
			LOG.error("获取模板ID失败.....");
			return "";
		}
		String resultJson = isSuccess(r.getErrcode()) ? r.getErrmsg() : r
				.toJsonString();
		JSONObject jsonObject = JSONUtil.getJSONFromString(resultJson);	
		return jsonObject.get("template_id").toString();
	}

	/**
	 * 发布模板消息
	 * 
	 * @param touser
	 *            关注者ID
	 * @param template_id
	 *            模板id
	 * @param templateUrl
	 *            模板url，可为null
	 * @param data
	 *            模板内容，map类型
	 * @return
	 */
	public ResultType sendTemplateMessage(String touser, String template_id,
			String templateUrl, Map<String, Object> data) {
		BeanUtil.requireNonNull(touser, "touser is null");
		BeanUtil.requireNonNull(template_id, "template_id is null");
		BeanUtil.requireNonNull(data, "data is null");
		LOG.debug("发布模板消息......");
		String url = BASE_API_URL
				+ "cgi-bin/message/template/send?access_token=#";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("touser", touser);
		params.put("template_id", template_id);
		params.put("url", templateUrl);
		params.put("data", data);
		BaseResponse response = executePost(url, JSONUtil.toJson(params));
		return ResultType.get(response.getErrcode());
	}

	/**
	 * 设置data参数值
	 * 
	 * @param value
	 *            data-value参数
	 * @return
	 */
	public Map<String, Object> getParam1(String value) {
		return getParam2(value, null);
	}

	/**
	 * 设置data参数值
	 * 
	 * @param value
	 *            data-value参数
	 * @param color
	 *            data-color参数
	 * @return
	 */
	public Map<String, Object> getParam2(String value, String color) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("value", value);
		if (StringUtils.isNotEmpty(color)) {
			param.put("color", color);
		} else {
			param.put("color", "#000000");
		}
		return param;
	}
}