package com.hrofirst.repository;


import java.util.List;

import com.fnst.es.common.repository.BaseRepository;
import com.hrofirst.entity.WeChatUploadFile;

public interface WeChatUploadFileRepository extends BaseRepository<WeChatUploadFile, Long> {

	//根据操作时间和未删除标示isDeleted查询文件信息
	// public List<WeChatUploadFile> findByPersonIdAndLastAccessDate(Long personId,int isDeleted );
	  
}
