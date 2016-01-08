<%--<ul data-am-widget="pagination" class="am-pagination am-pagination-default">
  <li class="am-pagination-first ">
    <a href="#" class="">第一页</a>
  </li>
  <li class="am-pagination-prev ">
    <a href="#" class="">上一页</a>
  </li>
  <li class="">
    <a href="#" class="">1</a>
  </li>
  <li class="am-active">
    <a href="#" class="am-active">2</a>
  </li>
  <li class="">
    <a href="#" class="">3</a>
  </li>
  <li class="">
    <a href="#" class="">4</a>
  </li>
  <li class="">
    <a href="#" class="">5</a>
  </li>
  <li class="am-pagination-next ">
    <a href="#" class="">下一页</a>
  </li>
  <li class="am-pagination-last ">
    <a href="#" class="">最末页</a>
  </li>
</ul>--%>

<%--
 分页格式
   首页 <<   1   2   3   4   5   6   7   8   9   10  11>  >> 尾页
   首页 <<   1   2   3   4   5   6   7   8   9   ... 11  12 >  >> 尾页
   首页 <<   1   2  ...  4   5   6   7   8   9   10 ... 12  13 >  >> 尾页
   首页 <<   1   2  ...  5   6   7   8   9   10  11  12  13 >  >> 尾页
   首页 <<   1   2  ...  5   6   7   8   9   10  11  ... 13  14 >  >> 尾页
   首页 <<   1   2  ...  5   6   7   8   9   10  11  ...   21  22 >  >> 尾页

--%>
<%@tag pageEncoding="UTF-8" description="分页" %>
<%@ attribute name="page" type="org.springframework.data.domain.Page" required="true" description="分页" %>
<%@ attribute name="pageSize" type="java.lang.Integer" required="false" description="每页大小" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="es" tagdir="/WEB-INF/tags" %>

<c:if test="${empty pageSize}">
    <c:set var="pageSize" value="${page.size}"/>
</c:if>

<c:set var="displaySize" value="2"/>
<c:set var="current" value="${page.number + 1}"/>

<c:set var="begin" value="${current - displaySize}"/>
<c:if test="${begin <= displaySize}">
    <c:set var="begin" value="${1}"/>
</c:if>
<c:set var="end" value="${current + displaySize}"/>
<c:if test="${end > page.totalPages - displaySize}">
    <c:set var="end" value="${page.totalPages - displaySize}"/>
</c:if>
<c:if test="${end < 0 or page.totalPages < displaySize * 4}">
    <c:set var="end" value="${page.totalPages}"/>
</c:if>

<ul data-am-widget="pagination" class="am-pagination am-pagination-default">
    <c:choose>
        <c:when test="${page.firstPage}">
            <li class="am-pagination-first ">
                <a class="disabled" href="#"  title="第一页">第一页</a>
            </li>
            <li class="am-pagination-prev ">
                <a class="disabled" href="#"  title="上一页">上一页</a>
            </li>
        </c:when>
        <c:otherwise>
            <li class="am-pagination-first ">
                <a href="#" class="" title="第一页" onclick="$.table.turnPage('${pageSize}', 1, this);">第一页</a>
            </li>
            <li class="am-pagination-prev ">
                <a href="#" class="" title="上一页"
                   onclick="$.table.turnPage('${pageSize}', ${current - 1}, this);">上一页</a>
            </li>
        </c:otherwise>
    </c:choose>
    <c:forEach begin="1" end="${begin == 1 ? 0 : 2}" var="i">
        <li <c:if test="${current == i}"> class="am-active"</c:if>>
            <a href="#" onclick="$.table.turnPage('${pageSize}', ${i}, this);" title="第${i}页">${i}</a>
        </li>
    </c:forEach>

    <c:if test="${begin > displaySize + 1}">
        <li><a>...</a></li>
    </c:if>

    <c:forEach begin="${begin}" end="${end}" var="i">
        <li <c:if test="${current == i}"> class="am-active"</c:if>>
            <a href="#" onclick="$.table.turnPage('${pageSize}', ${i}, this);" title="第${i}页">${i}</a>
        </li>
    </c:forEach>


    <c:if test="${end < page.totalPages - displaySize}">
        <li><a>...</a></li>
    </c:if>

    <c:forEach begin="${end < page.totalPages ? page.totalPages - 1 : page.totalPages + 1}" end="${page.totalPages}" var="i">
        <li <c:if test="${current == i}"> class="am-active"</c:if>>
            <a href="#" onclick="$.table.turnPage('${pageSize}', ${i}, this);" title="第${i}页">${i}</a>
        </li>
    </c:forEach>
    <c:choose>
        <c:when test="${page.lastPage}">
            <li class="am-pagination-next ">
                <a class="disabled" href="#"  title="下一页">下一页</a>
            </li>
            <li class="am-pagination-last ">
                <a class="disabled" href="#"  title="最末页">最末页</a>
            </li>
        </c:when>
        <c:otherwise>
            <li class="am-pagination-next ">
                <a href="#" class="" title="下一页"  onclick="$.table.turnPage('${pageSize}', ${current + 1}, this);">下一页</a>
            </li>
            <li class="am-pagination-last ">
                <a href="#" class="" title="最末页"  onclick="$.table.turnPage('${pageSize}', ${page.totalPages}, this);">最末页</a>
            </li>
        </c:otherwise>
    </c:choose>
</ul>
