<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:contentHeader title="政策包查询" description="智阳网络技术" keywords="智阳网络技术"/>
<es:header href="${ctx}/selectCity" title="政策包"/>
<c:if test="${url ==null}">
    <article data-am-widget="paragraph" class="am-paragraph am-paragraph-default"
             data-am-paragraph="{ tableScrollable: true, pureview: true }">
        <h1>您查找的城市不存在政策包，请重新选择！</h1>
    </article>
</c:if>
<c:if test="${url !=null}">
    <iframe id="contentFrame" src="${ctx}/static/policy/policy/${url}?type=0" width="100%" height="500px"
            class="am-scrollable-vertical"></iframe>

</c:if>

<es:foot/>
<es:contentFooter/>
<script type="text/javascript">
    $(function () {
        var headerHeight = $("header").height();
        if (isWeixinBrowser()) {
            headerHeight = 0;
        }

        $("#contentFrame").height(window.screen.height - headerHeight - $("footer").height());
    });
</script>