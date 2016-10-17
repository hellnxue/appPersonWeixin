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
<body class="paf">
    <header><a  href="javascript:history.go(-1);">&#139;</a>个人公积金查询<a  href="javascript:history.go(-1);"> </a></header>  
   <!--  <ul>
        <li>
            <a href="#"><span>&#155;</span>个人公积金</a>
        </li>
        <li>
            <a href="#"><span>&#155;</span>个人补充公积金</a>
        </li>
    </ul> -->
    <div  id="showInfo">
     
   </div>
   <!-- 北京市管公积金 -->
    <script id="detailListForBJGJJ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>卡号</h2>
            <strong>{{cardNo}} </strong>
        </dd>
        <dd>
            <h2>姓名</h2>
            <strong>{{name}} </strong>
        </dd>
        <dd>
            <h2>账户状态</h2>
            <em>{{accountStatus}} </em>
        </dd>
        <dd>
            <h2>账户余额</h2>
            <em>{{RemainSum}} </em>
        </dd>
        
     </dl>  
	 
   <h2 class="title">月度明细</h2>
   <dl class="detail-basic" data-detail="list">
{{each list as value index}}  
		<dd>
            <h2>{{value.date}}</h2>
			<em>{{value.company}}</em>
			
		</dd>
        <dd>
            <h2>{{value.remark}}</h2>
            <div></div>
            <h2>汇缴</h2>
            <em>{{value.money}}</em>
        </dd>
 {{/each}}
    </dl>
  
	</script>
	  <!-- 曲靖公积金 -->
    <script id="detailListForQJGJJ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>卡号</h2>
            <strong>{{cardNo}} </strong>
        </dd>
        <dd>
            <h2>姓名</h2>
            <strong>{{name}} </strong>
        </dd>
        <dd>
            <h2>账户状态</h2>
            <em>{{accountStatus}} </em>
        </dd>
        <dd>
            <h2>账户余额</h2>
            <em>{{RemainSum}} </em>
        </dd>
        
     </dl>  
	 
   <h2 class="title">月度明细</h2>
   <dl class="detail-basic" data-detail="list">
{{each list as value index}}  
		<dd>
            <h2>{{value.date}}</h2>
			<em>{{value.company}}</em>
			
		</dd>
        <dd>
            <h2>{{value.remark}}</h2>

            <em>{{value.money}}</em>
        </dd>
 {{/each}}
    </dl>
  
	</script>
    <!-- 上海公积金 -->
    <script id="detailListForSHGJJ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>姓名</h2>
            <strong>{{name}} </strong>
        </dd>
        <dd>
            <h2>账户状态</h2>
            <em>{{accountStatus}} </em>
        </dd>
        <dd>
            <h2>开户时间</h2>
            <em>{{openDate}} </em>
        </dd>
        <dd>
            <h2>所属单位</h2>
            <em>{{company}} </em>
        </dd>
        <dd>
            <h2>账户余额</h2>
            <em>{{RemainSum}} </em>
        </dd>
        <dd>
            <h2>末次缴存年月</h2>
            <em>{{lastMonth}} </em>
        </dd>
        <dd>
            <h2>月缴存额</h2>
            <em>{{monthlyPayment}} </em>
        </dd>
     </dl>
   <h2 class="title">月度明细</h2>
   <dl class="detail-basic" data-detail="list">
 	 {{each list as value index}}  	    
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
 	 {{/each}}
    </dl>
   {{/if}}
	</script>
