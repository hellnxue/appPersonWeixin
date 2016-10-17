<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<!-- 地图，获取定位城市用 -->
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">体检预约</h1>
 <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
 <div class="am-g tj_name am-padding-vertical-sm">
  <div class="am-u-sm-8">
  	<p class="am-text-lg" id="storeName"></p>
  	<%-- href="${ctx }/webApp/tijian/tijian111?slocation=${slocation}" --%>
    <p class="am-text-sm"><a href="#" class="am-list-item-text" id="saddress"><i class="am-icon-map-marker am-text-secondary am-margin-left"></i></a></p>
  </div>
  <div class="am-u-sm-4 am-text-right">
  <!--  <p><span class="star star03"></span></p> -->
   <p class="am-text-xl am-text-danger" id="grade"></p>
  </div>
</div> 
<input type="hidden" id="serviceId" value="${service_id }"/><br/>
<input type="hidden" id="servicestoreid" value="${servicestoreid }"/>
<input type="hidden" id="userid" value="${userid }"/>
<div class="tj_time am-padding-sm">
	<p class="am-list-item-text">工作时间：</p>
    <p class="am-list-item-text" style="text-indent:5em;" id="sworktime"></p>
</div>
<div style="width:100%;margin:16px auto;">
<!--getmonthday.json为时间预约情况查询地址，getbooking.json为预约提交地址，getbookingok.json为已预约日历格式-->
<div class="datetimepicker" id="makedate" data-url="${ctx}/hrhelper-platform/serviceStoreAppointmentInfo" data-bookurl="${ctx}/static/assets/ajax/getbooking.json" data-startDate='2015-07-12'>
  <div class="data-title">
    <h3>一月份</h3>
    <a href="###" class="left-btn"></a>
    <a href="###" class="right-btn"></a>
  </div>
  <div class="week_tit"><b>日</b><b>一</b><b>二</b><b>三</b><b>四</b><b>五</b><b>六</b></div>
  <div class="data-list"></div>
</div>
</div>
<article data-am-widget="paragraph" class="am-paragraph am-paragraph-default"
data-am-paragraph="{ tableScrollable: true, pureview: true }">
<h1 class="am-text-lg" id="tjjianjie"></h1>
 <%--  <img src="${ctx}/static/assets/images/tjimg1.jpg" id="tjimg">--%>
 <!--  <p class=paragraph-default-p id="tjcontent">简介内容</p>  -->
  
</article>
<es:webAppNewFooter/>
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/int.pageajax.js"></script>
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/int.com.js" type="text/javascript"></script>
<script src="${ctx}/static/assets/js/int.datecur.js" type="text/javascript"></script>
<script type="text/javascript"  src="${ctx}/static/assets/js/jquery.dialog.js"></script>
<script type="text/javascript"  src="${ctx}/static/assets/js/jquery.bgiframe.min.js"></script>
<script>
var ctx="${ctx}";
var proid="${prodid}";
var latAndlng="";//经纬度
var saddress="";//地址
$(function() {
  $('.am-slider-manual').flexslider({
  // options
  });
  
//查询体检机构详情
  getListByPositionCity();
  
  //点击地址显示地图
  $("#saddress").on("click",function(){
	  window.location.href = "${ctx}/webApp/tijian/tijian112?latAndlng="+latAndlng+"&address="+encodeURI(encodeURI(saddress));
  });
  

});

//根据定位城市(省市区)查询体检机构详情
function getListByPositionCity(){
	 $.getJSON("${ctx}/hrhelper-platform/tjjigouDetail",{
		 prodId:"${prodid}",
		 service_store_id:"${servicestoreid }"//查询所有机构标示
	    }, 
		function (data) {
	         if(data.errorMessage!==undefined){
	             console.log("错误消息！");
	             return;
	         }
	         var tjarray=data.key;
	         console.log("tjarray.length="+tjarray.length);
	         if(tjarray.length===1&&tjarray.length!==0){
	        	 var tijianObject=tjarray[0];
	        	 var servicestoreid=tijianObject.SERVICE_STORE_ID;//机构id
	        	 var prodid=tijianObject.PROD_ID;//产品id
	        	 var servicestorename=tijianObject.SERVICE_STORE_NAME;//机构名称
	        	 var address=tijianObject.ADDRESS;//地址名称
	        	 var localtion=tijianObject.LOCALTION;//地址经纬度
	        	 var servicestoreworktime=tijianObject.SERVICE_STORE_WORKTIME;//地址经纬度
	        	 var orginfo=tijianObject.ORG_INFO;//简介内容
	        	 var grade=tijianObject.aps;
				 if(grade==undefined){
					 grade=0;//综合评分
				 }
				 grade=grade.toFixed(2);//综合评分
	        	 latAndlng=localtion;
	        	 saddress=address;
	        	 
	        	$("#tjjianjie").html(servicestorename+"简介");
				$("#tjjianjie").after("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+orginfo);
				$("#storeName").html(servicestorename);
				$("#saddress").prepend(address);
				$("#sworktime").html(servicestoreworktime);
				$("#grade").html(grade);		
	         }
	            
		});

	}
	

</script> 

</body>
</html>