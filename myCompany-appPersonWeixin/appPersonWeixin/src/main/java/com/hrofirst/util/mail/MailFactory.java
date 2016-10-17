package com.hrofirst.util.mail;


public class MailFactory {
	
	private static final String smtp = "smtp.ym.163.com";
	private static final String username = "china@clouppy.com";
	private static final String password = "yywn&1314";
	/**
	 * 获取配置文件中的邮件配置
	 * 
	 * @return
	 */
	public static MailSender getMailSend() {
		MailSender ms = new MailSender(smtp,username,password);
		return ms;
	}
}
