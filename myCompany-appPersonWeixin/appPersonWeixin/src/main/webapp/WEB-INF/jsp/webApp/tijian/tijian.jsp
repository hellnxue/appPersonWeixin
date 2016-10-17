<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">体检预约</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="tj_list" id="tj_list">
<ul data-am-widget="gallery" class="am-gallery am-avg-sm-2 am-avg-md-3 am-avg-lg-4 am-gallery-default">
 <li class="bd_mk">
   <div class="am-gallery-item">
  	<a href="${ctx }/webApp/user/tijianbangding">
    <img src="${ctx }/static/assets/images/addico.png" alt="远方 有一个地方 那里种有我们的梦想"/>
    <p align="center">点击激活体检卡</p>
    </a>
    </div>
  </li>
</ul>
</div>
<es:webAppNewFooter/>
<script src="${ctx}/static/assets/js/utils.js" type="text/javascript"></script>
<script>
$(function() {
  $('.am-slider-manual').flexslider({
  // options
  });
  /**
      调用体检券接口
  **/
  
  $.getJSON("${ctx}/hrhelper-platform/tjianTickets", 
	function (data) {
         if(data.errorMessage!==undefined){
             console.log("错误消息！");
             return;
         }
         
         var tjarray=data.key;
         console.log(tjarray);
         tjarray.forEach(function(item,index,array){
        	
        	 var status="";//预约状态
        	 var prodName=item.NAME;//产品名称
        	 var storeName=item.MNAME;//店铺名称
        	 var classs="am-radius";
        	 
        	 if(item.SERVICE_STATUS===undefined){
        		  status="待预约";
        	 }
        	 var hrefs='${ctx}/webApp/tijian/tijian1?prod_id='+item.PROD_ID+'&service_id='+item.SERVICE_ID;
        	 if(item.SERVICE_STATUS===1){
        		  status="已预约";
        		  classs="am-radius cur";
        		 hrefs='${ctx}/webApp/tijian/tijian12?service_id='+item.SERVICE_ID;
        		  //hrefs="#";
        	 }
        	 // * 预约状态  1预约中 2  预约成功  3预约失败  4 体检结束
        	/*  if(item.SERVICE_STATUS===1){
       		  status="预约中";
       		  status="已预约";
       		  classs="am-radius cur";
       		  hrefs='${ctx}/webApp/tijian/tijian12?service_id='+item.SERVICE_ID;
       	     } */
        	 var serviceStartDate=getHandleDate(item.SERVICE_START_DATE,"yyyy-mm-dd");//有效期始
        	 var serviceEndDate='';
        	 if(item.serviceEndDate!=null){
        		 serviceEndDate=item.serviceEndDate;
        	 }
        	 if(item.SERVICE_END_DATE){
            	  serviceEndDate=getHandleDate(item.SERVICE_END_DATE,"yyyy-mm-dd");//有效期止
        	 }
        	 // var serviceEndDate='2016-12-31'//getHandleDate(item.SERVICE_END_DATE,"yyyy-mm-dd");//有效期止
        	 var tempHtml=' <li> <div class="am-gallery-item"><a href="'+hrefs+'" class="'+classs+'"><img src="${ctx}/static/assets/images/guanai2.jpg" />'
			             +'<p class="am-gallery-title">'+status+'</p>'
			             + '<p class="am-gallery-desc">有效期：'+serviceEndDate+'</p> </a></div> </li>';
             
        	 $("#tj_list ul").prepend(tempHtml);
        	 
         });
         
       }); 
});


</script> 
<!--<![endif]--> 
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<![endif]--> 
<!--在这里编写你的代码-->

</body>
</html>