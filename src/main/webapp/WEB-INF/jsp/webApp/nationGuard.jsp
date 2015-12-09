<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="社保公积金查询" description="智阳网络技术" keywords="智阳网络技术"/>

<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">社保公积金查询</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="sp_info">
  <h2>个人信息</h2>
  <div class="info infoyg">
    <p><span class="m_l"><i>姓名</i></span><span class="m_s"  id="emoloyName">&nbsp;${userInfo.orgPerson.name}</span></p>
    <p><span class="m_l"><i>身份证号</i></span><span class="m_s" id="cardId">&nbsp;${handleIdCard }</span></p>
    <p><span class="m_l"><i>公积金账号</i></span><span class="m_s" id="sbEmpAccount">&nbsp;</span></p>
    <p><span class="m_l"><i>月份</i></span><span class="m_s">
       <input type="text" class="monthinput" placeholder="薪资年月"  data-am-datepicker="{format: 'yyyy-mm', viewMode: 'months', minViewMode: 'months'}"
            readonly id="month" month="${month}"/>
      </span></p>
  </div>
</div>
<div class="sp_info sp_s" id="result1">
<!--   <h2>残疾保障金</h2>
  <div class="info_li">
    <ul class="am-list">
      <li><a><span class="am-fr">6000</span>企业基数</a></li>
      <li><a><span class="am-fr">6000</span>个人基数</a></li>
      <li><a><span class="am-fr">80%</span>企业比例</a></li>
      <li><a><span class="am-fr">20%</span>个人比例</a></li>
      <li><a><span class="am-fr">1000</span>企业金额</a></li>
      <li><a><span class="am-fr">200</span>个人金额</a></li>
    </ul>
  </div> -->
</div>
<es:webAppNewFooter/>
<es:contentFooter/>
<script >
    $(function () {
        /* function processItem(name, val) {
            return '<li><div class="am-list am-list-static"><div class="am-u-sm-6 am-u-lg-2 ">' + name + '</div><div class="am-u-sm-6  am-u-lg-10">' + val + '</div></div></li>';
        } */

        function replaceWithStar(val, length, mask) {
            if (!length) {
                length = 6;
            }
            if (!mask) {
                mask = "*";
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

        //$("#cardId").text(replaceWithStar($("#cardId").attr("card")));
        //console.log(replaceWithStar($("#cardId").attr("card")));
        $("#month").val($("#month").attr("month").replace(/(.{4})/g, '$1-'));
        progress.start();
        $.getJSON("${ctx}/hrhelper-platform/SocialInsuranceController.action", {
            cardId: "${cardId}", month: "${month}"
        }, function (data) {
            if (data.errorMessage && data.errorMessage != "") {
               $("#result1").html('<div class="am-panel am-panel-danger"> <div class="am-panel-hd"> <h3 class="am-panel-title">错误消息</h3></div><div class="am-panel-bd">' + data.errorMessage + '</div></div>');
               //$('<div class="am-panel am-panel-danger"> <div class="am-panel-hd"> <h3 class="am-panel-title">错误消息</h3></div><div class="am-panel-bd">' + data.errorMessage + '</div></div>').appendTo("#result1");
                //$("#emoloyName").text(data.errorMessage);
                $("#sbEmpAccount").text(data.errorMessage);
                progress.done();
                return;
            }
            //$("#emoloyName").text(data.employeeName);
            if (data.sbEmpAccount && data.sbEmpAccount != "") {
                $("#sbEmpAccount").val(data.sbEmpAccount).text(replaceWithStar(data.sbEmpAccount));
            } else {
                $("#sbEmpAccount").parents("p").hide();
            }
            if (data.errorMessage != "") {
                //$('<div class="am-panel am-panel-danger"> <div class="am-panel-hd"> <h3 class="am-panel-title">错误消息</h3></div><div class="am-panel-bd">' + data.errorMessage + '</div></div>').appendTo(".sp_info sp_s");
                 $("#result1").html('<div class="am-panel am-panel-danger"> <div class="am-panel-hd"> <h3 class="am-panel-title">错误消息</h3></div><div class="am-panel-bd">' + data.errorMessage + '</div></div>');
                return;
            }
            $.each(data.listProd, function (index, product) {
                console.log("企业基数");
                //var divs='<div class="info_li"></div>';
               var ul = $('<ul class="am-list"> </ul>');
                //ul.append('<li><a>'+processItem("企业基数", '<span >'+product.companyBase+'</span>')+'</a></li>').append(processItem("个人基数", product.individualBase)).append(processItem("企业比例", product.companyRatio)).append(processItem("个人比例", product.individualRatio))/*.append(processItem("企业附加额", product.companyAppend)).append(processItem("个人附加额", product.individualAppend))*/.append(processItem("企业金额", product.companySum)).append(processItem("个人金额", product.individualSum))/*.append(processItem("补差额", product.compensationSum))*/;
               var a='<li><a><span class="am-fr">'+product.companyBase+'</span>企业基数</a></li>';
               var b='<li><a><span class="am-fr">'+product.individualBase+'</span>个人基数</a></li>';
               var c='<li><a><span class="am-fr">'+product.companyRatio+'</span>企业比例</a></li>';
               var d='<li><a><span class="am-fr">'+product.individualRatio+'</span>个人比例</a></li>';
               var e='<li><a><span class="am-fr">'+product.companySum+'</span>企业金额</a></li>';
               var f='<li><a><span class="am-fr">'+product.individualSum+'</span>个人金额</a></li>';
			   ul.append(a+b+c+d+e+f);
                //$(' <div class="am-panel am-panel-default"> <div class="am-panel-hd"> <h3 class="am-panel-title">' + product.prodName + '</h3></div></div>').append(ul).appendTo("#result1");
            	
            	$(' <div class="info_li">  <h2>' + product.prodName + '</h2></div>').append(ul).appendTo("#result1");
            });
            progress.done();

        });
        $("#month").on('changeDate.datepicker.amui', function (event) {
            //window.location.replace("${ctx}/webApp/nationalGuard?cardId=${cardId}&month=" + getMonth(event.date) + "&employeeName=${employeeName}");
            window.location.replace("${ctx}/webApp/nationalGuard?cardId=${cardId}&month=" + getMonth(event.date));

        });
    });
</script>