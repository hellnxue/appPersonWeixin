<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<dl class="am-accordion-item <c:if test="${type=='PERSONAL'}"> am-active</c:if>">
    <dt class="am-accordion-title">${title}<span class="am-badge am-badge-danger am-radius am-fr">${unRead}</span></dt>
    <dd class="am-accordion-bd am-collapse <c:if test="${type=='PERSONAL'}"> am-in</c:if>">
        <div class="am-accordion-content">
            <div data-am-widget="list_news" class="am-list-news am-list-news-default">
                <!--列表标题-->
                <div class="am-list-news-bd">
                    <ul class="am-list">
                        <c:forEach items="${content}" var="news">
                            <li class="am-g  <c:if test="${!news.read}">new</c:if>">
                                <c:if test="${!news.read}"><span class="am-badge am-badge-primary am-radius">new</span></c:if>
                                <a href="${ctx}/news/${news.id}">${news.title==""?"无题":news.title} </a>

                                <div class="am-list-item-text">${news.content}</div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <c:if test="${content.size() ne 0}">
                    <!--更多在底部-->
                    <div class="am-list-news-ft">
                        <a class="am-list-news-more am-btn am-btn-default " href="${ctx}/news/types?receiver=${param['receiver']}&type=${type}&name=${title}">查看更多${title} &raquo;</a>
                    </div>
                </c:if>

            </div>
            <c:if test="${content.size() eq 0}">
                <div class="am-g">
                    暂时没有${title}
                </div>
            </c:if>
        </div>
    </dd>
</dl>
