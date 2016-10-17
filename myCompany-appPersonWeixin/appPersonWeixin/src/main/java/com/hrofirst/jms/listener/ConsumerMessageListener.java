package com.hrofirst.jms.listener;

import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.ObjectMessage;
import javax.jms.TextMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.support.converter.MessageConverter;

import com.hrofirst.jms.service.ProducerService;

public class ConsumerMessageListener implements MessageListener {

	public void onMessage(Message message) {
		if (message instanceof TextMessage) {

			// 这里我们知道生产者发送的就是一个纯文本消息，所以这里可以直接进行强制转换，或者直接把onMessage方法的参数改成Message的子类TextMessage
			TextMessage textMsg = (TextMessage) message;

			System.out.println("接收到一个纯文本消息。");
			try {
				System.out.println("消息内容是：" + textMsg.getText());
			} catch (JMSException e) {
				e.printStackTrace();
			}

		} else if (message instanceof MapMessage) {

			MapMessage mapMessage = (MapMessage) message;
			System.out.println("接收到一个map消息。");
			try {
				System.out.println("消息内容是：" + mapMessage);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (message instanceof ObjectMessage) {
			// ObjectMessage objMessage = (ObjectMessage) message;
			// try {
			// Email email = (Email) messageConverter.fromMessage(objMessage);
			// System.out.println("接收到一个ObjectMessage，包含Email对象。");
			// System.out.println(email);
			// } catch (JMSException e) {
			// e.printStackTrace();
			// }
		}
	}

}
