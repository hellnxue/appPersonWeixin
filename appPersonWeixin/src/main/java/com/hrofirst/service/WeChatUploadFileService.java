package com.hrofirst.service;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fnst.es.common.repository.RepositoryHelper;
import com.fnst.es.common.repository.hibernate.HibernateUtils;
import com.fnst.es.common.service.BaseService;
import com.hrofirst.entity.WeChatUploadFile;
import com.hrofirst.repository.WeChatUploadFileRepository;
import com.hrofirst.util.FileUtil;
import com.hrofirst.util.HrHelperFileUploader;
import com.service.provider.entity.CenterSysUser;
@Service
public class WeChatUploadFileService extends BaseService<WeChatUploadFile, Long>{
	
	 private WeChatUploadFileRepository  getWeChatUploadFileRepository() {
		 
	        return (WeChatUploadFileRepository) baseRepository;
	    }
	 
	 public WeChatUploadFile save(WeChatUploadFile weChatUploadFile) {
	        return getWeChatUploadFileRepository().save(weChatUploadFile);
	    }
	 
	  /**
	     * 员工资料文件上传
	     * @param myfiles
	     * @param response
	     * @param request
	     * @return
	     * @throws Exception
	     */
	    public  Map uploadFiles(MultipartFile[] myfiles, HttpServletResponse response, HttpServletRequest request)throws Exception{
	    	
	    	Session session = HibernateUtils.getSessionFactory(RepositoryHelper.getEntityManager()).openSession();
	    	Transaction tx =session.beginTransaction();
	    	 
	    	String fileName="";//处理后的文件名称
			 
			String realPath=request.getSession().getServletContext().getRealPath("uploadFile")+"//";//文件上传目录
			
			Map<String,Object> map = new HashMap<String,Object>();
			CenterSysUser userInfo = (CenterSysUser) request.getSession().getAttribute("userInfo");
			Map<String, Object> result=null;
			int i=0;
			String realUrl="";
			for(MultipartFile myfile:myfiles){
				i++;
				if (!myfile.isEmpty()) {
					
	    			
	    			
	    		    fileName = new Date().getTime()+"."+FileUtil.getSuffixName(myfile.getOriginalFilename());//处理后的文件名称
	    			
	    			FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(realPath, fileName)); // 上传文件到项目根目录下的uploadFile
	    			
	    			result=HrHelperFileUploader.upload(realPath+fileName);//上传文件到服务器
	    			
	    			
	    			if(result.get("realUrl")!=null&&!(result.get("realUrl")).equals("")){
	    				
	    				realUrl=result.get("realUrl").toString();
	    				map.put("realUrl"+i, realUrl);
	    				
	    				if(i==1){
	    					batchSave(session,userInfo, realUrl, 1);
	    				}
	    				if(i==2){
	    					batchSave(session,userInfo, realUrl, 2);
	    				}
	    				if(i==3){
	    					batchSave(session,userInfo, realUrl, 3);
	    				}
	    				if(i==4){
	    					batchSave(session,userInfo, realUrl, 4);
	    				}
	    				if(i==5){
	    					batchSave(session,userInfo, realUrl, 5);
	    				}
	    				if(i==6){
	    					batchSave(session,userInfo, realUrl, 6);
	    				}
	    				if(i==7){
	    					batchSave(session,userInfo, realUrl, 7);
	    				} 
	    			 
	    			}else{
	    				map.put("error", result.get("message"));
	    				return map;
	    			}
	            	
	            }
				
				
			}
			
			tx.commit();  
			session.close(); 
			System.out.println("map="+map);
			if(map==null||map.size()==0){
				map.put("error", "文件上传失败！");
			}
			
			return map;
	    }
	    
	    /**
	     * 批量修改&插入
	     * @param session 
	     * @param userInfo
	     * @param realUrl
	     * @param type 证件类型
	     */
	    public void batchSave(Session session,CenterSysUser userInfo,String realUrl,int type){
	       String hqlUpdate = "update WeChatUploadFile set isDeleted =:newDeleted,lastAccessDate=:newDate where isDeleted=0 and type="+type;
	       int updatedEntities = session.createQuery( hqlUpdate ).setInteger( "newDeleted", 1 ).setDate("newDate", new Date()) .executeUpdate();
	    	WeChatUploadFile weChatUploadFile=new WeChatUploadFile();
			weChatUploadFile.setPersonId(userInfo.getOrgPerson().getPersonId());
			weChatUploadFile.setPersonName(userInfo.getOrgPerson().getName());
			weChatUploadFile.setMobile(userInfo.getOrgPerson().getMobile());
			weChatUploadFile.setLoginName(userInfo.getLoginUser().getLoginName());
			weChatUploadFile.setOrgId(userInfo.getOrgUser().getOrgId());
			weChatUploadFile.setLastAccessDate(new Date());
			weChatUploadFile.setFilePath(realUrl);
			weChatUploadFile.setType(type);
			session.save(weChatUploadFile); 
	    	
	    }
	    /**
	     *  员工资料上传--根据时间和删除标示查询员工资料 对接Jabava接口
	     * @param nowDate 查询时间
	     * @return
	     */
	    @SuppressWarnings("unchecked")
		public List<WeChatUploadFile> getUploadFiles(String nowDate){
	    	 Session session = HibernateUtils.getSessionFactory(RepositoryHelper.getEntityManager()).openSession();
	    	 Transaction tx =session.beginTransaction();
	    	String hqlUpdate = "from WeChatUploadFile where lastAccessDate > \'"+nowDate+"\' and isDeleted=0";
	    	 List<WeChatUploadFile> list = session.createQuery( hqlUpdate ).list();
		     tx.commit();  
			 session.close(); 
	    	 return list;
	    	
	    }
}
