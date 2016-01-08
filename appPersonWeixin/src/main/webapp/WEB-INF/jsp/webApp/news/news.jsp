<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="智阳科技" description="智阳网络技术" keywords="智阳网络技术"/>

<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">新闻</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>

<div data-am-widget="slider" class="am-slider am-slider-c4" data-am-slider='{&quot;controlNav&quot;:false}'>
  <ul class="am-slides">
    <li> <img src="${ctx}/static/assets/images/fl01.jpg">
      <div class="am-slider-desc">远方 有一个地方 那里种有我们的梦想</div>
    </li>
    <li> <img src="${ctx}/static/assets/images/fl01.jpg">
      <div class="am-slider-desc">某天 也许会相遇 相遇在这个好地方</div>
    </li>
    <li> <img src="${ctx}/static/assets/images/fl01.jpg">
      <div class="am-slider-desc">不要太担心 只因为我相信 终会走过这条遥远的道路</div>
    </li>
    <li> <img src="${ctx}/static/assets/images/fl01.jpg">
      <div class="am-slider-desc">OH PARA PARADISE 是否那么重要 你是否那么地遥远</div>
    </li>
  </ul>
</div>
<div class="index_news m10 pages_news white-bg">
  <div data-am-widget="list_news" class="am-list-news am-list-news-default">
    <div class="am-list-news-bd">
      <ul class="am-list">
	        <c:set value="${personal.content}" var="content" />
	        <%@include file="/WEB-INF/jsp/webApp/news/_newsList.jsp" %>
	              

      </ul>
    </div>
  </div>
</div>



<es:webAppNewFooter/>
<!--在这里编写你的代码-->
<script>
$(function() {
  $('.am-slider-manual').flexslider({
  // options
  });
});
</script> 

</body>
</html>

