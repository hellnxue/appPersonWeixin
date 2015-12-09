package org.apache.shiro.realm;

import org.apache.shiro.authc.AuthenticationToken;

import java.util.Map;

/**

 * <p>Date: 14-2-26
 * <p>Version: 1.0
 */
public class StatelessToken implements AuthenticationToken {

    private String username;
    private Map<String, ?> params;
    private String clientDigest;

    private String MD5Digest;

    public StatelessToken(String username, String MD5Digest, Map<String, ?> params, String clientDigest) {
        this.username = username;
        this.params = params;
        this.clientDigest = clientDigest;
        this.MD5Digest = MD5Digest;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Map<String, ?> getParams() {
        return params;
    }

    public void setParams( Map<String, ?> params) {
        this.params = params;
    }

    public String getClientDigest() {
        return clientDigest;
    }

    public void setClientDigest(String clientDigest) {
        this.clientDigest = clientDigest;
    }

    @Override
    public Object getPrincipal() {
       return username;
    }

    @Override
    public Object getCredentials() {
        return clientDigest;
    }

    public String getMD5Digest() {
        return MD5Digest;
    }

    public void setMD5Digest(String MD5Digest) {
        this.MD5Digest = MD5Digest;
    }
}
