package com.hrofirst.util.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MailAuthenticator extends Authenticator {

	/**
	 * 用户名（登录邮箱）
	 */
	private String username;
	/**
	 * 密码
	 */
	private String password;

	/**
	 * 初始化邮箱和密码
	 * 
	 * @param username
	 *            邮箱
	 * @param password
	 *            密码
	 */
	public MailAuthenticator(String username, String password) {
		this.username = username;
		this.password = password;
	}

	String getPassword() {
		return password;
	}

	/**
	 * @author 邮箱身份验证
	 * @date 2015年6月11日 下午8:06:20
	 * @return
	 * @see javax.mail.Authenticator#getPasswordAuthentication()
	 */
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(username, password);
	}

	String getUsername() {
		return username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setUsername(String username) {
		this.username = username;
	}
}
