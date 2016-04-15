package com.hrofirst.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hrofirst.entity.News;
import com.hrofirst.entity.Policy;
import com.hrofirst.entity.Province;
import com.hrofirst.entity.WeChatUser;
import com.hrofirst.entity.WebAppMenu;
import com.hrofirst.jms.sender.apiDataJMSSender;
import com.hrofirst.service.ProvinceService;
import com.hrofirst.util.BaobeikejiClient;
import com.hrofirst.util.Config;
import com.hrofirst.util.TripleDES;
import com.hrofirst.util.ValidatorBasic;
import com.service.provider.CenterUserService;
import com.service.provider.entity.CenterSysUser;
import com.service.provider.entity.ReceivingAddrInfo;
import com.service.provider.entity.ReturnS;
@Controller
public class IndexCommonController extends baseController{
	
	HttpClient client = HttpClientBuilder.create().build();
	public String apptype="";//登出时保存apptype类型    
	public String openid="";//登出时保存openid参数

    /**
     * 新版微信公众号的login页面，具体登录验证见shiro的UserRealm类的doGetAuthenticationInfo方法，内部会整合openId和智阳用户的关系
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/webApp/login")
    public ModelAndView webApp_login(HttpServletRequest request, HttpServletResponse response, Model model) {
    	if(request.getSession().getAttribute("errorMessage")!=null){
           model.addAttribute("errorMessage", request.getSession().getAttribute("errorMessage"));
    	}
    	//System.out.println(request.getAttribute("appName"));
    	//处理退出时session停掉导致的登录页面样式不显示bug
    	if(apptype!=null&&!apptype.equals("")){
    		request.getSession().setAttribute("appType", apptype);
    	}
    	if(openid!=null&&!openid.equals("")){
    		request.getSession().setAttribute("UserName", openid);
    	}
    	return new ModelAndView("webApp/login");
    }  
    
    /**
     * 首页
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/index")
    public String webApp_index(HttpServletRequest request, HttpServletResponse response, Model model) {
    	//Object s=request.getSession().getAttribute("appName");
    	if (request.getSession().getAttribute("appName")!=null){
    		model.addAttribute("appName", request.getSession().getAttribute("appName"));
    		model.addAttribute("appType", request.getSession().getAttribute("appType"));
    	}else{
    		request.getSession().setAttribute("appName", "员工帮手");
    	}
    	
    	String receiver = "333232312143314";
    	
        Page<News> publicNews =
                newsService.findByReceiverAndType(receiver, News.NewsType.PERSONAL, 0, 4);
        long unReadPublic = newsService.countUnRead(receiver, News.NewsType.PERSONAL);

        model.addAttribute("publicNews", publicNews);
        model.addAttribute("unReadPublic", unReadPublic);
        
    	if (request.getSession().getAttribute("ZhiyangUserName") != null){
    		String name = (String) request.getSession().getAttribute(
					"ZhiyangUserName");
			CenterSysUser userInfo = (CenterSysUser) request.getSession()
					.getAttribute("userInfo");
			userInfo.getOrgOrganization().getHroOrgId();
			model.addAttribute("loginname", name);
			model.addAttribute("orgid",userInfo.getOrgUser().getOrgId());
			model.addAttribute("userName", userInfo.getOrgPerson().getName());
			model.addAttribute("userID", userInfo.getLoginUser().getLoginId());
    	}       
    	
    	long unReadPersonal = newsService.countUnRead(receiver, News.NewsType.PERSONAL);
    	model.addAttribute("unReadPersonal", unReadPersonal);
    	
        return "webApp/index";
    }
    
    /**
     * 用户页
     * @param request
     * @param model
     * @return
     * 
     *  
    	String userName=request.getSession().getAttribute("ZhiyangUserName").toString();
    	
    	ReturnS rs = centerUserService.getCenterUser(userName,
				CenterUserService.SYSTEM_ID_HF);
    	
    	CenterSysUser userInfo  = (CenterSysUser) rs.getResult();
     */
    @RequestMapping("/webApp/user")
    public ModelAndView webApp_user(HttpServletRequest request, Model model) {
    	if (request.getSession().getAttribute("ZhiyangUserName") != null) {
			CenterSysUser userInfo = (CenterSysUser) request.getSession()
					.getAttribute("userInfo");
			model.addAttribute("userName", userInfo.getOrgPerson().getName());
			model.addAttribute("userID", userInfo.getLoginUser().getLoginId());
		}
		// apptype获取不了？
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		String apptype = (String) session.getAttribute("appType");
		System.out.println(apptype);
		return new ModelAndView("webApp/user/user");
    }
    
