package com.hrofirst.repository;
import java.util.List;
import com.fnst.es.common.repository.BaseRepository;
import com.hrofirst.entity.Product;

public interface ProductRepository  extends BaseRepository<Product, Long>{
	
	public List<Product> findByCategoryAndOrgId(long category,long orgId);
	
	public List<Product> findByOrgId(long orgId);

}
