<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:contentHeader title="安全校验" description="智阳网络技术" keywords="智阳网络技术"/>
<c:if test="${!isWeChat}">
	<header class="demo-bar">
	<a href="/widgets/m" class="am-icon-home demo-icon-home"></a>
	<h1>安全校验</h1>
	</header>
</c:if>

<!--内容部分-->
    <div class="safety">
    <p><label>请输入138xxxx8888收到的验证码</label></p>
    <p><input type="text" name="info" class="input_yzm" placeholder="请输入短信验证码" /><button class="btn_yzm">获取验证码</button></p>
    <p><button class="btn_OK">完 成</button></p>
    </div>



<es:webAppFooter/>




