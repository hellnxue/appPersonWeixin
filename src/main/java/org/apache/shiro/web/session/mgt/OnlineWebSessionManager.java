/**
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package org.apache.shiro.web.session.mgt;

import com.fnst.es.common.Constants;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.OnlineSession;
import org.apache.shiro.session.mgt.SessionKey;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 为OnlineSession定制的Web Session Manager
 * 主要是在此如果会话的属性修改了 就标识下其修改了 然后方便 OnlineSessionDao同步
 * <p/>
 * <p/>
 * <p>Date: 13-3-21 下午2:28
 * <p>Version: 1.0
 */
public class OnlineWebSessionManager extends DefaultWebSessionManager {

    private static final Logger log = LoggerFactory.getLogger(OnlineWebSessionManager.class);


    @Override
    public void setAttribute(SessionKey sessionKey, Object attributeKey, Object value) throws InvalidSessionException {
        super.setAttribute(sessionKey, attributeKey, value);
        if (value != null && needMarkAttributeChanged(attributeKey)) {
            Session session=doGetSession(sessionKey);
            if(session instanceof OnlineSession) {
                OnlineSession s = (OnlineSession)session;
                s.markAttributeChanged();
            }
        }
    }

    private boolean needMarkAttributeChanged(Object attributeKey) {
        if (attributeKey == null) {
            return false;
        }
        String attributeKeyStr = attributeKey.toString();
        //优化 flash属性没必要持久化
        if (attributeKeyStr.startsWith("org.springframework")) {
            return false;
        }
        if (attributeKeyStr.startsWith("javax.servlet")) {
            return false;
        }
        if (attributeKeyStr.equals(Constants.CURRENT_USERNAME)) {
            return false;
        }
        return true;
    }

    @Override
    public Object removeAttribute(SessionKey sessionKey, Object attributeKey) throws InvalidSessionException {
        Object removed = super.removeAttribute(sessionKey, attributeKey);
        if (removed != null) {
        	Session session=doGetSession(sessionKey);
        	
            if(session instanceof OnlineSession) {
                OnlineSession s = (OnlineSession)session;
                s.markAttributeChanged();
            }        	
        }

        return removed;
    }


}
