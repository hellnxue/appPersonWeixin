package com.hrofirst.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.hrofirst.common.ZimuSort;
import com.hrofirst.entity.Person;
import com.service.provider.IEhrZdyOrganizeService;
@Controller
@RequestMapping("/webApp")
public class OrganizeController {

	@Autowired
    IEhrZdyOrganizeService ehrZdyOrganizeService;
	
	//获取组织架构
	@RequestMapping("/tree")
	@ResponseBody
	public String Tree(HttpServletRequest request, HttpServletResponse response){
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		 String cardId = (String) session.getAttribute("IdCard");
		 //cardId = "520112198311271721";
		 List list = new ArrayList();
		 try{
		     list = ehrZdyOrganizeService.loadTree(cardId);
			 String json = "[" + list.get(0).toString() + "]";
			 Object result = JSON.parse(json);
		     return result.toString();
		 }catch(Exception e){
			 return "抛出异常";
		 }
		
	}
	//获取当前组织下所有用户
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("/person")
	public String  person(HttpServletRequest request, HttpServletResponse response, Model model , @RequestParam String organizationId ){
		List<HashMap> list = new ArrayList<HashMap>();
		String result="{\"errorMessage\":\"查询数据不存在！\"}";
		Long oId =  Long.parseLong(organizationId);
		try{
		list= ehrZdyOrganizeService.loadPerson(oId);
		ZimuSort zimuSort = new ZimuSort();  
   	    ArrayList<HashMap> tempList=new ArrayList<HashMap>();
   	    
   		for(int i=0; i<list.size(); i++){
   			Person detail = new Person();
   			BeanUtils.populate(detail, list.get(i));
   			//各个值放入map
   		    HashMap tempMap=new HashMap();
   		    tempMap.put("DEPT_ID", detail.getOrgId());
	   		tempMap.put("CNAME", detail.getName());
	   		tempMap.put("USER_ID", detail.getPersonId());
	   		tempMap.put("USER_NAME", detail.getName());
	   		tempMap.put("DEPT_NAME", detail.getOrg());
	   		tempMap.put("mobile", detail.getMobile());
	   		tempMap.put("email", detail.getEmail());
	   		tempList.add(tempMap);
	   		
   		}
   		String resultStr = zimuSort.sort(tempList);
   		Object todaySum1 = JSON.parse(resultStr);
   		//System.out.println("tempList="+tempList);
   		//System.out.println("todaySum1="+todaySum1);
   		result=todaySum1.toString();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		request.getSession().setAttribute("list", result);
		return "webApp/tongxunluperson";
	}
}
