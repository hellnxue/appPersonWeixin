/**
 * Copyright (C) 2006-2012 Tuniu All rights reserved
 * Author: 
 * Date: Tue Jul 07 15:22:04 CST 2015
 * Description:
 */
package com.service.provider.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *  ReceivingAddr
 *  RECEIVING_ADDR
 */
public class ReceivingAddrInfo implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 8484995000120390513L;

	/**
     * 收货地址ID
     * RECEIVING_ADDR.RECEIVING_ADDR_ID
     */
    private Long receivingAddrId;

    /**
     * 购买人ID
     * RECEIVING_ADDR.USER_ID
     */
    private Long userId;

    /**
     * 所在地区的ID:用","分割省份,城市,区县,街道
     * RECEIVING_ADDR.AREA_IDS
     */
    private String areaIds;

    /**
     * 所在地区:省份+城市+区县+街道
     * RECEIVING_ADDR.AREA
     */
    private String area;

    /**
     * 写详细的地址：街道、门票、楼层、房间
     * RECEIVING_ADDR.DETAILED_ADDR
     */
    private String detailedAddr;

    /**
     * 邮政编码
     * RECEIVING_ADDR.ZIP_CODE
     */
    private Integer zipCode;

    /**
     * 收货人姓名
     * RECEIVING_ADDR.RECEIVING_NAME
     */
    private String receivingName;

    /**
     * 手机号码
     * RECEIVING_ADDR.MOBILE_PHONE
     */
    private Long mobilePhone;

    /**
     * 固定电话
     * RECEIVING_ADDR.LANDLINE_PHONE
     */
    private String landlinePhone;

    /**
     * 是否默认:1是 0 否
     * RECEIVING_ADDR.IS_DEFAULT
     */
    private Integer isDefault;

    /**
     * 逻辑删除标识0 正常, 1 已删除，默认值是0
     * RECEIVING_ADDR.IS_DELETED
     */
    private Integer isDeleted;

    /**
     * 创建人
     * RECEIVING_ADDR.CREATE_BY
     */
    private Long createBy;

    /**
     * 创建时间
     * RECEIVING_ADDR.CREATE_DT
     */
    private Date createDt;

    /**
     * 更新人
     * RECEIVING_ADDR.UPDATE_BY
     */
    private Long updateBy;

    /**
     * 更新时间
     * RECEIVING_ADDR.UPDATE_DT
     */
    private Date updateDt;

    /**
     * @return RECEIVING_ADDR.RECEIVING_ADDR_ID
     */
    public Long getReceivingAddrId() {
        return receivingAddrId;
    }

    /**
     * @param Long receivingAddrId (RECEIVING_ADDR.RECEIVING_ADDR_ID )
     */
    public void setReceivingAddrId(Long receivingAddrId) {
        this.receivingAddrId = receivingAddrId;
    }

    /**
     * @return RECEIVING_ADDR.USER_ID
     */
    public Long getUserId() {
        return userId;
    }

    /**
     * @param Long userId (RECEIVING_ADDR.USER_ID )
     */
    public void setUserId(Long userId) {
        this.userId = userId;
    }

    /**
     * @return RECEIVING_ADDR.AREA_IDS
     */
    public String getAreaIds() {
        return areaIds;
    }

    /**
     * @param String areaIds (RECEIVING_ADDR.AREA_IDS )
     */
    public void setAreaIds(String areaIds) {
        this.areaIds = areaIds == null ? null : areaIds.trim();
    }

    /**
     * @return RECEIVING_ADDR.AREA
     */
    public String getArea() {
        return area;
    }

    /**
     * @param String area (RECEIVING_ADDR.AREA )
     */
    public void setArea(String area) {
        this.area = area == null ? null : area.trim();
    }

    /**
     * @return RECEIVING_ADDR.DETAILED_ADDR
     */
    public String getDetailedAddr() {
        return detailedAddr;
    }

    /**
     * @param String detailedAddr (RECEIVING_ADDR.DETAILED_ADDR )
     */
    public void setDetailedAddr(String detailedAddr) {
        this.detailedAddr = detailedAddr == null ? null : detailedAddr.trim();
    }

    /**
     * @return RECEIVING_ADDR.ZIP_CODE
     */
    public Integer getZipCode() {
        return zipCode;
    }

    /**
     * @param Integer zipCode (RECEIVING_ADDR.ZIP_CODE )
     */
    public void setZipCode(Integer zipCode) {
        this.zipCode = zipCode;
    }

    /**
     * @return RECEIVING_ADDR.RECEIVING_NAME
     */
    public String getReceivingName() {
        return receivingName;
    }

    /**
     * @param String receivingName (RECEIVING_ADDR.RECEIVING_NAME )
     */
    public void setReceivingName(String receivingName) {
        this.receivingName = receivingName == null ? null : receivingName.trim();
    }

    /**
     * @return RECEIVING_ADDR.MOBILE_PHONE
     */
    public Long getMobilePhone() {
        return mobilePhone;
    }

    /**
     * @param Long mobilePhone (RECEIVING_ADDR.MOBILE_PHONE )
     */
    public void setMobilePhone(Long mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    /**
     * @return RECEIVING_ADDR.LANDLINE_PHONE
     */
    public String getLandlinePhone() {
        return landlinePhone;
    }

    /**
     * @param Long landlinePhone (RECEIVING_ADDR.LANDLINE_PHONE )
     */
    public void setLandlinePhone(String landlinePhone) {
        this.landlinePhone = landlinePhone == null ? null : landlinePhone.trim();
    }

    /**
     * @return RECEIVING_ADDR.IS_DEFAULT
     */
    public Integer getIsDefault() {
        return isDefault;
    }

    /**
     * @param Integer isDefault (RECEIVING_ADDR.IS_DEFAULT )
     */
    public void setIsDefault(Integer isDefault) {
        this.isDefault = isDefault;
    }

    /**
     * @return RECEIVING_ADDR.IS_DELETED
     */
    public Integer getIsDeleted() {
        return isDeleted;
    }

    /**
     * @param Integer isDeleted (RECEIVING_ADDR.IS_DELETED )
     */
    public void setIsDeleted(Integer isDeleted) {
        this.isDeleted = isDeleted;
    }

    /**
     * @return RECEIVING_ADDR.CREATE_BY
     */
    public Long getCreateBy() {
        return createBy;
    }

    /**
     * @param Long createBy (RECEIVING_ADDR.CREATE_BY )
     */
    public void setCreateBy(Long createBy) {
        this.createBy = createBy;
    }

    /**
     * @return RECEIVING_ADDR.CREATE_DT
     */
    public Date getCreateDt() {
        return createDt;
    }

    /**
     * @param Date createDt (RECEIVING_ADDR.CREATE_DT )
     */
    public void setCreateDt(Date createDt) {
        this.createDt = createDt;
    }

    /**
     * @return RECEIVING_ADDR.UPDATE_BY
     */
    public Long getUpdateBy() {
        return updateBy;
    }

    /**
     * @param Long updateBy (RECEIVING_ADDR.UPDATE_BY )
     */
    public void setUpdateBy(Long updateBy) {
        this.updateBy = updateBy;
    }

    /**
     * @return RECEIVING_ADDR.UPDATE_DT
     */
    public Date getUpdateDt() {
        return updateDt;
    }

    /**
     * @param Date updateDt (RECEIVING_ADDR.UPDATE_DT )
     */
    public void setUpdateDt(Date updateDt) {
        this.updateDt = updateDt;
    }
}