package com.hrofirst.service;

import com.fnst.es.common.service.BaseService;
import com.hrofirst.entity.Policy;
import com.hrofirst.entity.Salary;
import com.hrofirst.repository.SalaryRepository;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2015/3/25.
 */
@Service
public class SalaryService extends BaseService<Salary, Long> {
    private SalaryRepository getSalaryRepository() {
        return (SalaryRepository) baseRepository;
    }

    public Salary findSalaryByIdCardAndMonth(String idCard, String month) {
        List<Salary> salaryList = getSalaryRepository().findByIdCardAndMonth(idCard, month);
        if (salaryList == null || salaryList.size() == 0)
            return null;
        return salaryList.get(0);
    }
}
