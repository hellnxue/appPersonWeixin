<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewVIPHeader title="智阳科技" description="智阳网络技术" keywords="智阳网络技术"/>

<header class="am-header am-header-default am-no-layout vip-header" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title"></h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="vip_top am-g">
  <div class="img am-u-sm-3"><img src="${ctx }/static/assets/images/img1.jpg" class="am-img-thumbnail am-circle"></div>
  <div class="text am-u-sm-9">
    <h3><a>${userName}</a></h3>
   <!--  <p><span class="am-btn am-btn-warning am-round am-btn-xs">总金额：0元</span> <span class="am-btn am-btn-warning am-round am-btn-xs">积分：0分</span></p> -->
    <!-- <p><span class="am-btn am-btn-primary am-round am-btn-xs">其他：36000元</span> <span class="am-btn am-btn-primary am-round am-btn-xs">其他：36000分</span></p> -->
  </div>
</div>
<div data-am-widget="tabs" class="am-tabs am-tabs-d2 vip_cont_tab">
  <ul class="am-tabs-nav am-cf">
    <li class="am-active"> <a href="[data-tab-panel-0]"><i class="icon01"></i>账户中心</a> </li>
    <!-- <li class=""> <a href="[data-tab-panel-1]"><i class="icon02"></i>订单中心</a> </li> -->
    <li class=""> <a href="[data-tab-panel-2]"><i class="icon03"></i>建设中</a> </li>
  </ul>
  <div class="am-tabs-bd">
    <div data-tab-panel-0 class="am-tab-panel am-active">
      <div class="sp_list" id="widget-list">
        <ul class="am-list m-widget-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
         <%--  <li><a data-rel="accordion" href="${ctx}/webApp/user/city"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/assets/images/zhzxmenu1.png" class="widget-icon" width="28"> <span class="widget-name">所在城市</span></a></li> --%>
          <li><a data-rel="accordion" href="${ctx}/webApp/user/mobileSecurityCertify"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/assets/images/zhzxmenu2.png" class="widget-icon" width="28"> <span class="widget-name">手机号码</span></a></li>
          <li><a data-rel="accordion" href="${ctx}/webApp/user/emailSecurityCertify"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/assets/images/zhzxmenu3.png" class="widget-icon" width="28"> <span class="widget-name">邮箱</span></a></li>
          <li><a data-rel="accordion" href="${ctx}/webApp/user/accountSecurityCertify"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/assets/images/zhzxmenu4.png" class="widget-icon" width="28"> <span class="widget-name">用户密码</span></a></li>
          <%--  <li><a data-rel="accordion" href="${ctx}/webApp/user/payment_password"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/assets/images/zhzxmenu5.png" class="widget-icon" width="28"> <span class="widget-name">支付密码</span></a></li> --%>
       	  <li><a data-rel="accordion" href="${ctx}/webApp/user/receiveAddress?param=onlyaddress"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/assets/images/zhzxmenu5.png" class="widget-icon" width="28"> <span class="widget-name">收货地址</span></a></li>
        </ul>
      </div>
    </div>
    <div data-tab-panel-1 class="am-tab-panel "> </div>
    <div data-tab-panel-2 class="am-tab-panel "> </div>
  </div>
  <p align="center" style="padding:0 2rem;"><a class="am-btn am-btn-warning am-radius am-btn-block am-btn-lg" href="${ctx}/webApp/logout">退出当前账号</a></p>
</div>


<es:webAppNewVIPFooter/>

</body>
</html>


