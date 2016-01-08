package com.hrofirst.jms.service;

import java.io.Serializable;

import javax.jms.Destination;

public interface ProducerService {

	/**
	 * 发送普通的纯文本消息
	 * @param destination
	 * @param message
	 */
	public void sendMessage(Destination destination, String message, final String messageID, String headFlag);
	
	/**
	 * 发送一个ObjectMessage
	 * @param destination
	 * @param obj
	 */
	public void sendMessage(Destination destination, Serializable obj, final String messageID, String headFlag);
	
}