    /**
     * 功能列表页
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/functionList")
    public ModelAndView webApp_functionList(HttpServletRequest request, Model model) {
    	String code = request.getParameter("code");
    	
    	if (code != null){
    		
    		List<WebAppMenu> menu = webappmenuService.findByPId(Long.valueOf(code));
    		model.addAttribute("content", menu);
    		return new ModelAndView("webApp/functionList"); 
    	}
    	
    	return new ModelAndView("noId");
    }
    
    /**
     * 功能详情页
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/functionDetail")
    public ModelAndView webApp_functionDetail(HttpServletRequest request, Model model) {
    	
    	return new ModelAndView("webApp/functionDetail"); 
    }
    
    /**
     * 功能介绍页，目前只用于工资宝描述
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/functionDesc")
    public ModelAndView webApp_functionDesc(HttpServletRequest request, Model model) {
    	
    	return new ModelAndView("webApp/functionDesc"); 
    }
    
    /**
     * 移动签到页，假的
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/checkin")
    public ModelAndView webApp_checkin(HttpServletRequest request, Model model) {

    	return new ModelAndView("webApp/user"); 
    }
    
    /**
     * 个人消息页
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/msgs")
    public ModelAndView webApp_msgs(HttpServletRequest request, Model model) {
    	
    	String receiver = "333232312143314";
        Page<News> personal =
                newsService.findByReceiverAndType(receiver, News.NewsType.PERSONAL, 0, INDEX_NEWS_SIZE);
        long unReadPersonal = newsService.countUnRead(receiver, News.NewsType.PERSONAL);
        Page<News> publicNews =
                newsService.findByReceiverAndType(receiver, News.NewsType.PUBLIC, 0, INDEX_NEWS_SIZE);
        long unReadPublic = newsService.countUnRead(receiver, News.NewsType.PUBLIC);
        Page<News> thirdNews =
                newsService.findByReceiverAndType(receiver, News.NewsType.THIRD, 0, INDEX_NEWS_SIZE);
        long unReadThird = newsService.countUnRead(receiver, News.NewsType.THIRD);
        
        model.addAttribute("personal", personal);
        model.addAttribute("public", publicNews);
        model.addAttribute("third", thirdNews);
        model.addAttribute("unReadThird", unReadThird);
        model.addAttribute("unReadPersonal", unReadPersonal);
        model.addAttribute("unReadPublic", unReadPublic);

    	return new ModelAndView("webApp/news/msgs"); 
    }
    
    @RequestMapping("/webApp/news")
    public ModelAndView webApp_news(HttpServletRequest request, Model model) {
    	
    	String receiver = "333232312143314";
        Page<News> personal =
                newsService.findByReceiverAndType(receiver, News.NewsType.PERSONAL, 0, INDEX_NEWS_SIZE);
        long unReadPersonal = newsService.countUnRead(receiver, News.NewsType.PERSONAL);
        Page<News> publicNews =
                newsService.findByReceiverAndType(receiver, News.NewsType.PUBLIC, 0, INDEX_NEWS_SIZE);
        long unReadPublic = newsService.countUnRead(receiver, News.NewsType.PUBLIC);
        Page<News> thirdNews =
                newsService.findByReceiverAndType(receiver, News.NewsType.THIRD, 0, INDEX_NEWS_SIZE);
        long unReadThird = newsService.countUnRead(receiver, News.NewsType.THIRD);
        model.addAttribute("personal", personal);
        model.addAttribute("public", publicNews);
        model.addAttribute("third", thirdNews);
        model.addAttribute("unReadThird", unReadThird);
        model.addAttribute("unReadPersonal", unReadPersonal);
        model.addAttribute("unReadPublic", unReadPublic);

    	return new ModelAndView("webApp/news/news"); 
    }
    
    /**
     * 登出
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/logout")
    public ModelAndView webApp_logout(HttpServletRequest request, Model model) {
    	String appTypel=(String)request.getSession().getAttribute("appType");
    	String openId1=(String)request.getSession().getAttribute("UserName");

    	//如果微信号和智阳用户已经绑定，那么解除绑定
    	if ( request.getSession().getAttribute("UserName") != null){
    		String openId = (String)request.getSession().getAttribute("UserName");
    		String apptype=(String)request.getSession().getAttribute("appType");
    		WeChatUser user = weChatService.findWeChatUser(openId,apptype);
    		if (user != null) {
    			user.setZhiyangUserName(null);
    			user.setLastAccessDate(new Date());
    			weChatService.save(user);	
    		}
    		request.getSession().removeAttribute("ZhiyangUserName");
    	}
    	Subject subject = SecurityUtils.getSubject();
    	if (subject.isAuthenticated()) {
    		subject.logout(); // session 会销毁，在SessionListener监听session销毁，清理权限缓存
    	}
    	
    	apptype=appTypel;
    	openid=openId1;
    	return new ModelAndView("webApp/logout"); 
    }
    
    /**
     * 公积金查询
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/nationalGuard")
    public String webApp_nationalGuard(HttpServletRequest request, Model model) {
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyyMM");
   	    GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
        Date date=new Date();
		gc.setTime(date);
		gc.add(Calendar.MONTH, -1);
//		String cardId = request.getParameter("cardId");
		String cardId = "";
    	if ( request.getSession().getAttribute("IdCard") != null){
    		cardId = (String) request.getSession().getAttribute("IdCard"); 
    	}
    	//获得由页面传入的月份
    	String month = request.getParameter("month");
    	
    	if(month==null){
    		//获得上个月 例如：201506
    		 month=sdf.format(gc.getTime());
    	}
        model.addAttribute("cardId", cardId);
        if(cardId.length()==18){
        	 model.addAttribute("handleIdCard", cardId.replace(cardId.substring(6,14), "xxxxxxxx"));
        }
        if(cardId.length()==15){
        	 model.addAttribute("handleIdCard", cardId.replace(cardId.substring(6,12), "xxxxxx"));
       }
       
        model.addAttribute("month", month);
        return "webApp/nationGuard";
    }
    
    
    /**
     * 消息详情页
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/news/msgDetail")
    public String webApp_msgDetail(HttpServletRequest request, Model model) {
    	Long id = Long.valueOf(request.getParameter("id"));
        News news = newsService.findOne(id);
        model.addAttribute("news", news);
        newsService.markRead(id);
        return "webApp/news/msgDetail";
    }
    
    @RequestMapping("/webApp/news/newDetail")
    public String webApp_newsDetail(HttpServletRequest request, Model model) {
    	Long id = Long.valueOf(request.getParameter("id"));
        News news = newsService.findOne(id);
        model.addAttribute("news", news);
        newsService.markRead(id);
        return "webApp/news/newsDetail";
    }
    /**
     * 通讯录
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/tongxunlu")
    public String webApp_userTongxunlu(HttpServletRequest request, Model model) {
    	
        return "webApp/tongxunlu";
    } 
    /**
     * 通讯录详情
     * @param request
     * @param model
     * @return
     * @throws UnsupportedEncodingException 
     */
    @RequestMapping("/webApp/tongxunluDetail")
    public ModelAndView webApp_userTongxunluDetail(HttpServletRequest request, Model model) {
    	model.addAttribute("tusername", request.getParameter("tusername"));
    	model.addAttribute("tdept", request.getParameter("tdept"));
    	model.addAttribute("tposition", request.getParameter("tposition"));
    	model.addAttribute("tmobile", request.getParameter("tmobile"));
    	model.addAttribute("tphone", request.getParameter("tphone"));
    	model.addAttribute("temail", request.getParameter("temail"));
        return new ModelAndView("webApp/tongxunluDetail");
    } 
    /**
     * 雇员账户激活
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/anon/accountActivate")
    public ModelAndView webApp_useraccountActivate(HttpServletRequest request, Model model) {
    	String checkCode = (String) request.getSession().getAttribute("activeCode");
    	String inputCode = request.getParameter("messagecode");
    	String mobile = request.getParameter("mobile");
    	
    	if (mobile == null || checkCode == null || inputCode == null ){
    		
    	}
    	//暂时关掉短信验证
    	else if(!checkCode.equals(inputCode)){
    		model.addAttribute("codeTip", false);
    		
    	}
    	else{
    		request.getSession().setAttribute("inputMobile", mobile);
    		return new ModelAndView("redirect:/webApp/anon/accountActivate2");
    	}
    	
    	return new ModelAndView("/webApp/user/accountActivate");
    } 
    
    /**
     * 雇员账户激活2
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/anon/accountActivate2")
    public ModelAndView webApp_useraccountActivate2(HttpServletRequest request, Model model) {
    	String mobile = (String) request.getSession().getAttribute("activeMobile");
    	if (mobile == null){
    		return new ModelAndView("redirect:/webApp/anon/accountActivate");
    	}
    	
    	String inputPassword = request.getParameter("new_password");
    	String inputPassword2 = request.getParameter("a_new_password");

    	if (inputPassword == null || inputPassword2 == null || inputPassword.equals("") || !inputPassword.equals(inputPassword2)){
    		
    	}else{
    		request.getSession().removeAttribute("errorMessage");
    		
    		//执行激活用户
    	    ReturnS result=centerUserService.activeAccount(mobile, mobile, inputPassword);
    	    
    	    if(result.getSuccess()){
    	    	request.getSession().setAttribute("activeCode", null);//清空Session中的验证码
    	    }
    	    model.addAttribute("tip", result.getSuccess());
    		
    	}
    	
    	return new ModelAndView("/webApp/user/accountActivate2");
    }  
    
    
    /**
     * 安全认证--修改用户密码（用户中心）
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/accountSecurityCertify")
    public ModelAndView webApp_useraccountSecurityCertify(HttpServletRequest request, Model model) {
    	
//    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
//				.getAttribute("userInfo");
    	
    	CenterSysUser userInfo  = (CenterSysUser)request.getSession().getAttribute("userInfo");

		String mobile = userInfo.getOrgPerson().getMobile();
    	String checkCode = (String) request.getSession().getAttribute("activeCode");
    	String inputCode = request.getParameter("messagecode");
    	if(mobile!=null&&!mobile.equals("")){
			model.addAttribute("handleMobile",mobile.replace(mobile.substring(3, 8), "xxxx"));
		}else{
			return new ModelAndView("redirect:/webApp/user");
		}
    	model.addAttribute("mobile", mobile);
    	
    	if (checkCode == null || inputCode == null ){
    		
    	}else if(!checkCode.equals(inputCode)){
    		model.addAttribute("codeTip", false);
    		
    	}else{
		    return new ModelAndView("redirect:/webApp/user/update_password");
	     }
    	
    	return new ModelAndView("/webApp/user/accountSecurityCertify");

    } 
    
    /**
     * 安全认证2  身份证验证（步骤以去掉）
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/accountSecurityCertify2")
    public ModelAndView webApp_useraccountSecurityCertify2(HttpServletRequest request, Model model) {
    	String cardId = (String) request.getSession().getAttribute("IdCard");
    	String passportCode = request.getParameter("passportCode");
    	if (passportCode != null && !passportCode.equals("") &&passportCode.equals(cardId)){
    		return new ModelAndView("redirect:/webApp/user/update_password");
    	}
    	
        return new ModelAndView("webApp/user/accountSecurityCertify2");
    }   
    
    /**
     * 安全认证---修改邮箱  发送手机验证码
     */
    @RequestMapping("/webApp/user/emailSecurityCertify")
    public ModelAndView webApp_userEmailSecurityCertify(HttpServletRequest request, Model model) {
    	
    	CenterSysUser userInfo  = (CenterSysUser)request.getSession().getAttribute("userInfo");
		String mobile = userInfo.getOrgPerson().getMobile();
    	
    	String checkCode = (String) request.getSession().getAttribute("activeCode");
    	String inputCode = request.getParameter("messagecode");
    	if(mobile!=null&&!mobile.equals("")){
			model.addAttribute("handleMobile",mobile.replace(mobile.substring(3, 8), "xxxx"));
		}else{
			return new ModelAndView("redirect:/webApp/user");
		}
    	model.addAttribute("mobile", mobile);
    	if (StringUtils.isBlank(inputCode) || checkCode == null || inputCode == null ){
    		
    	}else if(!checkCode.equals(inputCode)){
    		model.addAttribute("codeTip", false);
    	}else{
    		return new ModelAndView("redirect:/webApp/user/mailbox");
    	}
    	
    	return new ModelAndView("/webApp/user/emailSecurityCertify");
    } 
    
