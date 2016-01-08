package com.hrofirst.jms.listener;

import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.listener.SessionAwareMessageListener;

import com.hrofirst.jms.sender.apiDataJMSSender;

public class ConsumerSessionAwareMessageListener implements SessionAwareMessageListener {

	private Destination destination;

	public void onMessage(Message message, Session session)
			throws JMSException {
		
		if (message instanceof TextMessage){
			System.out.println("收到一条消息！！！！！！！！");
			System.out.println("消息内容是：" + ((TextMessage) message).getText());
			
			if (message.getJMSCorrelationID() != null){
				apiDataJMSSender.freshData(message.getJMSCorrelationID(), ((TextMessage) message).getText());
			}else{
				MessageProducer producer = session.createProducer(destination);
				Message textMessage = session.createTextMessage("weixinA。。。。。");
				textMessage.setStringProperty("exampleConsumer", "true");
				producer.send(textMessage);
			}
			
		}else if (message instanceof MapMessage){
			MapMessage mapmessage = (MapMessage)message;
			String result = "weixinA";
			
//			if (mapmessage.getString("type") != null){
//				result = apiservice.getData(mapmessage.getString("type"), null, mapmessage);
//			}else{
//				result = Constants.getReturnStrByErrCode("40004");
//			}

			Message textMessage = session.createTextMessage(result);
			textMessage.setStringProperty("exampleConsumer", "true");
			MessageProducer producer = session.createProducer(destination);
			producer.send(textMessage);
		}
	}

	public Destination getDestination() {
		return destination;
	}

	public void setDestination(Destination destination) {
		this.destination = destination;
	}

}
