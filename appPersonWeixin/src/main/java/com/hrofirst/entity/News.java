package com.hrofirst.entity;

import com.fnst.es.common.entity.BaseEntity;
import com.fnst.es.common.repository.support.annotation.EnableQueryCache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by qixb.fnst on 2015/02/12.
 */
@Entity
@Table(name = "sys_news")
@EnableQueryCache
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class News extends BaseEntity<Long> {
    @Enumerated(EnumType.ORDINAL)
    @Column(name = "news_type")
    private NewsType type;
    private String title;
    private String content;
    
    @Column(name = "readed")
    @org.hibernate.annotations.Type(type = "yes_no")
    private boolean read = false;
    
    private String sender;
    private String receiver;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "send_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date sendTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "read_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date readTime;


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Boolean isRead() {
        return read;
    }

    public Boolean getRead() {
        return read;
    }

    public void setRead(Boolean read) {
        this.read = read;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }


    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public Date getReadTime() {
        return readTime;
    }

    public void setReadTime(Date readTime) {
        this.readTime = readTime;
    }

    public NewsType getType() {
        return type;
    }

    public void setType(NewsType type) {
        this.type = type;
    }

    public static enum NewsType {
        PERSONAL(0), PUBLIC(1),THIRD(2);
        private int type;

        public int getType() {
            return type;
        }

        private NewsType(int type) {
            this.type = type;
        }
    }
}
