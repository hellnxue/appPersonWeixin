<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:contentHeader title="${param['name']}" description="智阳网络技术" keywords="智阳网络技术"/>
<es:header href="${ctx}/news?receiver=${param['receiver']}" title="${param['name']}"/>
<div class="am-container doc-example">
    <div data-am-widget="list_news" class="am-list-news am-list-news-default">
        <!--列表标题-->
        <div class="am-list-news-bd">
            <ul class="am-list">
                <c:forEach items="${page.content}" var="news">
                    <li class="am-g  <c:if test="${!news.read}">new</c:if>">
                        <c:if test="${!news.read}"><span class="am-badge am-badge-primary am-radius">new</span></c:if>
                        <a href="${ctx}/news/${news.id}">${news.title==""?"无题":news.title} </a>

                        <div class="am-list-item-text">${news.content}</div>
                    </li>
                </c:forEach>
            </ul>
        </div>

</div>
    <es:page page="${page}"/>
    <es:foot/>
<es:contentFooter/>