<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">体检预约</h1>
 <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div style="background-color: white">
 <div class="am-g tj_jigou am-padding-vertical-sm">
	<div class="am-u-sm-3"><img src="" id="logoName"></div>
    <div class="am-u-sm-9">
    	<h2 class="am-text-default"  id="jigouName">关爱健康体检服务中心</h2>
        <p id="storeName">门店：上海慈铭（人民广场分院）</p>
    </div>
</div>
 <div class="am-g tj_name am-padding-vertical-sm">
  <div class="am-u-sm-12">
  	<p class="am-text-lg" id="prodName">关爱健康年度体检关怀A卡</p>
    <p class="am-text-sm"><a href="tijian-1-1-1.htm" class="am-list-item-text" id="prodNo">卡号：TEST207654321室</a></p>
    <p><a href="#" class="am-text-sm am-list-item-text" id="saddress"><i class="am-icon-map-marker am-text-secondary am-margin-left"></i></a></p>
    <p class="am-text-sm am-list-item-text" id="applyTime">预约时间：</p>
  </div>
</div> 
<div class="sp_info">
  <h2>体检人</h2>
  <div class="info">
    <p><span class="m_l"><i>姓名</i></span><span class="m_s" id="tjusername">张佳丽</span></p>
    <p><span class="m_l"><i>年龄</i></span><span class="m_s" id="tjage">18</span></p>
    <p><span class="m_l"><i>性别</i></span><span class="m_s" id="tjgenger">女</span></p>
    <p><span class="m_l"><i>身份证号</i></span><span class="m_s" id="tjcardid">1234567890123*****</span></p>
    <p class="" id="fkcheck"><span class="m_l"><i>&nbsp;</i></span><span class="m_s"><input type="checkbox" id="fkbox"> 参加妇科三项检查</span></p>
  </div>
</div>
<div class="sp_info ti-form">
<h2>报告收件人</h2>
  <div class="add-address">
  <ul class="am-list am-list-static am-list-border">
  	<li  id="selectaddress" style="cursor:pointer">
    <div class="am-g">
    <div class="am-u-sm-10" id="addressinfos">
    <p><span class="am-padding-right-xl" id="adname"><i class="am-icon-user"></i>&nbsp; 张佳丽</span><span id="adphone"><i class="am-icon-phone"></i> &nbsp;12345678978</span></p>
    <p class="am-text-sm am-list-item-text" id="adaddress">上海市黄浦区广东路429号天鹅公上海市黄浦区广东路429号天鹅公寓2楼 </p>
    </div>
    <div class="am-u-sm-2 am-vertical-align am-text-center" style="height:60px;">
    	<div class="am-vertical-align-middle"><a   href="#"><em class="am-icon-angle-right am-text-xxl">
    </em></a></div>
    </div>
    </div>
    </li>
  </ul>
</div>
</div>
<div class="btns am-g am-text-center"  ><input type="button" class="am-btn am-btn-primary am-radius blue_btn am-btn-block"  id="doc-confirm-toggle" value="提 交"></div>
</div>
<div class="footer">
<div id="" class="am-navbar am-cf am-navbar-default am-no-layout" data-am-widget="navbar">
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
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/int.pageajax.js"></script>
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/int.com.js" type="text/javascript"></script>
<script src="${ctx}/static/assets/js/utils.js"></script> 
<script>
var adname=decodeURI(decodeURI("${param.adname}"));
var adphone=decodeURI(decodeURI("${param.adphone}"));
var adaddress=decodeURI(decodeURI("${param.adaddress}"));
var receivingAddrId="";
var fkbox="${param.fkbox}";
if(fkbox==1){
	$("#fkbox").attr("checked", true);
}
if(adname){
	$("#adname").html('<i class="am-icon-user"></i>&nbsp;'+adname);
	$("#adphone").html('<i class="am-icon-phone"></i>&nbsp;'+adphone);
	$("#adaddress").text(adaddress);
	receivingAddrId="${param.receivingAddrId}";
	console.log("receivingAddrId===="+receivingAddrId);
}else{
	//取默认地址
	$.getJSON("${ctx}/hrhelper-platform/getDefaultAddress" ,function (data) {
		if(data.errorMessage!==undefined){
			console.log("错误消息！");
			$("#addressinfos").html("<div style='padding-top:16px'>管理收货地址</div>");
            return;
		}
	    var receivingAddrInfo=data.receivingAddrInfo;
	    $("#adname").html('<i class="am-icon-user"></i>&nbsp;'+receivingAddrInfo.receivingName);
	   	$("#adphone").html('<i class="am-icon-phone"></i>&nbsp;'+receivingAddrInfo.mobilePhone);
	   	$("#adaddress").text(receivingAddrInfo.detailedAddr);
	   	receivingAddrId=receivingAddrInfo.receivingAddrId;
      
      
    });
	
}

