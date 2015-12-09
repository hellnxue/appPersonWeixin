<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:contentHeader title="工作台" description="智阳网络技术" keywords="智阳网络技术"/>
<c:if test="${!isWeChat}">
    <header class="am-topbar am-topbar-fixed-top am-header-default">
        <div class="am-container">
            <h1 class="am-topbar-brand">
                <a href="#">工作台</a>
            </h1>
        </div>
    </header>
</c:if>
<div class="am-container">
    <div class="am-panel am-panel-danger">
        <div class="am-panel-hd"><h3 class="am-panel-title">错误消息</h3></div>
        <div class="am-panel-bd">对不起，请先绑定身份证号再访问此页面。</div>
    </div>
</div>
<es:foot/>
<es:contentFooter/>
<script type="text/javascript">
    function onBridgeReady() {
        WeixinJSBridge.call('hideOptionMenu');
    }

    if (typeof WeixinJSBridge == "undefined") {
        if (document.addEventListener) {
            document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
        } else if (document.attachEvent) {
            document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
            document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
        }
    } else {
        onBridgeReady();
    }
    function closeWindow(){
        WeixinJSBridge.invoke('closeWindow', {}, function (res) {
        });
    }

</script>