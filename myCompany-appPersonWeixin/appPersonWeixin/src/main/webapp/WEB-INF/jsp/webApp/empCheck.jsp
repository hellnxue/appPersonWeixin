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
        <div class="am-u-sm-4" style="text-align:center;"><button type="button" class="am-round am-btn am-btn-block sign_btn_c" id="doc-confirm-toggle">其他签到</button></div>
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
    <div class="am-modal-tit">
	    <select id="otype" name="otype" onchange="changeSelect(value)" style="width:80%">
			<option value="3" selected>销量上报</option>
			<option value="4" >请假</option>
		</select>
		<c:choose>
   			<c:when test="${prductSize != 0}">
			<select id="productCategory" name="productCategory" onchange="changeCategory(value)" style="width:80%;disabled:none;margin-top: 15px;">
				<option value="0" selected>请选择产品类别</option>
				<c:forEach items="${listCategory}" var="category">
				<option value="${category.id}">${category.name}</option>
				</c:forEach>
			</select>
			<select id="product" name="product" onchange="changeProduct()" style="width:80%;disabled:none;margin-top: 15px;">
				<option value="0" selected>请选择产品</option>
			</select>
			<input type="hidden" id="productisnull" value="1">
			</c:when>
			<c:otherwise>
			<input type="hidden" id="productisnull" value="0">	
   			</c:otherwise>
		</c:choose>
	    <input type="text" style="margin-top:20px;" class="am-modal-prompt-input" id="performace" maxlength="30"  placeholder="" required> 
	 </div>
	 <%-- <div style="text-align:left;margin-left:24px;">
	    <img src="${ctx}/static/assets/images/sign_cb.png" /> 覆盖今日已提交数据    
	 </div> --%>
	<%--  <div class="am-modal-tit" >
	    <img src="${ctx}/static/assets/images/sign_cb.png" data-status="1"/> 覆盖今日已提交数据&nbsp;&nbsp;
	 </div> --%>
      <div class="btns am-g">
          <a style="margin-top: 30px;" class="am-btn am-btn-primary am-radius am-u-sm-12 am-modal-btn  am-disabled" data-am-modal-confirm id="performaceBtn">确 定</a>
      </div>
  </div>
</div>

<es:webAppNewFooter/>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=${ak}"></script> 
<!-- <script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>  -->
    
<!--在这里编写你的代码-->

<script type="text/javascript">
var address="";//地理位置
var lonstr;
var latstr;
var typeint="inclass";

function changeSelect(value){
	if(value == "3"){
		$('#product').show();
		$('#productCategory').show();
		$('#performace').attr('placeholder', '请填写今日销售量');
	}else{
		$('#performace').attr('placeholder', '请填写休假原因');
		$('#product').hide();
		$('#productCategory').hide();
	}
	inputDisabled();
}

function changeProduct(){
	inputDisabled();
}

function changeCategory(value){
	inputDisabled();
	$('#product').empty();
	if(value != "0"){
		$.ajax({
			type:"post",
			url:"${ctx}/hrhelper-platform/getProductByCategory",
			data:{"cotegoryId":value},
			dataType:"json",
			async:false,
			success : function(data) {
				$('#product').append('<option value="0" selected>请选择产品</option>');
				var list =data.list;
				for(var j=0;j<list.length;j++){
					var option='<option value="'+list[j].id+'">'+list[j].name+'</option>';
					$('#product').append(option);
				}
			}
			
		});
	}
}
	
if (!supportsGeoLocation()) {
	alert("不支持 GeoLocation.");
}
// 检测浏览器是否支持HTML5
function supportsGeoLocation() {
	return !! navigator.geolocation;
}
// 单次位置请求执行的函数             
function getLocation() {
	/* navigator.geolocation.getCurrentPosition(mapIt, locationError); */
	
	var geolocation=new BMap.Geolocation();
	var map=new BMap.Map("allmap");
	geolocation.getCurrentPosition(function(r){
		  
		  if(this.getStatus()==BMAP_STATUS_SUCCESS){
			lonstr = r.point.lng;
			latstr = r.point.lat;
			var mk=new BMap.Marker(r.point);
			map.addOverlay(mk);
		    map.panTo(r.point);
		    var point = new BMap.Point(r.point.lng,r.point.lat);
			map.centerAndZoom(point, 19);
			var marker = new BMap.Marker(point);//创建标注
			map.addOverlay(marker); // 将标注添加到地图中
			map.setCenter(point);
			var gc = new BMap.Geocoder();
			
			var sContent="";
			//根据坐标获取文字地理位置信息
			gc.getLocation(point,function(rs) {
				
				var addComp = rs.addressComponents;
				if (addComp.province !== addComp.city) {
					 sContent = "<div><h4>你当前的位置是：</h4>" + "<p style='margin:0;line-height:1.5;font-size:12px;text-indent:2em'>" + addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + "</p>" + "</div>";
				    //address= addComp.province   + addComp.city   + addComp.district  + addComp.street;
				} else {
					 sContent = "<div><h4>你当前的位置是：</h4>" + "<p style='margin:0;line-height:1.5;font-size:12px;text-indent:2em'>" + addComp.city + ", " + addComp.district + ", " + addComp.street + "</p>" + "</div>";
					//address=  addComp.city   + addComp.district  + addComp.street;
				}
				var infoWindow = new BMap.InfoWindow(sContent);//创建信息窗口
				map.openInfoWindow(infoWindow, point);//开启信息窗口
				
				 //点击标注打开信息window
				 marker.addEventListener("click",function(e){
					 map.openInfoWindow(infoWindow,point); //开启信息窗口
				  }); 
			});
		  }else{
			  
			  alert("falid="+this.getStatus());
		  }
		  
	},{enableHighAccuracy:true});
}




//定位成功时，执行的函数
function mapIt(position) {
   var lon = position.coords.longitude;
	var lat = position.coords.latitude;  
	/* var lon = position.point.lng;
	var lat = position.point.lat; */
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
	changeSelect("3");
	$("ul li[data-rmk='empCheck']").addClass("cur");
 
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
 	  if(type==3 || type==4){
 		 jsonObj.performance=$("#performace").val();
 	  }
 	  if(type==3){//销量上报
 		  if($("#productisnull").val() == "1"){
 			jsonObj.product=$("#product option:selected").text();
 			jsonObj.productCategory=$("#productCategory option:selected").text();
 		  }else{
 			jsonObj.product="";
  			jsonObj.productCategory="";
 		  }
 	  }
	  $.getJSON("${ctx}/hrhelper-platform/empCheck",jsonObj, function (data) {
	  	if (data.err === 0)	{      
	  		if(type==1){
  		       tip="上班签到已成功！";
  			}else if(type==2){
  			   tip="下班签到已成功！";
  			}else if(type==3){
  			   tip="提交成功！";
  			}else if(type==4){
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
		    	signInAndOut($("#otype").val());
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
  
  //按钮禁用状态
  function inputDisabled(){
	  if($('#otype').val() == "3"){
	  	if($("#performace").val().length>0 && (($('#productCategory').val() !="0" && $('#product').val() !="0") || $('#productisnull').val() =="0") ){
		  $("#performaceBtn").removeClass("am-disabled");
	  	}else{
		  $("#performaceBtn").addClass("am-disabled");
	 	 }
	  }else{
		  if($("#performace").val().length>0){
			  $("#performaceBtn").removeClass("am-disabled");
		  }else{
			  $("#performaceBtn").addClass("am-disabled");
		  }
	  }
  }
</script>

</body>
</html>

