<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!doctype html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="智阳网络技术">
<meta name="keywords" content="智阳网络技术">
<meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>智阳网络—上海社保查询</title>

<!-- Set render engine for 360 browser -->
<meta name="renderer" content="webkit">

<!-- No Baidu Siteapp-->
<meta http-equiv="Cache-Control" content="no-siteapp"/>
<link rel="icon" type="image/png" href="assets/i/favicon.png">

<!-- Add to homescreen for Chrome on Android -->
<meta name="mobile-web-app-capable" content="yes">
<link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">

<!-- Add to homescreen for Safari on iOS -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-title" content="智阳科技"/>
<link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">

<!-- Tile icon for Win8 (144x144 + tile color) -->
<meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
<meta name="msapplication-TileColor" content="#0e90d2">
<link rel="stylesheet" href="${ctx}/static/assets/css/amazeui.min.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/app.css">
<style type="text/css">
body{
  background: #ffffff;
}
.ram-header {
   height: 44px;
   background-color: #56baec;
}
.am-header .ram-header-title {
    font-size: 17px;
}
.am-header .ram-titlebar-right{
font-size: 15px;
}
.widget-icon{
    margin-right:12px;
}

.sp_list li a img.widget-icon1 {
    
    margin-right: 20px;
}

.sp_list li a img.widget-icon2 {
    
    margin-right: 14px;
}

.widget-name{
   font-size:17px;
}

.ram-list {
    margin-bottom: 0;
     
}

.rsp_list li {
    
    height: 44px;
    margin: 6px;
}
.am-border-top{
  border-top: 1px solid #dedede;
}
.am-border-bottom{
  border-bottom: 1px solid #dedede;
}
.am-list > li:first-child{
    border-top-width: 0;
}
.am-list > li:last-child{
    border-bottom-width: 0;
}
.am-text-white{
  color: #ffffff;
}
.am-text-grays{
  color: #ababab;
}
.am-no-border{
  border: 0;
}
</style>
</head>

<body>
<!-- 分享缩略图 -->
<div style='margin:0 auto;display:none;'>
	<img src='${ctx}/static/assets/images/verson1/zy_slt.jpg' />
</div>
<div class="am-panel am-panel-default am-no-border"  style="background: url(${ctx}/static/assets/images/verson1/login-banner.jpg) no-repeat; background-size: cover; min-height:245px;">
     <div class="am-panel-bd ram-panel-bd am-padding-top-xl">
      <div class="img am-text-center am-margin-top-sm">
        <img src="${ctx}/static/assets/images/verson1/login-logo.png" width="36%">
      </div>
      <div class="am-text-center am-text-white">
        <h2 class="am-margin-top-xs">上海社保查询</h2>
      </div>
    </div>
     
      
</div>
<form action="" method="post"  >
<div class="am-header-one am-padding-left-lg am-padding-right-lg">
  <ul class="am-list am-list-static am-margin-bottom-xs">
    <li>
      <div class="am-g">
          <div class="am-u-sm-4 am-padding-0">
            <span class="am-text-grays">查询城市</span>
          </div>
          <div class="am-u-sm-8">
            <span>上海</span>
          </div>
      </div>
      
    </li>
    <li>
      <div class="am-g">
          <div class="am-u-sm-4 am-padding-0">
            <span class="am-text-grays">身份证号码</span>
          </div>
          <div class="am-u-sm-8">
            <input type="text" class="am-no-border" name="idcard" id="idcard" maxlength="18" required>
          </div>
      </div>
    </li>
    <li>
      <div class="am-g">
          <div class="am-u-sm-4 am-padding-0">
            <span class="am-text-grays">查询密码</span>
          </div>
          <div class="am-u-sm-8">
            <input type="password" class="am-no-border" name="pwd" id="pwd" required>
          </div>
      </div>
    </li>
    
    <li class="am-padding-top-0">
     <span style="color:red;margin-top:0.46rem;display:block;" id="errorTip"></span>
        <button type="submit"   class="am-btn am-btn-primary am-radius am-btn-block am-margin-top-lg am-btn-xl">查询</button>
    </li>
  </ul>
</div>
</form>

<div class="am-header-one am-padding-left-lg am-padding-right-lg am-padding-top-sm am-padding-bottom-lg">
  <p class="am-text-xs am-text-center">
      <strong class="am-link-muted">友情提示：</strong>
      <span class="am-text-grays">用户首次申请密码时，请携带本人有效身份证件前往就近的街镇社区事务受理服务中心或各区县社保分中心自助查询机进行设置和申请。</span>
  </p>
</div>

<!--[if (gte IE 9)|!(IE)]><!--> 
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/int.pageajax.js"></script>
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/int.com.js"></script>
<script src="${ctx}/static/assets/js/int.datecur.js"></script>
<script src="${ctx}/static/assets/js/jquery.dialog.js"></script>
<script src="${ctx}/static/assets/js/jquery.bgiframe.min.js"></script>

<!--<![endif]--> 
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<![endif]--> 
<script type="text/javascript">
var tip="${codeTipInfo}";
if(tip){
	$("#errorTip").html("系统提示："+tip);
}

$(function(){
$("#idcard").blur(function(){
		
		if($(this).val().length>0){
			$("#errorTip").remove();
		}
	});
	
});
</script>
</body>
</html>

