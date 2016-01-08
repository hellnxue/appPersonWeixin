package com.hrofirst.service;

import java.util.List;

import org.springframework.stereotype.Service;
import com.fnst.es.common.service.BaseService;
import com.hrofirst.entity.WebAppMenu;
import com.hrofirst.repository.WebAppMenuRepository;

@Service
public class WebAppMenuService extends BaseService<WebAppMenu, Long> {
    private WebAppMenuRepository getMenuRepository() {
        return (WebAppMenuRepository) baseRepository;
    }

    public WebAppMenu findByKeywordAndPId(String keyword,Long pId){
        return getMenuRepository().findByKeywordAndPId(keyword,pId);
    }

    public List<WebAppMenu> findByPId(Long pId){
        return getMenuRepository().findByPId(pId);
    }
}