<%@attribute name="title" type="java.lang.String" required="false" %>
<%@tag pageEncoding="UTF-8"%>
<%@attribute name="description" type="java.lang.String" required="false" %>
<%@attribute name="keywords" type="java.lang.String" required="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="${description}">
    <meta name="keywords" content="${keywords}">
    <title>${title}</title>

    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">

    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>

    <link rel="icon" type="image/png" href="${ctx}/static/comp/amazeui/i/favicon.png">

    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="${ctx}/static/comp/amazeui/i/app-icon72x72@2x.png">

    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze"/>
    <link rel="apple-touch-icon-precomposed" href="${ctx}/static/comp/amazeui/i/app-icon72x72@2x.png">

    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="${ctx}/static/comp/amazeui/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">

    <!-- SEO: If your mobile URL is different from the desktop URL, add a canonical link to the desktop page https://developers.google.com/webmasters/smartphone-sites/feature-phones -->
    <!--
    <link rel="canonical" href="http://www.example.com/">
    -->
    <%@include file="/WEB-INF/jsp/common/import-login-css.jspf" %>
</head>
<body>
<!--[if lte IE 9]>
<p class="browsehappy">你正在使用<strong>过时</strong>的浏览器，amaze 暂不支持。 请 <a
        href="http://rj.baidu.com/soft/detail/14744.html?ald" target="_blank">升级浏览器</a>
    以获得更好的体验！</p>
<![endif]-->
