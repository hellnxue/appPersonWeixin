package com.hrofirst.service;

import com.fnst.es.common.entity.search.Searchable;
import com.fnst.es.common.service.BaseService;
import com.hrofirst.entity.Menu;
import com.hrofirst.repository.MenuRepository;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
@Service
public class MenuService extends BaseService<Menu, Long> {
    private MenuRepository getMenuRepository() {
        return (MenuRepository) baseRepository;
    }

    public Menu findByKeywordAndPId(String keyword,Long pId){
        return getMenuRepository().findByKeywordAndPId(keyword,pId);
    }

    public List<Menu> findByPId(Long pId){
        return getMenuRepository().findByPId(pId);
    }
    
    //根据菜单的pId与appType查询对应的菜单集
    public Page<Menu> findByPidAndApptype(Long pId, String apptype) {
        
        Searchable searchable =
                Searchable.newSearchable().addSearchParam("pId_eq", pId).addSearchParam("apptype_eq", apptype);
        return findAll(searchable);
    } 
    
   //根据菜单keyword查询id
    public Page<Menu> findByKeyword(String keyword) {
        
        Searchable searchable =
                Searchable.newSearchable().addSearchParam("keyword_eq", keyword);
        return findAll(searchable);
    }
    //根据菜单的keyword与appType查询对应的菜单集
    public Page<Menu> findByKeywordAndAppType(String keyword,String apptype) {
        
        Searchable searchable =
                Searchable.newSearchable().addSearchParam("keyword_eq", keyword).addSearchParam("apptype_eq", apptype);
        return findAll(searchable);
    }

}
