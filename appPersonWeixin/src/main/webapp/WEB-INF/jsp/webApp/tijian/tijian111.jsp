<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">地理位置</h1>
 <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>

<div class="maps" id="allmap" style="width:100%; height:500px;">
 <!-- 加载数据时显示的样式 -->
 <p align="center" id="load" style="height:10px;">定位中<i class="am-icon-spinner am-icon-pulse loading_view " ></i></p> 
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
<!--[if (gte IE 9)|!(IE)]><!--> 
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4w74Vl1HGCoyxlFsx3VdkxjZ"></script>
<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
<script type="text/javascript">

var markerArr =null;//数据数组
var positionObject=null;//收集定位城市的信息：省市区

$(function(){
	getLocation();
});

//根据定位获取城市级别的城市列表并标注于地图中
function gettjlistByPositionCity(positionObject,map){
	//console.log("province============"+province);
	$.getJSON(
			"${ctx}/hrhelper-platform/tjlistByPositionCity",
			{
				province : positionObject.province,		//encodeURI("上海市")
				city : positionObject.city,				//encodeURI("上海市")
				lat : positionObject.lat, 				//121.533435
				lng : positionObject.lng,				//31.23485
				currentPage : -1,          				//查询所有
				prodId : "${param.prodId}",				//产品id
				pageSize:0
			},
			function(data) {
				if (data.errorMessage !== undefined) {
					console.log("错误消息！");
					return;
				}
				 markerArr=data.key;
				 
				//第7步：绘制点    
				 if(markerArr){
						for (var i = 0; i < markerArr.length; i++) {  
							var p0 = markerArr[i].LOCALTION.split(",")[0];  
							var p1 = markerArr[i].LOCALTION.split(",")[1];  
							var maker = addMarker(new window.BMap.Point(p0, p1), i,map);  
							addInfoWindow(maker, markerArr[i], i);   
						} 
						
					}
			});
}





var addComp=null;
//定位成功时（电脑调试）
function mapItPc(position) {
    console.log("go   mapItPc");
	var lon = position.point.lng;
	var lat = position.point.lat;
	
	latAndLnt="" + lon + "", "" + lat + "";
	 console.log("您位置的经度是："+lon+" 纬度是："+lat);
	
	var map = new BMap.Map("allmap");
	var point = new BMap.Point("" + lon + "", "" + lat + "");
	map.centerAndZoom(point, 19);
	//第3步：启用滚轮放大缩小  
	map.enableScrollWheelZoom(true);  
	//第4步：向地图中添加缩放控件  
	var ctrlNav = new window.BMap.NavigationControl({  
		anchor: BMAP_ANCHOR_TOP_LEFT,  
		type: BMAP_NAVIGATION_CONTROL_LARGE  
	});  
	map.addControl(ctrlNav);  
	//第5步：向地图中添加缩略图控件  
	var ctrlOve = new window.BMap.OverviewMapControl({  
		anchor: BMAP_ANCHOR_BOTTOM_RIGHT,  
		isOpen: 1  
	});  
	map.addControl(ctrlOve);  

	//第6步：向地图中添加比例尺控件  
	var ctrlSca = new window.BMap.ScaleControl({  
		anchor: BMAP_ANCHOR_BOTTOM_LEFT  
	});  
	map.addControl(ctrlSca); 
	//显示自己的当前位置
	var gc = new BMap.Geocoder();
	translateCallback = function(point) {
	var marker = new BMap.Marker(point);//添加标注
	map.addOverlay(marker);
	map.setCenter(point);
	gc.getLocation(point,
			function(rs) {
				   addComp = rs.addressComponents;
				   console.log("定位省=" + addComp.province);
				   console.log("定位市=" + addComp.city);
					
					var positionProvince = addComp.province; 	//省
					var positionCity = addComp.city; 			//市
					var positionDistrict = addComp.district; 	//区县
					
					 positionObject={
							province:encodeURI(positionProvince),//encodeURI("上海市")
							city:encodeURI(positionCity),
							district:encodeURI(positionDistrict),
							lat:lon,
							lng:lat
					}; 
				//添加机构list标注
				gettjlistByPositionCity(positionObject,map);
				
			});
	
	//点击自己位置的标注时提示地址信息
	marker.addEventListener("click", function(){
		
		if (addComp.province !== addComp.city) {
			var sContent = "<div><h4>我的位置：</h4>" + "<p style='margin:0;line-height:1.5;font-size:12px;text-indent:2em'>" + addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + "</p>" + "</div>";
		} else {
			var sContent = "<div><h4>我的位置：</h4>" + "<p style='margin:0;line-height:1.5;font-size:12px;text-indent:2em'>" + addComp.city + ", " + addComp.district + ", " + addComp.street + "</p>" + "</div>";
		}
		var infoWindow = new BMap.InfoWindow(sContent);
		map.openInfoWindow(infoWindow, point);
	}); 
		
	};
	BMap.Convertor.translate(point, 0, translateCallback);
		
}