    /**
     * 个人邮箱
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/mailbox")
    public ModelAndView webApp_userMailbox(HttpServletRequest request, Model model) {
    	String username = (String) request.getSession().getAttribute("ZhiyangUserName");
    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
    	String email = userInfo.getOrgPerson().getEmail();
    	model.addAttribute("email", email);
    	String newEmail = request.getParameter("email");
    	System.out.println(ValidatorBasic.isEmail(newEmail));
    	if (newEmail != null && !newEmail.equals("")&&ValidatorBasic.isEmail(newEmail) ){
    		//修改邮箱
    		ReturnS rs=centerUserService.updateEmailInfo(username, newEmail);
    		if(rs.getSuccess()){
    			request.getSession().setAttribute("activeCode", null);//清空Session中的验证码
    			userInfo.getOrgPerson().setEmail(newEmail);
        		request.getSession().setAttribute("userInfo",userInfo);
    		}
    		return new ModelAndView("redirect:/webApp/user/");
    	}
    	
        return new ModelAndView("/webApp/user/mailbox");
    }    
    
    /**
     * 用户修改支付密码(用户已设置过支付密码  跳转到修改支付密码页面,需输入原始密码)
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/update_payment_password")
    public String webApp_userPayPass_update(HttpServletRequest request, Model model) {
        return "webApp/user/update_payment_password";
    }
    
    /**
     * 用户设置支付密码(用户未设置过支付密码  跳转到设置支付密码页面)
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/payment_password")
    public String webApp_userPayPass(HttpServletRequest request, Model model) {
        return "webApp/user/payment_password";
    }
    /**
     * 所在城市
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/city")
    public ModelAndView webApp_userCity(HttpServletRequest request, Model model) {
    	String city="上海";//此城市后期要根据登录用户的详细信息获取的
    	//String ccity=request.getParameter("ccity");
    	if(city!=null&&!city.equals("")){
    		//修改城市，接口有问题，暂时注掉
    		//hrofirstUserService.updateCityInfo(username, ccity);
    		model.addAttribute("city",city);
    	}
        return new ModelAndView("webApp/user/city");
    }
    
    /**
     * 安全认证---修改手机号码 发送手机验证码
     */
    @RequestMapping("/webApp/user/mobileSecurityCertify")
    public ModelAndView webApp_userMobileSecurityCertify(HttpServletRequest request, Model model) {
    	
    	
    	CenterSysUser userInfo  = (CenterSysUser)request.getSession().getAttribute("userInfo");
		String mobile = userInfo.getOrgPerson().getMobile();
    	String checkCode = (String) request.getSession().getAttribute("activeCode");
    	String inputCode = request.getParameter("messagecode");
    	model.addAttribute("mobile", mobile);
    	
    	if(mobile!=null&&!mobile.equals("")){
			model.addAttribute("handleMobile",mobile.replace(mobile.substring(3, 8), "xxxx"));
		}else{
			return new ModelAndView("redirect:/webApp/user");
		}
    	
    	if (checkCode == null || inputCode == null ){

    	}else if(!checkCode.equals(inputCode)){
    		model.addAttribute("codeTip", false);
    		
    	}else{
    		//跳转到修改手机号码页面
    		return new ModelAndView("redirect:/webApp/user/phone_number");
    	}
    	
    	return new ModelAndView("/webApp/user/mobileSecurityCertify");
    } 
    /**
     * 用户手机号
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/phone_number")
    public ModelAndView webApp_userPhoneNum(HttpServletRequest request, Model model) {

    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
    	
		String username = (String) request.getSession().getAttribute(
				"ZhiyangUserName");

		String mobile = userInfo.getOrgPerson().getMobile();
    	model.addAttribute("mobile", mobile);
    	String checkCode = (String) request.getSession().getAttribute("activeCode");
    	String inputCode = request.getParameter("messagecode");
    	String inputMobile = request.getParameter("mobile");
    	
    	if (inputMobile == null || checkCode == null || inputCode == null ){
    	}else if(!checkCode.equals(inputCode)){
    		model.addAttribute("codeTip", false);
    		
    	}else{
    		
    		//修改手机号码
    		ReturnS rs=centerUserService.updateMobile(username, inputMobile);
    		if(rs.getSuccess()){
    			request.getSession().setAttribute("activeCode", null);//清空Session中的验证码
    			userInfo.getOrgPerson().setMobile(inputMobile);
        		request.getSession().setAttribute("userInfo",userInfo);
    		}
    		
    		
    	    return new ModelAndView("redirect:/webApp/user");
    	}
    	
    	return new ModelAndView("/webApp/user/phone_number");
    	
       
    }

    
    
    /**
     * 用户安全校验
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/securityCheck")
    public String webApp_usersecCheck(HttpServletRequest request, Model model) {
        return "webApp/user/securityCheck";
    }
    
    /**
     * 忘记密码，找回密码
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/anon/find_password")
    public ModelAndView webApp_userUpPass(HttpServletRequest request, Model model) {
    	String inputMobile = request.getParameter("mobile");
    	String inputCode = request.getParameter("messagecode");
    	String checkCode = (String) request.getSession().getAttribute("activeCode");
    	
    	if ((inputMobile != null&&!inputMobile.equals(""))  || (inputCode != null&&!inputCode.equals(""))){
    		String username=centerUserService.getLoginNameByMobile(inputMobile,  CenterUserService.USER_TYPE_INDIVIDUAL);
        	
    		if(username!=null){
    			if(StringUtils.isNotBlank(inputCode) && !username.equals("")&& (checkCode!=null&&checkCode.equals(inputCode))){
            		//System.out.println("username======"+username);
            		request.getSession().setAttribute("upusername", username);
            		model.addAttribute("username", username);
            		return new ModelAndView("redirect:/webApp/anon/find_password1");
            	}
    		} 
        		model.addAttribute("errorinfo", "信息填写错误，请重新填写！");
        	 
    	}
    		return new ModelAndView("/webApp/user/find_password");
    }
    /**
     * 用户找回密码 ----设置密码
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/anon/find_password1")
    public ModelAndView  webApp_findPassword1(HttpServletRequest request,Model model) {
    	String inputPassword = request.getParameter("new_password");
    	String inputPassword2 = request.getParameter("a_new_password");
    	if (inputPassword == null || inputPassword2 == null || inputPassword.equals("") || inputPassword2.equals("")){
    	}else{
    		request.getSession().removeAttribute("errorMessage");
    		//执行修改密码
    		String username=(String) request.getSession().getAttribute("upusername");
    		ReturnS result=centerUserService.updatePassword(username, inputPassword);
    		
    		if(result.getSuccess()){
    	    	request.getSession().setAttribute("activeCode", null);//清空Session中的验证码
    	    }
    		model.addAttribute("tip",result.getSuccess());
    	}
    	
    	 return new ModelAndView("webApp/user/find_password1");
    	
    }
    /**
     * 用户修改密码
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/update_password")
    public ModelAndView  webApp_userUserPass(HttpServletRequest request,Model model) {
    	String username = (String) request.getSession().getAttribute("ZhiyangUserName");
    	String userPassword=(String)request.getSession().getAttribute("ZhiyangPassword");
    	String inputOldPassword = request.getParameter("old_password");
    	String inputPassword = request.getParameter("new_password");
    	String inputPassword2 = request.getParameter("a_new_password");
    	if (inputPassword == null || inputPassword2 == null || inputPassword.equals("") || inputPassword2.equals("")){
    		
    	}else if(!inputOldPassword.endsWith(userPassword)){
			model.addAttribute("pwdTip", false);
		}else{
			request.getSession().removeAttribute("errorMessage");
    		//执行修改密码
    		ReturnS result=centerUserService.updatePassword(username, inputPassword);
    	    if(result.getSuccess()){
     	    	request.getSession().setAttribute("activeCode", null);//清空Session中的验证码
     	    }
    		model.addAttribute("tip", result.getSuccess());
    	}
    	
    	 return new ModelAndView("webApp/user/update_password");
    	
    }
    
    
    /**
     * 工资单
     * @param cardId
     * @param month
     * @param model
     * @return
     */
    @RequestMapping("/webApp/salary")
    public String wsalary(HttpServletRequest request, Model model) {
		CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
		model.addAttribute("mobile", userInfo.getOrgPerson().getMobile());
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyyMM");
   	    GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
        Date date=new Date();
		gc.setTime(date);
		gc.add(Calendar.MONTH, -1);
		
    	String cardId = "";
//    	获得页面传入的身份证
//    	String cardId = request.getParameter("IdCard");
//    	if (cardId == null){
//    		cardId = hrofirstUserService.getDetailLoginInfo(login);
//		
//    	}
    
    	if ( request.getSession().getAttribute("IdCard") != null){
    		cardId = (String) request.getSession().getAttribute("IdCard"); 
    	}
    	
    	//获得页面传入的月份
    	String month = request.getParameter("month");
    	
    	if (month == null){
    		//获得上个月 例如：201506
    		 month=sdf.format(gc.getTime());
    	}
        model.addAttribute("cardId", cardId);
        model.addAttribute("month", month);
        return "webApp/salary";
    }
  
