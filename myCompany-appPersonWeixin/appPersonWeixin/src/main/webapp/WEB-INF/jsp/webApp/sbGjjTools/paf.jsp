<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
 <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=700">
    <title>社保公积金查询页面</title>
    <link rel="stylesheet" href="${ctx }/static/sbGjjTools/css/main.css">
    <script src="${ctx }/static/sbGjjTools/lib/hotcss.min.js"></script>
    <script src="${ctx}/static/assets/js/jquery.min.js"></script> 
    
</head>
<body class="paf">
    <header><a  href="javascript:history.go(-1);">&#139;</a>个人公积金查询</header>
    <ul>
        <li>
            <a href="#"><span>&#155;</span>个人公积金</a>
        </li>
        <li>
            <a href="#"><span>&#155;</span>个人补充公积金</a>
        </li>
    </ul>
    <div style="display:none">
     <dl class="detail-basic">
        <dt>基本信息</dt>
        <dd>
            <h2>姓名</h2>
            <strong>张三</strong>
        </dd>
        <dd>
            <h2>开户状态</h2>
            <em>正常</em>
        </dd>
        <dd>
            <h2>开户时间</h2>
            <em>2012年2月</em>
        </dd>
        <dd>
            <h2>所属单位</h2>
            <em>智阳网络技术（上海）有限公司</em>
        </dd>
        <dd>
            <h2>账户余额</h2>
            <em>￥1200.00</em>
        </dd>
        <dd>
            <h2>末次缴存年月</h2>
            <em>2016年2月</em>
        </dd>
        <dd>
            <h2>月缴存额</h2>
            <em>￥2200.00</em>
        </dd>
    </dl>
    <h2 class="title">缴纳明细</h2>
    <dl class="detail-list">
        <dt>智阳网络技术（上海）有限公司</dt>
        <dd>
            <h2>2016年2月</h2>
            <em>集中冲还贷</em>
            <div></div>
            <h2>支取</h2>
            <em>￥1050.00</em>
        </dd>
        <dd>
            <h2>2016年2月</h2>
            <em></em>
            <div></div>
            <h2>汇缴</h2>
            <em>￥1050.00</em>
        </dd>
    </dl>
   </div>
   <script>
   
     $(function(){
    	 
    	 $("ul li a").click(function(){
    		  $(this).parents("ul").hide();
    		  $("div").show();
    		 
    		  back();
    	 });
    	 
     });
     
     
     
     function back(){
    	 $("header>a").click(function(){
       		 $("header>a").attr("href","#");
       		 $("div").hide();
       		 $("ul").show();
        	 $("header>a").attr("href","javascript:history.go(-1);");
	    		 
	    	 });
     }
   </script>
</body>
</html>
