package org.apache.shiro.realm;

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
		String userName = token.getUsername();
		String password = String.valueOf(token.getPassword());

		// 获取session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();

		// 根据登录用户名获取用户信息
		ReturnS userS = null;		
		CenterSysUser userInfo = null;
		CenterUserInfo centerUserInfo = null;
		// 智阳用户名、密码登录
		try {
			userS = centerUserService.loginAuth(
					CenterUserService.LOGIN_TYPE_LOGINNAME,
					CenterUserService.USER_TYPE_INDIVIDUAL, userName,
					password);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		try {
			if (userS.getSuccess()) {
				if(userS.getResult()!=null ){
					centerUserInfo = (CenterUserInfo) userS.getResult();
					if(centerUserInfo!=null && StringUtils.isNotBlank(centerUserInfo.getLoginName())){
						userName = centerUserInfo.getLoginName();
					}
				}				
				userS = centerUserService.getCenterUser(userName,
						CenterUserService.SYSTEM_ID_HF);
				userInfo = (CenterSysUser) userS.getResult();
				if (!userS.getSuccess()) {
					session.setAttribute("errorMessage", 2);
					return null;
				}
			}else {
				session.setAttribute("errorMessage", 3);
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		// 判断该登录用户
		if (userName != null && !"".equals(userName) && userS != null
				&& userInfo != null) {
			// 将登录用户名和密码保存到session
			session.setAttribute("ZhiyangUserName", userName);
			session.setAttribute("ZhiyangPassword", password);
			session.setAttribute("userInfo", userInfo);
			session.setAttribute("IdCard", userInfo.getOrgPerson().getCardNum());

			// 处理自动登录
			if ("______".equals(password)) {
				SimpleAuthenticationInfo sa = new SimpleAuthenticationInfo(
						userName, password, getName());
				return sa;
			}
			// 智阳用户名、密码登录
			try {
				userS = centerUserService.loginAuth(
						CenterUserService.LOGIN_TYPE_LOGINNAME,
						CenterUserService.USER_TYPE_INDIVIDUAL, userName,
						password);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			if (userS.getSuccess()) {
				SimpleAuthenticationInfo sa = new SimpleAuthenticationInfo(
						userName, password, getName());
				// 获取微信用户名和用户类型
				String openId = (String) session.getAttribute("UserName");
				String apptype = (String) session.getAttribute("appType");
				// 判空
				if (openId == null) {
					return sa;
				}

				WeChatUser user = weChatService.findWeChatUser(openId, apptype);

				if (user == null) {
					return sa;
				}

				user.setZhiyangUserName(userName);
				weChatService.save(user);
				return sa;
			} else {
				session.setAttribute("errorMessage", 3);
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
