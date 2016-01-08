<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="智阳科技" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">智阳科技</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="index"><em></em></a> </div>
</header>

<div class="sp_list" id="widget-list">
  <ul class="am-list m-widget-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
		<c:forEach items="${content}" var="list">
		    <li><a data-rel="accordion" href="${ctx}/${list.url}"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/${list.image}" class="widget-icon" width="28"> <span class="widget-name">${list.detail}</span></a></li>
		</c:forEach>  
  </ul>
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




