package com.hrofirst.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.fnst.es.common.entity.BaseEntity;
import com.fnst.es.common.repository.support.annotation.EnableQueryCache;

@Entity
@Table(name = "wechat_upload_file")
@EnableQueryCache
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class WeChatUploadFile extends BaseEntity<Long>{
	
	private Long personId;		// 员工id

	private String personName;	// 员工姓名

	private String mobile;		// 员工手机号码

	private String loginName;	// 员工帮手登录名称

	private Long orgId;			// 所在企业id

	private int type;			// 证件类型：证件类型：1身份证 2户口薄 3学历证 4简历 5离职证明 6健康证明 7薪资证明

	private String filePath;		// 文件所在服务器地址
	
	@Column(name = "is_deleted")
	private int isDeleted; // 逻辑删除标识0 正常, 1 已删除，默认值是0
	
	@Column(name = "last_access_date")
	private Date lastAccessDate;	// 操作时间

	public Date getLastAccessDate() {
		return lastAccessDate;
	}

	public void setLastAccessDate(Date lastAccessDate) {
		this.lastAccessDate = lastAccessDate;
	}

	
 
	public Long getPersonId() {
		return personId;
	}

	public void setPersonId(Long personId) {
		this.personId = personId;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public Long getOrgId() {
		return orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(int isDeleted) {
		this.isDeleted = isDeleted;
	}

 
	 
	 
	
}
