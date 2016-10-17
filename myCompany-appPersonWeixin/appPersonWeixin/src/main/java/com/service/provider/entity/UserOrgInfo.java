package com.service.provider.entity;

public class UserOrgInfo implements java.io.Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String nameAbbr;

    private String name;

    private Boolean isAuth;

    private String tel;

    private String zipcode;

    private String fax;

    private String website;

    private Long legalpersonBusiLicenseFileId;

    private Long taxRegCertFileId;

    private Long orgCodeCertFileId;

    private String address;

    private String businessRange;

    private String keyWords;

    private String legalPerson;

    private Integer registerCapital;

    private String registerAddress;

    private Long relHroOrgId;

    private String contactPerson;

    private Long logoFileId;

	public String getNameAbbr() {
		return nameAbbr;
	}

	public void setNameAbbr(String nameAbbr) {
		this.nameAbbr = nameAbbr;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getIsAuth() {
		return isAuth;
	}

	public void setIsAuth(Boolean isAuth) {
		this.isAuth = isAuth;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public Long getLegalpersonBusiLicenseFileId() {
		return legalpersonBusiLicenseFileId;
	}

	public void setLegalpersonBusiLicenseFileId(Long legalpersonBusiLicenseFileId) {
		this.legalpersonBusiLicenseFileId = legalpersonBusiLicenseFileId;
	}

	public Long getTaxRegCertFileId() {
		return taxRegCertFileId;
	}

	public void setTaxRegCertFileId(Long taxRegCertFileId) {
		this.taxRegCertFileId = taxRegCertFileId;
	}

	public Long getOrgCodeCertFileId() {
		return orgCodeCertFileId;
	}

	public void setOrgCodeCertFileId(Long orgCodeCertFileId) {
		this.orgCodeCertFileId = orgCodeCertFileId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getBusinessRange() {
		return businessRange;
	}

	public void setBusinessRange(String businessRange) {
		this.businessRange = businessRange;
	}

	public String getKeyWords() {
		return keyWords;
	}

	public void setKeyWords(String keyWords) {
		this.keyWords = keyWords;
	}

	public String getLegalPerson() {
		return legalPerson;
	}

	public void setLegalPerson(String legalPerson) {
		this.legalPerson = legalPerson;
	}

	public Integer getRegisterCapital() {
		return registerCapital;
	}

	public void setRegisterCapital(Integer registerCapital) {
		this.registerCapital = registerCapital;
	}

	public String getRegisterAddress() {
		return registerAddress;
	}

	public void setRegisterAddress(String registerAddress) {
		this.registerAddress = registerAddress;
	}

	public Long getRelHroOrgId() {
		return relHroOrgId;
	}

	public void setRelHroOrgId(Long relHroOrgId) {
		this.relHroOrgId = relHroOrgId;
	}

	public String getContactPerson() {
		return contactPerson;
	}

	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}

	public Long getLogoFileId() {
		return logoFileId;
	}

	public void setLogoFileId(Long logoFileId) {
		this.logoFileId = logoFileId;
	}

}
