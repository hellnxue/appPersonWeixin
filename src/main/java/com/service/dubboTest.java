package com.service;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.service.provider.UserService;

public class dubboTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
    	System.out.println( "hsx test" ); // 显示调用结果
    	
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[] {"provider.xml"});
        context.start();
  
        UserService demoService = (UserService)context.getBean("userService"); // 获取远程服务代理
        Integer res = demoService.isPsuser("songjing", "123456"); // 执行远程方法
        System.out.println("result:"+ res+"." ); // 显示调用结果
	}

}
