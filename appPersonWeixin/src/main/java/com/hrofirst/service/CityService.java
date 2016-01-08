package com.hrofirst.service;

import com.fnst.es.common.service.BaseService;
import com.hrofirst.entity.City;
import com.hrofirst.repository.CityRepository;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
@Service
public class CityService extends BaseService<City, Long> {
    private CityRepository getCityRepository() {
        return (CityRepository) baseRepository;
    }

    public List<City> findByProvince(long province) {
        return getCityRepository().findByProvince(province);
    }
}
