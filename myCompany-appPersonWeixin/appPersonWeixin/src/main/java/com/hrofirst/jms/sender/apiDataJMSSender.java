package com.hrofirst.jms.sender;

import java.util.HashMap;

import javax.jms.Destination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.hrofirst.jms.service.ProducerService;

public class apiDataJMSSender {

	@Autowired  
	private ProducerService producerService; 
	
	@Autowired  
	@Qualifier("queueProducerDestination")  
	private Destination destination;  
 
	private static HashMap<String, String> jmsData = new HashMap<String, String>();
	
	public void testDatacenterSend(String id) {  
		jmsData.put(id, "");
		producerService.sendMessage(destination, "你好，生产者！这是消息："+id, id, "datacenter");  
	}

	public String getData(String id) {
		// TODO Auto-generated method stub
		
		return jmsData.get(id);
	}
	
	public static void freshData(String id, String result){
		jmsData.remove(id);
		jmsData.put(id, result);
	}
}
