<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:contentHeader title="关于我们" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-topbar am-topbar-fixed-top">
    <div class="am-container">
        <h1 class="am-topbar-brand">
            <a href="#">发送</a>
        </h1>

    </div>
</header>
<div class="about">
    <div class="am-g">${message}</div>
    <div class="am-g am-container">
        <form class="am-form" action="" method="post">
            <fieldset>
                <legend>发送</legend>

                <div class="am-form-group">
                    <label for="receiver">接受者</label>
                    <input type="text" class="" id="receiver" name="receiver" placeholder="接受者"
                           value="333232312143314">
                </div>

                <div class="am-form-group">
                    <label for="title">标题</label>
                    <input type="text" class="" name="title" id="title" placeholder="标题">
                </div>

                <div class="am-form-group">
                    <label for="type">类型</label>
                    <label class="am-radio-inline">
                        <input type="radio" id="type" value="PERSONAL" name="type" checked> 个人
                    </label>
                    <label class="am-radio-inline">
                        <input type="radio" name="type" value="PUBLIC"> 公共
                    </label>
                    <label class="am-radio-inline">
                        <input type="radio" name="type" value="THIRD"> 第三方
                    </label>
                </div>

                <div class="am-form-group">
                    <label for="content">内容</label>
                    <textarea class="" rows="5" name="content" id="content"></textarea>
                </div>

                <p>
                    <button type="submit" class="am-btn am-btn-default">提交</button>
                </p>
            </fieldset>
        </form>
    </div>
</div>
<footer class="footer am-topbar ">
    <div>
        <p> ©2014 e智阳. All right reserved. 沪ICP备14044489</p>
    </div>
</footer>
<es:contentFooter/>