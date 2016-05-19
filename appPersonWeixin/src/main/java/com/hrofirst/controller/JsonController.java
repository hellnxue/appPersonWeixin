package com.hrofirst.controller;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hrofirst.common.ZimuSort;
import com.hrofirst.entity.City;
import com.hrofirst.entity.Province;
import com.hrofirst.entity.Salary;
import com.hrofirst.entity.WeChatUploadFile;
import com.hrofirst.service.CityService;
import com.hrofirst.service.ProvinceService;
import com.hrofirst.service.SalaryService;
import com.hrofirst.service.WeChatUploadFileService;
import com.hrofirst.util.Config;
import com.hrofirst.util.SimpleTextEncryption;
import com.hrofirst.util.ValidatorBasic;
import com.service.provider.CenterUserService;
import com.service.provider.MedicalServiceService;
import com.service.provider.MobileService;
import com.service.provider.ReceivingAddrServiceInterface;
import com.service.provider.entity.Area;
import com.service.provider.entity.CenterSysUser;
import com.service.provider.entity.ReceivingAddrInfo;
import com.service.provider.entity.ReturnS;

/**
 * Created by qixb.fnst on 2015/02/11.
 */
@RestController
public class JsonController {
	private static final Logger LOG = LoggerFactory
			.getLogger(JsonController.class);
	//HttpClient client = HttpClientBuilder.create().build();
	
	@Autowired
	private CenterUserService centerUserService;
	
	
	
    @Autowired
    private ProvinceService provinceService;
    @Autowired
    private CityService cityService;
    @Autowired
    private SalaryService salaryService;
    
    @Autowired
    private WeChatUploadFileService weChatUploadFileService;
    
    @Autowired
    private MedicalServiceService medicalServiceService; //体检预约接口
    @Autowired
    private ReceivingAddrServiceInterface receivingAddrServiceInterface; //收货地址管理接口
    
    @Autowired
	private MobileService mobileService;
    
    @RequestMapping("province")
    public List<Province> findAllProvince() {
        return provinceService.findByTypeNot(ProvinceService.ProvinceType.其他国家);
    }

