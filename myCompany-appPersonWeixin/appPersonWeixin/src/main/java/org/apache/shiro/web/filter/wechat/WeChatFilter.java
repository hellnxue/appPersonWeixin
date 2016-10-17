package org.apache.shiro.web.filter.wechat;

import org.apache.shiro.web.filter.AccessControlFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by qixb.fnst on 2015/02/25.
 */
public class WeChatFilter extends AccessControlFilter {
	
    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        if (request instanceof HttpServletRequest) {
            HttpServletRequest httpServletRequest = (HttpServletRequest) request;
            String userAgent = httpServletRequest.getHeader("User-Agent");
            if (userAgent != null && userAgent.toLowerCase().contains("micromessenger")) {
                httpServletRequest.getSession().setAttribute("isWeChat", true);
                
                
                System.out.println("WeChatFilter:Debug");
            }
        }
        return true;
    }

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        return true;
    }
}
