package com.hrofirst.service;

import com.fnst.es.common.service.BaseService;
import com.hrofirst.entity.Policy;
import com.hrofirst.repository.PolicyRepository;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
@Service
public class PolicyService extends BaseService<Policy, Long> {
    private PolicyRepository getPolicyRepository() {
        return (PolicyRepository) baseRepository;
    }

    public List<Policy> findByCity(long city) {
        return getPolicyRepository().findByCity(city);
    }
}
