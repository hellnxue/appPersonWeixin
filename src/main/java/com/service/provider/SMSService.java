package com.service.provider;

public interface SMSService {
	
	//发送短信
	Boolean sendMessage(String mobile, String content);
	
}