<!-- 郑州公积金 -->
    <script id="detailListForZZGJJ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>卡号</h2>
            <strong>{{cardNo}} </strong>
        </dd>
        <dd>
            <h2>姓名</h2>
            <strong>{{name}} </strong>
        </dd>
        <dd>
            <h2>账户状态</h2>
            <em>{{accountStatus}} </em>
        </dd>
        <dd>
            <h2>开户时间</h2>
            <em>{{openDate}} </em>
        </dd>
        <dd>
            <h2>账户余额</h2>
            <em>{{RemainSum}} </em>
        </dd>
        <dd>
            <h2>月缴存基数</h2>
            <em>{{personalMonthlyPayment}} </em>
        </dd>
        <dd>
            <h2>月缴金额</h2>
            <em>{{monthlyPayment}} </em>
        </dd>
        <dd>
            <h2>缴存比例</h2>
            <em>{{depositRatio}} </em>
        </dd>
        <dd>
            <h2>末次缴存年月</h2>
            <em>{{lastMonth}} </em>
        </dd>
     </dl>
 
	</script>
	<!-- 青岛公积金 -->
    <script id="detailListForQDGJJ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>卡号</h2>
            <strong>{{cardNo}} </strong>
        </dd>
        <dd>
            <h2>姓名</h2>
            <strong>{{name}} </strong>
        </dd>
        <dd>
            <h2>账户状态</h2>
            <em>{{accountStatus}} </em>
        </dd>
        <dd>
            <h2>开户时间</h2>
            <em>{{openDate}} </em>
        </dd>
        <dd>
            <h2>账户余额</h2>
            <em>{{RemainSum}} </em>
        </dd>
        <dd>
            <h2>月缴存基数</h2>
            <em>{{personalMonthlyPayment}} </em>
        </dd>
        <dd>
            <h2>月缴金额</h2>
            <em>{{monthlyPayment}} </em>
        </dd>
        <dd>
            <h2>缴存比例</h2>
            <em>{{depositRatio}} %</em>
        </dd>        
     </dl>  
	 
   <h2 class="title">月度明细</h2>
   <dl class="detail-basic" data-detail="list">
{{each list as value index}}  
		<dt>青岛公积金</dt>
        <dd>
            <h2>{{value.remark}}</h2>
            <em>{{value.date}}</em>
            <div></div>
            <h2>汇缴</h2>
            <em>{{value.total}}</em>
        </dd>
 {{/each}}
    </dl>
  
	</script>
	<!-- 杭州公积金 -->
    <script id="detailListForHZGJJ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>卡号</h2>
            <strong>{{cardNo}} </strong>
        </dd>
        <dd>
            <h2>姓名</h2>
            <strong>{{name}} </strong>
        </dd>
        <dd>
            <h2>账户状态</h2>
            <em>{{accountStatus}} </em>
        </dd>
        <dd>
            <h2>开户时间</h2>
            <em>{{openDate}} </em>
        </dd>
        <dd>
            <h2>账户余额</h2>
            <em>{{RemainSum}} </em>
        </dd>
        
        <dd>
            <h2>月缴金额</h2>
            <em>{{monthlyPayment}} </em>
        </dd>
               
     </dl>  
	 
   <h2 class="title">月度明细</h2>
   <dl class="detail-basic" data-detail="list">
{{each list as value index}}  
		<dd>
            <h2>{{value.date}}</h2>
			<em>{{value.company}}</em>
			
		</dd>
        <dd>
            <h2>{{value.remark}}</h2>
            <div></div>
            <h2>汇缴</h2>
            <em>{{value.money}}</em>
        </dd>
 {{/each}}
    </dl>
  
	</script>
	<!-- 福州公积金 -->
    <script id="detailListForFZGJJ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>卡号</h2>
            <strong>{{cardNo}} </strong>
        </dd>
        <dd>
            <h2>姓名</h2>
            <strong>{{name}} </strong>
        </dd>
        <dd>
            <h2>账户余额</h2>
            <em>{{RemainSum}} </em>
        </dd>
               
     </dl>  
	 
   <h2 class="title">月度明细</h2>
   <dl class="detail-basic" data-detail="list">
{{each list as value index}}  
		<dd>
            <h2>{{value.date}}</h2>
			<em>{{value.company}}</em>
			
		</dd>
        <dd>
            <h2>{{value.remark}}</h2>
         
            <em>{{value.money}}</em>
        </dd>
 {{/each}}
    </dl>
  
	</script>
	<!-- 呼和浩特公积金 -->
    <script id="detailListForHHHTGJJ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>卡号</h2>
            <strong>{{cardNo}} </strong>
        </dd>
        <dd>
            <h2>姓名</h2>
            <strong>{{name}} </strong>
        </dd>
        
        <dd>
            <h2>账户余额</h2>
            <em>{{RemainSum}} </em>
        </dd>
        
     </dl>  
	 
   <h2 class="title">月度明细</h2>
   <dl class="detail-basic" data-detail="list">
{{each list as value index}}  
		<dd>
            <h2>{{value.date}}</h2>
		</dd>
		<dd>
            <h2>{{value.company}}</h2>
		</dd>
        <dd>
            <h2>{{value.remark}}</h2>
            <em>{{value.money}}</em>
        </dd>
 {{/each}}
    </dl>
  
	</script>
   <script>
    var resultObj=${result};
    var sbType="${sbType}";

     $(function(){
    	 
    	/*  $("ul li a").click(function(){
    		  $(this).parents("ul").hide();
    		  $("div").show();
    		 
    		  back();
    	 }); */
    	 
    	 init(resultObj);
    	 
    	 
     });
   
     //数据初始化
     function init(obj){
    	 
    	 if(obj&&obj.code==1){
    		 
    		 var dataTemplate=null;
	   		 var html ="";
	   		 if(sbType==2){//上海公积金
	   			  dataTemplate= handlerSHGJJ(obj);
	   			  html = template("detailListForSHGJJ", dataTemplate);
	   			  
	   		 }
	   		 else  if(sbType==9){//郑州公积金
	   			  dataTemplate= handlerZZGJJ(obj);
	   			  html = template("detailListForZZGJJ", dataTemplate);
	   		 }else if(sbType==10){//青岛公积金
	   			 dataTemplate= handlerQDGJJ(obj);
	   			  html = template("detailListForQDGJJ", dataTemplate);
	   		 }
	   		else if(sbType==22){//福州公积金
	   			 dataTemplate= handlerFZGJJ(obj);
	   			  html = template("detailListForFZGJJ", dataTemplate);
	   		 }
	   		else if(sbType==23){//合肥公积金
	   			 dataTemplate= handlerHFGJJ(obj);
	   			  html = template("detailListForFZGJJ", dataTemplate);
	   		 }
	   		else if(sbType==28){//呼和浩特公积金
	   			 dataTemplate= handlerHFGJJ(obj);
	   			  html = template("detailListForHHHTGJJ", dataTemplate);
	   		 }
	   		else if(sbType==26){//曲靖公积金
	   			dataTemplate= handlerHZGJJ(obj);
	   			  html = template("detailListForQJGJJ", dataTemplate);
	   		 }
	   		 else{
	   			dataTemplate= handlerHZGJJ(obj);
	   			  html = template("detailListForBJGJJ", dataTemplate);
	   		 }
	   		$("#showInfo").append(html);  
    		 
    		 
    		 
    	 }
     }
     
     
     
     
  /**上海公积金数据处理**/
     
     function handlerSHGJJ(obj){
    	 
    	 var dataObj=obj.data;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.name=dataObj.Name;
		 dataTemplate.accountStatus=dataObj.accountStatus;
		 dataTemplate.openDate=dataObj.openDate; 
		 dataTemplate.company=dataObj.company; 
		 dataTemplate.RemainSum=dataObj.RemainSum; 
		 dataTemplate.lastMonth=dataObj.lastMonth; 
		 dataTemplate.monthlyPayment=dataObj.monthlyPayment; 
		 
		 
		 dataTemplate.list=resultArray;
		 return dataTemplate;
     }
     
     
 /**郑州公积金数据处理**/
     
     function handlerZZGJJ(obj){
    	 
    	 var dataObj=obj.data;
		 var resultArray=new Array();
		 
		 var dataTemplate=new Object();
		 dataTemplate.cardNo=dataObj.cardNo;
		 dataTemplate.name=dataObj.Name;
		 dataTemplate.accountStatus=dataObj.accountStatus;
		 dataTemplate.openDate=dataObj.openDate.substring(0,8); 
		 dataTemplate.personalMonthlyPayment=dataObj.personalMonthlyPayment; 
		 dataTemplate.RemainSum=dataObj.RemainSum; 
		 dataTemplate.lastMonth=dataObj.lastMonth.substring(0,8); 
		 dataTemplate.monthlyPayment=dataObj.monthlyPayment; 
		 
		 dataTemplate.depositRatio=dataObj.depositRatio; 
		 
		 dataTemplate.list=resultArray;
		 return dataTemplate;
     } 
     /**青岛公积金数据处理**/    
       function handlerQDGJJ(obj){
    	 
    	 var dataObj=obj.data;
         var year = '<%=year%>';  
		 var resultArray=dataObj.ChargeList[year];
		 var dataTemplate=new Object();
		 dataTemplate.cardNo=dataObj.cardNo;
		 dataTemplate.name=dataObj.Name;
		 dataTemplate.accountStatus=dataObj.accountStatus;
		 dataTemplate.openDate=dataObj.openDate; 
		 dataTemplate.personalMonthlyPayment=dataObj.declareWageBase; 
		 dataTemplate.RemainSum=dataObj.RemainSum; 
		// dataTemplate.lastMonth=dataObj.lastMonth.substring(0,10); 
		 dataTemplate.monthlyPayment=dataObj.monthlyPayment; 
		 dataTemplate.depositRatio=dataObj.depositRatio; 
		 dataTemplate.list=resultArray;
		 return dataTemplate;
     } 
       /**杭州公积金数据处理**/    
     function handlerHZGJJ(obj){
    	 
    	 var dataObj=obj.data;
    	// var dataObj = dataObj1.substring(0, 4)+"年"+dataObj1.substring(4, 6)+"月"+dataObj1.substring(6, 8)+"日";
    	var resultArray=new Array();
		 var year = '<%=year%>';  
		 
		 var resultArray=dataObj.ChargeList[year];
		 var newArray = [];
		 for(var i = 0; i < resultArray.length; i ++){
			 var record = resultArray[i];
			 var date = record.date;
			 record.date = date.substring(0, 4)+"年"+date.substring(4, 6)+"月"+date.substring(6, 8)+"日";
			 newArray.push(record);
		 }
		 
		 console.log(resultArray);
		 var dataTemplate=new Object();
		 dataTemplate.cardNo=dataObj.cardNo;
		 dataTemplate.name=dataObj.Name;
		 dataTemplate.accountStatus=dataObj.accountStatus;
		 dataTemplate.openDate=dataObj.openDate; 
		 dataTemplate.personalMonthlyPayment=dataObj.declareWageBase; 
		 dataTemplate.RemainSum=dataObj.RemainSum; 
		// dataTemplate.lastMonth=dataObj.lastMonth.substring(0,10); 
		 dataTemplate.monthlyPayment=dataObj.monthlyPayment; 
		 //dataTemplate.list=resultArray;
		 dataTemplate.list=newArray;
		 return dataTemplate;
     } 
     /**福州公积金数据处理**/    
     function handlerFZGJJ(obj){
    	 
    	 var dataObj=obj.data;
    	// var dataObj = dataObj1.substring(0, 4)+"年"+dataObj1.substring(4, 6)+"月"+dataObj1.substring(6, 8)+"日";
    	var resultArray=new Array();
		 var year = '<%=year%>';  
		 
		 var resultArray=dataObj.ChargeList[year];
		 var newArray = [];
		 for(var i = 0; i < resultArray.length; i ++){
			 var record = resultArray[i];
			 var date = record.date;
			 record.date = date.substring(0, 4)+"年"+date.substring(4, 6)+"月"+date.substring(6, 8)+"日";
			 newArray.push(record);
		 }
		 
		 console.log(resultArray);
		 var dataTemplate=new Object();
		 dataTemplate.cardNo=dataObj.cardNo;
		 dataTemplate.name=dataObj.Name;
		 
		 dataTemplate.accountStatus=dataObj.status;
		 dataTemplate.openDate=dataObj.date; 
		 dataTemplate.personalMonthlyPayment=dataObj.money; //个人基数
		 
		 dataTemplate.RemainSum=dataObj.RemainSum; //余额
		// dataTemplate.lastMonth=dataObj.lastMonth.substring(0,10); 
		 dataTemplate.monthlyPayment=dataObj.total; //金额
		 //dataTemplate.list=resultArray;
		 dataTemplate.list=newArray;
		 return dataTemplate;
     }  
     
     
     /**合肥公积金数据处理**/    
     function handlerHFGJJ(obj){
    	 
    	 var dataObj=obj.data;
    	// var dataObj = dataObj1.substring(0, 4)+"年"+dataObj1.substring(4, 6)+"月"+dataObj1.substring(6, 8)+"日";
    	var resultArray=new Array();
		 var year = '<%=year%>';  
		 
		 var resultArray=dataObj.ChargeList[year];
		 var newArray = [];
		 for(var i = 0; i < resultArray.length; i ++){
			 var record = resultArray[i];
			 var date = record.date;
			 record.date = date.substring(0, 4)+"年"+date.substring(4, 6)+"月"+date.substring(6, 8)+"日";
			 newArray.push(record);
		 }
		 
		 console.log(resultArray);
		 var dataTemplate=new Object();
		 dataTemplate.cardNo=dataObj.cardNo;
		 dataTemplate.name=dataObj.Name;
		 
		 dataTemplate.accountStatus=dataObj.remark;
		 dataTemplate.openDate=dataObj.date; 
		 dataTemplate.personalMonthlyPayment=dataObj.total; //个人基数
		 
		 dataTemplate.RemainSum=dataObj.RemainSum; //余额
		// dataTemplate.lastMonth=dataObj.lastMonth.substring(0,10); 
		 dataTemplate.monthlyPayment=dataObj.money; //金额
		 //dataTemplate.list=resultArray;
		 dataTemplate.list=newArray;
		 return dataTemplate;
     }  
     
     
     
     
     
     
     
     
     //后退
     function back(){
    	 $("header>a").click(function(){
    		
    		 if($("ul").css("display")!=="block"){
    			 $("header>a").attr("href","#");
           		 $("div").hide();
           		 $("ul").show();
            	 $("header>a").attr("href","javascript:history.go(-1);");
    		 }
       		
	    	 	 
	    	 });
     }
     
   </script>
</body>
</html>
