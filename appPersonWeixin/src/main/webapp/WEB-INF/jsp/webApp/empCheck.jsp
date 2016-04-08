<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="${appName}" description="智阳网络技术" keywords="智阳网络技术"/>

<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">移动签到</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="am-sign">
	<h3><i></i><a onClick="getLocation();">点击重新定位</a></h3>
    <div class="maps" id="allmap" style="width:100%; min-height:500px;"></div>
  
    <div class="btns am-g" style="position:fixed; bottom:50px;">
        <div class="am-u-sm-4"><button type="button" data-type="1" class="am-btn am-btn-primary am-radius am-btn-block sign_btn_a cur">上班签到</button></div>
        <div class="am-u-sm-4" style="text-align:center;"><button type="button" class="am-round am-btn am-btn-block sign_btn_c" id="doc-confirm-toggle">业绩签到</button></div>
        <div class="am-u-sm-4"><button type="button" data-type="2" class="am-btn am-btn-primary am-radius am-btn-block sign_btn_a">下班签到</button></div>
    </div>
</div>

<div class="am-modal am-modal-confirm" tabindex="-1" id="my-confirm">
  <div class="am-modal-dialog">
    <div class="am-modal-tit" id="am-modal-tit">
    	 亲爱的用户张佳丽，您于09:01成功签到！您已连续签到5天。
    </div>
      <div class="btns am-g">
      <a class="am-btn am-btn-primary am-radius am-u-sm-12 am-modal-btn" data-am-modal-confirm >确 定</a>
      </div>
  </div>
</div>

<div class="am-modal am-modal-confirm" tabindex="-1" id="my-confirm-performance">
  <div class="am-modal-dialog">
   <div class="am-modal-hd"> 
      <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
    </div>
    <div class="am-modal-tit"  >
    
	      <input type="text" class="am-modal-prompt-input" id="performace" maxlength="30" placeholder="请填写今日销售量" required> 
	      
	 </div>
	 <%-- <div style="text-align:left;margin-left:24px;">
	    <img src="${ctx}/static/assets/images/sign_cb.png" /> 覆盖今日已提交数据    
	 </div> --%>
	<%--  <div class="am-modal-tit" >
	    <img src="${ctx}/static/assets/images/sign_cb.png" data-status="1"/> 覆盖今日已提交数据&nbsp;&nbsp;
	 </div> --%>
      <div class="btns am-g">
          <a class="am-btn am-btn-primary am-radius am-u-sm-12 am-modal-btn  am-disabled" data-am-modal-confirm id="performaceBtn">确 定</a>
      </div>
  </div>
</div>

<es:webAppNewFooter/>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>  
<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script> 
    
<!--在这里编写你的代码-->

<script type="text/javascript">
var address="";//地理位置
var lonstr;
var latstr;
var typeint="inclass";
	
if (!supportsGeoLocation()) {
	alert("不支持 GeoLocation.");
}
// 检测浏览器是否支持HTML5
function supportsGeoLocation() {
	return !! navigator.geolocation;
}
// 单次位置请求执行的函数             
function getLocation() {
	navigator.geolocation.getCurrentPosition(mapIt, locationError);
}
//定位成功时，执行的函数
function mapIt(position) {
	var lon = position.coords.longitude;
	var lat = position.coords.latitude;
    // alert("您位置的经度是："+lon+" 纬度是："+lat);
	$("#lonint").val(lon);
	$("#latint").val(lat);
	
	lonstr = lon;
	latstr = lat;
	
	var map = new BMap.Map("allmap");
	var point = new BMap.Point("" + lon + "", "" + lat + "");
	map.centerAndZoom(point, 19);
	var gc = new BMap.Geocoder();
	translateCallback = function(point) {
		var marker = new BMap.Marker(point);
		map.addOverlay(marker);
		map.setCenter(point);
		gc.getLocation(point,
		function(rs) {
			var addComp = rs.addressComponents;
			if (addComp.province !== addComp.city) {
				var sContent = "<div><h4>你当前的位置是：</h4>" + "<p style='margin:0;line-height:1.5;font-size:12px;text-indent:2em'>" + addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + "</p>" + "</div>";
			    address= addComp.province   + addComp.city   + addComp.district  + addComp.street;
			} else {
				var sContent = "<div><h4>你当前的位置是：</h4>" + "<p style='margin:0;line-height:1.5;font-size:12px;text-indent:2em'>" + addComp.city + ", " + addComp.district + ", " + addComp.street + "</p>" + "</div>";
				address=  addComp.city   + addComp.district  + addComp.street;
			}
			var infoWindow = new BMap.InfoWindow(sContent);
			map.openInfoWindow(infoWindow, point);
		});
	}
	BMap.Convertor.translate(point, 0, translateCallback);
}
// 定位失败时，执行的函数
function locationError(error) {
	switch (error.code) {
	case error.PERMISSION_DENIED:
		alert("User denied the request for Geolocation.");
		break;
	case error.POSITION_UNAVAILABLE:
		alert("Location information is unavailable.");
		break;
	case error.TIMEOUT:
		alert("The request to get user location timed out.");
		break;
	case error.UNKNOWN_ERROR:
		alert("An unknown error occurred.");
		break;
	}
}
// 页面加载时执行getLocation函数
window.onload = getLocation;
$(document).ready(function(){
	$('.sign_btn_a').click(function() {
		$(this).addClass('cur').parents(".am-u-sm-4").siblings().find("button").removeClass('cur');
		typeint = $(this).data('type');
		$("#typeint").val($(this).data('type'));
	});
	
});
</script>
<script type="text/javascript">
/**
 * 签到
 */
