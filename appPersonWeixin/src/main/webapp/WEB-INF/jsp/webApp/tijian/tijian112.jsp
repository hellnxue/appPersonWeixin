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
