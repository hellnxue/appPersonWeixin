<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>

<es:webAppNewLoginHeader title="登录" description="智阳网络技术" keywords="智阳网络技术"/>

<!--登录页面-->
<header class="am-header am-header-default am-no-layout vip-header" data-am-widget="header">
  <h1 class="am-header-title"></h1>
</header>

<div class="login_form">
   <h1 class="yglogo"><a></a></h1>
  <form action="" method="post">
    <div class="box_mk">
      <p class="inputmk upradius">
        <label class="inputuser yguser"></label>
        <span>
        <input type="text" class="logininput am-radius" name="username" id="username">
        </span></p>
      <p class="inputmk downradius">
        <label class="inputmm ygmm"></label>
        <span>
        <input type="password" class="logininput am-radius" name="password" id="password">
        </span></p>
        <c:if test="${errorMessage==2 }"><span style="color:red">没有该用户！</span></c:if>
        <c:if test="${errorMessage==3 }"><span style="color:red">密码输入错误，请重新输入！</span></c:if>
         <c:if test="${errorMessage==4 }"><span style="color:red">请重新输入用户名,密码！</span></c:if>
      <p class="loginbtn">
        <input type="submit" class="am-btn am-btn-danger am-btn-block am-btn-lg ygbtn" value="登录">
      </p>
      <div class="forget"><a href="${ctx }/webApp/anon/find_password" class="color3">忘记密码？</a></div>
      <div class="active_user">
      	<a  title="" href="${ctx}/webApp/anon/accountActivate"><em></em>激活账号</a>
      </div>
    </div>
  </form>
</div>
<es:webAppNewLoginFooter/>
</body>
</html>