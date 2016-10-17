<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=750">
    <title>新增收货地址</title>
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/normalize.css">
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/main.css">
    <script src="${ctx}/static/huifuli/js/hotcss.min.js"></script>
</head>
<body>
    <div class="header">
        新增收货地址
        <a href="" class="h_back"><i class="icon icon-backward"></i></a>
    </div>
    <div class="address-create">
        <div class="form">
            <div class="group">
                <label class="label"><span class="l3">收货人</span></label>
                <div class="control">
                    <div class="text-control">
                        <input type="text" id="name" class="text" placeholder="请填写收货人姓名" value="">
                    </div>
                </div>
            </div>
            <div class="group">
                <label class="label"><span>联系电话</span></label>
                <div class="control">
                    <div class="text-control">
                        <input type="text" id="phone" class="text" placeholder="请认真填写方便快递联系" value="">
                    </div>
                </div>
            </div>
            <div class="group">
                <label class="label"><span>收货地址</span></label>
                <div class="control">
                    <div class="text-control">
                        <input type="text" id="address" class="text" placeholder="请填写详细地址以便收货" value="">
                    </div>
                </div>
            </div>
        </div>
        <div class="bot-link">
            <a href="javascript:history.go(-1)" class="gray">取 消</a>
            <a href="javascript:add()" class="red">提 交</a>
        </div>
    </div>
    <script src="${ctx}/static/huifuli/js/jquery.js"></script>
    <script src="${ctx}/static/huifuli/js/TouchSlide.1.1.js"></script>
    <script src="${ctx}/static/huifuli/js/main.js"></script>
    <script>
    function add() {
    	var name=$('#name').val();
    	var phone=$('#phone').val();
    	var address=$('#address').val();
    	window.location ="${ctx}/webApp/anon/user/user_addressCreate?userName=${userName}&name="+name+"&phone="+phone+"&address="+address+"&code=${code}";
    };
    </script>
</body>
</html>