<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">地理位置</h1>
 <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="maps" id="allmap" style="width:100%; height:500px;"></div>
<es:webAppNewFooter/>
<!--[if (gte IE 9)|!(IE)]><!--> 
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4w74Vl1HGCoyxlFsx3VdkxjZ"></script>
<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
<script type="text/javascript">
var latAndlng="${param.latAndlng}";
var saddress=decodeURI(decodeURI("${param.address}"));
var lat=latAndlng.split(",")[0];
var lng=latAndlng.split(",")[1];
console.log("latAndlng="+lat+" "+lng+" ddddd="+saddress);
var map = new BMap.Map("allmap");
map.enableScrollWheelZoom(true);    //启用滚轮放大缩小，默认禁用
map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
map.addControl(new BMap.OverviewMapControl()); //添加默认缩略地图控件
map.addControl(new BMap.OverviewMapControl({ isOpen: true, anchor: BMAP_ANCHOR_BOTTOM_RIGHT }));   //右下角，打开
map.clearOverlays();//清空原来的标注

var poi = new BMap.Point(lat,lng);
map.centerAndZoom(poi, 19);
var marker = new BMap.Marker(poi);  // 创建标注，为要查询的地方对应的经纬度
map.addOverlay(marker);
var content =  "<div><p>地址：" + saddress + "</p></div>";
var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");

marker.addEventListener("click", function () { this.openInfoWindow(infoWindow); });
</script>

</body>
</html>
