package com.hrofirst.repository;

import com.fnst.es.common.repository.BaseRepository;
import com.hrofirst.entity.Menu;

import java.util.List;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
public interface MenuRepository extends BaseRepository<Menu, Long> {
    public Menu findByKeywordAndPId(String keyword,Long pId);

    List<Menu> findByPId(Long pId);
    
    //根据Pid、appType查询菜单
    List<Menu> findByApptype(String appType);
}