    @RequestMapping("/webApp/walletintegration")
    public ModelAndView walletintegration(HttpServletRequest request, Model model) {
    	
		String name = (String) request.getSession().getAttribute("ZhiyangUserName");
        return new ModelAndView("redirect:"+Config.getWallet_url()+name);
    }
    
    @RequestMapping("/webApp/empCheck")
    public ModelAndView empCheck(HttpServletRequest request, Model model) {
    	String cardId ="";
//    	String cardId = request.getParameter("cardId");
//    	
//    	if (cardId == null)
//    		cardId = "xxx";
//
//    	if ( request.getSession().getAttribute("IdCard") != null){
//    		cardId = (String) request.getSession().getAttribute("IdCard"); 
//    	}
//    	
//    	if (!cardId.equals("")){
    		CenterSysUser userInfo = (CenterSysUser) request.getSession().getAttribute("userInfo");
    		cardId = userInfo.getOrgPerson().getCardNum();
    		System.out.println(userInfo.getOrgOrganization().getHroOrgId());
    	//}
    	
        model.addAttribute("cardId", cardId);
        model.addAttribute("ak", Config.getBMapAK());
        return new ModelAndView("webApp/empCheck");
    }	
    
    
    
    
    @RequestMapping("/aboutUs")
    public String aboutUs() {
        return "/about";
    }

