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
    <li class="am-comment am-comment-primary"><a href="#link-to-user-home"><img height="48" width="48" class="am-comment-avatar" alt="" src="${ctx}/static/assets/images/img1.jpg"></a>
      <div class="am-comment-main">
        <div class="am-comment-bd white-bg">
          <p>${news.content}</p>
        </div>
      </div>
    </li>
    <li class="time_talk"><span class="am-radius">${news.sendTime}</span></li>

  </ul>
</div>
<div class="talk_word am-g">
  <form class="am-form-inline" role="form">
    <div class="am-form-group am-u-sm-9">
      <input onBlur="if(this.value==''){this.value='在这里输入文字';}" onFocus="if(this.value=='在这里输入文字'){this.value='';}" value="在这里输入文字" autocomplete="off" type="text" class="am-form-field am-input-sm" placeholder="电子邮件">
    </div>
    <div class="am-form-group">
      <button type="submit" class="am-btn am-btn-default am-u-sm-3 am-btn-sm">发送</button>
    </div>
  </form>
</div>


<es:webAppNewFooter/>
<!--在这里编写你的代码-->


</body>
</html>

