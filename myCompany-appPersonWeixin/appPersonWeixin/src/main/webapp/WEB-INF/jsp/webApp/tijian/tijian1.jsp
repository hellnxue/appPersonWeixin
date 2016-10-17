<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
   <h1 class="am-header-title">体检预约</h1>
  <div class="am-titlebar-right"> <a title="" class="posi_ico" href="${ctx}/webApp/tijian/tijian111?prodId=${prodId}"><em></em></a></div> 
</header>
<!-- 地图，获取定位城市用 -->
<div class="maps" id="allmap"></div>
<div class="am-g tj_tab">
    <div class="am-u-sm-6 area_select" id="areascur">区域<em></em></div>   
    <div class="am-u-sm-6 sort_select">排序<em></em></div> 
</div>
<div class="tj_mkselect">
<!-- 区域部分 -->  
<div class="none" id="areas">
<div class="layer_tj"></div>
<div class="select_list tj_select tj_select_ct" id="showAreas">
          <ul class="tab tab_menu" id="showprovince">
           <!--  <li class="cur">上海市</li> -->
          </ul>
          <div class="cont tab_cont_view" id="showcity">
          </div>
          <div class="btns none"><a class="am-btn am-btn-primary am-radius">确定</a></div>
        </div>
</div>
<!-- 排序部分 -->  
<div class="none" id="nearsort">
      <div class="layer_tj"></div>
      <div class="select_list tj_select tj_select_pf none" >
          <div class="cont tab_cont_view">
            <div class="">
              <ul class="menu-list-item">
                <li data-gsid="5" id="nearme"><a>离我最近</a></li>
                <li data-gsid="5"><a>综合评分</a></li>
              </ul>
            </div>
          </div>
          <div class="btns none"><a class="am-btn am-btn-primary am-radius">确定</a></div>
        </div>  
</div>
</div>
<div data-am-widget="list_news" class="am-list-news am-list-news-default tj_slist">
  <div class="am-list-news-bd" id="tijianjigou">
   <ul class="am-list " >
     
    </ul>
  </div>
 <!-- 加载数据时显示的样式 -->
 <p align="center" id="load" style="height:10px;">数据加载中&nbsp;&nbsp;<i class="am-icon-spinner am-icon-pulse loading_view " ></i></p> 
</div>
<es:webAppNewFooter />
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<%-- <script src="${ctx}/static/assets/js/int.pageajax.js"></script> --%>
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/int.com.js" type="text/javascript"></script>
<script src="${ctx}/static/assets/js/int.datecur.js" type="text/javascript"></script>
<script type="text/javascript"  src="${ctx}/static/assets/js/jquery.dialog.js"></script>
<script type="text/javascript"  src="${ctx}/static/assets/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4w74Vl1HGCoyxlFsx3VdkxjZ"></script>
<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
<script>

var currentpage = 0;
var totalpage = 0;
var districtFlag=false;//根据区县查询出列表集合的标示
var districtid="";     //区县id
var flag = true;
var positionObject=null;//收集定位城市的信息：省市区

var errorInfo='<li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-right"><div align="center"><p>未查询到相关数据。</p></div></li>';
$(function() {
	// 页面加载时定位城市
	getLocation();
	
    //延迟加载
  	 $(window).scroll(function() {
  	      
  	        var  scrollTop = $(window).scrollTop(); //滚动条距离顶部的高度
  	        var  scrollHeight = $(document).height(); //当前页面的总高度
  	        var  windowHeight = $(window).height(); //当前可视的页面高度
  	        if ((scrollTop + windowHeight >= scrollHeight)) { //距离顶部+当前高度 >=文档总高度 即代表滑动到底部
  	        		
  	           if(flag){
  	        	 setTimeout("ajaxRed()",1000);
  	        	 flag=false;
  	           }
  	        	
  	        }
  	    }); 
     
    
    
    //机构列表(后期去掉此处，改为定位城市完成后执行该查询)
	//getListByPositionCity("","",0);
    
	//初始化区域
	getAreaInfo(null,2);
	var initprovinceid=$("#showprovince .cur").attr("id");
	getAreaInfo(initprovinceid,3);
	
	
	//排序--离我最近
	$("#nearme").on("click",function(){
		$("#tijianjigou ul").html("");			//清空列表
		$("#nearsort").css("display", "none");	//隐藏离我最近div
		currentpage=0;							//初始化当前页
		getListByPositionCity(positionObject,currentpage);
	});
	
	
});


