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
@Table(name = "dict_policy")
@EnableQueryCache
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Policy extends BaseEntity<Long> {
    @Column(name = "URL")
    private String url;
    @Column(name = "N_CITYID")
    private long city;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public long getCity() {
        return city;
    }

    public void setCity(long city) {
        this.city = city;
    }
}
