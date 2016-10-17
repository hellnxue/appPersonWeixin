<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewVIPHeader title="智阳科技" description="智阳网络技术" keywords="智阳网络技术"/>

<header class="am-header am-header-default am-no-layout ram-header" data-am-widget="header">
 <!--  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div> -->
  <h1 class="am-header-title ram-header-title">个人中心</h1>
  <div class="am-titlebar-right ram-titlebar-right"> <a  href="${ctx}/webApp/logout"> 退出登录 </a> </div>  
</header>

<div class="am-panel am-panel-default">
     <div class="am-panel-bd ram-panel-bd">
      <div class="img am-text-center "><img src="${ctx}/static/assets/images/verson1/head_de.png" id="headImg" class="am-img-thumbnail am-circle am-text-middle" width="70px"></div>
      <div class="am-text-center"><p id="loginName"></p><p></p></div>
	</div>     
</div>
<div data-am-widget="tabs" class="am-tabs am-tabs-d2 vip_cont_tab sp_list rsp_list">
   
  <div class="am-tabs-bd">
    <div data-tab-panel-0 class="am-tab-panel am-active">
      <div id="widget-list">
        <ul class="am-list m-widget-list ram-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
         
          <li><a data-rel="accordion" href="${ctx}/webApp/user/mobileSecurityCertify"><span class="am-fr">${handleMobile }</span><img alt="Accordion" src="${ctx}/static/huifuli/images/icon1.png" class="widget-icon3"> <span class="widget-name">绑定手机</span></a></li>
          <li><a data-rel="accordion" href="${ctx}/webApp/user/accountSecurityCertify"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/huifuli/images/icon2.png" class="widget-icon3"> <span class="widget-name">修改密码</span></a></li>
          <li><a data-rel="accordion" href="${ctx}/webApp/anon/user/user_card?idcard=${IdCardMW}&nickname=${nickname}&headimgurl=${headimgurl}"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/huifuli/images/icon3.png" class="widget-icon3"> <span class="widget-name">我的名片</span></a></li>
          <li><a data-rel="accordion" href="${ctx}/webApp/anon/user/user_welfare?userName=${loginName}"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/huifuli/images/icon4.png" class="widget-icon3"> <span class="widget-name">我的福利</span></a></li>
          <li><a data-rel="accordion" href="${huifuliUrl}/shop/wx/message/account.jhtml?userName=${loginName}"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/huifuli/images/icon5.png" class="widget-icon3"> <span class="widget-name">我的积分</span></a></li>
          <li><a data-rel="accordion" href="${ctx}/webApp/anon/user/user_order?userName=${loginName}"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/huifuli/images/icon6.png" class="widget-icon3"> <span class="widget-name">我的订单</span></a></li>
          <%--  <li><a data-rel="accordion" href="${ctx}/webApp/user/city"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/assets/images/zhzxmenu1.png" class="widget-icon" width="28"> <span class="widget-name">所在城市</span></a></li> --%>
          <%--  <li><a data-rel="accordion" href="${ctx}/webApp/user/emailSecurityCertify"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/assets/images/zhzxmenu3.png" class="widget-icon" width="28"> <span class="widget-name">邮箱</span></a></li> --%>
          <%--  <li><a data-rel="accordion" href="${ctx}/webApp/user/payment_password"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/assets/images/zhzxmenu5.png" class="widget-icon" width="28"> <span class="widget-name">支付密码</span></a></li> --%>
       	  <%-- <li><a data-rel="accordion" href="${ctx}/webApp/user/receiveAddress?param=onlyaddress"><span class="am-fr"></span><img alt="Accordion" src="${ctx}/static/assets/images/zhzxmenu5.png" class="widget-icon" width="28"> <span class="widget-name">收货地址</span></a></li> --%>
        </ul>
      </div>
    </div>
    <div data-tab-panel-1 class="am-tab-panel "> </div>
    <div data-tab-panel-2 class="am-tab-panel "> </div>
  </div>
<%--   <p align="center" style="padding:0 2rem;"><a class="am-btn am-btn-warning am-radius am-btn-block am-btn-lg" href="${ctx}/webApp/logout">退出当前账号</a></p> --%>
</div>


<%-- <es:webAppNewVIPFooter/> --%>
<es:webAppNewFooter/>
<script>
 $("ul li[data-rmk='user']").addClass("cur");
 var headImg="${headimgurl}";
 if(headImg){
	 $("#headImg").attr("src",headImg);
 }
 
 $(function(){
	 var idcard = '${IdCardMW}';
	 if(idcard){
		  getUserInfo(idcard);
		  var loginName = $("#loginName").html();
		  if(loginName==""){
			  var loginName = '${userName}';
			  $("#loginName").html(loginName);
		  }
	  }
	 else{
		 var name = '${userName}';
		 $("#loginName").html(name);
	 }
 });
//获取用户信息
 function getUserInfo(idcard){
	      $.getJSON("${ctx}/jabava/getUserInfoByCardId", {idcard: idcard }, function (jsonObj) {
			 if(jsonObj&&jsonObj.json){   
				 var uObj=jsonObj.json; 	 
					$("#loginName").html(uObj.userName);
			 }
		}) ;     
 }
</script>
</body>
</html>


