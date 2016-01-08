/**
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package org.apache.shiro.web.filter.authc;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;

import com.hrofirst.util.Config;
import com.hrofirst.util.casUtils;

/**
 * 基于几点修改：
 * 1、onLoginFailure 时 把异常添加到request attribute中 而不是异常类名
 * 2、登录成功时：成功页面重定向：
 * 2.1、如果前一个页面是登录页面，-->2.3
 * 2.2、如果有SavedRequest 则返回到SavedRequest(/admin/polling except)
 * 2.3、否则根据当前登录的用户决定返回到管理员首页/前台首页
 * <p/>
 * <p/>
 * <p>Date: 13-3-19 下午2:11
 * <p>Version: 1.0
 */
public class CustomFormAuthenticationFilter extends FormAuthenticationFilter {


    @Override
    protected void setFailureAttribute(ServletRequest request, AuthenticationException ae) {
        request.setAttribute(getFailureKeyAttribute(), ae);
    }

    /**
     * 默认的成功地址
     */
    private String defaultSuccessUrl;
    /**
     * 管理员默认的成功地址
     */
    private String adminDefaultSuccessUrl;


    public void setDefaultSuccessUrl(String defaultSuccessUrl) {
        this.defaultSuccessUrl = defaultSuccessUrl;
    }

    public void setAdminDefaultSuccessUrl(String adminDefaultSuccessUrl) {
        this.adminDefaultSuccessUrl = adminDefaultSuccessUrl;
    }

    public String getDefaultSuccessUrl() {
        return defaultSuccessUrl;
    }

    public String getAdminDefaultSuccessUrl() {
        return adminDefaultSuccessUrl;
    }

    /**
     * 根据用户选择成功地址
     *
     * @return
     */
    @Override
    public String getSuccessUrl() {
        String username = (String) SecurityUtils.getSubject().getPrincipal();
        return getDefaultSuccessUrl();
    }

    protected void issueSuccessRedirect(ServletRequest request, ServletResponse response) throws Exception {
    	
    	String username = request.getParameter("username");
    	String password = request.getParameter("password");
    	
    	if (username != null && password != null){
    		casUtils cas = new casUtils();
    		Cookie cook = cas.processCASLogin(Config.getCasservice(), username, password);
    		
    		if (cook != null){
        		cook.setDomain(Config.getCascookiedomain());
        		((HttpServletResponse) response).addCookie(cook);
    		}
    	}
    	
        String successUrl = null;
        boolean contextRelative = true;
        SavedRequest savedRequest = WebUtils.getAndClearSavedRequest(request);
        if (savedRequest != null && savedRequest.getMethod().equalsIgnoreCase(AccessControlFilter.GET_METHOD)) {
            if (!isPushUrl(savedRequest)) {
                successUrl = savedRequest.getRequestUrl();
                contextRelative = false;
            }
        }

        if (successUrl == null) {
            successUrl = getSuccessUrl();
        }

        if (successUrl == null) {
            throw new IllegalStateException("Success URL not available via saved request or via the " +
                    "successUrlFallback method parameter. One of these must be non-null for " +
                    "issueSuccessRedirect() to work.");
        }

        WebUtils.issueRedirect(request, response, successUrl, null, contextRelative);
    }

    private boolean isPushUrl(SavedRequest savedRequest) {
        return savedRequest.getRequestURI().equals("/admin/polling");
    }
}