var latAndlng="";//经纬度
var saddress="";//地址
$(function() {
	//获取体检券信息
	  $.getJSON("${ctx}/hrhelper-platform/medicalBeforeDetail", {
	   service_id:"${param.service_id}",
	   service_store_id:"${param.service_store_id}",
	   userid:"${userid}"
     },
		function (data) {
	         if(data.errorMessage!==undefined){
	             console.log("错误消息！");
	             return;
	         }
	         
	            var prodName=data.PROD_NAME;					//产品名称
		        // var prodno=data.PROD_NO;						//卡号（暂时没有）
		         var logoName=data.FILE_PATH;					//产品logo
		        // var jigouName=data.FILE_PATH;				//机构（暂无）
		         var storeName=data.SERVICE_STORE_NAME;			//门店
		         var userName=data.EMPLOYEE_NAME;					//体检人
		         
		         var age=data.age;								//年龄
		         var gender=data.GENDER===0?"男":"女";			//性别
		         var cardNum=data.CARD_NUM;						//卡号
		         
		          storeAddress=data.ADDRESS;				//门店地址
		         
		         latAndlng=data.LOCALTION;						//经纬度  p
		         
		         $("#prodName").html(prodName);
		         $("#logoName").attr("src",logoName);
		         $("#jigouName").html(storeName);
		         $("#storeName").append(storeName);
		         $("#tjusername").html(userName);
		         $("#tjage").html(age);
		         $("#tjgenger").html(gender);
		         
		         $("#tjcardid").html(cardNum);
		         $("#saddress").prepend("门店地址："+storeAddress);
		         $("#applyTime").append("${param.year}"+"年"+"${param.month}"+"月"+"${param.day}"+"日");
	         	
		         if(gender=="男"){
		        	 $("#fkcheck").css("display","none");
		         }
	         
     }); 
	
	
	 //点击地址显示地图
	  $("#saddress").on("click",function(){
		  window.location.href = "${ctx}/webApp/tijian/tijian112?latAndlng="+latAndlng+"&address="+encodeURI(encodeURI(storeAddress));
	  });
	 
	 $("#selectaddress").on("click",function(){
		 var fkvalue=2;
		 if($("#fkbox").is(':checked')){
			 fkvalue=1;
		 }
		window.location.href="${ctx }/webApp/user/receiveAddress?year=${param.year}&month=${param.month}&day=${param.day}&service_id=${param.service_id}&service_store_id=${param.service_store_id}&prodid=${param.prodid}&fkbox="+fkvalue; 
	 });
	 //提交表格
	 $("#doc-confirm-toggle").on("click",function(){
		
		
		 var fkvalue=2;
		 
		 if($("#fkbox").is(':checked')){
			 fkvalue=1;
		 }
		 
		 $.ajax({
             url: "${ctx}/hrhelper-platform/submitMedicalAppointment",
             type: 'get',
             dataType: 'json',
             data: {
            	 year:"${param.year}" ,
            	 month:"${param.month}" ,
            	 day:"${param.day}" ,
            	 service_id:"${param.service_id}",
            	 service_store_id:"${param.service_store_id}",
            	 checked:"${param.fkbox}",
            	 receivingAddrId:receivingAddrId//65
           	 
             },
             success:function(data){
            	
            	window.location.href="${ctx}/webApp/tijian/tijian11?service_id=${param.service_id}&servicestoreid=${param.service_store_id}&prodid=${param.prodid}";
             }
         });
		 
		
		 
	 });
	 
	 
});

</script> 

</body>
</html>