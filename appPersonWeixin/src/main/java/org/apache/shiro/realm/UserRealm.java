package org.apache.shiro.realm;

import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

import com.fnst.es.common.repository.support.SimpleBaseRepositoryFactoryBean;
import com.fnst.es.common.utils.security.Md5Utils;
import com.hrofirst.entity.WeChatUser;
import com.hrofirst.service.WeChatService;
import com.hrofirst.util.ValidatorBasic;
import com.service.provider.CenterUserService;
import com.service.provider.entity.CenterSysUser;
import com.service.provider.entity.CenterUserInfo;
import com.service.provider.entity.ReturnS;

public class UserRealm extends AuthorizingRealm {

	@Autowired
	CenterUserService centerUserService;

	@Autowired
	private WeChatService weChatService;

	@Autowired
	public UserRealm(ApplicationContext ctx) {
		super();
		// 不能注入 因为获取bean依赖顺序问题造成可能拿不到某些bean报错
		// why？
		// 因为spring在查找findAutowireCandidates时对FactoryBean做了优化，即只获取Bean，但不会autowire属性，
		// 所以如果我们的bean在依赖它的bean之前初始化，那么就得不到ObjectType（永远是Repository）
		// 所以此处我们先getBean一下 就没有问题了
		ctx.getBeansOfType(SimpleBaseRepositoryFactoryBean.class);
	}

