<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="社保公积金查询" description="智阳网络技术" keywords="智阳网络技术"/>

<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <%-- <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> --%> </div>
  <h1 class="am-header-title">社保公积金查询</h1>
  <div class="am-titlebar-right"> <%-- <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> --%> </div>
</header>
<div id="errorMessage" style="display: none;">${errorMessage }</div>
<div class="sp_info">
  <h2>个人信息</h2>
  <div class="info infoyg">
    <p><span class="m_l"><i>姓名</i></span><span class="m_s"  id="emoloyName">&nbsp;${userInfo.orgPerson.name}</span></p>
    <p>
	    <span class="m_l"><i>身份证号</i></span><span class="m_s" id="cardId">
	    	<c:choose>
				<c:when test="${fn:length(idCard)==18 }">
					${fn:replace(idCard,fn:substring(idCard,6,14),'xxxxxxxx') }
				</c:when>
				<c:when test="${fn:length(idCard)==15 }">
					${fn:replace(idCard,fn:substring(idCard,6,12),'xxxxxx') }
				</c:when>
				<c:otherwise>
					&nbsp;
				</c:otherwise>
			</c:choose>
	    </span>
	 </p>
    <p><span class="m_l"><i>公积金账号</i></span><span class="m_s" id="sbEmpAccount">&nbsp;</span></p>
    <p><span class="m_l"><i>月份</i></span><span class="m_s">
       <input type="text" class="monthinput" placeholder="薪资年月"  data-am-datepicker="{format: 'yyyy-mm', viewMode: 'months', minViewMode: 'months'}"
            readonly id="month" month="${month}"/>
      </span></p>
  </div>
</div>
<div class="sp_info sp_s" id="result1">
</div>
<%-- <es:webAppNewFooter/> --%>
<es:contentFooter/>
<script >
    $(function () {
    	var errorMessage=$("#errorMessage").text();
    	if(errorMessage){
    		$("#result1").html('<div class="am-panel am-panel-danger"> <div class="am-panel-hd"> <h3 class="am-panel-title">错误消息</h3></div><div class="am-panel-bd">' + errorMessage + '</div></div>');
    		return;
    	}
        function replaceWithStar(val, length, mask) {
            if (!length) {
                length = 6;
            }
            if (!mask) {
                mask = "x";
            }
            if (typeof val == "string") {
                if (val.length < length) {
                    val = "";
                } else {
                    val = val.substr(0, val.length - length);
                }
                for (var i = 0; i < length; i++) {
                    val += mask;
                }
            }
            return val;
        }

        var progress = $.AMUI.progress;

        $("#month").val($("#month").attr("month").replace(/(.{4})/g, '$1-'));
        progress.start();
        $.getJSON("${ctx}/hrhelper-platform/SocialInsuranceController.action", {
            cardId: "${idCard}", month: "${month}"
        }, function (data) {
        	$("#emoloyName").text(data.employeeName);
            if (data.errorMessage && data.errorMessage != "") {
               $("#result1").html('<div class="am-panel am-panel-danger"> <div class="am-panel-hd"> <h3 class="am-panel-title">错误消息</h3></div><div class="am-panel-bd">' + data.errorMessage + '</div></div>');
                $("#sbEmpAccount").text(data.errorMessage);
                progress.done();
                return;
            }
            if (data.sbEmpAccount && data.sbEmpAccount != "") {
                $("#sbEmpAccount").val(data.sbEmpAccount).text(replaceWithStar(data.sbEmpAccount));
            } else {
                $("#sbEmpAccount").parents("p").hide();
            }
            if (data.errorMessage != "") {
                 $("#result1").html('<div class="am-panel am-panel-danger"> <div class="am-panel-hd"> <h3 class="am-panel-title">错误消息</h3></div><div class="am-panel-bd">' + data.errorMessage + '</div></div>');
                return;
            }
            $.each(data.listProd, function (index, product) {
                console.log("企业基数");
               var ul = $('<ul class="am-list"> </ul>');
               var a='<li><a><span class="am-fr">'+product.companyBase+'</span>企业基数</a></li>';
               var b='<li><a><span class="am-fr">'+product.individualBase+'</span>个人基数</a></li>';
               var c='<li><a><span class="am-fr">'+product.companyRatio+'</span>企业比例</a></li>';
               var d='<li><a><span class="am-fr">'+product.individualRatio+'</span>个人比例</a></li>';
               var e='<li><a><span class="am-fr">'+product.companySum+'</span>企业金额</a></li>';
               var f='<li><a><span class="am-fr">'+product.individualSum+'</span>个人金额</a></li>';
			   ul.append(a+b+c+d+e+f);
            	$(' <div class="info_li">  <h2>' + product.prodName + '</h2></div>').append(ul).appendTo("#result1");
            });
            progress.done();

        });
        $("#month").on('changeDate.datepicker.amui', function (event) {
            window.location.replace("${ctx}/api/nationalGuard?cardId=${enCardId}&month=" + getMonth(event.date));

        });
    });
</script>