var addComp1=null;
//定位成功时(手机端)
function mapIt(position) {
   console.log("go   mapIt");
	var lon = position.coords.longitude;
	var lat = position.coords.latitude;
	latAndLnt="" + lon + "", "" + lat + "";
	console.log("您位置的经度是："+lon+" 纬度是："+lat);
	
	var map = new BMap.Map("allmap");
	var point = new BMap.Point("" + lon + "", "" + lat + "");
	map.centerAndZoom(point, 19);
	//第3步：启用滚轮放大缩小  
	map.enableScrollWheelZoom(true);  
	//第4步：向地图中添加缩放控件  
	var ctrlNav = new window.BMap.NavigationControl({  
		anchor: BMAP_ANCHOR_TOP_LEFT,  
		type: BMAP_NAVIGATION_CONTROL_LARGE  
	});  
	map.addControl(ctrlNav);  
	//第5步：向地图中添加缩略图控件  
	var ctrlOve = new window.BMap.OverviewMapControl({  
		anchor: BMAP_ANCHOR_BOTTOM_RIGHT,  
		isOpen: 1  
	});  
	map.addControl(ctrlOve);  

	//第6步：向地图中添加比例尺控件  
	var ctrlSca = new window.BMap.ScaleControl({  
		anchor: BMAP_ANCHOR_BOTTOM_LEFT  
	});  
	map.addControl(ctrlSca); 
	//显示自己的当前位置
	var gc = new BMap.Geocoder();
	translateCallback = function(point) {
	var marker = new BMap.Marker(point);//添加标注
	map.addOverlay(marker);
	map.setCenter(point);
	
	gc.getLocation(point,
			function(rs) {
				   addComp1 = rs.addressComponents;
				   console.log("定位省=" + addComp.province);
				    console.log("定位市=" + addComp.city);
					var positionProvince = addComp.province; 	//省
					var positionCity = addComp.city; 			//市
					var positionDistrict = addComp.district; 	//区县
					 positionObject={
							province:encodeURI(positionProvince),//encodeURI("上海市")
							city:encodeURI(positionCity),
							district:encodeURI(positionDistrict),
							lat:lon,
							lng:lat
					}; 
				//添加机构list标注
				gettjlistByPositionCity(positionObject,map);
				
			});
	
	//点击自己位置的标注时提示地址信息
	marker.addEventListener("click", function(){
		
		if (addComp1.province !== addComp1.city) {
			var sContent = "<div><h4>我的位置：</h4>" + "<p style='margin:0;line-height:1.5;font-size:12px;text-indent:2em'>" + addComp1.province + ", " + addComp1.city + ", " + addComp1.district + ", " + addComp1.street + "</p>" + "</div>";
		} else {
			var sContent = "<div><h4>我的位置：</h4>" + "<p style='margin:0;line-height:1.5;font-size:12px;text-indent:2em'>" + addComp1.city + ", " + addComp1.district + ", " + addComp1.street + "</p>" + "</div>";
		}
		var infoWindow = new BMap.InfoWindow(sContent);
		map.openInfoWindow(infoWindow, point);
	}); 
		
	};
	BMap.Convertor.translate(point, 0, translateCallback);
		
}

//检测浏览器是否支持HTML5
function supportsGeoLocation() {
	return !! navigator.geolocation;
}
// 单次位置请求执行的函数             
function getLocation() {
	if(browserRedirect()){
		if (!supportsGeoLocation()) {
			alert("不支持 GeoLocation.");
		}
		navigator.geolocation.getCurrentPosition(mapIt, locationError);
	}else{
		var geolocation = new BMap.Geolocation();
		geolocation.getCurrentPosition(mapItPc,locationError);
	}
}
// 定位失败时，执行的函数
function locationError(error) {
	console.log(error);
	
}

//添加标注  
function addMarker(point, index,map) {  
	var myIcon = new BMap.Icon("http://api.map.baidu.com/img/markers.png",  
		new BMap.Size(23, 25), {  
			offset: new BMap.Size(10, 25),  
			imageOffset: new BMap.Size(0, 0 - index * 25)  
		});  
	var marker = new BMap.Marker(point);  //new BMap.Marker(point, { icon: myIcon })
	map.addOverlay(marker);  
	return marker;  
}  
      
// 添加信息窗口  
function addInfoWindow(marker, poi) {  
    console.log("start marker......");
	//pop弹窗标题  
	var title = '<div style="font-weight:bold;color:#CE5521;font-size:14px">' + poi.SERVICE_STORE_NAME + '</div>';  
	//pop弹窗信息  
	var html = [];  
	html.push(title);
	html.push('<table cellspacing="0" style="table-layout:fixed;width:100%;font:12px arial,simsun,sans-serif"><tbody>');  
	html.push('<tr>');  
	html.push('<td style="vertical-align:top;line-height:16px;width:38px;white-space:nowrap;word-break:keep-all">地址:</td>');  
	html.push('<td style="vertical-align:top;line-height:16px">' + poi.ADDRESS + ' </td>');  
	html.push('</tr>');  
	html.push('<tr>');  
	html.push('<td style="vertical-align:top;line-height:16px;width:38px;white-space:nowrap;word-break:keep-all">电话:</td>');  
	html.push('<td style="vertical-align:top;line-height:16px">' + poi.PHONE + ' </td>');  
	html.push('</tr>');
	html.push('</tbody></table>');  
	var infoWindow = new BMap.InfoWindow(html.join(""), {  width: 200 });  

	var openInfoWinFun = function () {  
		marker.openInfoWindow(infoWindow);  
	};  
	marker.addEventListener("click", openInfoWinFun); 
	 
	return openInfoWinFun;  
}  



function browserRedirect() {
    var sUserAgent = navigator.userAgent.toLowerCase();
    var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
    var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
    var bIsMidp = sUserAgent.match(/midp/i) == "midp";
    var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
    var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
    var bIsAndroid = sUserAgent.match(/android/i) == "android";
    var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
    var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
    if (bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM) {
        return true;
    } else {
        return false;
    }
}
</script>

</body>
</html>
