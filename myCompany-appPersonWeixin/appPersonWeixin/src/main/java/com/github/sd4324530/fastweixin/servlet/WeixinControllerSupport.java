package com.github.sd4324530.fastweixin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public abstract class WeixinControllerSupport extends WeixinSupport {
	private static final Logger LOG = LoggerFactory.getLogger(WeixinControllerSupport.class);
	
	@RequestMapping(method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	@ResponseBody
	protected final String bind(HttpServletRequest request) {
		if (isLegal(request)) {
			return request.getParameter("echostr");
		}

		return "";
	}

	@RequestMapping(method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	protected final String process(HttpServletRequest request)
			throws ServletException, IOException {
		if (!isLegal(request)) {
			LOG.info("请输入正确的指令");
			return "请输入正确的指令";
		}
		return processRequest(request);
	}
}
