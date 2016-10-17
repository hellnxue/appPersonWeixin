package com.hrofirst.repository;

import java.util.List;

import com.fnst.es.common.repository.BaseRepository;
import com.hrofirst.entity.Product;
import com.hrofirst.entity.ProductCategory;

public interface ProductCategoryRepository extends BaseRepository<ProductCategory, Long> {
	public List<ProductCategory> findByOrgId(long orgId);
}
