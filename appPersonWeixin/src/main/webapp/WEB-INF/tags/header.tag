<%@tag pageEncoding="UTF-8" description="header" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="href" type="java.lang.String" required="true" description="href" %>
<%@ attribute name="index" type="java.lang.String" required="false" description="index" %>
<%@ attribute name="title" type="java.lang.String" required="true" description="title" %>
<%@ attribute name="fixed" type="java.lang.Boolean" required="false" description="fixed" %>
<c:if test="${!isWeChat}">
    <header data-am-widget="header"
            class="am-header am-header-default  <c:if test="${fixed==null||fixed}">am-header-fixed</c:if>">
        <div class="am-header-left am-header-nav">
            <a href="${href}" class="">
                <i class="am-header-icon am-icon-chevron-left"></i>
            </a>
        </div>

        <h1 class="am-header-title">
            <a href="#" class="">${title}</a>
        </h1>
        <div class="am-header-right am-header-nav">
            <c:if test="${index!=null}">
            <a href="${index}" class="">
                <i class="am-header-icon am-icon-home"></i>
            </a>
            </c:if>
            <a onclick="reloadUrl(this)" class="">
                <i class="am-header-icon am-icon-refresh"></i>
            </a>
        </div>
    </header>
</c:if>