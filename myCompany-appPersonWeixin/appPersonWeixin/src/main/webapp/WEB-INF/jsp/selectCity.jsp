<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf"%>
<es:contentHeader title="政策包查询" description="智阳网络技术" keywords="智阳网络技术" />
<c:if test="${!isWeChat}">
<header class="am-topbar am-topbar-fixed-top am-header-default">
    <div class="am-container">
        <h1 class="am-topbar-brand">
            <a href="#">选择城市</a>
        </h1>
    </div>
</header>
    </c:if>
<div class="doc-example am-g am-g-fixed ">
    <form class="am-form" action="${ctx}/policy">
        <fieldset>
            <legend>选择城市</legend>
            <div class="am-form-group">
                <label for="province">省份</label>
                <select data-am-selected="{searchBox: 1}" id="province" name="province">
                    <c:forEach var="province" items="${provinces}">
                        <option value="${province.id}">${province.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="am-form-group">
                <label for="city">城市</label>
                <select data-am-selected="{searchBox: 1}" id="city" name="city">
                    <c:forEach var="city" items="${cities}">
                        <option value="${city.id}">${city.name}</option>
                    </c:forEach>
                </select>
            </div>
                <button type="submit" class="am-btn am-btn-primary am-btn-block">查询</button>
        </fieldset>
    </form>

</div>
<es:foot/>
<es:contentFooter/>
<script type="text/javascript">
    $(function () {
        function initCity() {
            progress.start();
            $.getJSON("${ctx}/province/" + $("#province").val() + "/city", function (data) {
                var option = "<option value='{id}'>{name}</option>";
                var html = "";
                $.each(data, function (index, city) {
                    html += option.replace("{id}", city.id).replace("{name}", city.name);
                });
                removeSelect("city");
                $("#city").html(html).removeData('amui.selected').selected();
                progress.done();
            });
        }
        var progress = $.AMUI.progress;
        if ($("#province").val() != '1') {
            initCity();
        }
        $('body').on('change', '#province', function() {  initCity(); });

    });
    function removeSelect(id) {
        $("#" + id + "").parent().children(".am-selected").remove();
    }
</script>