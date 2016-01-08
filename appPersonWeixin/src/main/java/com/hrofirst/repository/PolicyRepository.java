package com.hrofirst.repository;

import com.fnst.es.common.repository.BaseRepository;
import com.hrofirst.entity.Policy;

import java.util.List;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
public interface PolicyRepository extends BaseRepository<Policy, Long> {

    public List<Policy> findByCity(long city);
}
