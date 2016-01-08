<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="${appName}" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">个人信息</h1>
</header>
<div class="sp_info">
  <div class="info_li">
    <ul class="am-list">
      <li><a href="#"><span class="am-fr">${tusername }</span><i class="icon icon01"></i>姓名</a></li>
      <li><a href="#"><span class="am-fr">${tdept }</span><i class="icon icon02"></i>部门</a></li>
      <li><a href="#"><span class="am-fr">${tposition }</span><i class="icon icon03"></i>职位</a></li>
      <li>
      <a href="tel: ${tmobile }">
      <span class="am-fr">
      <c:if test="${not empty tmobile }">拨打${tmobile }</c:if>
      </span>
      <i class="icon icon04"></i>手机</a>
      </li>
      <li><a href="#"><span class="am-fr">${tphone }</span><i class="icon icon05"></i>座机</a></li>
      <li><a href="#"><span class="am-fr">${temail }</span><i class="icon icon06"></i>邮箱</a></li>
    </ul>
  </div>
</div>
<es:webAppNewFooter/>
<script>
</script> 
</body>
</html>