<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf"%>
<es:contentHeader title="关于我们" description="智阳网络技术" keywords="智阳网络技术" />
<c:if test="${!isWeChat}">
<header class="am-topbar am-topbar-fixed-top am-header-default">
    <div class="am-container">
        <h1 class="am-topbar-brand">
            <a href="#">关于我们</a>
        </h1>

    </div>
</header>
</c:if>
<div class="about">
    <div class="am-g am-container">
        <div class="am-u-lg-12">
            <h2 class="about-title about-color">智阳网络技术(上海)有限公司</h2>

            <div class="am-g">

                <div class="am-u-lg-12 am-u-md-12 am-u-sm-12">

                    <p><a href="http://www.hrofirst.com" target="_blank">HROfirst</a>是面向HRO（人事代理、劳务派遣）服务提供商提供免费、在线运用的人力资源技术服务平台。平台界面直观、功能全面、管理高效，业务流程顺畅。<br/>
                        HROfirst采用当前最先进的技术，为HRO服务商提供了基于云计算技术，智能、易用的完整技术系统模块。系统涵盖委托方和受托方以及企业内部管理所需的销售管理、合同管理、订单管理、员工管理、社保公积金管理、薪酬管理、外部财务管理、数据统计和挖掘等全流程模块。<br/>
                        依托智阳平台，HRO服务商可与全国同行同行并行在线，合作机会时时有。平台还提供了服务商之间业务交互的功能模块；与excel表的强大对话能力、表与表实现秒级比对，帮助客服
                        与“表哥”与“表妹”说再见！</p>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="am-g am-container">
    <div class="am-u-lg-12 am-u-md-12 am-u-sm-12">

        <ul class="am-avg-sm-3 am-avg-md-6 am-thumbnails am-text-center am-container am-g-fixed ">
            <li>
                <a class="am-icon-map-marker    am-secondary am-icon-btn " data-title="地址"  href="${ctx}/aboutUs/address"></a>
            </li>
            <li>
                <a class="am-icon-mobile  am-warning am-icon-btn "  href="${ctx}/aboutUs/tel" data-title="电话"></a>
            </li>
            <li>
                <a class="am-icon-envelope  am-success am-icon-btn "  href="${ctx}/aboutUs/mail" data-title="邮件"></a>

            </li>
            <li>
                <a class="am-icon-phone  am-warning am-icon-btn "  href="${ctx}/aboutUs/phone"  data-title="400电话"></a>
            </li>
            <li>
                <a class="am-icon-qq am-danger am-icon-btn " data-title="QQ" href="${ctx}/aboutUs/qq"></a>
            </li>
            <li>
                <a class="am-icon-wechat am-secondary am-icon-btn " data-title="微信" href="${ctx}/aboutUs/weChat"></a>

            </li>
        </ul>
    </div>
    </div>
<es:foot/>
<es:contentFooter/>