    @RequestMapping("/selectCity")
    public String selectCity(Model model) {
        List<Province> provinces = provinceService.findByTypeNot(ProvinceService.ProvinceType.其他国家);
        model.addAttribute("provinces", provinces);
        model.addAttribute("cities", cityService.findByProvince(provinces.get(0).getId()));

        return "/selectCity";
    }

    @RequestMapping("/policy")
    public String policy(@RequestParam long city, Model model) {
        List<Policy> policy = policyService.findByCity(city);
        if (policy != null && !policy.isEmpty()) {
            model.addAttribute("url", policy.get(0).getUrl());
        }
        
        return "/policy";
    }
    
    
//    @RequestMapping(value={"/workStation"})
//    public String workStation(Model model, String code) {
//        if (code != null) {
//            String openId = oAuthAPI.getToken(code).getOpenid();
//            if (openId != null) {
//                WeChatUser user = weChatService.findByUsername(openId);
//                if (user != null && user.getIdCard() != null) {
//                    model.addAttribute("cardId", user.getIdCard());
//                    return "workStation";
//                }
//            }
//        }
//       return "noId";
//    }

    /**
     * url:hrhelper-platform/SocialInsuranceController.action
     * <p/>
     * 接收参数名：身份证号：cardId;     姓名：employeeName;     月份：month(yyyyMM)
     * <p/>
     * 示例返回：
     * 正常返回：{"cardId":"333232312143314","month":"201106","employeeName":"张三","sbEmpAccount":"0809839434343",
     * "errorMessage":"",
     * [{"prodName":"养老保险","companyBase":"9000","individualBase":"9000",
     * "companyRatio":"0.20","individualRatio":"0.08","companyAppend":"0",
     * "individualAppend":"0","companySum":"1800","individualSum":"720",
     * "compensationSum":"0"},{"prodName":"医疗保险","companyBase":"9000","individualBase":"9000",
     * "companyRatio":"0.20","individualRatio":"0.08","companyAppend":"0",
     * "individualAppend":"0","companySum":"1800","individualSum":"720",
     * "compensationSum":"0"}]}
     * 异常返回：{"cardId":"333232312143314","month":"201106","employeeName":"张三","sbEmpAccount":"0809839434343",
     * "errorMessage":"所查信息不存在",[]}
     * 字段说明
     * 姓名：employeeName;     公积金账号：sbEmpAccount;
     * 产品名：prodName;     企业基数：companyBase;     个人基数：individualBase;
     * 企业比例：companyRatio;     个人比例：individualRatio;     企业附加额：companyAppend;
     * 个人附加额：individualAppend;		企业金额：companySum;     个人金额：individualSum;     补差额：compensationSum
     * 错误信息：errorMessage
     * *
     */
    @RequestMapping("/nationalGuard")
    public String nationalGuard(
            @RequestParam String cardId, @RequestParam String month, Model model) {
        model.addAttribute("cardId", cardId);
        model.addAttribute("month", month);
        return "/nationGuard";
    }