function signInAndOut(type){
	 
      var tip="";
 	  var mdlObj={
 	    relatedTarget: this,
	    onConfirm: function(options) {
	        }
	         
	      };
 	  var jsonObj={
			aType: type, aForget: 1, idCard: "${cardId}", longitude: lonstr, latitude: latstr
	  };
 	  if(type==3){
 		 jsonObj.performance=$("#performace").val();
 	  }
	  $.getJSON("${ctx}/hrhelper-platform/empCheck",jsonObj, function (data) {
	  	if (data.err === 0)	{      
	  		if(type==1){
  		       tip="上班签到已成功！";
  			}else if(type==2){
  			   tip="下班签到已成功！";
  			}else if(type==3){
  			   tip="提交成功！";
  			}
	  	}else if (data.errMsg=== "-1"){
	  		tip="您已经签过了！" ;
	  	}else if (data.errMsg === "-2"){
	  		tip="您今日不需要签到！" ;
	  	}else if (data.errMsg === "-3"){
	     	 tip="您还未上班签到！" ;
	  	}else if (data.errMsg  === "-4"){
	  		tip="请求超时或用户未找到！" ;
	     		mdlObj.closeViaDimmer=false;
	     		mdlObj.onConfirm=function(options) {
			       		location.replace("${ctx}/webApp/logout");
		        };
	  	}else if (data.errMsg === "-5"){
	  		tip="考勤地点错误！" ;
	  	}else{
	  		tip="未知错误！" ;
	  	}
			
	  	$("#am-modal-tit").html(tip);
	    $('#my-confirm').modal(mdlObj);
	  });	  
	   
	
}
$(function() {

  $("button[data-type]"). on('click', function() {
    
	  var type=$(this).data("type");
	  signInAndOut(type);
    
    });
  
  $("#doc-confirm-toggle").on("click",function(){
	  
	  $('#my-confirm-performance').modal({
	 	    relatedTarget: this,
		    onConfirm: function(options) {
		    	signInAndOut(3);
		        }
		         
		      });
	  
  });
  
  $("#my-confirm-performance img").on("click",function(){
	  //${ctx}/static/assets/images/sign_cm.png
	  if($(this).attr("src")=="${ctx}/static/assets/images/sign_cm.png"){
		  $(this).attr("src","${ctx}/static/assets/images/sign_cb.png");
	  }else{
		  $(this).attr("src","${ctx}/static/assets/images/sign_cm.png");
	  }
	  
	}); 
  
  inputDisabled();
  $("#performace").on("keyup",function(){
	  inputDisabled();
  });
  
	  
  });
  function inputDisabled(){
	  if($("#performace").val().length>0){
		  $("#performaceBtn").removeClass("am-disabled");
	  }else{
		  $("#performaceBtn").addClass("am-disabled");
	  }
  }
</script>

</body>
</html>

