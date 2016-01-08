package com.service.provider;

import java.util.Map;


public interface PageService {
	
	public String indexHead();
	
	public String indexFooter();
	
	public Map<String,String> getAllProjectUrl();
	
	public Map<String,String> getEleHref();  
	
}
