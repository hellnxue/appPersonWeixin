package com.hrofirst.repository;

import java.util.List;

import com.fnst.es.common.repository.BaseRepository;
import com.hrofirst.entity.WebAppMenu;

public interface WebAppMenuRepository extends BaseRepository<WebAppMenu, Long>{
	
    public WebAppMenu findByKeywordAndPId(String keyword,Long pId);
    List<WebAppMenu> findByPId(Long pId);
}
