<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=750">
    <title>福利详情</title>
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/normalize.css">
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/main.css">
    <script src="${ctx}/static/huifuli/js/hotcss.min.js"></script>
</head>
<body>
    <div class="header">
        福利详情
        <a href="javascript:history.go(-1)" class="h_back"><i class="icon icon-backward"></i></a>
    </div>
    <div class="set-detail">
        <div class="pic">
            <img src="${image}" alt="">
        </div>
        <div class="info">
            <p class="name">${name}</p>
            <p class="price">${price}</p>
        </div>
        <div class="detail">
        </div>
        <div class="bot-link">
            <a href="javascript:history.go(-1)" id="l_back" class="gray">返 回</a>
            <a href="" id="l_confirm" class="red">兑 换</a>
        </div>
    </div>
    <script src="${ctx}/static/huifuli/js/jquery.js"></script>
    <script src="${ctx}/static/huifuli/js/TouchSlide.1.1.js"></script>
    <script src="${ctx}/static/huifuli/js/main.js"></script>
    <script>
    var pid = ${id},
        str = localStorage.arr,
        arr = JSON.parse(str);
    $(function() {
        $('#l_confirm').click(function(e) {
            e.preventDefault();
            arr.push(pid);
            str = JSON.stringify(arr);
            localStorage.arr = str;
            window.location = '${ctx}/webApp/anon/user/user_set?userName=${userName}&code=${code}';
        });
    });
    </script>
</body>
</html>