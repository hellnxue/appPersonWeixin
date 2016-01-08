package com.hrofirst.repository;

import com.fnst.es.common.repository.BaseRepository;
import com.hrofirst.entity.WeChatUser;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
public interface WeChatRepository extends BaseRepository<WeChatUser, Long> {
    public WeChatUser findByUsername(String username);
}
