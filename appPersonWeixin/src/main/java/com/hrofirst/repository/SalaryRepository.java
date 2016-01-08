package com.hrofirst.repository;

import com.fnst.es.common.repository.BaseRepository;
import com.hrofirst.entity.City;
import com.hrofirst.entity.Salary;

import java.util.List;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
public interface SalaryRepository extends BaseRepository<Salary, Long> {
    public List<Salary> findByIdCardAndMonth(String idCard,String month );
}
