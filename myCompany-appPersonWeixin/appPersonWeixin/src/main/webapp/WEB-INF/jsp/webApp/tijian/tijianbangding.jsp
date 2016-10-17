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
<es:webAppNewFooter/>

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
			$.getJSON("${ctx}/hrhelper-platform/tjianActivate", {
				cardNum : cardNum,
				cardPwd : cardPwd,
				storeId : 114
			}, function(data) {
				alert(data.message);
				window.location.href="${ctx}/webApp/tijian/tijian";
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