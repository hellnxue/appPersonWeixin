package com.hrofirst.repository;

import com.fnst.es.common.repository.BaseRepository;
import com.hrofirst.entity.City;

import java.util.List;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
public interface CityRepository extends BaseRepository<City, Long> {
    public List<City> findByProvince(long province);
}
