<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:contentHeader title="链接" description="智阳网络技术" keywords="智阳网络技术"/>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<header class="am-topbar am-topbar-fixed-top am-header-default">
    <div class="am-container">
        <h1 class="am-topbar-brand">
            <a href="#">链接</a>
        </h1>

    </div>
</header>
<div class="am-container doc-example">
    <!--列表标题-->
    <div class="am-list-news-bd">
        <ul class="am-list">
            <li class="am-g ">
                <a class="am-btn am-btn-primary" href="${ctx}/workStation">工作台 </a>
            </li>
            <li class="am-g ">
                <a  class="am-btn am-btn-secondary" href="${ctx}/selectCity">政策包查询 </a>
            </li>
            <li class="am-g ">
                <a  class="am-btn am-btn-success"href="${ctx}/aboutUs">关于我们 </a>
            </li>
            <li class="am-g ">
                <a  class="am-btn am-btn-danger" href="${ctx}/news?receiver=333232312143314">我的消息 </a>
            </li>
            <li class="am-g ">
                <a  class="am-btn am-btn-warning" href="${ctx}/apps" id="download" data-am-popover="{content: '  <img src=http://png.2vma.theucd.com/chart?cht=qr&chs=300x300&chl=<%=basePath%>apps/>', trigger: 'hover focus'}">下载app </a>
            </li>
        </ul>
    </div>

    <es:foot/>
<es:contentFooter/>
    <script type="text/javascript">
        $("#download").hover(function(){

        });
    </script>