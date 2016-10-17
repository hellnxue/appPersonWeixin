package com.hrofirst.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fnst.es.common.service.BaseService;
import com.hrofirst.entity.Product;
import com.hrofirst.entity.ProductCategory;
import com.hrofirst.repository.ProductCategoryRepository;

@Service
public class ProductCategoryService extends BaseService<ProductCategory, Long>{
	 private ProductCategoryRepository getProductCategoryRepository() {
	        return (ProductCategoryRepository) baseRepository;
	    }
	 public List<ProductCategory> findByOrgId(long orgId) {
	        return getProductCategoryRepository().findByOrgId(orgId);
	    }
}