//延迟加载ajax
function ajaxRed() {
	flag=true;
	console.log("ajaxRed===="+flag);
	
	currentpage++; //执行成功页码+1
	if (currentpage >= totalpage) {
		return; //判断页码是否达到限定的加载次数;
	}
	if(districtFlag){
		console.log("延迟加载区县districtid==============="+districtid);
		showListForDistrict(districtid,currentpage);
	}else{
		getListByPositionCity(positionObject,currentpage); 
	}
	console.log("currentpage===========" + currentpage);  
}

	
	//根据定位城市id获得机构列表总数
	function getListTotal(positionObject){
		
		$.ajax({
			url : "${ctx}/hrhelper-platform/tjlistByPositionCityTotal",
			type : "get",
			dataType : "json",
			data : {
				province : encodeURI("上海市"),		 //encodeURI("上海市")
				city : encodeURI("上海市"),				 //encodeURI("上海市")
				prodId : "${prodId}"					 //产品id
			},
			async:false,  
			success : function(data) {
				 if(data.errorMessage!==undefined){
		              console.log("错误消息！");
		              return;
		          }
		          console.log("total==="+data);
		          totalpage=parseInt(data);
				
			}
		});
		
	}
	
	
	//根据定位城市(省市区)查询体检机构列表
	function getListByPositionCity(positionObject, ctPage) {
		console.log("tijianjigou list--------------");
		$("#load").html('<i class="am-icon-spinner am-icon-pulse loading_view " ></i>');
		districtFlag=false;//去掉根据区县查询
		$.getJSON(
				"${ctx}/hrhelper-platform/tjlistByPositionCity",
				{
					province : encodeURI("上海市"),	//encodeURI("上海市")
					city : encodeURI("上海市"),		//encodeURI("上海市")
					lat : 121.533435, 				//121.533435
					lng : 31.23485,					//31.23485
					currentPage : ctPage,			//当前页数
					prodId : "${prodId}", 			//产品id
					pageSize:10						//3
				},
				function(data) {
					
					if (data.errorMessage !== undefined) {
						$("#load").html("");
						console.log("错误消息！");
						return;
					}
					
					var tjarray = data.key;
					
					console.log(tjarray);
					if (tjarray.length === 0) {
						$("#tijianjigou ul").html(errorInfo);
						$("#load").css("display","none");
						return;
					}
					if(currentpage===0){
						$("#tijianjigou ul").html("");
					}
					
					tjarray.forEach(function(item, index, array) {
								var servicestoreid = item.SERVICE_STORE_ID;//机构id
								var prodid = item.PROD_ID;//产品id
								var servicestorename = item.SERVICE_STORE_NAME;//机构名称
								var address = item.ADDRESS;//地址名称
								var localtion = item.LOCALTION;//地址经纬度
								var servicestoreworktime = item.SERVICE_STORE_WORKTIME;//地址经纬度
								var distance=item.distance*0.001;//距离，m为单位
								var grade=item.aps;
								if(grade==undefined){
									 grade=0;//综合评分
								}
								grade=grade.toFixed(2);//综合评分
								
								var distancehtml=' <p class="am-list-item-text am-text-sm"></p>';
								console.log("1111111111111111"+typeof item.distance);
								if(item.distance){
									distancehtml=' <p class="am-list-item-text am-text-sm">'+distance+'km</p>';
								}
								var tempHtml = '<li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-right">'
										+ '<div class=" am-u-sm-9 am-list-main">'
										+ ' <h3 class="am-list-item-hd">'
										+ ' <a href="#" class="" onclick="totijian11('
										+ "'"
										+ prodid
										+ "'"
										+ ','
										+ "'"
										+ servicestoreid
										+ "'"
										+ ')">'
										+ servicestorename
										+ '</a> </h3>'
										+ '<div class="am-list-item-text">'
										+ address
										+ '</div> </div>'
										+ ' <div class="am-u-sm-3 am-list-thumb am-text-center">'
										+ ' <p class="am-text-danger">评分：'+grade+'分</p>'
										+ distancehtml
										+ '</div></li>';
								
								$("#tijianjigou ul").append(tempHtml);
								$("#load").html("");
							});

				});

	}

	//跳转到预约页面
	function totijian11(prodid, servicestoreid) {

		window.location.href = "${ctx}/webApp/tijian/tijian11?servicestoreid="
				+ servicestoreid + "&service_id=" + "${service_id}"
				+ "&prodid=" + prodid;
	}
	
	
	//根据条件加载地区
	
	function getAreaInfo(parentId, identifier) {
		
				$.ajax({
					url : "${ctx}/hrhelper-platform/areaInfo",
					type : "get",
					dataType : "json",
					data : {
						parentId : parentId,
						identifier : identifier
					},
					async : false,
					success : function(data) {
						if (data.errorMessage !== undefined) {
							console.log("错误消息！");
							return;
						}
						var arearry = data.key;
						if (arearry) {
							switch (identifier) {
							case 2:
								arearry
										.forEach(function(item, index, array) {
											var provinceName = item.areaName;
											var provinceId = item.id;
											if (index === 0) {
												var provinceHtml = '<li class="cur" onclick="provinceClass('
														+ provinceId
														+ ')" id="'
														+ provinceId
														+ '">'
														+ provinceName
														+ '</li>';
											} else {
												provinceHtml = '<li onclick="provinceClass('
														+ provinceId
														+ ')" id="'
														+ provinceId
														+ '">'
														+ provinceName
														+ '</li>';
											}
											$("#showprovince").append(
													provinceHtml);
										});
								break;
							case 3:
								$("#showcity").html("");

								var cinfo = "";
								arearry
										.forEach(function(item, index, array) {
											var cityName = item.areaName;
											var cityId = item.id;

											cinfo += ' <li id="'+cityId+'"  class="subli"><a onclick="cityClass('
													+ cityId
													+ ')" id="'
													+ cityId
													+ 'cc">'
													+ cityName + '</a></li>';//城市列表

										});
								$("#showcity").html(
										'<div style="display:block"><ul class="menu-list-item" >'
												+ cinfo + '</ul></div>');
								break;
							case 4:
								var dhtml = "";
								arearry.forEach(function(item, index, array) {
									var dName = item.areaName;
									var dId = item.id;
									dhtml += '<li onclick="selectdistrict('
											+ dId + ')" data-gsid="5"><a>'
											+ dName + '</a></li>';

								});
								$("#" + parentId + "cc").after(
										'<ul class="gsidlist">' + dhtml
												+ '</ul>');//城市列表

								break;
							default:
								console.log("hello");

							}
						}
					}
				});
	}

	//点击省添加样式cur
	function provinceClass(provinceId) {
		$("#showAreas ul li").removeClass('cur');
		$("#" + provinceId).prop('class', 'cur');
		$("#showcity div").css("display", "none");
		$("#" + provinceId + "c").css("display", "block");

		getAreaInfo(provinceId, 3);
	}

	//点击有区县的城市修改样式
	function cityClass(cid) {
		var classval = $("#" + cid).attr("class");
		if (classval === "subli") {
			$("#" + cid).addClass("down");
		} else {
			$("#" + cid).removeClass("down");
		}

		getAreaInfo(cid, 4);
	}

	//点击区域中的区县查询体检机构列表
	function selectdistrict(did) {
		var district = did; //区县id
		districtid = did; //全局变量
		$("#areas").removeAttr("style");
		$("#tijianjigou ul").html(""); //清空列表
		currentpage = 0; //初始化当前页
		districtFlag = true; //根据区县将查询结果延迟加载

		showListForDistrict(district, currentpage);

	}

	//根据选中的区县id展示机构列表
	function showListForDistrict(districtid, currentpage) {
		//console.log("showListForDistrict================== "+currentpage);
		$("#load").html(
				'<i class="am-icon-spinner am-icon-pulse loading_view " ></i>');
		$
				.getJSON(
						"${ctx}/hrhelper-platform/tjjigoulist",
						{
							areadistrictid : districtid,
							//currentPage:currentpage,//分页参数
							prodId : "${prodId}" //产品id
						},
						function(data) {
							if (data.errorMessage !== undefined) {
								$("#tijianjigou ul").html(errorInfo);
								console.log("错误消息！");
								$("#load").html('');
								return;
							}

							var tjarray = data.key;
							if (tjarray.length === 0) {
								$("#tijianjigou ul").html(errorInfo);
								$("#load").css("display", "none");
								return;
							}
							$("#tijianjigou ul").html("");
							tjarray
									.forEach(function(item, index, array) {
										var servicestoreid = item.SERVICE_STORE_ID;//机构id
										var prodid = item.PROD_ID;//产品id
										var servicestorename = item.SERVICE_STORE_NAME;//机构名称
										var address = item.ADDRESS;//地址名称
										var localtion = item.LOCALTION;//地址经纬度
										var servicestoreworktime = item.SERVICE_STORE_WORKTIME;//地址经纬度
										
										//var distance=item.distance*0.001;//距离，m为单位
										var grade=item.aps;
										if(grade==undefined){
											 grade=0;//综合评分
										}
										grade=grade.toFixed(2);//综合评分
										var distancehtml=' <p class="am-list-item-text am-text-sm"></p>';
										/*
										if(item.distance){
											distancehtml=' <p class="am-list-item-text am-text-sm">'+distance+'km</p>';
										} */
										var tempHtml = '<li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-right">'
												+ '<div class=" am-u-sm-9 am-list-main">'
												+ ' <h3 class="am-list-item-hd">'
												+ ' <a href="#" class="" onclick="totijian11('
												+ "'"
												+ prodid
												+ "'"
												+ ','
												+ "'"
												+ servicestoreid
												+ "'"
												+ ')">'
												+ servicestorename
												+ '</a> </h3>'
												+ '<div class="am-list-item-text">'
												+ address
												+ '</div> </div>'
												+ ' <div class="am-u-sm-3 am-list-thumb am-text-center">'
												+ ' <p class="am-text-danger">评分：'+grade+'分</p>'
												+ distancehtml
												+ '</div></li>';

										$("#tijianjigou ul").append(tempHtml);
										$("#load").html("");
									});

						});

	}

	//-----------------------------获取定位城市-------------------------------------------

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
		if (bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid
				|| bIsCE || bIsWM) {
			return true;
		} else {
			return false;
		}
	}
	// 检测浏览器是否支持HTML5
	function supportsGeoLocation() {
		return !!navigator.geolocation;
	}
	// 单次位置请求执行的函数             
	function getLocation() {
		if (browserRedirect()) {
			if (!supportsGeoLocation()) {
				alert("不支持 GeoLocation.")
			}
			navigator.geolocation.getCurrentPosition(mapIt, locationError);
		} else {
			var geolocation = new BMap.Geolocation();
			geolocation.getCurrentPosition(mapItPc, locationError);

		}
	}

	//定位成功时，执行的函数
	function mapIt(position) {
		var lon = position.coords.longitude;
		var lat = position.coords.latitude;
		latAndLnt = "" + lon + "", "" + lat + "";
		// alert("您位置的经度是："+lon+" 纬度是："+lat);
		$("#lonint").val(lon);
		$("#latint").val(lat);

		var map = new BMap.Map("allmap");
		var point = new BMap.Point("" + lon + "", "" + lat + "");
		map.centerAndZoom(point, 19);
		var gc = new BMap.Geocoder();
		translateCallback = function(point) {
			var marker = new BMap.Marker(point);
			map.addOverlay(marker);
			map.setCenter(point);
			gc.getLocation(point, function(rs) {
				var addComp = rs.addressComponents;
				console.log("定位省=" + addComp.province);
				console.log("定位市=" + addComp.city);
				var positionProvince = addComp.province; //省
				var positionCity = addComp.city; //市
				var positionDistrict = addComp.district; //区县

				positionObject = {
					province : encodeURI(positionProvince),//encodeURI("上海市")
					city : encodeURI(positionCity),
					district : encodeURI(positionDistrict),
					lat : lon,
					lng : lat
				};
				getListTotal(positionObject);
				getListByPositionCity(positionObject, 0);//根据定位省市区查询机构列表
			});
		}
		BMap.Convertor.translate(point, 0, translateCallback);
	}
	function mapItPc(position) {
		var lon = position.point.lng;
		var lat = position.point.lat;

		latAndLnt = "" + lon + "", "" + lat + "";
		console.log("您位置的经度是：" + lon + " 纬度是：" + lat);

		var map = new BMap.Map("allmap");
		var point = new BMap.Point("" + lon + "", "" + lat + "");
		map.centerAndZoom(point, 19);
		var gc = new BMap.Geocoder();
		translateCallback = function(point) {
			var marker = new BMap.Marker(point);
			map.addOverlay(marker);
			map.setCenter(point);
			gc.getLocation(point, function(rs) {
				var addComp = rs.addressComponents;
				console.log("定位省=" + addComp.province);
				console.log("定位市=" + addComp.city);

				var positionProvince = addComp.province; //省
				var positionCity = addComp.city; //市
				var positionDistrict = addComp.district; //区县

				positionObject = {
					province : positionProvince,//encodeURI("上海市")
					city : encodeURI(positionCity),
					district : encodeURI(positionDistrict),
					lat : lon,
					lng : lat
				};
				getListTotal(positionObject);
				getListByPositionCity(positionObject, 0);//根据定位省市区查询机构列表
			});
		}
		BMap.Convertor.translate(point, 0, translateCallback);
	}
	// 定位失败时，执行的函数
	function locationError(error) {
		console.log(error);
	}
</script> 

</body>
</html>
