package com.hrofirst.entity;

import com.fnst.es.common.entity.AbstractEntity;
import com.fnst.es.common.entity.BaseEntity;
import com.fnst.es.common.repository.support.annotation.EnableQueryCache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by Administrator on 2015/3/25.
 */
@Entity
@Table(name = "salary")
@EnableQueryCache
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Salary extends BaseEntity<Long> {

    private String userName;

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    private String month;
    private String basicSalary;
    private String allSalary;
    private String pSafe;
    private String safeCompany;
    private String pTax;
    private String actual;
    private String idCard;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getBasicSalary() {
        return basicSalary;
    }

    public void setBasicSalary(String basicSalary) {
        this.basicSalary = basicSalary;
    }

    public String getAllSalary() {
        return allSalary;
    }

    public void setAllSalary(String allSalary) {
        this.allSalary = allSalary;
    }

    public String getpSafe() {
        return pSafe;
    }

    public void setpSafe(String pSafe) {
        this.pSafe = pSafe;
    }

    public String getSafeCompany() {
        return safeCompany;
    }

    public void setSafeCompany(String safeCompany) {
        this.safeCompany = safeCompany;
    }

    public String getpTax() {
        return pTax;
    }

    public void setpTax(String pTax) {
        this.pTax = pTax;
    }

    public String getActual() {
        return actual;
    }

    public void setActual(String actual) {
        this.actual = actual;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }
}
