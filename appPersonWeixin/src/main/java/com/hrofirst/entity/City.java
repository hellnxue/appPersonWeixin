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
@Table(name = "dict_city")
@EnableQueryCache
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class City extends BaseEntity<Long> {
    @Column(name = "S_CITYNAME")
    private String name;
    @Column(name = "N_PROVID")
    private long province;
    @Column(name = "S_STATE")
    private String state;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getProvince() {
        return province;
    }

    public void setProvince(long province) {
        this.province = province;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
