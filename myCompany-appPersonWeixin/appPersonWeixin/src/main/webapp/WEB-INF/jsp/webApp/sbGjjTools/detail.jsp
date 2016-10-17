<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	Calendar calendar = Calendar.getInstance(); 
	int year = calendar.get(Calendar.YEAR);
%>
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
	<header>
		<a href="javascript:history.go(-1);" style="font-size: 110px"><b>&#139;</b></a>个人社保详情
	</header>
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
            <h2>当年缴纳余额</h2>
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
	<!-- 北京社保 -->
	 <script id="detailListForBJ" type="text/html">
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
     </dl>
     <dl class="detail-basic" data-detail="list">
   	 {{each list as value index}}
    	    
 		<dt>缴纳明细<strong>{{value.date}}</strong></dt>
        
        <dd>
            <h2>公司</h2>
            <em>{{value.company}}</em>
        </dd>
        <dd>
            <h2>养老基数</h2>
            <em>{{value.ylbase}}</em>
        </dd>
        <dd>
            <h2>养老单位缴费额</h2>
            <em>{{value.yldwjfe}}</em>
        </dd>
        <dd>
            <h2>养老个人缴费额</h2>
            <em>{{value.ylgrjfe}}</em>
        </dd>

        <dd>
            <h2>失业基数</h2>
            <em>{{value.sybase}}</em>
        </dd>
        <dd>
            <h2>失业单位缴费额</h2>
            <em>{{value.sydwjfe}}</em>
        </dd>
        <dd>
            <h2>失业个人缴费额</h2>
            <em>{{value.sygrjfe}}</em>
        </dd>


        <dd>
            <h2>工伤基数</h2>
            <em>{{value.gsbase}}</em>
        </dd>
        <dd>
            <h2>工伤单位缴费额</h2>
            <em>{{value.gsdwjfe}}</em>
        </dd>

        <dd>
            <h2>生育基数</h2>
            <em>{{value.sebase}}</em>
        </dd>
        <dd>
            <h2>生育单位缴费额</h2>
            <em>{{value.sedwjfe}}</em>
        </dd>

        <dd>
            <h2>医保基数</h2>
            <em>{{value.ybbase}}</em>
        </dd>
        <dd>
            <h2>医保单位缴费额</h2>
            <em>{{value.ybdwjfe}}</em>
        </dd>
        <dd>
            <h2>医保个人缴费额</h2>
            <em>{{value.ybgrjfe}}</em>
        </dd>
   	 {{/each}}
      </dl>
	</script>

	<!-- 湖北社保 -->
	<script id="detailListForHB" type="text/html">
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
     </dl>
     <dl class="detail-basic" data-detail="list">
   	 {{each list as value index}}
    	    
 		<dt>缴纳明细<strong>{{value.date}}</strong></dt>
        
        <dd>
            <h2>公司</h2>
            <em>{{value.company}}</em>
        </dd>
        <dd>
            <h2>医保单位缴费额</h2>
            <em>{{value.ybdwjfe}}</em>
        </dd>
        <dd>
            <h2>医保个人缴费额</h2>
            <em>{{value.ybgrjfe}}</em>
        </dd>
   	 {{/each}}
      </dl>
	</script>
	<!-- 湖北黄石社保 -->
	<script id="detailListForHS" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>姓名</h2>
            <strong>{{name}} </strong>
        </dd>
     </dl>
     <dl class="detail-basic" data-detail="list">
   	 {{each list as value index}}
    	    
 		<dt>缴纳明细<strong>{{value.date}}</strong></dt>
        
        <dd>
            <h2>公司</h2>
            <em>{{value.company}}</em>
        </dd>
   	 {{/each}}
      </dl>
	</script>
	<!-- 湖北武汉社保 -->
	<script id="detailListForWH" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>{{name}}</h2>
        </dd>
     </dl>
     <dl class="detail-basic" data-detail="list">
   	 {{each list as value index}}
    	    
 		<dt>明细<strong>{{value.date}}</strong></dt>
          <dd>
			<h2>缴纳基数</h2>
            <em>{{value. base}}</em>
        </dd>
		 <dd>
			<h2>缴纳金额</h2>
            <em>{{value.total}}</em>
        </dd>
   	 {{/each}}
      </dl>
	</script>
	<!-- 湖北荆门社保 -->
	<script id="detailListForJM" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>{{name}}</h2>
        </dd>
     </dl>
     <dl class="detail-basic" data-detail="list">
   	 {{each list as value index}}
    	    
 		<dt>明细<strong>{{value.date}}</strong></dt>
          
		 <dd>
			<h2>缴纳金额</h2>
            <em>{{value.total}}</em>
        </dd>
   	 {{/each}}
      </dl>
	</script>
	<!-- 湖北仙桃社保 -->
	<script id="detailListForXT" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>{{name}}</h2>
        </dd>
     </dl>
     <dl class="detail-basic" data-detail="list">
   	 {{each list as value index}}
    	    
 		<dt>{{value.type}}<strong>{{value.date}}</strong></dt>
          <dd>
			<h2>缴纳基数</h2>
            <em>{{value.base}}</em>
        </dd>
		 <dd>
			<h2>缴纳金额</h2>
            <em>{{value.total}}</em>
        </dd>
   	 {{/each}}
      </dl>
	</script>
	<!-- 青岛社保 -->
	<script id="detailListForQD" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>{{name}}</h2>
        </dd>
     </dl>
     <dl class="detail-basic" data-detail="list">
   	 {{each list as value index}}
    	    
 		<dt>明细<strong>{{value.date}}</strong></dt>
          <dd>
			<h2>缴纳基数</h2>
            <em>{{value.base}}</em>
        </dd>
		 <dd>
			<h2>缴纳金额</h2>
            <em>{{value.total}}</em>
        </dd>
        <dd>
			<h2>状态</h2>
            <em>{{value.flag}}</em>
        </dd>
   	 {{/each}}
      </dl>
	</script>
	<!-- 深圳社保 -->
	<script id="detailListForSZ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>{{name}}</h2>
        </dd>
     </dl>
     <dl class="detail-basic" data-detail="list">
   	 {{each list as value index}}
    	    
 		<dt>明细<strong>{{value.date}}</strong></dt>
        <dd>
			<h2>缴纳基数</h2>
            <em>{{value.base}}</em>
        </dd>
		 <dd>
			<h2>缴纳金额</h2>
            <em>{{value.total}}</em>
        </dd>
   	 {{/each}}
      </dl>
	</script>
	<!-- 鄂州社保 -->
	<script id="detailListForEZ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>{{name}}</h2>
        </dd>
     </dl>
     <dl class="detail-basic" data-detail="list">
   	 {{each list as value index}}
    	    
 		<dt>失业保险</dt>
          <dd>
			<h2>费款所属期</h2>
            <em>{{value.typesy}}</em>
          </dd>
        <dt>工商保险</dt>
          <dd>
			<h2>费款所属期</h2>
            <em>{{value.typegs}}</em>
          </dd>
        <dt>职工医保</dt>
          <dd>
			<h2>费款所属期</h2>
            <em>{{value.typezg}}</em>
          </dd>
        <dt>生育保险</dt>
          <dd>
			<h2>费款所属期</h2>
            <em>{{value.typeshy}}</em>
          </dd>
   	 {{/each}}
      </dl>
	</script>
	<!-- 台州社保 -->
	<script id="detailListForZJTZ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>{{name}}</h2>
        </dd>
     </dl>
     <dl class="detail-basic" data-detail="list">
   	 {{each list as value index}}
    	    
 		<dt>{{value.type}}<strong>{{value.date}}</strong></dt>
        <dd>
			<h2>缴纳基数</h2>
            <em>{{value.base}}</em>
        </dd>
		 
   	 {{/each}}
      </dl>
	</script>
	<!-- 德州社保 -->
	<script id="detailListForSDDZ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>{{name}}</h2>
        </dd>
     </dl>
     <dl class="detail-basic" data-detail="list">
   	 {{each list as value index}}
    	    
 		<dt>明细<strong>{{value.date}}</strong></dt>
        <dd>
			<h2>缴纳基数</h2>
            <em>{{value.base}}</em>
        </dd>
		 <dd>
			<h2>缴纳金额</h2>
            <em>{{value.total}}</em>
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
    		  if(sbType==5){
    			  dataTemplate= handlerSHSB(obj);
    			  html = template("detailListForSH", dataTemplate);
    		  }else if(sbType==6){
    			  
    			  dataTemplate= handlerBJSB(obj);
    			  html = template("detailListForBJ", dataTemplate);
    		  }
				
				else if(sbType==13){
	    			  
	    			  dataTemplate= handlerWHSB(obj);
	    			  html = template("detailListForWH", dataTemplate);
	    		  }
				else if(sbType==14){
	    			  
	    			  dataTemplate= handlerXYSB(obj);
	    			  html = template("detailListForWH", dataTemplate);
	    		  }
				else if(sbType==15){
	    			  
	    			  dataTemplate= handlerNSSB(obj);
	    			  html = template("detailListForWH", dataTemplate);
	    		  }
				else if(sbType==16){
	    			  
	    			  dataTemplate= handlerXNSB(obj);
	    			  html = template("detailListForWH", dataTemplate);
	    		  }
				else if(sbType==17){
	    			  
	    			  dataTemplate= handlerJMSB(obj);
	    			  html = template("detailListForJM", dataTemplate);
	    		  }
				else if(sbType==18){
	    			  
	    			  dataTemplate= handlerHSSB(obj);
	    			  html = template("detailListForXT", dataTemplate);
	    		  }
				else if(sbType==19){
	    			  
	    			  dataTemplate= handlerEZSB(obj);
	    			  html = template("detailListForEZ", dataTemplate);
	    		  }
				else if(sbType==20){
	    			  
	    			  dataTemplate= handlerXTSB(obj);
	    			  html = template("detailListForXT", dataTemplate);
	    		  }
				else if(sbType==21){
	    			  
	    			  dataTemplate= handlerQDSB(obj);
	    			  html = template("detailListForQD", dataTemplate);
	    		  }
				else if(sbType==24){
	    			  
	    			  dataTemplate= handlerHFSB(obj);
	    			  html = template("detailListForXT", dataTemplate);
	    		  }
				else if(sbType==25){
	    			  
	    			  dataTemplate= handlerSZSB(obj);
	    			  html = template("detailListForSZ", dataTemplate);
	    		  }
				else if(sbType==29){
	    			  
	    			  dataTemplate= handlerHHHTSB(obj);
	    			  html = template("detailListForXT", dataTemplate);
	    		  }
				else if(sbType==30){
	    			  
	    			  dataTemplate= handlerZJTZSB(obj);
	    			  html = template("detailListForZJTZ", dataTemplate);
	    		  }
				else if(sbType==31){
	    			  
	    			  dataTemplate= handlerSDDZSB(obj);
	    			  html = template("detailListForSDDZ", dataTemplate);
	    		  }
				else if(sbType==32){
	    			  
	    			  dataTemplate= handlerJSLYGSB(obj);
	    			  html = template("detailListForZJTZ", dataTemplate);
	    		  }
				else if(sbType==33){
	    			  
	    			  dataTemplate= handlerJSSZSB(obj);
	    			  html = template("detailListForSZ", dataTemplate);
	    		  }
				else if(sbType==34){
	    			  
	    			  dataTemplate= handlerSDTNSB(obj);
	    			  html = template("detailListForSZ", dataTemplate);
	    		  }
			  else {
    			  
				  dataTemplate= handlerXTSB(obj);
    			  html = template("detailListForXT", dataTemplate);
    		  }
    		 
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
    /**鄂州社保数据处理**/
     
     function handlerEZSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		
		 
		
			 var sy = paidArray.sybx;
			 var gs = paidArray.gsbx;
			 var zg = paidArray.zgyb;
			 var shy= paidArray.shybx;
			 var tempObj={
					 typesy:sy.substring(6,sy.length),   //失业保险
					 typegs:gs.substring(6,gs.length),//工商保险
					 typezg:zg.substring(6,zg.length),//职工医保
					 typeshy:shy.substring(6,shy.length),//生育医保
			 };
			 
			 resultArray.push(tempObj);
		 
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
     
 /**北京社保数据处理**/
     
     function handlerBJSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		 console.log("dataObj.name="+dataObj.name);
		 dataTemplate.IDcard=dataObj.IDcard;
		 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		 var year = '<%=year%>';
		 for(var i=0;i<paidArray.length;i++){
			 if(paidArray[i].date.substring(0,4)==year){
			 var tempObj={
					 date:paidArray[i].date,
					 ylbase:paidArray[i].ylbase,
					 sybase:paidArray[i].sybase,
					 yldwjfe:paidArray[i].yldwjfe,
					 ybbase:paidArray[i].ybbase,
					 ybdwjfe:paidArray[i].ybdwjfe,
					 gsdwjfe:paidArray[i].gsdwjfe,
					 ylgrjfe:paidArray[i].ylgrjfe,
					 gsbase:paidArray[i].gsbase,
					 sydwjfe:paidArray[i].sydwjfe,
					 sygrjfe:paidArray[i].sygrjfe,
					 company:paidArray[i].company,
					 sedwjfe:paidArray[i].sedwjfe,
					 ybgrjfe:paidArray[i].ybgrjfe,
					 sebase:paidArray[i].sebase
			 };
			 
			 resultArray.push(tempObj);
		 }
		 }
		 var recentPayObj=dataObj.paidList.pop();
		 dataTemplate.lastDate=recentPayObj.date;//末次存缴月份 
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
/**湖北襄阳社保数据处理**/
     
     function handlerXYSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.qianjiaomingxi;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		 console.log("dataObj.name="+dataObj.name);
		 dataTemplate.IDcard=dataObj.IDcard;
		 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		 var year = '<%=year%>';
		 for(var i=0;i<paidArray.length;i++){
			 if(paidArray[i].JFNY.substring(0,4)==year){
			 var tempObj={
					 date:paidArray[i].JFNY,
					 sebase:paidArray[i].JFJS,
					 company:paidArray[i].DWMC,
					 sedwjfe:paidArray[i].DWJFJE,
					 ybgrjfe:paidArray[i].GRJFJE,
					 ybbase:paidArray[i].JFJS,
			 };
			 
			 resultArray.push(tempObj);
		 }
		 }
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
 /**湖北武汉社保数据处理**/
     
     function handlerWHSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList.unemployment;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		 console.log("dataObj.name="+dataObj.name);
		 dataTemplate.IDcard=dataObj.IDcard;
		 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		  var year = '<%=year%>';
		 for(var i=0;i<paidArray.length;i++){
			if(paidArray[i].JFNY.substring(0,4)==year){
			var total = parseFloat(paidArray[i].GRJFJE);
			 var tempObj={
					 date:paidArray[i].JFNY,
					 base:paidArray[i].JFJS,
					 total:total,
			 };
			 
			 resultArray.push(tempObj);
		 }
		 }
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
/**湖北襄阳社保数据处理**/
     
     function handlerXYSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList.medicalDetail.qianjiaomingxi;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		 console.log("dataObj.name="+dataObj.name);
		 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		 var year = '<%=year%>';
		 for(var i=0;i<paidArray.length;i++){
			 if(paidArray[i].date.substring(0,4)==year){
			 var tempObj={
					 date:paidArray[i].date,
					 base:paidArray[i].jiaofeijishu,
					 total:paidArray[i].yingjiaojine,
			 };
			 
			 resultArray.push(tempObj);
		 }
		 }
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
/**湖北恩施社保数据处理**/
     
     function handlerNSSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList.yiBaoData;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		 console.log("dataObj.name="+dataObj.name);
		 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		  var year = '<%=year%>';
		 for(var i=0;i<paidArray.length;i++){
			 if(paidArray[i].date.substring(0,4)==year){
			var total = parseFloat(paidArray[i].hrgrzh);
			 var tempObj={
					 date:paidArray[i].date,
					 base:paidArray[i].ylbase,
					 total:total,
			 };
			 
			 resultArray.push(tempObj);
		 }
		 }
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
/**湖北咸宁社保数据处理**/
     
     function handlerXNSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		 console.log("dataObj.name="+dataObj.name);
		 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		 var year = '<%=year%>';
		 for(var i=0;i<paidArray.length;i++){
			 if(paidArray[i].date.substring(0,4)==year){
			var total =parseFloat(paidArray[i].ybgejfe);
			 var tempObj={
					 date:paidArray[i].date,
					 base:paidArray[i].ybbase,
					 total:total,
			 };
			 
			 resultArray.push(tempObj);
		 }
		 }
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
/**湖北荆门社保数据处理**/
     
     function handlerJMSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		 
		 var date = paidArray.qyjbylbx.startTime+"-"+paidArray.qyjbylbx.endTime;
			 
			 var tempObj={
					 date:date,
					 base:paidArray.qyjbylbx.ybbase,
					 total:paidArray.qyjbylbx.personalPay,
			 };
			 
			 resultArray.push(tempObj);
		 
		
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
     
