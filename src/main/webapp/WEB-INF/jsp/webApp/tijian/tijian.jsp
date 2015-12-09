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
<div class="footer">
<div id="" class="am-navbar am-cf am-navbar-default am-no-layout" data-am-widget="navbar">
<!--[if (gte IE 9)|!(IE)]><!--> 
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/int.pageajax.js"></script>
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/utils.js"></script> 
<ul class="am-navbar-nav am-cf am-avg-sm-5 fot_bg">
  <li class="footer01 cur"> <a href="${ctx}/webApp/index"> <span class="am-footer-ico"></span> <span class="am-navbar-label">首页</span></a></li>
  <li class="footer02"> <a href="${ctx}/webApp/empCheck"> <span class="am-footer-ico"></span> <span class="am-navbar-label">移动签到</span></a></li>
  <li class="footeradd"> <a> <span class="index-home-ico"><em></em></span></a></li>
  <li class="footer03"> <a href="${ctx}/webApp/msgs"> <span class="am-footer-ico"></span> <span class="am-navbar-label">消息</span></a></li>
  <li class="footer04"> <a href="${ctx}/webApp/user"> <span class="am-footer-ico"></span> <span class="am-navbar-label">我的</span></a></li>
</ul>
</div>
<div class="foot-home-over">
<div data-am-widget="slider" class="am-slider am-slider-default layer_list" data-am-slider='{&quot;animation&quot;:&quot;slide&quot;,&quot;slideshow&quot;:false}'>
  <ul style="margin-left:20px;">
    <li class="list01">
      <a href="${ctx}/webApp/tongxunlu"><dl class="icon01"><dt></dt><dd>通讯录</dd></dl></a>
    </li>
  </ul>
</div>
</div>
</div>
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
         tjarray.forEach(function(item,index,array){
        	 var status="";//预约状态
        	 var prodName=item.PROD_NAME;//产品名称
        	 var storeName=item.STORE_NAME;//店铺名称
        	 var classs="am-radius";
        	 
        	 if(item.SERVICE_STATUS===undefined){
        		  status="待预约";
        	 }
        	 if(item.SERVICE_STATUS===1){
        		  status="预约中";
        	 }
        	 var hrefs='${ctx}/webApp/tijian/tijian1?prod_id='+item.PROD_ID+'&service_id='+item.SERVICE_ID;
        	 if(item.SERVICE_STATUS===2){
        		  status="已预约";
        		  classs="am-radius cur";
        		 hrefs='${ctx}/webApp/tijian/tijian12?service_id='+item.SERVICE_ID;
        		  //hrefs="#";
        	 }
        	 var serviceStartDate=getHandleDate(item.SERVICE_START_DATE,"yyyy-mm-dd");//有效期始
        	 var serviceEndDate=getHandleDate(item.SERVICE_END_DATE,"yyyy-mm-dd");//有效期止
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