    /**
     * url:/service/ewage.e?login="???"
     * 姓名:001
     * 薪资年月：002
     * 基本工资：003
     * 应发合计：004
     * 保险个人缴纳合计：005
     * 保险单位合计：006
     * 个税所得税：007
     * 实发工资：008
     * <p/>
     * errorMessage:"异常信息" ，success:"true/false"，"001":"8999",….
     * *
     */
    @RequestMapping("/salary")
    public String salary(@RequestParam String cardId, @RequestParam String month, Model model) {
        model.addAttribute("cardId", cardId);
        model.addAttribute("month", month);
        return "/salary";
    }

    /**
     * 新闻
     * @param receiver
     * @param model
     * @return
     */
    @RequestMapping("/news")
    public String news(
            @RequestParam String receiver, Model model) {
        Page<News> personal =
                newsService.findByReceiverAndType(receiver, News.NewsType.PERSONAL, 0, INDEX_NEWS_SIZE);
        long unReadPersonal = newsService.countUnRead(receiver, News.NewsType.PERSONAL);
        Page<News> publicNews =
                newsService.findByReceiverAndType(receiver, News.NewsType.PUBLIC, 0, INDEX_NEWS_SIZE);
        long unReadPublic = newsService.countUnRead(receiver, News.NewsType.PUBLIC);
        Page<News> thirdNews =
                newsService.findByReceiverAndType(receiver, News.NewsType.THIRD, 0, INDEX_NEWS_SIZE);
        long unReadThird = newsService.countUnRead(receiver, News.NewsType.THIRD);
        model.addAttribute("personal", personal);
        model.addAttribute("public", publicNews);
        model.addAttribute("third", thirdNews);
        model.addAttribute("unReadThird", unReadThird);
        model.addAttribute("unReadPersonal", unReadPersonal);
        model.addAttribute("unReadPublic", unReadPublic);

        return "/news/news";
    }

    /**
     * 根据新闻类型查询
     * @param receiver
     * @param type
     * @param page
     * @param size
     * @param model
     * @return
     */
    @RequestMapping("/news/types")
    public String news(
            @RequestParam String receiver,
            @RequestParam News.NewsType type,
            @RequestParam(defaultValue = "0", required = false) int page,
            @RequestParam(defaultValue = "10", required = false) int size,
            Model model) {
        model.addAttribute("unRead", newsService.countUnRead(receiver, type));
        Page<News> news =
                newsService.findByReceiverAndType(receiver, type, page, size);
        model.addAttribute("page", news);
        return "/news/type";
    }
    
