<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:contentHeader title="${news.title}" description="智阳网络技术" keywords="智阳网络技术"/>
<es:header href="${BackURL}" title="${news.title}" index="${ctx}/news?receiver=${param['receiver']}"/>
<div class="am-container doc-example">
    <article class="am-article">
        <div class="am-article-hd">
            <h1 class="am-article-title">${news.title}</h1>

            <p class="am-article-meta"><i class="am-icon-user"></i>无名</p>

            <p class="am-article-meta"><i class="am-icon-clock-o"></i><spring:eval expression="news.sendTime"/></p>
        </div>

        <div class="am-article-bd">
            <p class="am-article-lead">${news.content}</p>
        </div>
    </article>

</div>

<es:foot/>
<es:contentFooter/>