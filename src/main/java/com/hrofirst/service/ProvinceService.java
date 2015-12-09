package com.hrofirst.service;

import com.fnst.es.common.service.BaseService;
import com.hrofirst.entity.Province;
import com.hrofirst.repository.ProvinceRepository;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
@Service
public class ProvinceService extends BaseService<Province, Long> {
    private ProvinceRepository getProvinceRepository() {
        return (ProvinceRepository) baseRepository;
    }

    public List<Province> findByTypeNot(ProvinceType type) {
        return getProvinceRepository().findByTypeNot(type.getType());
    }

    public static enum ProvinceType {
        直辖市("1"), 行政省("2"), 自治区("3"), 特别行政区("4"), 其他国家("5");
        private String type;

        private ProvinceType(String type) {
            this.type = type;
        }

        public String getType() {
            return type;
        }

    }
}