    /**
     * 新闻详情页
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/news/{id}")
    public String news(
            @PathVariable Long id, Model model) {
        News news = newsService.findOne(id);
        model.addAttribute("news", news);
        newsService.markRead(id);
        return "/news/detail";
    }

    @RequestMapping(value={"/"})
    public ModelAndView index() {
    	
    	return new ModelAndView("redirect:/webApp/index");
    }

    @RequestMapping(value = {"/apps"})
    public String apps(Model model) {
        model.addAttribute("ios_download_path", Config.getIosDownloadPath());
        return "/apps";
    }
    @RequestMapping(value = {"/baidu"})
    public String baidu() {
        return "/baidu";
    }
    
    @Autowired
    private apiDataJMSSender apiDataJMSSender;
    
    /**
     * activeMQ发送消息
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = {"/jmssender/{id}"})
    public String jmssender(@PathVariable String id, Model model) {
    	
    	apiDataJMSSender.testDatacenterSend(id);  
        return "";
    }
    
    /**
     * activeMQ接收消息
     * @param response
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = {"/jmsreceiver/{id}"})
    public String jmsreceiver(HttpServletResponse response, @PathVariable String id, Model model) {
    	
        try {  
            OutputStream os = response.getOutputStream();  
            os.write(apiDataJMSSender.getData(id).getBytes("UTF-8"));  
            os.flush();  
            os.close();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }

        return null;
    }    
    
    /**
     * 体检预约 tijian 体检券
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/tijian/tijian")
    public ModelAndView webApp_tijian_tijian(HttpServletRequest request, Model model) {
    	
    	return new ModelAndView("webApp/tijian/tijian"); 
    }
    /**
     * 体检预约 tijianli 延迟加载
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/tijian/tijianli")
    public ModelAndView webApp_tijian_tijianli(HttpServletRequest request, Model model) {
    	
    	return new ModelAndView("webApp/tijian/tijianli"); 
    }
    
    /**
     * 体检预约 tijian1 体检机构列表
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/tijian/tijian1")
    public ModelAndView webApp_tijian_tijian1(HttpServletRequest request, Model model) {
    	String prodId=request.getParameter("prod_id");//产品id
    	model.addAttribute("prodId", prodId);
    	String service_id=request.getParameter("service_id");//产品id
    	model.addAttribute("service_id", service_id);
    	return new ModelAndView("webApp/tijian/tijian1"); 
    }
    
    /**
     * 体检预约 tijian11 预约和体检机构详情
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/tijian/tijian11")
    public ModelAndView webApp_tijian_tijian11(HttpServletRequest request, Model model) {
    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
    	Long userid = userInfo.getLoginUser().getLoginId();  
        String servicestoreid=request.getParameter("servicestoreid");
    	String serviceId=request.getParameter("service_id");
    	String prodid=request.getParameter("prodid");
    	model.addAttribute("servicestoreid", servicestoreid);
    	model.addAttribute("service_id", serviceId);
    	model.addAttribute("userid", userid);
    	model.addAttribute("prodid", prodid);
    	return new ModelAndView("webApp/tijian/tijian11"); 
    }
    
    /**
     * 体检预约 tijian111 地图显示多个机构地址
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/tijian/tijian111")
    public ModelAndView webApp_tijian_tijian111(HttpServletRequest request, Model model) {
    	
    	return new ModelAndView("webApp/tijian/tijian111"); 
    }
    
    /**
     * 根据经纬度显示标注在地图上
     * @param request
     * @param model
     * @return
     * @throws UnsupportedEncodingException 
     */
    @RequestMapping("/webApp/tijian/tijian112")
    public ModelAndView webApp_tijian_tijian112(HttpServletRequest request, Model model) throws UnsupportedEncodingException {
    	return new ModelAndView("webApp/tijian/tijian112"); 
    }
    /**
     * 体检预约 tijian12 已预约-预约详情
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/tijian/tijian12")
    public ModelAndView webApp_tijian_tijian12(HttpServletRequest request, Model model) {
    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
    	Long userid = userInfo.getLoginUser().getLoginId();  
    	String service_id=request.getParameter("service_id");//产品id
    	model.addAttribute("service_id", service_id);
    	model.addAttribute("userid", userid);
    	return new ModelAndView("webApp/tijian/tijian12"); 
    }
    
    /**
     * 体检预约 tijian13 点击日历预约时跳转到填写信息页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/tijian/tijian13")
    public ModelAndView webApp_tijian_tijian13(HttpServletRequest request, Model model) {
    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
    	Long userid = userInfo.getLoginUser().getLoginId();  
    	
    	ReceivingAddrInfo receivingAddrInfo=receivingAddrServiceInterface.getDefaultAddr(userid);
    	model.addAttribute("userid", userid);
    	model.addAttribute("receivingAddrInfo", receivingAddrInfo);
    	return new ModelAndView("webApp/tijian/tijian13"); 
    }
    /**
     * 根据卡号绑定体检卡
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/tijianbangding")
    public ModelAndView tijianbangding(HttpServletRequest request, Model model) {
    	return new ModelAndView("webApp/tijian/tijianbangding"); 
    }
    /**
     * 收货地址管理
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/receiveAddress")
    public ModelAndView reciveAddress(HttpServletRequest request, Model model) {
    	String flag=request.getParameter("param");
    	if(flag!=null&&flag.equals("onlyaddress")){
    		model.addAttribute("paramflag", flag);
    	}
    	return new ModelAndView("webApp/user/receiveAddress"); 
    }
    /**
     * 新建收货地址
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/addAddress")
    public ModelAndView addAddress(HttpServletRequest request, Model model) {
    	String flag=request.getParameter("param");
    	if(flag!=null&&flag.equals("onlyaddress")){
    		model.addAttribute("paramflag", flag);
    	}
    	return new ModelAndView("webApp/user/addAddress"); 
    }
    /**
     * 修改收货地址
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/updateAddress")
    public ModelAndView updateAddress(HttpServletRequest request, Model model) {
    	String flag=request.getParameter("param");
    	if(flag!=null&&flag.equals("onlyaddress")){
    		model.addAttribute("paramflag", flag);
    	}
    	System.out.println(request.getParameter("receivingAddrId"));
        ReceivingAddrInfo receivingAddrInfo=receivingAddrServiceInterface.selectReceivingAddr(Long.parseLong(request.getParameter("receivingAddrId")));
        model.addAttribute("receivingAddrInfo",receivingAddrInfo);
    	return new ModelAndView("webApp/user/updateAddress"); 
    }
    /**
     * 跳转至资料上传页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/user/dataUpload")
    public String upload(HttpServletRequest request, Model model) {
    	 
    	return "webApp/user/dataUpload"; 
    }
    
    
    /**
     * 资料上传
     */
    @SuppressWarnings("rawtypes")
	@RequestMapping("/webApp/user/uploadFile")
	@ResponseBody
	public String uploadFile(@RequestParam MultipartFile[] myfiles,HttpServletResponse response,HttpServletRequest request) throws Exception{
    	
    	//Map result=wechatFileService.uploadFiles(myfiles, response, request);
    	Map result=weChatUploadFileService.uploadFiles(myfiles, response, request);
     
		return JSON.toJSONString(result);
	}
    /**
     * 社保公积金查询工具首页
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/sbGjjTools/officialData")
    public String sbGjjOfficialData(HttpServletRequest request, Model model) {
    	
    	return "webApp/sbGjjTools/officialData"; 
    }
    
    /**
     * 社保公积金查询工具首页
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/sbGjjTools/index")
    public String sbGjjIndex(HttpServletRequest request, Model model) {
    	
    	return "webApp/sbGjjTools/index"; 
    }
    
    
    /**
     * 公积金详情页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/sbGjjTools/detail_paf")
    public String sbGjjDetailPaf(HttpServletRequest request, Model model) {
    	String jsonStr="{\"errorMessage\":\"该用户不存在！\",\"userName\":\"hehe\"}";
    	//String params="?sKey=f05ebcc0eb47cfdd8d4aee4b584e0b7c&type="+type+"&name="+name+"&pwd="+pwd+"&loginType=&idcard=&name=&vCode=&sid=";
    	String type=request.getParameter("type");
    	String name=request.getParameter("name");
    	String pwd=request.getParameter("pwd");
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	BaobeikejiClient baobeikejiClient = new BaobeikejiClient();
    	
    	paramMap.put("sKey", "f05ebcc0eb47cfdd8d4aee4b584e0b7c");
    	if(type!=null&&!type.equals("")){
    		paramMap.put("type", Integer.parseInt(type));
    	}
    	if(name!=null&&!name.equals("")){
    		paramMap.put("cardNo", name);
    	}
		if(pwd!=null&&!pwd.equals("")){
			paramMap.put("pwd", pwd);
		}
    	 
    	
		try {
			jsonStr = baobeikejiClient.invoke(paramMap);
			System.out.println(jsonStr);
			JSONObject object0 = JSON.parseObject(jsonStr);
		      
		    int code= (Integer) object0.get("code");
		    
		    if(code==10008){//验证码错误，重新请求
		    	JSONObject object1 = JSON.parseObject(object0.get("data").toString());
		    	paramMap.put("vCode", object1.get("sid"));
		    	paramMap.put("sid", object1.get("url"));
		    	jsonStr = baobeikejiClient.invoke(paramMap);
		    }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	model.addAttribute("result", jsonStr);
    	return "webApp/sbGjjTools/detail_paf"; 
    }
    
    /**
     * 社保详情页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/webApp/sbGjjTools/detail")
    public String sbGjjDetail(HttpServletRequest request, Model model) {
    	String jsonStr="{\"errorMessage\":\"数据错误！\"}"; 
    	String type=request.getParameter("type");
    	String idcard=request.getParameter("idcard");
    	String pwd=request.getParameter("pwd");
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	BaobeikejiClient baobeikejiClient = new BaobeikejiClient();
    	
    	paramMap.put("sKey", "f05ebcc0eb47cfdd8d4aee4b584e0b7c");
    	if((type!=null&&!type.equals(""))&&(idcard!=null&&!idcard.equals(""))&&(pwd!=null&&!pwd.equals(""))){
    		paramMap.put("type", Integer.parseInt(type));
    		paramMap.put("cardNo", idcard);
    		paramMap.put("pwd", pwd);
    	}else{
    		model.addAttribute("result", "{\"errorMessage\":\"输入错误！\"}");
        	return "webApp/sbGjjTools/detail"; 
		}
    	 
		try {
			jsonStr = baobeikejiClient.invoke(paramMap);
//			System.out.println(jsonStr);
			JSONObject object0 = JSON.parseObject(jsonStr);
		      
		    int code= (Integer) object0.get("code");
		    
		    if(code==10008){//验证码错误，重新请求
		    	JSONObject object1 = JSON.parseObject(object0.get("data").toString());
		    	paramMap.put("vCode", object1.get("sid"));
		    	paramMap.put("sid", object1.get("url"));
		    	jsonStr = baobeikejiClient.invoke(paramMap);
		    }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
		model.addAttribute("result", jsonStr);
		model.addAttribute("sbType", type);
    	return "webApp/sbGjjTools/detail"; 
    }
  
    public static void main(String args[]){
//    	SimpleDateFormat sdf=new SimpleDateFormat("yyyyMM");
//    	Calendar cal = Calendar.getInstance();
//        int day = cal.get(Calendar.DATE);
//        int month = cal.get(Calendar.MONTH) + 1;
//         System.out.println(month);
//         
//         GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
//         Date date=new Date();
// 		gc.setTime(date);
// 		gc.add(Calendar.MONTH, -1);
// 		System.out.println(sdf.format(gc.getTime()));
// 		String idcard="420626199309013017";//310109xxxxxxxx0018
// 		System.out.println(idcard.replace(idcard.substring(6,14), "xxxxxxxx"));
// 		String idcard15="130503670401001";
// 		System.out.println(idcard15.replace(idcard15.substring(6,12), "xxxxxx"));
// 		String mobile="13811431906";
// 		System.out.println(mobile.replace(mobile.substring(3,8), "xxxx"));
 		
    /*	String path=System.getProperty("user.dir");
    	String p=System.getProperty("user.dir")+"\\uploadFile\\hello2.txt";
    	System.out.println("path="+p);
 		try {
			FileUtil.newFile(p);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
 		
 	  
 		String jsonStr="{ \"code\": 10008, \"data\" : { \"sid\" :\"22016031710194056ea143cdbfe4\"   , \"url\": \"hello\"  } }";
    	JSONObject object0 = JSON.parseObject(jsonStr);
 		System.out.println(object0.get("code"));
 		
 		JSONObject object1 = JSON.parseObject(object0.get("data").toString());
 		
 		System.out.println(object1.get("sid"));
 		System.out.println(object1.get("url"));
 		
 		
    }
}
