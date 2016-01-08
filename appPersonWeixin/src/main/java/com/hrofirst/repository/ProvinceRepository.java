package com.hrofirst.repository;

import com.fnst.es.common.repository.BaseRepository;
import com.hrofirst.entity.Province;

import java.util.List;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
public interface ProvinceRepository extends BaseRepository<Province, Long> {

    public List<Province> findByTypeNot(String type);

}
