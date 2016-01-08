package com.hrofirst.jms.service.impl;

import java.io.Serializable;

import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.jms.core.ProducerCallback;
import org.springframework.jms.core.SessionCallback;
import org.springframework.stereotype.Component;

import com.hrofirst.jms.service.ProducerService;

@Component
public class ProducerServiceImpl implements ProducerService {

	private JmsTemplate jmsTemplate;
	
    public JmsTemplate getJmsTemplate() {
		return jmsTemplate;
	}

	public void setJmsTemplate(JmsTemplate jmsTemplate) {
		this.jmsTemplate = jmsTemplate;
	}
	
    private String oraParaName;
    
	public String getOraParaName() {
		return oraParaName;
	}

	public void setOraParaName(String oraParaName) {
		this.oraParaName = oraParaName;
	}

	private String selfConsumerName;
	
	
	public String getSelfConsumerName() {
		return selfConsumerName;
	}

	public void setSelfConsumerName(String selfConsumerName) {
		this.selfConsumerName = selfConsumerName;
	}
	
	public void sendMessage(final Destination destination, final String message, final String messageID, final String headFlag) {
		System.out.println("---------------生产者发送消息-----------------");
		System.out.println("---------------生产者发了一个消息：" + message);
		
		MessageCreator msg = new MessageCreator() {
			public Message createMessage(Session session) throws JMSException {
				MapMessage tmes = session.createMapMessage();
				tmes.setString("type", "datatest");
				tmes.setString("key", "1");
				tmes.setStringProperty(headFlag, "true");
				tmes.setStringProperty(oraParaName, selfConsumerName);
				tmes.setJMSCorrelationID(messageID);
				
				System.out.println("---------------生产者发了一个TEST消息：" + tmes);
				return tmes;
			}
		};
		
		jmsTemplate.send(destination, msg);
	}
	
	public void sendMessage(final Destination destination, final Serializable obj, final String messageID, final String headFlag) {
		//未使用MessageConverter的情况
		/*jmsTemplate.send(destination, new MessageCreator() {

			public Message createMessage(Session session) throws JMSException {
				ObjectMessage objMessage = session.createObjectMessage(obj);
				return objMessage;
			}
			
		});*/
		//使用MessageConverter的情况
		jmsTemplate.convertAndSend(destination, obj);
		jmsTemplate.execute(new SessionCallback<Object>() {

			public Object doInJms(Session session) throws JMSException {
				MessageProducer producer = session.createProducer(destination);
				Message message = session.createObjectMessage(obj);
				producer.send(message);
				return null;
			}
			
		});
		jmsTemplate.execute(new ProducerCallback<Object>() {

			public Object doInJms(Session session, MessageProducer producer)
					throws JMSException {
				Message message = session.createObjectMessage(obj);
				producer.send(destination, message);
				return null;
			}
			
		});
	}
	
}