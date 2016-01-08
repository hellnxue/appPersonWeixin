package com.hrofirst.util.mail;

/**
 * 邮件设置参数
 * 
 * @author 郑长山
 * @date 2015年6月11日 下午8:09:02
 */
public class SimpleMail {

	/**
	 * 邮件内容
	 */
	private String content;

	/**
	 * 邮件标题
	 */
	private String subject;

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
