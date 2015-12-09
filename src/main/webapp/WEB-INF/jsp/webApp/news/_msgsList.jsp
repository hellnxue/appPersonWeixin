<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>

		<c:forEach items="${content}" var="news">
            <li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left">
              <div class="am-u-sm-3 am-list-thumb"> <a href="${ctx}/webApp/news/msgDetail?id=${news.id}" class=""> <img src="${ctx}/static/assets/images/img1.jpg" alt="${news.title==""?"无题":news.title}" class="am-radius" /> <c:if test="${!news.read}"> <em class="am-round"></em></c:if></a> </div>
              <div class="am-u-sm-9 am-list-main">
                <h3 class="am-list-item-hd"> <span class="am-fr am-text-gray">2015-06-17</span> <a href="${ctx}/webApp/news/msgDetail?id=${news.id}" class="">${news.title==""?"无题":news.title}</a> </h3>
                <div class="am-list-item-text">${news.content}</div>
              </div>
            </li>
         </c:forEach>           

