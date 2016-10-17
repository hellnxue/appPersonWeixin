package com.hrofirst.entity;

import com.fnst.es.common.entity.BaseEntity;
import com.fnst.es.common.repository.support.annotation.EnableQueryCache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
@Entity
@Table(name = "wechat_user")
@EnableQueryCache
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class WeChatUser extends BaseEntity<Long> {
    private String username;

    @Column(name = "current_menu")
    private Long currentMenu;
    
    @Column(name = "apptype")
    private String apptype;
    
    @Column(name = "zhiyang_user_name")
    private String zhiyangUserName;
    
    @Column(name = "id_card")
    private String idCard;
    
    @Column(name = "last_access_date")
    @Temporal(TemporalType.TIMESTAMP )
    
    private Date lastAccessDate;
    @Column(name = "follow_date")
    
    @Temporal(TemporalType.TIMESTAMP )
    private Date followDate;
    
    public WeChatUser(){

    }
    public WeChatUser(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Long getCurrentMenu() {
        return currentMenu;
    }

    public void setCurrentMenu(Long currentMenu) {
        this.currentMenu = currentMenu;
    }

    public String getZhiyangUserName() {
        return zhiyangUserName;
    }

    public void setZhiyangUserName(String zhiyangUserName) {
        this.zhiyangUserName = zhiyangUserName;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public Date getLastAccessDate() {
        return lastAccessDate;
    }

    public void setLastAccessDate(Date lastAccessDate) {
        this.lastAccessDate = lastAccessDate;
    }

    public Date getFollowDate() {
        return followDate;
    }

    public void setFollowDate(Date followDate) {
        this.followDate = followDate;
    }
    
	public String getApptype() {
		return apptype;
	}
	
	public void setApptype(String apptype) {
		this.apptype = apptype;
	}
}
