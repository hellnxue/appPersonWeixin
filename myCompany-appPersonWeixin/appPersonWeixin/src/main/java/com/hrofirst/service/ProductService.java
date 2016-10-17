package com.hrofirst.service;

import java.util.List;


import org.springframework.stereotype.Service;

import com.fnst.es.common.service.BaseService;
import com.hrofirst.entity.Product;
import com.hrofirst.repository.ProductRepository;

@Service
public class ProductService extends BaseService<Product, Long>{
	 private ProductRepository getProductRepository() {
	        return (ProductRepository) baseRepository;
	    }
	 
	 public List<Product> findByCategoryAndOrgId(long category,long orgId) {
	        return getProductRepository().findByCategoryAndOrgId(category,orgId);
	    }
	 
	 public List<Product> findByOrgId(long orgId) {
	        return getProductRepository().findByOrgId(orgId);
	    }
}
