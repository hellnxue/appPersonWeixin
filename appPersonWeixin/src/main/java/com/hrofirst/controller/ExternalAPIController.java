package com.hrofirst.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hrofirst.util.DesUtil;

/**
 * 对外接口页面api
 * 
 * @author 郑长山
 * 
 */
@Controller
@RequestMapping("/api")
public class ExternalAPIController {
	/**
	 * 公积金查询页面
	 */
	private final static String NATIONGUARD = "api/nationGuard";
	/**
	 * 工资单查询页面
	 */
	private final static String SALARY = "api/salary";

	/**
	 * 公积金查询
	 * 
	 * @param cardId
	 *            身份证号码，加密
	 * @param month
	 *            年月6位数字，可为空
	 * @param model
	 * @return
	 */
	@RequestMapping("/nationalGuard")
	public String webApp_nationalGuard(String cardId, String month, Model model) {
		setModel(cardId, month, model);
		return NATIONGUARD;
	}

	/**
	 * 工资单
	 * 
	 * @param cardId
	 *            身份证号码，加密
	 * @param month
	 *            年月6位数字，可为空
	 * @param model
	 * @return
	 */
	@RequestMapping("/salary")
	public String wsalary(String cardId, String month, Model model) {
		setModel(cardId, month, model);
		return SALARY;
	}

	/**
	 * 设置request参数，并返回
	 * 
	 * @param cardId
	 *            身份证号码，加密
	 * @param month
	 *            年月6位数字，可为空
	 * @param model
	 */
	@SuppressWarnings("deprecation")
	private void setModel(String cardId, String month, Model model) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
		Date date = new Date();
		gc.setTime(date);
		gc.add(Calendar.MONTH, -1);
		// 判断传入身份证号码是否为空
		if (!StringUtils.isEmpty(cardId)) {
			// 身份证号码解密
			String deCardId = desDecrypt(cardId);
			// 判断解析是否正确
			if (!StringUtils.isEmpty(deCardId)) {
				// 判断参数解密后格式是否正确
				if (deCardId.contains("-")) {
					// 获取身份证号码
					String idCard = deCardId.split("-")[0];
					model.addAttribute("idCard", idCard);
					// 加密身份证号码
					String enCardId = idCard + "-" + getRandomCode();
					model.addAttribute("enCardId",
							URLEncoder.encode(desEncrypt(enCardId)));
				} else {
					model.addAttribute("errorMessage", "参数格式错误");
				}
			} else {
				model.addAttribute("errorMessage", "参数解析失败");
			}
		} else {
			model.addAttribute("errorMessage", "身份证号码参数不能为空");
		}
		if (month == null) {
			month = sdf.format(gc.getTime());
		}
		model.addAttribute("month", month);
	}

	/**
	 * 解密方法
	 * 
	 * @param param
	 *            解密字符串
	 * @return
	 */
	@SuppressWarnings("unused")
	private String desDecrypt(String param) {
		DesUtil desUtil = new DesUtil();
		String res = "";
		try {
			res = DesUtil.decrypt(param, "wechatapi");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	/**
	 * 加密方法
	 * 
	 * @param param
	 *            加密字符串
	 * @return
	 */
	@SuppressWarnings("unused")
	private String desEncrypt(String param) {
		DesUtil desUtil = new DesUtil();
		String res = "";
		try {
			res = DesUtil.encrypt(param, "wechatapi");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	/**
	 * 获取随机数
	 * 
	 * @return
	 */
	private String getRandomCode() {
		String valid_code_value_range = "0123456789";
		// 获取随机验证码
		Random random = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < 6; i++) {
			int number = random.nextInt(valid_code_value_range.length());
			sb.append(valid_code_value_range.charAt(number));
		}
		String randomCode = sb.toString();
		return randomCode;
	}
}
