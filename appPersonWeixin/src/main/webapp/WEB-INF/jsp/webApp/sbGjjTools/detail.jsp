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
    <script src="${ctx}/static/assets/js/template.js"></script> 
</head>
<body>
     <header><a href="javascript:history.go(-1);" style="font-size:110px"><b>&#139;</b></a>个人社保详情</header>
    <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>姓名</h2>
            <strong> </strong>
        </dd>
        <dd>
            <h2>身份证号</h2>
            <em> </em>
        </dd>
        <dd>
            <h2>末次缴纳月份</h2>
            <em> </em>
        </dd>
        <dd>
            <h2>缴纳金额</h2>
            <em> </em>
        </dd>
        <dd>
            <h2>累计缴纳月数</h2>
            <em> </em>
        </dd>
    </dl>
    <dl class="detail-basic" data-detail="list">
        <!-- <dt>缴纳明细<strong>2016年2月</strong></dt>
        <dd>
            <h2>缴纳费用</h2>
            <em>￥1000.00</em>
        </dd>
        <dd>
            <h2>缴费基数</h2>
            <em>5000</em>
        </dd>
        <dd>
            <h2>养老金个人缴纳</h2>
            <em>￥400.00</em>
        </dd>
        <dd>
            <h2>医保个人缴纳</h2>
            <em>￥100.00</em>
        </dd>
        <dd>
            <h2>失保个人缴纳</h2>
            <em>￥20.00</em>
        </dd> -->  
       
    </dl>
    <script id="detailList" type="text/html">

   	 {{each list as value index}}
    	    
 		<dt>缴纳明细<strong>{{value.date}}</strong></dt>
        <dd>
            <h2>缴纳费用</h2>
            <em>{{value.sumPart}}</em>
        </dd>
        <dd>
            <h2>缴费基数</h2>
            <em>{{value.base}}</em>
        </dd>
        <dd>
            <h2>养老金个人缴纳</h2>
            <em>{{value.ylgrjfe}}</em>
        </dd>
        <dd>
            <h2>医保个人缴纳</h2>
            <em>{{value.ybgrjfe}}</em>
        </dd>
        <dd>
            <h2>失保个人缴纳</h2>
            <em>{{value.sygrjfe}}</em>
        </dd>
   	 {{/each}}

	</script>
    <script>
     var resultObj=${result};
     $(function(){
    	  
    	 if(resultObj.errorMessage!=undefined){
    		 $("header").siblings().remove();
    		 $("header").after("<center>"+resultObj.errorMessage+"</center>");
    	 }else{
    		 init(resultObj);
    	 }
    	 
     });
   
     function init(obj){
    	 
    	 if(obj&&obj.code==1){
    		 var dataObj=obj.data;
    		 var Name=dataObj.name;
    		 var IDcard=dataObj.IDcard;
    		 var totalMonths=dataObj.total.totalMonths;	//累计缴费月数
    		 var $basicEmSelector=$("[data-basic='basic'] dd");
    		 $basicEmSelector.eq(0).find("strong").html(Name);
    		 $basicEmSelector.eq(1).find("em").html(IDcard);
    		 $basicEmSelector.eq(4).find("em").html(totalMonths);
    		 
    		 var paidArray=dataObj.paidList;
    		 var needArray=dataObj.needPay;
    		 var resultArray=new Array();
    		 
    		 for(var i=0;i<paidArray.length;i++){
    			 var paidDate=paidArray[i].date;
    			 for(var j=0;j<needArray.length;j++){
    				 var needDate=needArray[j].date;
    				 
    				 if(paidDate==needDate){
    					 
    					 var tempObj={
    							 date:Number(needArray[i].date),
    							 sumPart:paidArray[i].sumPart,
    							 base:needArray[i].base,
    							 ylgrjfe:needArray[i].ylgrjfe,
    							 ybgrjfe:needArray[i].ybgrjfe,
    							 sygrjfe:needArray[i].sygrjfe,
    					 };
    					 
    					 resultArray.push(tempObj); 
    				 }
    			 }
    			 
    		 }
    		 var recentPayObj=dataObj.paidList.pop();
    		 var lastDate=recentPayObj.date;		    //末次存缴月份 
    		 var sumPart=recentPayObj.sumPart;			//缴纳金额?
    		 $basicEmSelector.eq(2).find("em").html(lastDate);
    		 $basicEmSelector.eq(3).find("em").html(sumPart);
    		 resultArray.sort(function campareObjArray(v1,v2){
    	    	  return  v2.date-v1.date;
    	    	});
    		 var html = template("detailList", {list:resultArray});
    		 $("[data-detail='list']").append(html);
    	 }
     }
     
     
   </script>
</body>
</html>