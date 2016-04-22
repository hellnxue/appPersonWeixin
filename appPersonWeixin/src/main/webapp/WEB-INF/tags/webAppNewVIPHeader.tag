<%@attribute name="title" type="java.lang.String" required="false" %>
<%@tag pageEncoding="UTF-8"%>
<%@attribute name="description" type="java.lang.String" required="false" %>
<%@attribute name="keywords" type="java.lang.String" required="false" %>
<!doctype html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="${description}">
<meta name="keywords" content="${keywords}">
<meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>${title}</title>

<!-- Set render engine for 360 browser -->
<meta name="renderer" content="webkit">

<!-- No Baidu Siteapp-->
<meta http-equiv="Cache-Control" content="no-siteapp"/>
<link rel="icon" type="image/png" href="${ctx}/static/assets/i/favicon.png">

<!-- Add to homescreen for Chrome on Android -->
<meta name="mobile-web-app-capable" content="yes">
<link rel="icon" sizes="192x192" href="${ctx}/static/assets/i/app-icon72x72@2x.png">

<!-- Add to homescreen for Safari on iOS -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-title" content="${title}"/>
<link rel="apple-touch-icon-precomposed" href="${ctx}/static/assets/i/app-icon72x72@2x.png">

<!-- Tile icon for Win8 (144x144 + tile color) -->
<meta name="msapplication-TileImage" content="${ctx}/static/assets/i/app-icon72x72@2x.png">
<meta name="msapplication-TileColor" content="#0e90d2">
<link rel="stylesheet" href="${ctx}/static/assets/css/amazeui.min.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/app.css">
<style type="text/css">
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
.ram-panel-bd {
    height: 135px;
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

/* .sp_list li span.am-fr{
  font-size:14px;
} */
</style>
</head>
<%-- <body style="background:url(${ctx}/static/assets/images/vipbg.jpg) no-repeat;background-size:100%;"> --%>
<body style="background:#efeff4;">
