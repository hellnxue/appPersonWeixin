<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="${news.title}" description="智阳网络技术" keywords="智阳网络技术"/>

<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">消息</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>

<div class="talk_main">
  <ul class="am-comments-list am-comments-list-flip">
    <li class="am-comment am-comment-primary"><a href="#link-to-user-home"><img height="48" width="48" class="am-comment-avatar" alt="" src="${companyLogo}"></a>
      <div class="am-comment-main">
        <div class="am-comment-bd white-bg">
          <p>${companynews.resultData.information_content}</p>
        </div>
      </div>
    </li>
    <li class="time_talk"><span class="radius" style="background:#dddddd ;color:#888 ;height:22px;padding:0 1rem;font-size:1.2rem;border-radius:2px">${companynews.resultData.startDate}~${companynews.resultData.finishDate}</span></li>

  </ul>
</div>
<es:webAppNewFooter/>
<!--在这里编写你的代码-->
<script>
$(function() {
	String.prototype.trim=function() {
	
	    return this.replace(/(^\s*)|(\s*$)/g,'');
	}
  var spanStr = $(".radius").html().trim();
  var j= spanStr.lastIndexOf(" ");
  var i= spanStr.indexOf(" ");
  var start = spanStr.substring(0,i);
  var end = spanStr.substring(20,j);
  var time = start+" ~ "+end;
  $(".radius").html(time);
});
</script> 
</body>
</html>

