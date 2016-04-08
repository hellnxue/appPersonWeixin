package com.hrofirst.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.github.sd4324530.fastweixin.api.OauthAPI;
import com.github.sd4324530.fastweixin.api.config.ApiConfig;
import com.hrofirst.entity.WeChatUser;
import com.hrofirst.util.Config;
import com.hrofirst.util.casUtils;
@Controller
@DependsOn("userRealm")
public class IndexPersonController extends baseController{
    private final  OauthAPI oAuthAPI = new OauthAPI(new ApiConfig(Config.getPersonappid(), Config.getPersonappsecret(), true));

    /**
     * 判断微信号是否已经和智阳账号绑定，如果已经绑定，那么模拟登录，用户不需要再次输入用户名和密码
     * @param request
     * @param code
     */
    private boolean processOpenID(HttpServletRequest request, HttpServletResponse response, String code){
        if (code != null) {
        	String openId = oAuthAPI.getToken(code).getOpenid();
        	//String openId="oCH-TxHGOqLsA-6Bk5TADRDVVof4";
        	System.out.println("appid="+Config.getPersonappid()+"   secret="+Config.getPersonappsecret());
            if (openId != null) {
            	String apptype=String.valueOf(request.getSession().getAttribute("appType"));
                // 根据Username与appType查询用户信息
            	WeChatUser user = weChatService.findWeChatUser(openId, apptype);
            	if(user!=null){
            		request.getSession().setAttribute("UserName", openId);
                	if (user.getZhiyangUserName() != null && !user.getZhiyangUserName().equals("")){
                		//模拟shiro登录，如果已经登录，那么先退出，然后重新登录
                		Subject subject = SecurityUtils.getSubject(); 
        	        	UsernamePasswordToken token = new UsernamePasswordToken(user.getZhiyangUserName(), "______");
       	        	    subject.login(token);//登录            

       	        	    //模拟单点登录
	       	         	String username = user.getZhiyangUserName();
		       	     	String password = "weixin"+username;
		       	     	
		       	     	if (username != null && password != null){
		       	     		casUtils cas = new casUtils();
		       	     		Cookie cook = cas.processCASLogin(Config.getCasservice(), username, password);
		       	     		
		       	     		if (cook != null){
		       	         		cook.setDomain(Config.getCascookiedomain());
		       	         		((HttpServletResponse) response).addCookie(cook);
		       	     		}
		       	     	}       	        	    
		       	     	
		       	     	return true;
                	}
            	}
            }
        }    
        
        return false;
    }
    
    /**
     * 微信授权登录，内部判断微信openId和智阳用户的关联
     * @param request
     * @param model
     * @param code
     * @return
     */
    @RequestMapping(value={"/webApp/weixinPerson"})
    public ModelAndView weixin_login(HttpServletRequest request, HttpServletResponse response, Model model, String code) {
    	request.getSession().setAttribute("appType", "weixinPerson");
    	request.getSession().setAttribute("appName", "员工帮手");
    	
    	if (processOpenID(request, response, code)){
    		return new ModelAndView("redirect:/webApp/index");
    	}else{
    		return new ModelAndView("redirect:/webApp/logout");
    	}
    		
    		
    }
    
    //我的消息
    @RequestMapping(value={"/webApp/weixinPersonNews"})
    public ModelAndView weixin_PersonNews(HttpServletRequest request, HttpServletResponse response, Model model, String code) {
    	request.getSession().setAttribute("appType", "weixinPerson");
    	request.getSession().setAttribute("appName", "员工帮手");
    	
    	if (processOpenID(request, response, code))
    		return new ModelAndView("redirect:/webApp/msgs");
    	else
    		return new ModelAndView("redirect:/webApp/logout");
    } 
    
    //移动签到
    @RequestMapping(value={"/webApp/weixinPersonSignIn"})
    public ModelAndView weixin_PersonSignIn(HttpServletRequest request, HttpServletResponse response, Model model, String code) {
    	request.getSession().setAttribute("appType", "weixinPerson");
    	request.getSession().setAttribute("appName", "员工帮手");
    	
    	if (processOpenID(request, response, code))
    		return new ModelAndView("redirect:/webApp/empCheck");
    	else
    		return new ModelAndView("redirect:/webApp/logout");
    }
}