/**湖北黄石社保数据处理**/
     
     function handlerHSSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList.unemployment;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		 console.log("dataObj.name="+dataObj.name);
		 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		 var year = '<%=year%>';
		 for(var i=0;i<paidArray.length;i++){
			 if(paidArray[i].daozhangriqi.substring(0,4)==year){
			 var tempObj={
					 date:paidArray[i].daozhangriqi,
					 type:paidArray[i].baoxianleibie,
					 base:paidArray[i].jiaofeijishu,
					 total:paidArray[i].benqiyinjiao,
			 };
			 
			 resultArray.push(tempObj);
		 }
		 }
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
/**湖北仙桃社保数据处理**/
     
     function handlerXTSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList.endowmentDetail;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		 console.log("dataObj.name="+dataObj.name);
		 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		 var year = '<%=year%>';
		 for(var i=0;i<paidArray.length;i++){
			 if(paidArray[i].date.substring(0,4)==year){
			 var tempObj={
					 date:paidArray[i].date,
					 type:paidArray[i].type,
					 base:paidArray[i].pbase,
					 total:paidArray[i].total,
			 };
			 
			 resultArray.push(tempObj);
		 }
		 }
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
/**青岛社保数据处理**/
     
     function handlerQDSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList.yangLaoData;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		 var year = '<%=year%>';
		 for(var i=0;i<paidArray.length;i++){
			 if(paidArray[i].date.substring(0,4)==year){
			 var tempObj={
					 date:paidArray[i].date,
					 flag:paidArray[i].flag,
					 base:paidArray[i].base,
					 total:paidArray[i].personalPay,
			 };
			 
			 resultArray.push(tempObj);
		 }
		 }
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
/**合肥社保数据处理**/
     
     function handlerHFSB(obj){
    	 
    	 var dataObj=obj.data;
		 var paidArray=dataObj.paidList;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.name;
		 console.log("dataObj.name="+dataObj.name);
		 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
		 var year = '<%=year%>';
		 for(var i=0;i<paidArray.length;i++){
			 if(paidArray[i].date.substring(0,4)==year){
			 var tempObj={
					 date:paidArray[i].date,
					 type:paidArray[i].type,
					 base:paidArray[i].personalBase,
					 total:paidArray[i].personalPay,
			 };
			 
			 resultArray.push(tempObj);
		 }
		 }
		 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
		 resultArray.sort(function campareObjArray(v1,v2){
			 
	    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
	    	  
	    	});
		 dataTemplate.list=resultArray;
    	 
		return dataTemplate;
     }
