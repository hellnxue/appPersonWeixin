<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<!-- 地图，获取定位城市用 -->
<div class="maps" id="allmap"></div>
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">预约详情</h1>
<div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a></div>
</header>
 <div class="am-g tj_name am-padding-vertical-sm">
  <div class="am-u-sm-12">
  	<p class="am-text-lg" id="prodName">关爱健康年度体检关怀A卡</p>
    <p class="am-text-sm"><a href="tijian-1-1-1.htm" class="am-list-item-text" id="prodNo">卡号：TEST207654321室</a></p>
  </div>
</div> 
<div class="am-g tj_jigou am-padding-vertical-sm">
	<div class="am-u-sm-3"><img src="" id="logoName"></div>
    <div class="am-u-sm-9">
    	<h2 class="am-text-default" id="jigouName"></h2>
        <p id="storeName">门店：</p>
    </div>
</div>
<div class="sp_info">
  <div class="info_li">
    <ul class="am-list">
      <li><a href="#"><span class="am-fr" id="userName"></span>体检人</a></li>
      <li><a href="#"><span class="am-fr" id="age"></span>年龄</a></li>
      <li><a href="#"><span class="am-fr" id="gender"></span>性别</a></li>
      <li><a href="#"><span class="am-fr" id="mobile"></span>体检人手机号</a></li>
    <!--   <li><a href="#"><span class="am-fr" id="youbian"></span>邮编</a></li> -->
      <li id="fkck"><a href="#"><span class="am-fr" id="checked"></span>参加妇科三项检查</a></li>
      <li><a href="#"><span class="am-fr" id="receivingName"></span>报告接收人</a></li>
      <li><a href="#"><span class="am-fr" id="detailedAddr"></span>报告收取地址</a></li>
    </ul>
  </div>
</div>
<div class="fjaddress am-padding-vertical-sm am-padding-horizontal-sm">
	<p><a href="#" id="storeAddress"><i class="am-icon-map-marker am-text-secondary am-margin-left"></i></a></p>
    <p id="applyTime"></p>
</div>
<es:webAppNewFooter/>
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/int.pageajax.js"></script>
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/int.com.js" type="text/javascript"></script>
<script src="${ctx}/static/assets/js/utils.js"></script> 
<script>
var ctx="${ctx}";
var latAndlng="";		//经纬度
var storeAddress="";	//门店地址
$(function() {

  //点击地址显示地图
  $("#storeAddress").on("click",function(){
	  window.location.href = "${ctx}/webApp/tijian/tijian112?latAndlng="+latAndlng+"&address="+encodeURI(encodeURI(storeAddress));
  });
});

$.getJSON("${ctx}/hrhelper-platform/mdicalDetails", {
	   service_id:"${service_id}",
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
	         var userName=data.EXAMINATION_NAME;					//体检人
	         
	         var age=data.EXAMINATION_AGE;								//年龄
	         var gender=data.EXAMINATION_GENDER==0?"男":"女";			//性别
	         var cardNum=data.CARD_NUM;						//卡号
	         var receivingName=data.REPORT_NAME;			//报告接收人
	         var detailedAddr=data.REPORT_ADD;			//报告接收地址
	         
	          storeAddress=data.STORE_ADDRESS;				//门店地址
	         var applyTime=getHandleDate(data.APPLY_TIME,"");//预约时间
	         
	         latAndlng=data.LOCALTION;						//经纬度
	         
	         var checked=data.CHECKED==1?"有":"没有";//妇科3项检查
	       //  var youbian=data.ZIP_CODE;//邮编
	         var mobile=data.EXAMINATION_MOBILE;   //体检人手机号码
	         var receivingMobile=data.REPORT_MOBILE;   //提交报告收取人的手机号码
	         
	         $("#prodName").html(prodName);
	         $("#logoName").attr("src",logoName);
	         $("#jigouName").html(storeName);
	         $("#storeName").append(storeName);
	         $("#userName").html(userName);
	         $("#age").html(age);
	         $("#gender").html(gender);
	         
	         $("#cardNum").html(cardNum);
	         $("#receivingName").html(receivingName);
	         $("#detailedAddr").html(detailedAddr);
	         $("#storeAddress").prepend(storeAddress);
	         $("#applyTime").html(applyTime);
	         
	         if(data.CHECKED!=1){
	        	 $("#fkck").empty().remove();
	         }else{
	        	 $("#checked").html(checked);
	         }
	        
	       //  $("#youbian").html(youbian);
	         $("#mobile").html(mobile);
	         
	       }); 

	
</script> 
<!--<![endif]--> 
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<![endif]--> 
<!--在这里编写你的代码-->

</body>
</html>