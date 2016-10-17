<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="工资单查询" description="智阳网络技术" keywords="智阳网络技术"/>

<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">工资单查询</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="sp_info">
  <h2>个人信息</h2>
  <div class="info infos">
    <p><span class="m_l"><i>姓名</i></span><span class="m_s" id="userName">&nbsp;</span></p>
    <p><span class="m_l"><i>月份</i></span><span class="m_s">
     <input type="text" class="monthinput" placeholder="薪资年月"  data-am-datepicker="{format: 'yyyy-mm', viewMode: 'months', minViewMode: 'months'}"
            readonly id="month" month="${month}"/>
      </span></p>
  </div>
</div>
<div class="sp_info sp_s" >
  <h2>工资明细</h2>
  <div class="info_li" id="result">
    <ul class="am-list" id="salaryList">
      <li><a><span class="am-fr" id="basicSalary">&nbsp;</span>基本工资</a></li>
      <li><a><span class="am-fr" id="allSalary">&nbsp;</span>应发合计</a></li>
      <li><a><span class="am-fr" id="pSafe">&nbsp;</span>保险个人缴纳合计</a></li>
      <li><a><span class="am-fr" id="safeCompany">&nbsp;</span>保险单位合计</a></li>
      <li><a><span class="am-fr" id="pTax">&nbsp;</span>个人所得税</a></li>
      <li><a><span class="am-fr font01" id="actual">&nbsp;</span>实发工资</a></li>
    </ul>
  </div>
</div>

<es:webAppNewFooter/>
<es:contentFooter/>
<script >
   var orgid="";
    $(function () {
    	
    	//获取企业id
    	$.ajax({
				type:"post",
				url:"${ctx}/hrhelper-platform/orgInfo",
				data:{"mobile":"${mobile}"},
				dataType:"json",
				async:false,
				success : function(data) {
					if(data.errorMessage!==undefined){
			              console.log("错误消息！");
			              return;
			          }
					  orgid=data.org_id;
				}
				
			});
    
        $("#month").val($("#month").attr("month").replace(/(.{4})/g, '$1-'));
        $("#month").on('changeDate.datepicker.amui', function (event) {
            window.location.replace("${ctx}/webApp/salary?month=" + getMonth(event.date));

        });
        var progress = $.AMUI.progress;
        progress.start();
        $.getJSON("${ctx}/hrhelper-platform/salary", {
             month: "${month}"
        }, function (data) {
        	$("#userName").text(data.employeeName);
            if (data.errorMessage!==undefined) {
              
                $("#result").html('<div class="am-panel am-panel-danger"> <div class="am-panel-hd"> <h3 class="am-panel-title">错误消息</h3></div><div class="am-panel-bd">' + data.errorMessage + '</div></div>');
                progress.done();
                return;
            }
            
            if(orgid=="354"||orgid=="12776"||orgid=="12777"||orgid=="12778"){//如果是京东
            	$("#salaryList").empty();               
            }else{
            	  $("#basicSalary").text(data.baseSalary);    //基本工资
                  $("#allSalary").text(data.amountSalary);    //应发合计
                  $("#pSafe").text(data.amountSb);			// 保险个人缴纳合计
                  $("#safeCompany").text(data.amountSbCompany);//保险单位合计
                  $("#pTax").text(data.amountTax);			//个人所得税
                  $("#actual").text(data.amountSalaried);		//实发工资
            }

            var variableArry=data.fields;//可变字段
            if(variableArry){
                variableArry.forEach(function(item,index,array){
                    if(item.value!==undefined){
              		$("#salaryList").append('<li><a><span class="am-fr">'+item.value+'</span>'+item.name+'</a></li>');
              	  }
                
                });
            }
            progress.done();
        });
    });
</script>