/**深圳社保数据处理**/
     
     function handlerSZSB(obj){
    	 
    	 var dataObj=obj.data;
    	 var year = '<%=year%>';
			var paidArray = dataObj.paidList.endowment[year];
			var resultArray = new Array();

			var dataTemplate = new Object();
			dataTemplate.name = dataObj.name;
			console.log("dataObj.name=" + dataObj.name);
			//dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数

			for (var i = 0; i < paidArray.length; i++) {

				var tempObj = {
					date : paidArray[i].date,
					base : paidArray[i].paymentBase,
					total : paidArray[i].personalPayment,
				};

				resultArray.push(tempObj);
			}

			//dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
			resultArray.sort(function campareObjArray(v1, v2) {

				return Number(v2.date.replace(/-/, ""))
						- Number(v1.date.replace(/-/, ""));

			});
			dataTemplate.list = resultArray;

			return dataTemplate;
		}
		/**呼和浩特社保数据处理**/

		function handlerHHHTSB(obj) {

			var dataObj = obj.data;
			var paidArray = dataObj.paidList.endowment;
			var resultArray = new Array();

			var dataTemplate = new Object();
			dataTemplate.name = dataObj.name;
			console.log("dataObj.name=" + dataObj.name);
			//dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
            var year = '<%=year%>';
			for (var i = 0; i < paidArray.length; i++) {
				if(paidArray[i].date.substring(0,4)==year){
				var tempObj = {
					date : paidArray[i].date,
					base : paidArray[i].base,
					total : paidArray[i].personalPay,
				};

				resultArray.push(tempObj);
			}
			}
			//dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
			resultArray.sort(function campareObjArray(v1, v2) {

				return Number(v2.date.replace(/-/, ""))
						- Number(v1.date.replace(/-/, ""));

			});
			dataTemplate.list = resultArray;

			return dataTemplate;
		}
		/**浙江台州社保数据处理**/
	     
	     function handlerZJTZSB(obj){
	    	 
	    	 var dataObj=obj.data;
			 var paidArray=dataObj.joinStatus;
			 var resultArray=new Array();
			 
			 var dataTemplate=new Object();
			 dataTemplate.name=dataObj.name;
			 console.log("dataObj.name="+dataObj.name);
			 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
			 var year = '<%=year%>';
			 for(var i=0;i<paidArray.length;i++){
				 if(paidArray[i].firstJoin.substring(0,4)==year){
				 var tempObj={
						 date:paidArray[i].firstJoin,
						 type:paidArray[i].type,
						 base:paidArray[i].base,
				 };
				 
				 resultArray.push(tempObj);
			 }
			 }
			 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
			 resultArray.sort(function campareObjArray(v1,v2){
				 
		    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
		    	  
		    	});
			 dataTemplate.list=resultArray;
	    	 
			return dataTemplate;
	     }
	     /**山东德州社保数据处理**/
	     
	     function handlerSDDZSB(obj){
	    	 
	    	 var dataObj=obj.data;
	    	 var year = '<%=year%>';
			 var paidArray = dataObj.paidList.endowment[year];
			 var resultArray=new Array();
			 
			 var dataTemplate=new Object();
			 dataTemplate.name=dataObj.name;
			 console.log("dataObj.name="+dataObj.name);
			 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
			 
			 for(var i=0;i<paidArray.length;i++){
				 
				 var tempObj={
						 date:paidArray[i].date,
						 base:paidArray[i].base,
						 total:paidArray[i].personalPay,
				 };
				 
				 resultArray.push(tempObj);
			 }
			
			 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
			 resultArray.sort(function campareObjArray(v1,v2){
				 
		    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
		    	  
		    	});
			 dataTemplate.list=resultArray;
	    	 
			return dataTemplate;
	     }
  /**江苏连云港社保数据处理**/
	     
	     function handlerJSLYGSB(obj){
	    	 
	    	 var dataObj=obj.data;
	    	 var year = '<%=year%>';
			 var paidArray = dataObj.paidList[year];
			 var resultArray=new Array();
			 
			 var dataTemplate=new Object();
			 dataTemplate.name=dataObj.name;
			 console.log("dataObj.name="+dataObj.name);
			 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
			 
			 for(var i=0;i<paidArray.length;i++){
				 
				 var tempObj={
						 date:paidArray[i].date,
						 base:paidArray[i].base,
						 total:paidArray[i].personalPay,
				 };
				 
				 resultArray.push(tempObj);
			 }
			
			 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
			 resultArray.sort(function campareObjArray(v1,v2){
				 
		    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
		    	  
		    	});
			 dataTemplate.list=resultArray;
	    	 
			return dataTemplate;
	     }
  /**山东泰安社保数据处理**/
	     
	     function handlerSDTNSB(obj){
	    	 
	    	 var dataObj=eval(obj.data);
	    	 var year = '<%=year%>';
			 var paidArray = dataObj.paidList.unmployment[year];
			 console.log(paidArray);
			 var resultArray=new Array();
			 var length = Object.keys(paidArray).length;
			 var dataTemplate=new Object();
			 dataTemplate.name=dataObj.name;
			 console.log("dataObj.name="+dataObj.name);
			 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
			 
			 for(var i=1;i<=length;i++){
				 var tempObj={
						 date:paidArray[i].date,
						 base:paidArray[i].base,
						 total:paidArray[i].personalPay,
				 };
				 
				 resultArray.push(tempObj);
			 }
			
			 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
			 resultArray.sort(function campareObjArray(v1,v2){
				 
		    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
		    	  
		    	});
			 dataTemplate.list=resultArray;
	    	 
			return dataTemplate;
	     }
	     /**苏州社保数据处理**/
	     
	     function handlerJSSZSB(obj){
	    	 
	    	 var dataObj=obj.data;
			 var paidArray=dataObj.paidList.yiliaobx;
			 console.log(paidArray);
			 var resultArray=new Array();
			 
			 var dataTemplate=new Object();
			 dataTemplate.name=dataObj.name;
			 console.log("dataObj.name="+dataObj.name);
			 //dataTemplate.totalMonths=dataObj.total.totalMonths;//累计缴费月数
			  var year = '<%=year%>';
			 for(var i=0;i<paidArray.length;i++){
				 if(paidArray[i].date.substring(0,4)==year){
				 var tempObj={
						 date:paidArray[i].date,
						 base:paidArray[i].payBase,
						 total:paidArray[i].personalPay,
				 };
				 
				 resultArray.push(tempObj);
			 }}
			
			 //dataTemplate.sumPart=recentPayObj.sumPart;//缴纳金额?
			 resultArray.sort(function campareObjArray(v1,v2){
				 
		    	  return  Number(v2.date.replace(/-/,""))-Number(v1.date.replace(/-/,""));
		    	  
		    	});
			 dataTemplate.list=resultArray;
	    	 
			return dataTemplate;
	     }
	</script>

</body>
</html>