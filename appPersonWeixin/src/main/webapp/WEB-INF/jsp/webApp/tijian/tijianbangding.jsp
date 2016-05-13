<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">激活体检卡</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="vip-center_form m10">
  <div class="input_list" id="widget-list">
    <ul class="am-list m-widget-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
      <li class="address-choose">
      <!-- <span class="am-fr"><em class="am-icon-angle-right"></em></span><label>所在地区:</label><b class="address-view"><span>上海</span>   </b></span> -->
        <div class="lines"><span>
          <input class="am-form-field am-input-lg" type="text" placeholder="选择商户" id="address-view" >
          <input   type="text"   id="address-id" >
          </span></div>
      </li>
      <li>
        <div class="lines"><span>
          <input class="am-form-field am-input-lg" type="text" placeholder="请输入体检卡卡号" id="cardNum">
          </span></div>
      </li>
      <li>
        <div class="lines"><span>
          <input class="am-form-field am-input-lg" type="text" placeholder="请输入体检卡密码" id="cardPwd">
          </span></div>
      </li>
    </ul>
    <p align="center" style="padding:0 2rem;">
      <input type="submit" class="am-btn am-btn-primary am-radius am-btn-block am-btn-lg" value="确 定" id="confirm">
    </p>
  </div>
</div>
<div class="footer">
<div id="" class="am-navbar am-cf am-navbar-default am-no-layout" data-am-widget="navbar">
<!--[if (gte IE 9)|!(IE)]><!--> 
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/int.pageajax.js"></script>
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/int.dropListchoose.js"></script>
<ul class="am-navbar-nav am-cf am-avg-sm-5 fot_bg">
  <li class="footer01 cur"> <a href="${ctx}/webApp/index"> <span class="am-footer-ico"></span> <span class="am-navbar-label">首页</span></a></li>
  <li class="footer02"> <a href="${ctx}/webApp/empCheck"> <span class="am-footer-ico"></span> <span class="am-navbar-label">移动签到</span></a></li>
  <li class="footeradd"> <a> <span class="index-home-ico"><em></em></span></a></li>
  <li class="footer03"> <a href="${ctx}/webApp/msgs"> <span class="am-footer-ico"></span> <span class="am-navbar-label">消息</span></a></li>
  <li class="footer04"> <a href="${ctx}/webApp/user"> <span class="am-footer-ico"></span> <span class="am-navbar-label">我的</span></a></li>
</ul>
</div>
<div class="foot-home-over">
<div data-am-widget="slider" class="am-slider am-slider-default layer_list" data-am-slider='{&quot;animation&quot;:&quot;slide&quot;,&quot;slideshow&quot;:false}'>
  <ul style="margin-left:20px;">
    <li class="list01">
      <a href="${ctx}/webApp/tongxunlu"><dl class="icon01"><dt></dt><dd>通讯录</dd></dl></a>
    </li>
  </ul>
</div>
</div>
</div>

	<div class="am-modal am-modal-alert" tabindex="-1" id="my-alert">
	  <div class="am-modal-dialog">
	    <div class="am-modal-hd"></div>
	    <div class="am-modal-footer">
	      <span class="am-modal-btn" data-am-modal-confirm>确定</span>
	    </div>
	  </div>
	</div> 
<script>
$(function() {

	$("#confirm").on("click", function() {
			var cardNum = $("#cardNum").val();
			var cardPwd = $("#cardPwd").val();
			var storeId = $("#address-id").val();
			console.log(storeId);
			if(storeId==""){
				$("#my-alert").find(".am-modal-hd").html("请选择商户！");
				$("#my-alert").modal();
				return;
			}
			$.getJSON("${ctx}/hrhelper-platform/tjianActivate", {
				cardNum : cardNum,
				cardPwd : cardPwd,
				storeId : 114
			}, function(data) {
				/* $("#my-alert").find(".am-modal-hd").html(data.message);
				$("#my-alert").modal(); */
				console.log(data.message);
			});

		});

	});
</script> 
<div class="address-mask none"></div>
<div class="address_selected none">
	<div class="title">
    	 <span class="title-back address-choose-close"><i></i></span><span class="title-name">选择商户</span>
    </div>
    <div class="address_list">
    	<ul class="am-list am-list-static am-list-border static-province" data-url="assets/ajax/city-list.json">
            <li><a data-value="1">北京</a></li>
            <li><a data-value="2">上海</a></li>
            <li><a data-value="3">天津</a></li>
            <li><a data-value="4">重庆</a></li>
        </ul>
    </div>
</div>
</body>
</html>