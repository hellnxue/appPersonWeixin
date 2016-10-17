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
    <!-- 上海社保 -->
    <script id="detailListForSH" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>姓名</h2>
            <strong>{{name}} </strong>
        </dd>
        <dd>
            <h2>身份证号</h2>
            <em>{{IDcard}} </em>
        </dd>
        <dd>
            <h2>末次缴纳月份</h2>
            <em>{{lastDate}} </em>
        </dd>
        <dd>
            <h2>缴纳金额</h2>
            <em>{{sumPart}} </em>
        </dd>
        <dd>
            <h2>累计缴纳月数</h2>
            <em>{{totalMonths}} </em>
        </dd>
     </dl>
     <dl class="detail-basic" data-detail="list">
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
      </dl>
	</script>
    <script>
     var resultObj=${result};
     var sbType="${sbType}";
     $(function(){
    	  
    	 if(resultObj.errorMessage!=undefined){
    		 $("header").siblings().remove();
    		 $("header").after("<p style='margin-top:20px;text-align:center'>"+resultObj.errorMessage+"</p>");
    	 }else{
    		 init(resultObj);
    	 }
    	 
     });
   
     function init(obj){
    	  if(obj&&obj.code==1){
    		  var dataTemplate=null;
    		  var html ="";
    			  dataTemplate= handlerSHSB(obj);
    			  html = template("detailListForSH", dataTemplate);
    		 
    		 $("header").after(html);  
    	 }
    	 
     }
    
     /**上海社保数据处理**/
     
     function handlerSHSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList;
		 var needArray=dataObj.needPay;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		
		 dataTemplate.IDcard=dataObj.IDcard;
		 dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		 
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
		 dataTemplate.lastDate=recentPayObj.date;//末次存缴月份 
		 dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
	    	  return  v2.date-v1.date;
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
     
 
   </script>
</body>
</html>