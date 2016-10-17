<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:contentHeader title="工资单查询" description="智阳网络技术" keywords="智阳网络技术"/>
<es:header href="${ctx}/workStation" title="工资单"/>
<div class="am-container">
    <div class="am-panel am-panel-secondary">
        <div class="am-panel-hd">
            <h3 class="am-panel-title">工资单</h3>
        </div>
        <ul class="am-list am-list-static">
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">姓名</div>
                </div>
                <div class="am-list am-list-static">
                    <div class="am-g" id="userName"></div>
                </div>
            </li>
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">薪资年月</div>
                </div>
                <div class="am-list am-list-static">
                    <p><input type="text" class="am-form-field" placeholder="薪资年月"
                              data-am-datepicker="{format: 'yyyy-mm', viewMode: 'months', minViewMode: 'months'}"
                              readonly id="month" month="${month}"/></p>
                </div>
            </li>
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">基本工资</div>
                </div>
                <div class="am-list am-list-static">
                    <div class="am-g" id="basicSalary"></div>
                </div>
            </li>
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">应发合计</div>
                </div>
                <div class="am-list am-list-static">
                    <div class="am-g" id="allSalary"></div>
                </div>
            </li>
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">保险个人缴纳合计</div>
                </div>
                <div class="am-list am-list-static">
                    <div class="am-g" id="pSafe"></div>
                </div>
            </li>
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">保险单位合计</div>
                </div>
                <div class="am-list am-list-static">
                    <div class="am-g" id="safeCompany"></div>
                </div>
            </li>
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">个税所得税</div>
                </div>
                <div class="am-list am-list-static">
                    <div class="am-g" id="pTax"></div>
                </div>
            </li>
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">实发工资</div>
                </div>
                <div class="am-list am-list-static">
                    <div class="am-g" id="actual"></div>
                </div>
            </li>

        </ul>
    </div>


</div>

<es:foot/>
<es:contentFooter/>
<script type="text/javascript">
    $(function () {
        $("#month").val($("#month").attr("month").replace(/(.{4})/g, '$1-'));
        $("#month").on('changeDate.datepicker.amui', function (event) {
            window.location.replace("${ctx}/salary?cardId=${cardId}&month=" + getMonth(event.date));

        });
        var progress = $.AMUI.progress;
        progress.start();
        $.getJSON("${ctx}/service/ewage.e", {
            cardId: "${cardId}", month: "${month}"
        }, function (data) {
            if (data.errorMessage != "") {
                $('<div class="am-panel am-panel-danger"> <div class="am-panel-hd"> <h3 class="am-panel-title">错误消息</h3></div><div class="am-panel-bd">' + data.errorMessage + '</div></div>').appendTo(".am-container");
                $("li").hide();
                $("#month").parents("li").show();
                progress.done();
                return;
            }
            $("#userName").text(data.data.userName);
            $("#basicSalary").text(data.data.basicSalary);
            $("#allSalary").text(data.data.allSalary);
            $("#pSafe").text(data.data.pSafe);
            $("#safeCompany").text(data.data.safeCompany);
            $("#pTax").text(data.data.pTax);
            $("#actual").text(data.data.actual);


            progress.done();
        });
    });
</script>