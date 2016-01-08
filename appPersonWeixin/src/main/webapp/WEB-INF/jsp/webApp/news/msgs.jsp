<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="智阳科技" description="智阳网络技术" keywords="智阳网络技术"/>

<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">消息</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>


<div data-am-widget="tabs" class="am-tabs am-tabs-d2 nomargin page_tab">
  <ul class="am-tabs-nav am-cf">
    <li class="am-active"> <a href="[data-tab-panel-0]">我的消息<em class="am-round"></em></a> </li>
    <li class=""> <a href="[data-tab-panel-1]">公共消息</a> </li>
  </ul>
  <div class="am-tabs-bd white-bg noborder msg_list">
    <div data-tab-panel-0 class="am-tab-panel am-active">
      <div data-am-widget="list_news" class="am-list-news am-list-news-default nomargin">
        <div class="am-list-news-bd">
          <ul class="am-list">
            <!--缩略图在标题左边-->
	        <c:set value="${personal.content}" var="content" />
	        <%@include file="/WEB-INF/jsp/webApp/news/_msgsList.jsp" %>

          </ul>
        </div>
      </div>
    </div>
    <div data-tab-panel-1 class="am-tab-panel ">
      <div data-am-widget="list_news" class="am-list-news am-list-news-default">
        <div class="am-list-news-bd">
          <ul class="am-list">
	        <c:set value="${publicNews.content}" var="content" />
	        <%@include file="/WEB-INF/jsp/webApp/news/_msgsList.jsp" %>            

          </ul>
        </div>
      </div>
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

