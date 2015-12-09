package com.service.provider.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Area implements Serializable   {
    /**  */
	private static final long serialVersionUID = -3269148533855281640L;

	private Long id;
	/** 国家ID COUNTRY_ID */
	private Long countryId;	
	
    private Long parentId;

    private String areaCode;

    private String areaName;

    private Integer identifier;//类型 1 地区（华北，华东 等）2  省区  3  城市 4 县城   5乡镇(街道)

    private Integer isDeleted;

    private Long createBy;

    private Date createDt;

    private Long updateBy;

    private Date updateDt;
    
    private List<Area> listCity;//市list
    
    private List<Area> listDistrict;//区县list
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode == null ? null : areaCode.trim();
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName == null ? null : areaName.trim();
    }

    public Integer getIdentifier() {
        return identifier;
    }

    public void setIdentifier(Integer identifier) {
        this.identifier = identifier;
    }

    public Integer getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Integer isDeleted) {
        this.isDeleted = isDeleted;
    }

    public Long getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Long createBy) {
        this.createBy = createBy;
    }

    public Date getCreateDt() {
        return createDt;
    }

    public void setCreateDt(Date createDt) {
        this.createDt = createDt;
    }

    public Long getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(Long updateBy) {
        this.updateBy = updateBy;
    }

    public Date getUpdateDt() {
        return updateDt;
    }

    public void setUpdateDt(Date updateDt) {
        this.updateDt = updateDt;
    }

	public Long getCountryId() {
		return countryId;
	}

	public void setCountryId(Long countryId) {
		this.countryId = countryId;
	}

	public List<Area> getListCity() {
		return listCity;
	}

	public void setListCity(List<Area> listCity) {
		this.listCity = listCity;
	}

	public List<Area> getListDistrict() {
		return listDistrict;
	}

	public void setListDistrict(List<Area> listDistrict) {
		this.listDistrict = listDistrict;
	}
    
}