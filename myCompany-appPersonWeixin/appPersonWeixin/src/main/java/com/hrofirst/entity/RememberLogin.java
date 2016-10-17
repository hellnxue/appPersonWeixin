package com.hrofirst.entity;
import com.fnst.es.common.entity.BaseEntity;
import com.fnst.es.common.repository.support.annotation.EnableQueryCache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
/**
 * Created by qixb.fnst on 2015/02/11.
 */
@Entity
@Table(name = "remember_login")
@EnableQueryCache
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class RememberLogin extends BaseEntity<Long> {

    @Column(name = "openid")
    private String openid;
    
	@Column(name = "remember")
	@org.hibernate.annotations.Type(type = "yes_no")
    private boolean remember;
    
    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public boolean getRemember() {
        return remember;
    }

    public void setRemember(boolean remember) {
        this.remember = remember;
    }
}

