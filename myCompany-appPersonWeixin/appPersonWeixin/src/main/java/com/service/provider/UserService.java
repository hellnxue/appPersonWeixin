package com.service.provider;

import com.service.provider.entity.ReturnS;

public interface UserService {
	
	//用户中心 登录 验证  平台帐号 密码
	Integer isPsuser(String login,String password);
	
	//用户中心 注册帐号
	ReturnS registerHro(String login,String password,String mobile,String email);
	
	//获得 hro 平台帐号
	String getOtherLogin(String ucLogin,Integer channel);
	
	//hro 平台同步账户
	ReturnS mHroLogin(String login,String password,String mobile,String email);
	
	//获取 账户基本信息
	ReturnS getLoginInfo(String login,Integer channel);
	
	ReturnS getLoginInfo(Long id);
	
}
