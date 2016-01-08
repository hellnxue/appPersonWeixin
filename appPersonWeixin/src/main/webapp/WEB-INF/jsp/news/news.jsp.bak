<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:contentHeader title="我的消息" description="智阳网络技术" keywords="智阳网络技术"/>
<c:if test="${!isWeChat}">
<header class="am-topbar am-topbar-fixed-top am-header-default">
    <div class="am-container">
        <h1 class="am-topbar-brand">
            <a href="#">我的消息</a>
        </h1>

    </div>
</header>
    </c:if>
<div class="am-container doc-example">
    <section data-am-widget="accordion" class="am-accordion am-accordion-default"
             data-am-accordion='{ }'>
        <c:set value="个人消息" var="title"/>
        <c:set value="${unReadPersonal}" var="unRead" />
        <c:set value="${personal.content}" var="content" />
        <c:set value="PERSONAL" var="type" />
        <%@include file="/WEB-INF/jsp/news/_news.jsp" %>
        <c:set value="公共消息" var="title"/>
        <c:set value="${unReadPublic}" var="unRead" />
        <c:set value="${publicNews.content}" var="content" />
        <c:set value="PUBLIC" var="type" />
        <%@include file="/WEB-INF/jsp/news/_news.jsp" %>
        <c:set value="第三方推送" var="title"/>
        <c:set value="${unReadThird}" var="unRead" />
        <c:set value="${third.content}" var="content" />
        <c:set value="THIRD" var="type" />
        <%@include file="/WEB-INF/jsp/news/_news.jsp" %>
    </section>


</div>

<es:foot/>
<es:contentFooter/>