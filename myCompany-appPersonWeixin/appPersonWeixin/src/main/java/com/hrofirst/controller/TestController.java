package com.hrofirst.controller;

import com.github.sd4324530.fastweixin.message.BaseMsg;
import com.github.sd4324530.fastweixin.message.TextMsg;
import com.github.sd4324530.fastweixin.message.req.TextReqMsg;
import com.hrofirst.entity.News;
import com.hrofirst.service.NewsService;
import com.hrofirst.service.WeChatService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by qixb.fnst on 2015/02/13.
 */
@Controller
@RequestMapping("/test")
public class TestController {
    @Autowired
    private NewsService newsService;

    @RequestMapping(value = "/send", method = RequestMethod.POST)
    public String sendNews(News news, RedirectAttributes redirectAttributes) {
        news.setSender("320882199112284562");
        news.setSendTime(new Date());
        newsService.save(news);
        redirectAttributes.addAttribute("message", "发送成功");
        return "redirect:/test/send";
    }

    @RequestMapping(value = "/send", method = RequestMethod.GET)
    public String sendNews() {
        return "test/send";
    }
    
    @Autowired
    private WeChatService weChatService;
    
    @RequestMapping(value = "/weixin")
    public String processWeixinText(HttpServletRequest request, HttpServletResponse response) {
    	String text = request.getParameter("text");
    	TextReqMsg msg = new TextReqMsg(text);
    	msg.setFromUserName("o0dYgt0KQThfr_PmFnx1oSxVSlXk");
    	BaseMsg ms = weChatService.checkPersonUserAndResponseMenu(msg);
    	//BaseMsg ms = weChatService.checkHRAndResponseMenu(msg);
    	//BaseMsg ms = weChatService.checkORGAndResponseMenu(msg);
    	response.setContentType("text/html; charset=utf-8");  
        PrintWriter out;
		try {
			out = response.getWriter();
	        out.println(ms.toXml());   
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}   
    	return null;
    }
}
