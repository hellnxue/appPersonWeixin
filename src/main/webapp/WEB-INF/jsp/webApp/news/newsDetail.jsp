<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="${news.title}" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">新闻</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>

<h3 class="am-paragraph-default news_tit">${news.title}</h3>
<p class="am-paragraph-default am-text-gray">${news.sendTime} <span class="am-text-primary">智阳网络</span></p>
<div class="seo_box"> <span>摘要：</span>热烈祝贺智阳网络技术（上海）有限公司发行工资宝发行工资宝热烈祝贺智阳网络技术（上海）有限公司！ </div>
<article data-am-widget="paragraph" class="am-paragraph am-paragraph-default"
data-am-paragraph="{ tableScrollable: true, pureview: true }">
  <p align="center"><img src="${ctx}/static/assets/images/gzbimg.jpg" width="100%"></p>
  <p class=paragraph-default-p>${news.content}</p>
</article>
<div class="am-paragraph-default pages_link">
  <p><span class="am-text-primary">【上一篇】</span> <a href="">热烈祝贺智阳网络技术（上海）有限...</a></p>
  <p><span class="am-text-primary">【下一篇】</span> <a href="">智阳网络技术有限公司发行工资宝</a></p>
</div>


<es:webAppNewFooter/>
<!--在这里编写你的代码-->


</body>
</html>

