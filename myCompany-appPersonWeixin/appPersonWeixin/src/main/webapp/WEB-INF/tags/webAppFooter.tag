<%@tag pageEncoding="UTF-8"%>

<div class="clear"></div>
<!-- 底部 -->
<div data-am-widget="navbar" class="footer">
<ul>
  <li class="index"><a href="${ctx}/webApp/index" onClick="info(this)">首页</a></li>
  <li class="lable"><a href="${ctx}/webApp/checkin">移动签到</a></li>
  <li class="information"><a href="${ctx}/webApp/news">消息</a><div class="xiaoxi">1</div></li>
  <li class="me"><a href="${ctx}/webApp/user">我的</a></li>
</ul>
</div>

</body>
<%@include file="/WEB-INF/jsp/common/import-js.jspf"%>
</html>