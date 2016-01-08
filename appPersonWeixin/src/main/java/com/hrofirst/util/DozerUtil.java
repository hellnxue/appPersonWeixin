package com.hrofirst.util;

import org.dozer.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Created by qixb.fnst on 2014/11/25.
 */
@Component
public class DozerUtil {
    private static Mapper mapper;

    @Autowired
    public void setMapper(Mapper mapper) {
        DozerUtil.mapper = mapper;
    }

    public static <T> T mapperClass(Object obj, Class<T> clazz) {
        return mapper.map(obj, clazz);
    }
}
