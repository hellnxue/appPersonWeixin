<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:contentHeader title="社保公积金查询" description="智阳网络技术" keywords="智阳网络技术"/>
<es:header href="${ctx}/workStation" title="社保公积金"/>
<div class="am-container">
    <div class="am-panel am-panel-secondary">
        <div class="am-panel-hd">
            <h3 class="am-panel-title">个人信息</h3>
        </div>

        <ul class="am-list am-list-static">
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">姓名</div>
                </div>
                <div class="am-list am-list-static">
                    <div class="am-g" id="emoloyName">${employeeName}</div>
                </div>
            </li>
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">身份证号</div>
                </div>
                <div class="am-list am-list-static">
                    <div class="am-g" id="cardId" card="${cardId}"></div>
                </div>
            </li>
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">公积金账号</div>
                </div>
                <div class="am-list am-list-static">
                    <div class="am-g" id="sbEmpAccount"></div>
                </div>
            </li>
            <li>
                <div class="am-list am-list-static">
                    <div class="am-g">月份</div>
                </div>
                <div class="am-list am-list-static">
                    <p><input type="text" class="am-form-field" placeholder="月份"
                              data-am-datepicker="{format: 'yyyy-mm', viewMode: 'months', minViewMode: 'months'}"
                              readonly id="month" month="${month}"/></p>
                </div>
            </li>

        </ul>
    </div>


</div>

<es:foot/>
<es:contentFooter/>
<script type="text/javascript">
    $(function () {
        function processItem(name, val) {
            return '<li><div class="am-list am-list-static"><div class="am-u-sm-6 am-u-lg-2 ">' + name + '</div><div class="am-u-sm-6  am-u-lg-10">' + val + '</div></div></li>';
        }

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

        $("#cardId").text(replaceWithStar($("#cardId").attr("card")));
        $("#month").val($("#month").attr("month").replace(/(.{4})/g, '$1-'));
        progress.start();
        $.getJSON("${ctx}/hrhelper-platform/SocialInsuranceController.action", {
            cardId: "${cardId}", month: "${month}"
        }, function (data) {
            if (data.errorMessage && data.errorMessage != "") {
                $('<div class="am-panel am-panel-danger"> <div class="am-panel-hd"> <h3 class="am-panel-title">错误消息</h3></div><div class="am-panel-bd">' + data.errorMessage + '</div></div>').appendTo(".am-container");
                $("#emoloyName").text(data.errorMessage);
                $("#sbEmpAccount").text(data.errorMessage);
                progress.done();
                return;
            }
            $("#emoloyName").text(data.employeeName);
            if (data.sbEmpAccount && data.sbEmpAccount != "") {
                $("#sbEmpAccount").val(data.sbEmpAccount).text(replaceWithStar(data.sbEmpAccount));
            } else {
                $("#sbEmpAccount").parents("li").hide();
            }
            if (data.errorMessage != "") {
                $('<div class="am-panel am-panel-danger"> <div class="am-panel-hd"> <h3 class="am-panel-title">错误消息</h3></div><div class="am-panel-bd">' + data.errorMessage + '</div></div>').appendTo(".am-container");
                return;
            }
            $.each(data.listProd, function (index, product) {
                var ul = $('<ul class="am-list am-list-static"> </ul>');
                ul.append(processItem("企业基数", product.companyBase)).append(processItem("个人基数", product.individualBase)).append(processItem("企业比例", product.companyRatio)).append(processItem("个人比例", product.individualRatio))/*.append(processItem("企业附加额", product.companyAppend)).append(processItem("个人附加额", product.individualAppend))*/.append(processItem("企业金额", product.companySum)).append(processItem("个人金额", product.individualSum))/*.append(processItem("补差额", product.compensationSum))*/;

                $(' <div class="am-panel am-panel-default"> <div class="am-panel-hd"> <h3 class="am-panel-title">' + product.prodName + '</h3></div></div>').append(ul).appendTo(".am-container");
            });
            progress.done();

        });
        $("#month").on('changeDate.datepicker.amui', function (event) {
            window.location.replace("${ctx}/nationalGuard?cardId=${cardId}&month=" + getMonth(event.date) + "&employeeName=${employeeName}");

        });
    });
</script>