	private static final String OR_OPERATOR = " or ";
	private static final String AND_OPERATOR = " and ";
	private static final String NOT_OPERATOR = " not ";

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		System.out.println("hsx 权限");
		return null;
	}

	/**
	 * 支持or and not 关键词 不支持and or混用
	 * 
	 * @param principals
	 * @param permission
	 * @return
	 */
	public boolean isPermitted(PrincipalCollection principals, String permission) {
		if (permission.contains(OR_OPERATOR)) {
			String[] permissions = permission.split(OR_OPERATOR);
			for (String orPermission : permissions) {
				if (isPermittedWithNotOperator(principals, orPermission)) {
					return true;
				}
			}
			return false;
		} else if (permission.contains(AND_OPERATOR)) {
			String[] permissions = permission.split(AND_OPERATOR);
			for (String orPermission : permissions) {
				if (!isPermittedWithNotOperator(principals, orPermission)) {
					return false;
				}
			}
			return true;
		} else {
			return isPermittedWithNotOperator(principals, permission);
		}
	}

	private boolean isPermittedWithNotOperator(PrincipalCollection principals,
			String permission) {
		if (permission.startsWith(NOT_OPERATOR)) {
			return !super.isPermitted(principals,
					permission.substring(NOT_OPERATOR.length()));
		} else {
			return super.isPermitted(principals, permission);
		}
	}

	@Override
	public boolean supports(AuthenticationToken token) {
		return token instanceof StatelessToken || super.supports(token);
	}

	/**
	 * 登录入口
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		// 获取登录信息，用户名userName，密码password
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		// 获取session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		if(StringUtils.isBlank(token.getUsername())){
			session.setAttribute("errorMessageInfo", null);
			session.setAttribute("errorMessage", null);
			session.setAttribute("errorMessage", 4);
			return null;
		}
		String userName = token.getUsername();
		String password="";
		if(token.getPassword()!=null&&!token.getPassword().equals("")){
		   password = String.valueOf(token.getPassword());
		}else{
			session.setAttribute("errorMessageInfo", null);
			session.setAttribute("errorMessage", null);
			session.setAttribute("errorMessageInfo", "请输入密码！");
			return null;
		}
		
		// 根据登录用户名获取用户信息
		ReturnS userS = null;		//用户验证相关信息
		ReturnS userGetInfo = null;	//根据用户名称获得的用户信息
		CenterSysUser userInfo = null;
		CenterUserInfo centerUserInfo = null;
		// 智阳用户名、密码登录  
		try {
			if (!"______".equals(password)) {
				//根据输入的用户名和密码登录验证拿用户的真正loginName
				userS = centerUserService.loginAuth(
						CenterUserService.LOGIN_TYPE_LOGINNAME,
						CenterUserService.USER_TYPE_INDIVIDUAL, userName,
						password);
				if (userS!=null && userS.getSuccess()) {
					if(userS.getResult()!=null ){
						centerUserInfo = (CenterUserInfo) userS.getResult();
						if(centerUserInfo!=null && StringUtils.isNotBlank(centerUserInfo.getLoginName())){
							userName = centerUserInfo.getLoginName();
						}
					}
					//根据登录验证取得的真正用户名获取用户信息
					userGetInfo = centerUserService.getCenterUser(userName,
							CenterUserService.SYSTEM_ID_HF);
					userInfo = (CenterSysUser) userGetInfo.getResult();
					if (!userGetInfo.getSuccess()) {
						//没有该用户
						session.setAttribute("errorMessageInfo", null);
						session.setAttribute("errorMessage", null);
						session.setAttribute("errorMessage", 2);
						return null;
					}
				}else{
					//此用户登录验证失败 密码错误或者没有该用户
					session.setAttribute("errorMessageInfo", null);
					session.setAttribute("errorMessage", null);
					session.setAttribute("errorMessageInfo", userS.getMsg());
					
					//登录用户名是手机号的话，且是待激活状态，给个提示：请激活
					if(StringUtils.isNotBlank(userName)){
						if(ValidatorBasic.isMobile(userName)){
							ReturnS result = centerUserService.getOtherUserInfo(userName);
							if (result.getSuccess()){
								
								session.setAttribute("errorMessageInfo", "该手机用户待激活，请先激活！");
							}
							
						  }
					} 
				}
			}else {
				//对应自动登录，直接根据用户名获取用户信息
				userGetInfo = centerUserService.getCenterUser(userName,
						CenterUserService.SYSTEM_ID_HF);
				userInfo = (CenterSysUser) userGetInfo.getResult();
				if (!userGetInfo.getSuccess()) {
					//没有该用户
					session.setAttribute("errorMessageInfo", null);
					session.setAttribute("errorMessage", null);
					session.setAttribute("errorMessage", 2);
					return null;
				}				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		// 判断该登录用户
		if (userName != null && !"".equals(userName) && userGetInfo != null&& userInfo != null) {
			// 将登录用户名和密码保存到session
			session.setAttribute("ZhiyangUserName", userName);
			session.setAttribute("ZhiyangPassword", password);
			session.setAttribute("userInfo", userInfo);
			session.setAttribute("IdCard", userInfo.getOrgPerson().getCardNum());

			// 处理自动登录
			if ("______".equals(password)) {
				SimpleAuthenticationInfo sa = new SimpleAuthenticationInfo(
						userName, password, getName());
				System.out.println("开始自动登录。。。。。。。。。。。。。。。。。");
				return sa;
			}
			
			if (userS.getSuccess()) {
				SimpleAuthenticationInfo sa = new SimpleAuthenticationInfo(userName, password, getName());
				// 获取微信用户名和用户类型
				String openId = (String) session.getAttribute("UserName");
				String apptype = (String) session.getAttribute("appType");
				
				if (openId == null) {
					return sa;
				}
				WeChatUser user = weChatService.findWeChatUser(openId, apptype);

				if (user == null) {
					return sa;
				}

				user.setZhiyangUserName(userName);
				user.setLastAccessDate(new Date());
				weChatService.save(user);
				System.out.println("new Date()保存输入结果============================="+new Date());
				return sa;
			} else {
				//此用户登录验证失败 密码错误或者没有该用户
				session.setAttribute("errorMessageInfo", null);
				session.setAttribute("errorMessage", null);
				session.setAttribute("errorMessageInfo", userS.getMsg());
				
				//登录用户名是手机号的话，且是待激活状态，给个提示：请激活
				if(StringUtils.isNotBlank(userName)){
					if(ValidatorBasic.isMobile(userName)){
						ReturnS result = centerUserService.getOtherUserInfo(userName);
						if (result.getSuccess()){
							
							session.setAttribute("errorMessageInfo", "该手机用户待激活，请先激活！");
						}
						
					  }
				} 
				return null;
			}
		}
		return null;
	}

	private String key;

	@SuppressWarnings("unused")
	private String getKey(String username) {
		return Md5Utils.hash(username + key);
	}

	public void setKey(String key) {
		this.key = key;
	}
	
}
