package com.service.provider.entity;

public class LoginUserInfo implements java.io.Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private Long id;

	private String loginId;
	
	private String userName;
	
	private String hPUrl;
	
	private String alias;
	
	private Boolean isPub;
	
	private UserOrgInfo uoi;

	public Boolean getIsPub() {
		return isPub;
	}

	public void setIsPub(Boolean isPub) {
		this.isPub = isPub;
	}

	public UserOrgInfo getUoi() {
		return uoi;
	}

	public void setUoi(UserOrgInfo uoi) {
		this.uoi = uoi;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String gethPUrl() {
		return hPUrl;
	}

	public void sethPUrl(String hPUrl) {
		this.hPUrl = hPUrl;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

}
