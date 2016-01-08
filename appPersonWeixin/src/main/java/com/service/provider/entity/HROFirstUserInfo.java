package com.service.provider.entity;

public class HROFirstUserInfo implements java.io.Serializable {
	private static final long serialVersionUID = 3002235204617879605L;

	private Long id;

	private String loginId;

	private String userName;

	private String hPUrl;

	private String alias;

	private Boolean isPub;

	private UserOrgInfo uoi;

	private Long orgId;

	private Long employeeId;

	private String mobile;

	private String email;
	
    private Integer userType;//用户类别 1企业用户 2个人用户
    
    private String nickName;//用户昵称
    
    private String cardID;//用户身份证号

    public HROFirstUserInfo() {
		super();
	}

	public HROFirstUserInfo(Long id, String loginId, String userName,
			String hPUrl, String alias, Boolean isPub, UserOrgInfo uoi,
			Long orgId, Long employeeId, String mobile, String email,Integer userType,String nickName,String cardID) {
		super();
		this.id = id;
		this.loginId = loginId;
		this.userName = userName;
		this.hPUrl = hPUrl;
		this.alias = alias;
		this.isPub = isPub;
		this.uoi = uoi;
		this.orgId = orgId;
		this.employeeId = employeeId;
		this.mobile = mobile;
		this.email = email;
		this.userType=userType;
		this.nickName=nickName;
		this.cardID=cardID;
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

	public Long getOrgId() {
		return orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}

	public Long getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Long employeeId) {
		this.employeeId = employeeId;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getCardID() {
		return cardID;
	}

	public void setCardID(String cardID) {
		this.cardID = cardID;
	}
	
}
