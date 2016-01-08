<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:contentHeader title="下载app" description="智阳网络技术" keywords="智阳网络技术"/>
<c:if test="${!isWeChat}">
    <header class="am-topbar am-topbar-fixed-top am-header-default">
        <div class="am-container">
            <h1 class="am-topbar-brand">
                <a href="#">下载app</a>
            </h1>

        </div>
    </header>
</c:if>
<table  border="0" align="center" cellpadding="0"
        cellspacing="0" class="download">
    <tr>
        <td><img src="${ctx}/static/images/download_03.png"/></td>
    </tr>
    <tr>
        <td><a href="${ios_download_path}">
            <img src="${ctx}/static/images/download_05.png"/>
        </a>
        </td>
    </tr>
    <tr>
        <td><a href="${ctx}/static/amaze-android.apk">
            <img src="${ctx}/static/images/download_06.png"/>
        </a></td>
    </tr>
</table>
<es:foot/>
<es:contentFooter/>
