package com.hrofirst.entity;
/**
 * 体检提交参数
 *
 * @version $Id: MedicalVO.java, 
 * v 0.1 2016年5月17日 下午6:41:27 
 * <pre>
 * @author steven.chen
 * @date 2016年5月17日 下午6:41:27 
 * </pre>
 */
public class MedicalVO {
	
	private Long loginId;
	private Integer year;
	private Integer month;
	private Integer day;
	private Long serviceId;
	private Long serviceStoreId;
	private Integer checked;
	private Long receivingAddrId;
	private String examinationName;
	private String examinationCardNum;
	private String examinationMobile;
	private String reportName;
	private String reportAdd;
	private String reportMobile;
	private Integer examinationGender;
	private Integer examinationAge;
	private Integer examinationMarried;
	
	public Integer getExaminationGender() {
		return examinationGender;
	}
	public void setExaminationGender(Integer examinationGender) {
		this.examinationGender = examinationGender;
	}
	public Integer getExaminationAge() {
		return examinationAge;
	}
	public void setExaminationAge(Integer examinationAge) {
		this.examinationAge = examinationAge;
	}
	public Integer getExaminationMarried() {
		return examinationMarried;
	}
	public void setExaminationMarried(Integer examinationMarried) {
		this.examinationMarried = examinationMarried;
	}
	public Long getLoginId() {
		return loginId;
	}
	public void setLoginId(Long loginId) {
		this.loginId = loginId;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		this.month = month;
	}
	public Integer getDay() {
		return day;
	}
	public void setDay(Integer day) {
		this.day = day;
	}
	public Long getServiceId() {
		return serviceId;
	}
	public void setServiceId(Long serviceId) {
		this.serviceId = serviceId;
	}
	public Long getServiceStoreId() {
		return serviceStoreId;
	}
	public void setServiceStoreId(Long serviceStoreId) {
		this.serviceStoreId = serviceStoreId;
	}
	public Integer getChecked() {
		return checked;
	}
	public void setChecked(Integer checked) {
		this.checked = checked;
	}
	public Long getReceivingAddrId() {
		return receivingAddrId;
	}
	public void setReceivingAddrId(Long receivingAddrId) {
		this.receivingAddrId = receivingAddrId;
	}
	public String getExaminationName() {
		return examinationName;
	}
	public void setExaminationName(String examinationName) {
		this.examinationName = examinationName;
	}
	public String getExaminationCardNum() {
		return examinationCardNum;
	}
	public void setExaminationCardNum(String examinationCardNum) {
		this.examinationCardNum = examinationCardNum;
	}
	public String getExaminationMobile() {
		return examinationMobile;
	}
	public void setExaminationMobile(String examinationMobile) {
		this.examinationMobile = examinationMobile;
	}
	public String getReportName() {
		return reportName;
	}
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}
	public String getReportAdd() {
		return reportAdd;
	}
	public void setReportAdd(String reportAdd) {
		this.reportAdd = reportAdd;
	}
	public String getReportMobile() {
		return reportMobile;
	}
	public void setReportMobile(String reportMobile) {
		this.reportMobile = reportMobile;
	}
	
	

}
