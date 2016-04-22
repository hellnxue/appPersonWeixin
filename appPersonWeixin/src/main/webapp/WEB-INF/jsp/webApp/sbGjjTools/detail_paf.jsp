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
<body class="paf">
    <header><a  href="javascript:history.go(-1);">&#139;</a>个人公积金查询<a  href="javascript:history.go(-1);"> </a></header>  
    <ul>
        <li>
            <a href="#"><span>&#155;</span>个人公积金</a>
        </li>
        <li>
            <a href="#"><span>&#155;</span>个人补充公积金</a>
        </li>
    </ul>
    <div style="display:none" id="showInfo">
     
   </div>
   
    <!-- 上海社保 -->
    <script id="detailListForSHGJJ" type="text/html">
	 <dl class="detail-basic" data-basic="basic">
        <dt>基本信息</dt>
        <dd>
            <h2>姓名</h2>
            <strong>{{name}} </strong>
        </dd>
        <dd>
            <h2>开户状态</h2>
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
   {{if list.length>0}}
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
   <script>
   // var resultObj=${result};
    var sbType="${sbType}";
   var resultObj={"code":1,"data":{"Name":"刘振宇","openDate":"20111216000000","company":"智阳网络技术（上海）有限公司","lastMonth":"20160201000000","RemainSum":"2101.03","monthlyPayment":"2100","accountStatus":"正常","nowStatus":"正在还款","loanOpenDate":"20130321000000","timeLimit":"180月","returnStyle":"月等额还款","total":"460000.00","balance":"390082.09","lastBackTime":"20160301000000","bank":"农商行","fundLoanAccount":"3246330134160851101","lastMonthRepayment":1440,"supplementOpenDate":"","supplementCompany":"","supplementLastMonth":"","supplementBalance":"","supplementMonthlyPayment":"","supplementFundStatus":"","ChargeList":{"2016":[{"date":"20160324000000","company":"智阳网络技术（上海）有限公司","money":"2100.00","remark":"汇缴2016年02月公积金","reason":"","total":"0"},{"date":"20160317000000","company":"智阳网络技术（上海）有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"930.00"},{"date":"20160218000000","company":"智阳网络技术（上海）有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"3275.01"},{"date":"20160214000000","company":"智阳网络技术（上海）有限公司","money":"2100.00","remark":"汇缴2016年01月公积金","reason":"","total":"0"},{"date":"20160126000000","company":"智阳网络技术（上海）有限公司","money":"2100.00","remark":"汇缴2015年12月公积金","reason":"","total":"0"},{"date":"20160119000000","company":"智阳网络技术（上海）有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"2100.00"}],"2015":[{"date":"20151223000000","company":"智阳网络技术（上海）有限公司","money":"2100.00","remark":"汇缴2015年11月公积金","reason":"","total":"0"},{"date":"20151217000000","company":"智阳网络技术（上海）有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"2100.00"},{"date":"20151119000000","company":"智阳网络技术（上海）有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"2100.00"},{"date":"20151117000000","company":"智阳网络技术（上海）有限公司","money":"2100.00","remark":"汇缴2015年10月公积金","reason":"","total":"0"},{"date":"20151019000000","company":"智阳网络技术（上海）有限公司","money":"2100.00","remark":"汇缴2015年09月公积金","reason":"","total":"0"},{"date":"20150917000000","company":"智阳网络技术（上海）有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"2100.00"},{"date":"20150910000000","company":"智阳网络技术（上海）有限公司","money":"2100.00","remark":"汇缴2015年08月公积金","reason":"","total":"0"},{"date":"20150819000000","company":"智阳网络技术（上海）有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"2100.00"},{"date":"20150812000000","company":"智阳网络技术（上海）有限公司","money":"2100.00","remark":"汇缴2015年07月公积金","reason":"","total":"0"},{"date":"20150805000000","company":"智阳网络技术（上海）有限公司","money":"0","remark":"启封","reason":"","total":"6.04"},{"date":"20150805000000","company":"智阳网络技术（上海）有限公司","money":"0","remark":"批量基数调整为2100元","reason":"","total":"6.04"},{"date":"20150731000000","company":"智阳网络技术（上海）有限公司","money":"0","remark":"转到智阳网络技术（上海）有限公司","reason":"","total":"6.04"},{"date":"20150731000000","company":"上海壳际网络科技有限公司","money":"0","remark":"从上海壳际网络科技有限公司转出","reason":"","total":"6.04"},{"date":"20150724000000","company":"上海壳际网络科技有限公司","money":"0","remark":"批量基数调整为1680元","reason":"","total":"6.04"},{"date":"20150717000000","company":"上海壳际网络科技有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"1680.00"},{"date":"20150714000000","company":"上海壳际网络科技有限公司","money":"1680.00","remark":"汇缴2015年06月公积金","reason":"","total":"0"},{"date":"20150701000000","company":"上海壳际网络科技有限公司","money":"2.07","remark":"结息","reason":"","total":"0"},{"date":"20150618000000","company":"上海壳际网络科技有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"3360.00"},{"date":"20150615000000","company":"上海壳际网络科技有限公司","money":"1680.00","remark":"汇缴2015年05月公积金","reason":"","total":"0"},{"date":"20150615000000","company":"上海壳际网络科技有限公司","money":"1680.00","remark":"补缴","reason":"","total":"0"},{"date":"20150522000000","company":"上海壳际网络科技有限公司","money":"0","remark":"启封","reason":"","total":"3.97"},{"date":"20150522000000","company":"上海壳际网络科技有限公司","money":"0","remark":"批量基数调整为1680元","reason":"","total":"3.97"},{"date":"20150519000000","company":"上海壳际网络科技有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"690.00"},{"date":"20150515000000","company":"上海壳际网络科技有限公司","money":"0.00","remark":"汇缴2015年04月公积金","reason":"","total":"0"},{"date":"20150505000000","company":"上海壳际网络科技有限公司","money":"0","remark":"转到上海壳际网络科技有限公司","reason":"","total":"693.97"},{"date":"20150505000000","company":"上海绿岸网络科技股份有限公司","money":"0","remark":"从上海绿岸网络科技股份有限公司转出","reason":"","total":"693.97"},{"date":"20150428000000","company":"上海绿岸网络科技股份有限公司","money":"692.00","remark":"汇缴2015年03月公积金","reason":"","total":"0"},{"date":"20150417000000","company":"上海绿岸网络科技股份有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"700.00"},{"date":"20150326000000","company":"上海绿岸网络科技股份有限公司","money":"692.00","remark":"汇缴2015年02月公积金","reason":"","total":"0"},{"date":"20150319000000","company":"上海绿岸网络科技股份有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"690.00"},{"date":"20150217000000","company":"上海绿岸网络科技股份有限公司","money":"692.00","remark":"汇缴2015年01月公积金","reason":"","total":"0"},{"date":"20150216000000","company":"上海绿岸网络科技股份有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"690.00"},{"date":"20150127000000","company":"上海绿岸网络科技股份有限公司","money":"692.00","remark":"汇缴2014年12月公积金","reason":"","total":"0"},{"date":"20150119000000","company":"上海绿岸网络科技股份有限公司","money":"0","remark":"支取","reason":"集中冲还贷（逐月）","total":"690.00"}]},"ConsumeList":{"2016":[{"date":"20160320000000","repaymentDate":"20160301000000","amountOfCapital":"377.54","amountOfInterest":"1062.46","businessLines":"公积金冲还贷"},{"date":"20160320000000","repaymentDate":"20160301000000","amountOfCapital":"1835.01","amountOfInterest":"0.00","businessLines":"日常(正常)还款"},{"date":"20160220000000","repaymentDate":"20160201000000","amountOfCapital":"2206.57","amountOfInterest":"1068.44","businessLines":"公积金冲还贷"},{"date":"20160120000000","repaymentDate":"20160101000000","amountOfCapital":"1154.38","amountOfInterest":"1195.62","businessLines":"公积金冲还贷"},{"date":"20160120000000","repaymentDate":"20160101000000","amountOfCapital":"1046.23","amountOfInterest":"0.00","businessLines":"日常(正常)还款"}],"2015":[{"date":"20151220000000","repaymentDate":"20151201000000","amountOfCapital":"947.74","amountOfInterest":"1412.26","businessLines":"公积金冲还贷"},{"date":"20151220000000","repaymentDate":"20151201000000","amountOfCapital":"1106.50","amountOfInterest":"0.00","businessLines":"日常(正常)还款"},{"date":"20151120000000","repaymentDate":"20151101000000","amountOfCapital":"2046.99","amountOfInterest":"1419.51","businessLines":"日常(正常)还款"},{"date":"20151118000000","repaymentDate":"20151101000000","amountOfCapital":"361.13","amountOfInterest":"0.00","businessLines":"逾期还款"},{"date":"20151020000000","repaymentDate":"20151001000000","amountOfCapital":"1678.64","amountOfInterest":"1426.73","businessLines":"日常(正常)还款"},{"date":"20150920000000","repaymentDate":"20150901000000","amountOfCapital":"2032.57","amountOfInterest":"1433.93","businessLines":"日常(正常)还款"},{"date":"20150820000000","repaymentDate":"20150801000000","amountOfCapital":"2025.39","amountOfInterest":"1441.11","businessLines":"日常(正常)还款"},{"date":"20150720000000","repaymentDate":"20150701000000","amountOfCapital":"2018.25","amountOfInterest":"1448.25","businessLines":"日常(正常)还款"},{"date":"20150620000000","repaymentDate":"20150601000000","amountOfCapital":"2011.12","amountOfInterest":"1455.38","businessLines":"日常(正常)还款"},{"date":"20150521000000","repaymentDate":"20150501000000","amountOfCapital":"2004.02","amountOfInterest":"552.78","businessLines":"逾期还款"},{"date":"20150520000000","repaymentDate":"20150501000000","amountOfCapital":"0.00","amountOfInterest":"909.70","businessLines":"日常(正常)还款"},{"date":"20150420000000","repaymentDate":"20150401000000","amountOfCapital":"1996.95","amountOfInterest":"1469.55","businessLines":"日常(正常)还款"},{"date":"20150320000000","repaymentDate":"20150301000000","amountOfCapital":"1989.90","amountOfInterest":"1476.60","businessLines":"日常(正常)还款"},{"date":"20150220000000","repaymentDate":"20150201000000","amountOfCapital":"1982.88","amountOfInterest":"1483.62","businessLines":"日常(正常)还款"},{"date":"20150123000000","repaymentDate":"20150101000000","amountOfCapital":"1975.88","amountOfInterest":"382.18","businessLines":"逾期还款"},{"date":"20150120000000","repaymentDate":"20150101000000","amountOfCapital":"0.00","amountOfInterest":"1140.59","businessLines":"日常(正常)还款"}]},"supplementChargeList":[],"cardNo":"129300639205","type":"上海公积金查询"}};

    
     $(function(){
    	 
    	 $("ul li a").click(function(){
    		  $(this).parents("ul").hide();
    		  $("div").show();
    		 
    		  back();
    	 });
    	 
    	 init(resultObj);
    	 
    	 
     });
   
     function init(obj){
    	 
    	 if(obj&&obj.code==1){
    		 
    		 var dataTemplate=null;
	   		 var html ="";
	   		 if(sbType==2){//上海公积金
	   			  dataTemplate= handlerSHGJJ(obj);
	   			  html = template("detailListForSHGJJ", dataTemplate);
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
