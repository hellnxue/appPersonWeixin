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
<div class="am-vertical-align" style="height: 100%;">
    <div class="am-container workstation am-vertical-align-middle ">
        <ul class="am-avg-sm-1 am-avg-md-1 am-avg-lg-1  am-text-center">
        <li >
                <table>
                    <tr>
                        <td><img src="${ctx}/static/images/desktop-button1.png" alt="社保公积金查询"/></td>
                        <td class="nationGuard customContainer">
                            <a href="javascript:nationGuard();">
                           社保公积金查询
                                </a>
                        </td>
                    </tr>
                </table>
        </li>
        <li >

                <table>
                    <tr>
                        <td class="salary customContainer">
                            <a href="javascript:salary();">
                            工资单查询
                                </a>
                        </td>
                        <td><img src="${ctx}/static/images/desktop-button2.png" alt="工资单查询"/></td>
                    </tr>
                </table>
        </li>
            <li >

                <table>
                    <tr>
                        <td><img src="${ctx}/static/images/desktop-button3.png" alt="基金理财"/></td>
                        <td class="money customContainer">
                               基金理财
                        </td>

                    </tr>
                </table>
            </li>
          <%--  <li class="more">
                <div>更多功能建设中……</div>
            </li>--%>
    </ul>
</div>
    </div>
<es:foot/>
<es:contentFooter/>
<script type="text/javascript">
    function nationGuard(){
        window.location.href = "${ctx}/nationalGuard?cardId=${cardId}&month=" + getMonth();
    }
    function salary(){
        window.location.href = "${ctx}/salary?cardId=${cardId}&month=" + getMonth();
    }
</script>