    @RequestMapping("province/{pid}/city")
    public List<City> findAllCity(@PathVariable long pid) {
        return cityService.findByProvince(pid);
    }
    /**
     * 社保公积金查询
     * @param cardId
     * @param month
     * @return
     */
    @RequestMapping("hrhelper-platform/SocialInsuranceController.action")
    public String nationalGuard( @RequestParam String cardId, @RequestParam String month) {
        HttpClient client = HttpClientBuilder.create().build();
        HttpGet get = new HttpGet(
                Config.getNationGuardUrl()+"?cardId=" + cardId + "&month=" + month);
        InputStream stream = null;
        try {
            HttpResponse res = client.execute(get, new BasicHttpContext());
            stream = res.getEntity().getContent();
            return inputStreamTOString(stream, "UTF-8");
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stream != null) {
                try {
                    stream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }
    
    
	/**
	 * 模拟浏览器post提交
	 * 
	 * @param url
	 * @return
	 */
	public static HttpPost getPostMethod(String url) {
		HttpPost pmethod = new HttpPost(url); // 设置响应头信�?
//		pmethod.addHeader("Connection", "keep-alive");
//		pmethod.addHeader("Accept", "*/*");
//		pmethod.addHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
//		pmethod.addHeader("X-Requested-With", "XMLHttpRequest");
//		pmethod.addHeader("Cache-Control", "max-age=0");
//		pmethod.addHeader("User-Agent",
//				"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0) ");
		return pmethod;
	}
	
    
    /**
     * 根据用户名查询其所在的企业名称  接口，返回json
     */
    @RequestMapping("hrhelper-platform/orgName")
    public String orgName(HttpServletRequest request, @RequestParam String userName) {
    	HttpClient client = HttpClientBuilder.create().build();
    	String result="{\"errorMessage\":\"该用户不存在！\",\"userName\":\""+userName+"\"}";
    	HttpPost httpost = new HttpPost(Config.getDatacenterUrl()+"tokenget.e?username=weixin&secret=123456&type=weixin1&user_name="+userName);
        try {
    		HttpResponse response = client.execute(httpost);
    		String jsonStr = EntityUtils.toString(response.getEntity(), "utf-8");
//        	String jsonStr ={"tables":[{"tablename":"ORG_NAME", "records":[{"USER_ID":"780278","USER_NAME":"songjing","ORG_CHINESE_NAME":"鏄婂熀浜哄姏璧勬簮鏈嶅姟锛堜笂娴凤級鏈夐檺鍏徃",},]},]}
	    	JSONObject object0 = JSON.parseObject(jsonStr);
	    	com.alibaba.fastjson.JSONArray list0 = JSON.parseArray(object0.getString("tables"));
	    	String records = ((JSONObject)list0.get(0)).getString("records");
	   		com.alibaba.fastjson.JSONArray list = JSON.parseArray(records);
	   		if(list!=null&&list.size()>0){
	   			result=list.get(0).toString();
	   		}
	    	System.out.println("result="+result);
	   		return result;
    		
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }   
        return result;
    }
    
    /**
     * 根据用户手机号码查询其所在的企业信息  接口，返回json
     */
    @RequestMapping("hrhelper-platform/orgInfo")
    public String orgInfo(HttpServletRequest request, @RequestParam String mobile) {
    	HttpClient client = HttpClientBuilder.create().build();
    	String result="{\"errorMessage\":\"未查到相关数据！\",\"mobile\":\""+mobile+"\"}";
    	HttpPost httpost = new HttpPost(Config.getDatacenterUrl()+"tokenget.e?username=weixin&secret=123456&type=weixin3&user_name="+mobile);
        try {
    		HttpResponse response = client.execute(httpost);
    		String jsonStr = EntityUtils.toString(response.getEntity(), "utf-8");
	    	JSONObject object0 = JSON.parseObject(jsonStr);
	    	com.alibaba.fastjson.JSONArray list0 = JSON.parseArray(object0.getString("tables"));
	    	String records = ((JSONObject)list0.get(0)).getString("records");
	   		com.alibaba.fastjson.JSONArray list = JSON.parseArray(records);
	   		if(list!=null&&list.size()>0){
	   			result=list.get(0).toString();
	   		}
	    	System.out.println("result="+result);
	   		return result;
    		
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }   
        return result;
    }
    /**
     * 调用通讯录接口，返回json
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("hrhelper-platform/contantList")
    public String contantList(HttpServletRequest request) {
    	HttpClient client = HttpClientBuilder.create().build();
    	String result="{\"errorMessage\":\"查询数据不存在！\"}";
    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
    	String idcard = userInfo.getOrgPerson().getCardNum();
    	HttpPost httpost = new HttpPost(Config.getDatacenterUrl()+"tokenget.e?username=weixin&secret=123456&type=weixin4&card_id="+idcard);
        try {
    		HttpResponse response = client.execute(httpost);
    		String jsonStr = EntityUtils.toString(response.getEntity(), "utf-8");
//        	String jsonStr ={"tables":[{"tablename":"ORG_NAME", "records":[{"USER_ID":"780278","USER_NAME":"songjing","ORG_CHINESE_NAME":"鏄婂熀浜哄姏璧勬簮鏈嶅姟锛堜笂娴凤級鏈夐檺鍏徃",},]},]}
	    	JSONObject object0 = JSON.parseObject(jsonStr);
	    	com.alibaba.fastjson.JSONArray list0 = JSON.parseArray(object0.getString("tables"));
	    	String records = ((JSONObject)list0.get(0)).getString("records");
	   		com.alibaba.fastjson.JSONArray list = JSON.parseArray(records);
	   		ZimuSort zimuSort = new ZimuSort();  
	   	    ArrayList<HashMap> tempList=new ArrayList<HashMap>();
	   		for(int i=0; i<list.size(); i++){
	   			JSONObject detail = (JSONObject)list.get(i);
	   			//各个值放入map
	   		    HashMap tempMap=new HashMap();
	   		    tempMap.put("DEPT_ID", detail.getString("DEPT_ID"));
		   		tempMap.put("CNAME", detail.getString("CNAME"));
		   		tempMap.put("USER_ID", detail.getString("USER_ID"));
		   		tempMap.put("USER_NAME", detail.getString("USER_NAME"));
		   		tempMap.put("DEPT_NAME", detail.getString("DEPT_NAME"));
		   		tempMap.put("mobile", detail.getString("mobile"));
		   		tempMap.put("email", detail.getString("email"));
		   		tempList.add(tempMap);
	   		}
	   		String resultStr = zimuSort.sort(tempList);
	   		Object todaySum1 = JSON.parse(resultStr);
	   		//System.out.println("tempList="+tempList);
	   		//System.out.println("todaySum1="+todaySum1);
	   		result=todaySum1.toString();
	   		System.out.println("result=========="+result);
	   		return result;
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }   
        return result;
    }
    

    /**
     * 调用工资单接口，返回json
     * @param cardId
     * @param month
     * @return
     */
    @RequestMapping("hrhelper-platform/salary")
    public String wsalary(@RequestParam String cardId, @RequestParam String month) {
    	HttpClient client = HttpClientBuilder.create().build();
    	
    	String url = Config.getSalaryApiUrl()+"?cardId="+cardId+"&month="+month;
        
    	HttpPost httpost = new HttpPost(url);
    	
        try {
    		HttpResponse response = client.execute(httpost);
    		String jsonStr = EntityUtils.toString(response.getEntity(), "utf-8");
   		
	    	return jsonStr;
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } 
        
        String result = "{\"errorMessage\":\"该用户不存在！\",\"cardId\":\""+cardId+"\"}";
        return result;

    }
    
    /**
     * 移动签到 ：上班签到和下班签到
     * @param request
     * @param addressStr
     * @return
     */
    @RequestMapping("hrhelper-platform/empCheck")
    public String empCheck(HttpServletRequest request, @RequestParam String aType, @RequestParam String aForget, @RequestParam String idCard) {
    	String result="{\"message\":\"success\"}";
    	HttpClient client = HttpClientBuilder.create().build();
    	LOG.info("移动签到.....");
    	String params="";
		String username = (String) request.getSession().getAttribute("ZhiyangUserName");   
		String longitude = request.getParameter("longitude");
		String latitude = request.getParameter("latitude");
		String performance = request.getParameter("performance");
		
    	System.out.println(longitude+"|"+latitude+"|");
    	LOG.info("经度："+longitude );
    	LOG.info("纬度："+latitude );
    	
    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
		 
		Long hroOrgId=userInfo.getOrgOrganization().getHroOrgId();
        //error position:121.543738  38.231596
    	//正式：http://kaoqin.ezhiyang.com
		//测试：http://bakkaoqin.ezhiyang.com
		if(aType.equals("3")){
			params="aType="+aType+"&author="+username+"&orgId="+hroOrgId+"&performance="+performance+"&pX="+longitude+"&pY="+latitude+"&idCard="+idCard;
		}else{
			
			params="idCard="+idCard+"&aForget="+aForget+"&aType="+aType+"&author="+username+"&pX="+longitude+"&pY="+latitude+"&orgId="+hroOrgId;
		}
		
		//hro移动签到接口
    	HttpPost httpost = getPostMethod( Config.getKaoqinUrl()+ "/attendance/ajax/create.e?"+params);
    	httpost.addHeader("Accept", "application/json");
        try {
    		HttpResponse response = client.execute(httpost);
    		result = EntityUtils.toString(response.getEntity(), "utf-8");
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }  
        
        JSONObject object0 = JSON.parseObject(result);
        System.out.println(object0.getString("err"));
        int flag=Integer.parseInt(object0.getString("err"));
        
         //jabava移动签到接口
         if(flag==0){
        	httpost = getPostMethod( Config.getKaoqinJabavaUrl()+ "/attendance/ajax/create.e?"+params);
        	System.out.println(Config.getKaoqinJabavaUrl()+ "/attendance/ajax/create.e?"+params);
        	httpost.addHeader("Accept", "application/json");
            try {
        		 HttpResponse response = client.execute(httpost);
        		 //result = EntityUtils.toString(response.getEntity(), "utf-8");  
            } catch (IOException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            } 
         }
        
        return result;
    }  
    
    
    /**
     *  根据手机号码判断账户是否被激活
     * @param mobile
     * @return
     */
    @RequestMapping("hrhelper-platform/isToBeActiveAccountInfo")
    public String isToBeActiveAccountInfo(String mobile){
    	//如果不包含该手机号对应的雇员，返回错误
		ReturnS result = centerUserService.getOtherUserInfo(mobile);
    	if (result.getSuccess() == false){
			return "{\"message\":\"false\""+","+"\"code\":\""+result.getMsg()+"\"}";
		}
    	return "{\"message\":\"true\"}";
    }
    
    /**
     * 发送手机验证码
     * @param request
     * @param mobile
     * @param functionCode
     * @return
     */
    private String sendMess(HttpServletRequest request, String mobile, String functionCode){
    	if(StringUtils.isNotBlank(mobile)){
			if(ValidatorBasic.isMobile(mobile)){
				//激活账号时做是否已经激活的判断
				if(functionCode.equals("personregister")){
					//如果不包含该手机号对应的雇员，返回错误
					ReturnS result = centerUserService.getOtherUserInfo(mobile);
					if (result.getSuccess() == false){
						return "{\"code\":\""+result.getMsg()+"\"}";
					}
				}
		    	String VALID_CODE_VALUE_RANGE = "0123456789";
		    	// 获取随机验证码
				Random random = new Random();
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < 6; i++) {
					int number = random.nextInt(VALID_CODE_VALUE_RANGE.length());
					sb.append(VALID_CODE_VALUE_RANGE.charAt(number));
				}
				
				String randomCode = sb.toString();
				String content = "验证码为" + randomCode
						+ ",感谢您使用智阳网络平台邮箱绑定服务，若非本人操作，请忽略此条信息。";
				
				
				if(mobileService.sendMessage(mobile, content).equals("1")){
					request.getSession().setAttribute("activeCode", randomCode);
		        	request.getSession().setAttribute("activeMobile", mobile);

					return "true";				
				}else{
					return "{\"code\":\"验证码发送失败\"}";
				}
			}else{
				return "{\"code\":\"手机号码格式不正确\"}";
			}
		}else{
			return  "{\"code\":\"手机号码为空\"}";
		}    	
    }
    /**
     * 给邮箱发送个验证码 暂时不用（暂时还不好用...）
     * @param request
     * @param mobile
     * @param functionCode
     * @return
     */
//    private String sendMessToEmail(HttpServletRequest request, String email, String functionCode){
//    	if(StringUtils.isNotBlank(email)){
//			if(ValidatorBasic.isEmail(email)){
//		    	String VALID_CODE_VALUE_RANGE = "0123456789";
//		    	// 获取随机验证码
//				Random random = new Random();
//				StringBuffer sb = new StringBuffer();
//				for (int i = 0; i < 6; i++) {
//					int number = random.nextInt(VALID_CODE_VALUE_RANGE.length());
//					sb.append(VALID_CODE_VALUE_RANGE.charAt(number));
//				}
//				
//				String randomCode = sb.toString();
//				SimpleMail sm = new SimpleMail();
//				sm.setContent("验证码为【" + randomCode
//						+ "】,感谢您使用智阳网络平台邮箱绑定服务，若非本人操作，请忽略此条信息。");
//				sm.setSubject("邮箱验证");
//				boolean flag = false;
//				try {
//					// 验证码发送
//					MailFactory.getMailSend().send(email, sm);
//					flag = true;
//				} catch (Exception e) {
//					e.printStackTrace();
//					flag = false;
//				}
//				if (flag) {
//					return "true";	
//				} else {
//					return "{\"code\":\"验证码发送失败\"}";
//				}
//				
//			}else{
//				return "{\"code\":\"邮箱地址格式不正确\"}";
//			}
//		}else{
//			return  "{\"code\":\"邮箱地址为空\"}";
//		}    	
//    }
    /**
     * 雇员激活、找回密码发送验证码接口，返回json
     * @return
     */
    @RequestMapping("hrhelper-platform/anon/sendMessage")
    @ResponseBody
    public String sendMessage(HttpServletRequest request, @RequestParam String mobile, @RequestParam String functionCode) {
    	
    	return sendMess(request, mobile, functionCode);
    }
    
    /**
     * 安全验证验证码接口，返回json
     * @return
     */
    @RequestMapping("hrhelper-platform/anon/sendCertifyMessage")
    @ResponseBody
    public String sendCertifyMessage(HttpServletRequest request) {
    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
    	String mobile = userInfo.getOrgPerson().getMobile();
    	
    	return sendMess(request, mobile, "certify");
    }
    
  
    
//    /**
//     * 修改邮箱发送验证码接口，返回json(暂时不用)
//     * @return
//     */
//    @RequestMapping("hrhelper-platform/anon/sendEmailMessage")
//    @ResponseBody
//    public String sendEmail(HttpServletRequest request, @RequestParam String email, @RequestParam String functionCode) {
//    	
//    	return sendMessToEmail(request, email, functionCode);
//    }
    @RequestMapping("hrhelper-platform/anon/checkCode")
    public String checkCode(HttpServletRequest request, @RequestParam String code) {
    	
    	String sessionCode = (String) request.getSession().getAttribute("activeCode");
    	if (sessionCode.equals(code)){
    		return "true";
    	}else{
    		return "false";
    	}
    }
    
    @RequestMapping("/service/ewage.e")
    public BaseResponse<Salary> salary(
            @RequestParam String cardId, @RequestParam String month) {
        BaseResponse<Salary> response = new BaseResponse<Salary>();
        Salary salary = salaryService.findSalaryByIdCardAndMonth(cardId, month);
        if (salary == null) {
            response.setErrorMessage("不存在该账户或无数据");
        }
        response.setData(salary);
        return response;

    }

    public static class BaseResponse<T> {
        private T data;
        private String errorMessage;

        public T getData() {
            return data;
        }

        public void setData(T t) {
            this.data = t;
        }

        public String getErrorMessage() {
            return errorMessage;
        }

        public void setErrorMessage(String errorMessage) {
            this.errorMessage = errorMessage;
        }
    }



    private static final int BUFFER_SIZE = 1024 * 1024;

    public static String inputStreamTOString(InputStream in, String encoding) throws Exception {

        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        byte[] data = new byte[BUFFER_SIZE];
        int count = -1;
        while ((count = in.read(data, 0, BUFFER_SIZE)) != -1)
            outStream.write(data, 0, count);

        data = null;
        String temp = new String(outStream.toByteArray(), encoding);
        outStream.close();
        return temp;
    }

    /**
      * 根据用户id查询他的体检券  接口，返回json
      */
     @RequestMapping("hrhelper-platform/tjianTickets")
     public String tickets(HttpServletRequest request) {
    	String username = (String) request.getSession().getAttribute("ZhiyangUserName");
     	String result="{\"errorMessage\":\"没有数据！\",\"userName\":\""+username+"\"}";
    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
    	Long userid = userInfo.getLoginUser().getLoginId();  
     	List<Map<String,Object>> list=medicalServiceService.getMedicalList(userid);//44L
     	if(list!=null&&list.size()>0){
     		System.out.println("list="+list);
         	JSONObject jsonObject=new JSONObject();
         	jsonObject.put("key", list);
         	//System.out.println("jsonObject333333333="+jsonObject.toString());
         	
            return jsonObject.toString();
     		
     	}
     	
     	return result;
     }
     /**
      * 激活体检卡
      */
     @RequestMapping("hrhelper-platform/tjianActivate")
     public String tjianActivate(HttpServletRequest request,String cardNum,String cardPwd,Long storeId) {
    	 
    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
    	Long userid = userInfo.getLoginUser().getLoginId();  
    	
     	String args=medicalServiceService.medicalCardActivation(cardNum, cardPwd, storeId, userid);
     	
    	String result="{\"message\":\""+args+"\"}";
    	
     	return result;
     }
     
     /**
      * 根据定位区县id查询机构列表 
      * @param request
      * @param areadistrictid 选择区域中的区县id
      * @param prodId   产品id
      * @return
     * @throws UnsupportedEncodingException 
      */
     @RequestMapping("hrhelper-platform/tjjigoulist")
     public String tjjigoulist(HttpServletRequest request,Long areadistrictid,Long prodId) throws UnsupportedEncodingException {
    	 String result="{\"errorMessage\":\"查询数据不存在！\"}";
    	 System.out.println("prodId=="+prodId);
    	 List<Map<String, Object>> listServiceStoreList=null;//机构列表list
    	 JSONObject jsonObject=new JSONObject();
    	 Long quxianId=areadistrictid; //默认区县id为点击区域选择的区县id
    	 
    	 listServiceStoreList=medicalServiceService.getServiceStoreList(prodId, quxianId,null);
    	 
    	 if(listServiceStoreList!=null&&listServiceStoreList.size()>0){
    			jsonObject.put("key",listServiceStoreList);
    	      	System.out.println("quxianjigouList="+jsonObject.toString());
    	        return jsonObject.toString();
		 }
      
    	 return result;
     }
     /**
      * 根据定位坐标查询距离该坐标由近及远的所有门店总数
      * @param request
      * @param province 定位省
      * @param city  定位市
      * @param prodId  产品id
      * @return
      * @throws UnsupportedEncodingException
      */
     @RequestMapping("hrhelper-platform/tjlistByPositionCityTotal")
     public String citytjjigoulistTotal(HttpServletRequest request, String province, String city, Long prodId) throws UnsupportedEncodingException {
    	 
    	 String pprovince=URLDecoder.decode(province, "UTF-8"); 				//省
    	 String pcity=URLDecoder.decode(city, "UTF-8");							//市
    	 Area sysAre=new Area();												//城市对象
    	 Long cityId=this.getCityIdByPnameAndCname(sysAre,pprovince,pcity);  	//市id
    	 
    	int total= medicalServiceService.getMedicalListForLocaltionSize(prodId,cityId);
    	
    	return total+"";
     }
     /**
      * 查询定位城市下的所有区县的所有机构列表
      * @param request
      * @param province 定位省
      * @param city 定位市
      * @param lat 经度
      * @param lng 纬度
      * @param currentPage 当前页
      * @param prodId 产品id
      * @return
      * @throws UnsupportedEncodingException
      */
     @RequestMapping("hrhelper-platform/tjlistByPositionCity")
     public String citytjjigoulist(HttpServletRequest request,String province,String city, Double lat, Double lng, int currentPage, Long prodId,int pageSize) throws UnsupportedEncodingException {
    	 String result="{\"errorMessage\":\"查询数据不存在！\"}";
    	 
    	 List<Map<String, Object>> listServiceStoreList=null;					//机构列表list
    	 JSONObject jsonObject=new JSONObject();
    	 String pprovince=URLDecoder.decode(province, "UTF-8"); 				//省
    	 String pcity=URLDecoder.decode(city, "UTF-8");							//市
    	 Area sysAre=new Area();												//城市对象
    	 Long cityId=this.getCityIdByPnameAndCname(sysAre,pprovince,pcity);     //市id
    	 
    	 listServiceStoreList=medicalServiceService.getMedicalListForLocaltion(prodId,cityId,lng,lat, currentPage,pageSize, null);
    	 if(listServiceStoreList!=null&&listServiceStoreList.size()>0){
    		jsonObject.put("key",listServiceStoreList);
          	System.out.println("cityOrg111="+jsonObject.toString());
            return jsonObject.toString();
    	 }
    	
    	return result;
     }
     
     /**
      * 根据省名称、类型和城市名称、类型查询城市id
      * @param sysAre
      * @param province
      * @param city
      * @return
      */
     public Long getCityIdByPnameAndCname(Area sysAre,String province,String city){
    	 //根据省查询
    	 sysAre.setAreaName(province);
    	 sysAre.setIdentifier(2);
    	 List<Area> listArea1=medicalServiceService.getSysAreaListByParam(sysAre);
    	 if(listArea1!=null&&listArea1.size()>0){
    		 //省id
    		 Long provinceId=listArea1.get(0).getId();
    		 //市
    		 sysAre.setParentId(provinceId);
    		 sysAre.setAreaName(city);
        	 sysAre.setIdentifier(3);
        	 List<Area> listArea2=medicalServiceService.getSysAreaListByParam(sysAre);
        	 if(listArea2!=null&&listArea2.size()>0){
           	  return listArea2.get(0).getId(); //市id
        	 }
    		
	       }
    	 return null;
     }
     
     /**
      * 查询指定机构详情
      * @param prodId
      * @param service_store_id
      * @return
      */
     @RequestMapping("hrhelper-platform/tjjigouDetail")
     public String getJitouListJsonByProvinceAndCity(Long prodId, Long service_store_id){
    	 
		JSONObject jsonObject = new JSONObject();
		List<Map<String, Object>> listServiceStoreList  = medicalServiceService.getServiceStoreList(prodId, null, service_store_id);
		jsonObject.put("key", listServiceStoreList);
		
		System.out.println("jigou Detail="+ jsonObject.toString());
		
		return jsonObject.toString();
     }
     
     /**
      * 获取地域---省市区json
      */
     @RequestMapping("hrhelper-platform/provincelist")
     public String provincelist(HttpServletRequest request) {
    	 String result="{\"errorMessage\":\"查询数据不存在！\"}";
    	 Area sysAre=new Area();//城市对象
    	 sysAre.setIdentifier(2);
    	 List<Area> listArea=medicalServiceService.getSysAreaListByParam(sysAre);
    	
    	 if(listArea!=null&&listArea.size()>0){
    		JSONObject jsonObject=new JSONObject();
    		
    		for(int p=0;p<listArea.size();p++){
    			sysAre.setParentId(listArea.get(p).getId());
    	    	sysAre.setIdentifier(3);
    			List<Area> cityList=getCityList(sysAre);//城市list
    			listArea.get(p).setListCity(cityList);
    			
    			if(cityList!=null&&cityList.size()>0){
    				for(int c=0;c<cityList.size();c++){
    					sysAre.setParentId(cityList.get(c).getId());
    			    	sysAre.setIdentifier(4);
    					List<Area> districtList=getCityList(sysAre);//区县list
    					cityList.get(c).setListDistrict(districtList);
    				}
    			}
    		}
	       	jsonObject.put("provincekey", listArea);
	       	System.out.println("jsonObjectssssssssssssssssss="+jsonObject.toString());
	       	return jsonObject.toString();
    	 }
    	
         return result;
     }
     
     /**
      * 根据省名称和类型获取地域---市list
      */
    
     public List<Area> getCityList(Area sysAre) {
    	 
    	 List<Area> listArea=medicalServiceService.getSysAreaListByParam(sysAre);
    	 if(listArea!=null&&listArea.size()>0){
	    	return listArea;
    	 }
         return null;
     }
     /**
      * 根据市名称和类型获取地域---区县list
      */
     public  List<Area> getDistrictList( Area sysAre) {
    	 List<Area> listArea=medicalServiceService.getSysAreaListByParam(sysAre);
    	 if(listArea!=null&&listArea.size()>0){
	    	return listArea;
    	 }
         return null;
     }
     
     /**
      * 获取服务门店预约日历信息
      * @param service_id  服务id
      * @param service_store_id  服务门店id
      * @param userid 用户id
      * @param year
      * @param month
      * @return
      */
 	@RequestMapping("hrhelper-platform/serviceStoreAppointmentInfo")
 	@ResponseBody
 	public Map<String, Object> serviceStoreScheduleList(Long service_id,Long service_store_id,Long userid, int year, int month) {
 		
 		Map<String, Object> map = medicalServiceService.getServiceStoreScheduleByStoreId(service_id,service_store_id, year,month,userid );//4L, 3L, 2015,8,44L
 		
 		return map;
 	}
 	 /**
     * 提交体检预约
     * @param service_id  服务id
     * @param service_store_id  服务门店id
     * @param userid 用户id
     * @param year
     * @param month 
     * @return   
     */
	@RequestMapping("hrhelper-platform/submitMedicalAppointment")
	@ResponseBody
	public String submitMedicalAppointment(HttpServletRequest request, int year, int month, int day,Long service_id,Long service_store_id,int checked,
			Long receivingAddrId) {
//		String username = (String) request.getSession().getAttribute("ZhiyangUserName");  
//    	ReturnS results = hrofirstUserService.getDetailLoginInfo(username);
//    	HROFirstUserInfo userInfo = (HROFirstUserInfo)results.getResult(); 
//		boolean flag = medicalServiceService.submitMedicalAppointment(service_id,service_store_id,  year,  month,  day,checked,receivingAddrId, userInfo);
		boolean flag = false;
		return  flag+"";
	}
     
	
	/**
	 * 根据体检劵id查询体检预约成功后详细信息
	 * @param service_id
	 * @param userid
	 * @return
	 */
	@RequestMapping("hrhelper-platform/mdicalDetails")
 	@ResponseBody
 	public String mdicalDetails(Long service_id,Long userid) {
		String result="{\"errorMessage\":\"查询数据不存在！\"}";
 		Map<String, Object> map = medicalServiceService.medicalDetail(service_id,userid);//44L
 		System.out.println("map=="+map);
 		if(map!=null&&map.size()>0){
 			
 			return JSONObject.toJSON(map).toString();
 		}
 		return result;
 	}
	
	/**
	 * 日历预约页面相关详情
	 * @param service_id
	 * @param userid
	 * @return
	 */
	@RequestMapping("hrhelper-platform/medicalBeforeDetail")
 	@ResponseBody
 	public String medicalBeforeDetail(Long service_id,Long service_store_id,Long userid) {
		String result="{\"errorMessage\":\"查询数据不存在！\"}";
 		Map<String, Object> map = medicalServiceService.medicalBeforeDetail( service_id, userid,  service_store_id);//44L
 		System.out.println("map=="+map);
 		if(map!=null&&map.size()>0){
 			
 			return JSONObject.toJSON(map).toString();
 		}
 		return result;
 	}
	
	/**
	 * 根据条件获取地域
	 * @param request
	 * @param parentId 父级id
	 * @param identifier 地区等级
	 * @return
	 */
    @RequestMapping("hrhelper-platform/areaInfo")
    public String areaInfo(HttpServletRequest request,Long parentId,int identifier) {
    	
	   	 String result="{\"errorMessage\":\"查询数据不存在！\"}";
	   	 
	   	 Area sysAre=new Area();//城市对象
	   	 
	   	 sysAre.setIdentifier(identifier);
	   	 
	   	 if(parentId!=null){
	   		sysAre.setParentId(parentId);;
	   	 }
	   	 
	   	 List<Area> listArea=medicalServiceService.getSysAreaListByParam(sysAre);
	   	 
	   	 if(listArea!=null&&listArea.size()>0){
	   		 
	   		 JSONObject jo=new JSONObject();
	   		 jo.put("key", listArea);
	   		 System.out.println("result=="+jo.toString());
	   		 return jo.toString();
	   	 }
	      return result;
    }
    public static void main(String args[]){
    	
//    	String json=JSON.parse(tijian).toString();
//    	System.out.println(json);
    	
    	List<String> list=new ArrayList<String>();
    	list.add("hello");
    	list.add("world");
    	JSONObject jo=new JSONObject();
    	jo.put("key", list);
    	
    	//JSON.parse(jo.toJSONString());
    	System.out.println(JSON.parse(jo.toString()));
    	System.out.println(jo.toString());
    	
    	Map<String,Object> map=new HashMap<String,Object>();
    	map.put("h1", "hello");
    	map.put("h2", 10);
    	
    	System.out.println(JSON.toJSONString(map));
    	
    	
    	String result="{\"err\":0,\"errMsg\":\"hello\"}";
    	 JSONObject object0 = JSON.parseObject(result);
         System.out.println(object0.getString("errMsg"));
         
         
         String str="hello world";
         boolean flag=str instanceof Object;
         System.out.println("HEHE:"+flag);
         
         String st1="hello";
         String st2="hello";
         boolean f1=st1==st2;
         boolean f2=st1.equals(st2);
         
         System.out.println(f1+"\n hh="+f2);
         
         String s1="hello";
         String s2=new String("hello");
         boolean ff1=s1==s2;
         boolean ff2=s1.equals(s2);
         
         System.out.println("==:"+ff1);
         System.out.println("==:"+ff2);
//         String a=null;
//         String b=new String(a);
         
         String ss=new String("world");
         String xx=new String("world");
         System.out.println(ss==ss);//true
         System.out.println(ss==xx);//false
    	
    }
    /**
	 * 查询收获地址列表
	 * @param request
	 * @return
	 */
    @RequestMapping("hrhelper-platform/receiveList")
    public String receiveList(HttpServletRequest request) {
    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
	   	String result="{\"errorMessage\":\"查询数据不存在！\"}";
	   	ReceivingAddrInfo receivingAddrInfo=new ReceivingAddrInfo();
	   	receivingAddrInfo.setUserId(userInfo.getLoginUser().getLoginId());
	   	receivingAddrInfo.setIsDeleted(0);
	   	List<ReceivingAddrInfo> receiveList=receivingAddrServiceInterface.getReceivingAddr(receivingAddrInfo);
	   	 
	   	 if(receiveList!=null&&receiveList.size()>0){
	   		 
	   		 JSONObject jo=new JSONObject();
	   		 jo.put("key", receiveList);
	   		// System.out.println("result=="+jo.toString());
	   		 return jo.toString();
	   	 } 
	      return result;
    }
    
    /**
	 * 新增地址列表
	 * @param request
	 * @return
	 */
    @RequestMapping("hrhelper-platform/receiveAdd")
    public String receiveAdd(HttpServletRequest request,@RequestBody ReceivingAddrInfo receivingAddrInfo) {
    	CenterSysUser userInfo = (CenterSysUser) request.getSession()
				.getAttribute("userInfo");
	   	
	   	receivingAddrInfo.setUserId(userInfo.getLoginUser().getLoginId());
	   	
	   	if(receivingAddrInfo.getIsDefault()==1){
	   		receivingAddrServiceInterface.updateDefaultStatus(userInfo.getLoginUser().getLoginId());
	   	}
	   	int flag=receivingAddrServiceInterface.addReceivingAddr(receivingAddrInfo);
	   
	   	return flag+"";
    }
    
    /**
  	 * 根据地址id获取地址详情
  	 * @param request
  	 * @return
  	 */
      @RequestMapping("hrhelper-platform/receiveUpdate")
      public String getReceiveInfoById(HttpServletRequest request,@RequestBody ReceivingAddrInfo receivingAddrInfo) {
    	  
         	CenterSysUser userInfo = (CenterSysUser) request.getSession()
    				.getAttribute("userInfo");
         	
	  	   	//假如修改的该条数据本身是默认收货地址时，即使未选中checkbox，它仍然是默认的收货地址
	  	   	if(receivingAddrInfo.getIsDefault()!=1&&receivingAddrInfo.getIsChecked()==1){
	  	  	    receivingAddrInfo.setIsDefault(receivingAddrInfo.getIsChecked());
	  	   		receivingAddrServiceInterface.updateDefaultStatus(userInfo.getLoginUser().getLoginId());
	  	   	}
	  	   	int flag=receivingAddrServiceInterface.updateReceivingAddr(receivingAddrInfo);
  	   
	  	   	return flag+"";
      }
      
     /**
  	 * 删除收获地址列表
  	 * @param request
  	 * @return
  	 */
      @RequestMapping("hrhelper-platform/receiveDelete")
      public String receiveDelete(HttpServletRequest request,Long receivingAddrId) {
		ReceivingAddrInfo receivingAddrInfo=new ReceivingAddrInfo();
  	    receivingAddrInfo.setReceivingAddrId(receivingAddrId);
  	   	int flag=receivingAddrServiceInterface.deleteReceivingAddr(receivingAddrInfo);
  	   	 
  	    return flag+"";
      }
      
      /**
    	 * 获取默认收货地址
    	 * @param request
    	 * @return
    	 */
        @RequestMapping("hrhelper-platform/getDefaultAddress")
        public String getDefaultAddress(HttpServletRequest request) {
        	String result="{\"errorMessage\":\"查询数据不存在！\"}";
         	CenterSysUser userInfo = (CenterSysUser) request.getSession()
    				.getAttribute("userInfo");
         	ReceivingAddrInfo receivingAddrInfo=receivingAddrServiceInterface.getDefaultAddr(userInfo.getLoginUser().getLoginId());
         	if(receivingAddrInfo.getReceivingAddrId()!=null){
         		JSONObject jsonObject=new JSONObject();
        	   	jsonObject.put("receivingAddrInfo", receivingAddrInfo);
        	   	System.out.println(jsonObject.toString());
        	    return jsonObject.toString();
         		
         	}
    	   	return result;
        }
        
        /**
         * 员工资料上传--根据时间和删除标示查询员工资料 对接Jabava接口
         */
        
    	@RequestMapping("/webApp/user/getEmployeeUploadFiles")
    	@ResponseBody
    	public String getUploadsFiles(HttpServletRequest request)  {
    		
    		String nowDate=request.getParameter("nowDate");
    		
    		//String nowDate="2016-01-26 17:51:48";
    		
    		List<WeChatUploadFile> list=null;
    		
    		if(nowDate!=null&&!nowDate.equals("")){
    			
    			list=weChatUploadFileService.getUploadFiles(nowDate);
    		}else{
    			return  "{\"errorMessage\":\"参数不正确！\"}";
    		}
    		
    		if(list!=null&&list.size()>0){
    			
    			System.out.println(JSON.toJSON(list));
    			
    			return JSON.toJSON(list).toString();
    		}
    		return "{\"errorMessage\":\"没有相关数据！\"}";
    	}
    	
    	/**
    	 * 调用Jabava接口获取用户基本信息
    	 * @param request
    	 * @param idcardmw 加密后的身份证
    	 * @return
    	 */
    	@RequestMapping("jabava/getUserInfoByCardId")
    	@ResponseBody
	    public String getUserInfoByCardId(HttpServletRequest request,String idcard) {// +/z//v38/PT1//31/fz9/fz0
    	  LOG.info("获取用户基本信息......");
    	  LOG.info("密文idcard："+idcard);
		  String cardId = "";
		  HttpClient client = HttpClientBuilder.create().build();
		 
    	  if ( request.getSession().getAttribute("IdCard") != null){//用户自己查看名片
    		cardId = (String) request.getSession().getAttribute("IdCard");
            
    	  }else{//分享出去的时候别人查看名片
    		 
    		cardId=SimpleTextEncryption.decrypt(idcard);//获取身份证密文并解密
    		System.out.println("解密后的idcard:"+cardId);
    	  }
		   
	      HttpGet get = new HttpGet(Config.getJabavaUrl()+"/api/employeeInteface/getEmployeeByCardId?cardId=" + cardId);//3242222222
	      InputStream stream = null;
	      try {
	            HttpResponse res = client.execute(get, new BasicHttpContext());
	            stream = res.getEntity().getContent();
	            String result=inputStreamTOString(stream, "UTF-8");
	            return result;
	        } catch (IOException e) {
	            e.printStackTrace();
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (stream != null) {
	                try {
	                    stream.close();
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
    		
	        return "{\"errorMessage\":\"没有相关数据！\"}";
	    }
}
