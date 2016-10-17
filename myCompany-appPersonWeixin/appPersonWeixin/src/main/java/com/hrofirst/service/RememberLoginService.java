package com.hrofirst.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fnst.es.common.entity.search.Searchable;
import com.fnst.es.common.service.BaseService;
import com.hrofirst.entity.RememberLogin;
import com.hrofirst.repository.RememberRepository;

@Service
public class RememberLoginService extends BaseService<RememberLogin, Long>{

    private RememberRepository getRememberRepository() {
        return (RememberRepository) baseRepository;
    }
	public RememberLogin save(RememberLogin rememberLogin) {
		 rememberLogin = getRememberRepository().save(rememberLogin);
	        return rememberLogin;
	    }
	public RememberLogin findByOpenId(String openid) {
		Searchable searchable =
                Searchable.newSearchable().addSearchParam("openid", openid);
		getRememberRepository().findAll(searchable);
		
		RememberLogin rememberLogin=null;
    	List<RememberLogin> list = getRememberRepository().findAll(searchable).getContent();
    	if(list!=null && list.size()>0){
    		rememberLogin=list.get(0);
    	}
    	return rememberLogin;
		
	    }
}
