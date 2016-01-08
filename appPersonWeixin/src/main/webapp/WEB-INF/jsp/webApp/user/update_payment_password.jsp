<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 修改支付密码 -->
<es:webAppNewHeader title="${appName}" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">支付密码</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="vip-center_form">
  <div class="input_list" id="widget-list">
    <ul class="am-list m-widget-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
      <li>
        <div class="lines"><span>
          <input class="am-form-field am-input-lg" type="number" placeholder="请输入原支付密码">
          </span></div>
      </li>
      <li>
        <div class="lines"><span>
          <input class="am-form-field am-input-lg" type="number" placeholder="请输入新支付密码">
          </span></div>
      </li>
      <li>
        <div class="lines"><span>
          <input class="am-form-field am-input-lg" type="number" placeholder="请再次输入新支付密码">
          </span></div>
      </li>
    </ul>
    <p align="center" style="padding:0 2rem;">
      <input type="submit" class="am-btn am-btn-primary am-radius am-btn-block am-btn-lg" value="确 定">
    </p>
  </div>
</div>
<es:webAppNewFooter/>
</body>
</html>