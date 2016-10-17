<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=750">
    <title>选择收货地址</title>
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/normalize.css">
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/main.css">
    <script src="${ctx}/static/huifuli/js/hotcss.min.js"></script>
</head>
<body>
    <div class="header">
        选择收货地址
        <a href="javascript:history.go(-1)" class="h_back"><i class="icon icon-backward"></i></a>
    </div>
    <div class="address">
        <div class="default">
            <div class="address-info info-list" id="default">
            </div>
        </div>
        <div class="address-list">
            <div class="title">我的收货地址</div>
            <div class="items" id="list">
               
            </div>
        </div>
        <div class="bot-link">
            <a href="${ctx}/webApp/anon/user/user_addAddressPath?userName=${userName}&code=${code}" class="red"><i class="icon icon-add-white"></i>添加收货地址</a>
        </div>
    </div>
    <script src="${ctx}/static/huifuli/js/jquery.js"></script>
    <script src="${ctx}/static/huifuli/js/TouchSlide.1.1.js"></script>
    <script src="${ctx}/static/huifuli/js/main.js"></script>
    <script>
    var resultObj=${result}; 
    var obj=resultObj.obj;
    var receiverId=${receiverId}; 
    $(function() {
    	var  receivers=obj.receivers;
    	var index=0;
    	for(var i=0;i<receivers.length;i++){
    		var isDefault=receivers[i].isDefault;
    		if(isDefault == 1){
    			index=2;
    			$("#default").html('<p><span class="fs30" id="'+receivers[i].id+'">'+receivers[i].consignee+'&nbsp;'+ receivers[i].phone+'</span></p>'+
                				   '<p><i class="icon icon-locate"></i>'+receivers[i].address+'</p>'+
                				   '<a href="${ctx}/webApp/anon/user/user_confirm?userName=${userName}&code=${code}&type=1&receiverId='+receivers[i].id+'" class="link"><i class="icon icon-tick"></i></a>');
    		}else{
    			$("#list").append('<div class="item">'+
    								 '<div class="address-info info-list">'+
    								 '<p><span class="fs30" id="'+receivers[i].id+'">'+receivers[i].consignee+'&nbsp;'+ receivers[i].phone+'</span></p>'+
    								 '<p><i class="icon icon-locate"></i>'+receivers[i].address+'</p>'+
    								 ' <a href="${ctx}/webApp/anon/user/user_confirm?userName=${userName}&code=${code}&type=1&receiverId='+receivers[i].id+'" class="link"><i class="icon icon-tick-gray"></i></a></div></div>');
    		}
    		if(index == 0){
    			$("#default").html('<p><span class="fs30" id="'+receivers[0].id+'">'+receivers[0].consignee+'&nbsp;'+ receivers[0].phone+'</span></p>'+
     				   '<p><i class="icon icon-locate"></i>'+receivers[0].address+'</p>'+
     				   '<a href="${ctx}/webApp/anon/user/user_confirm?userName=${userName}&code=${code}&type=1&receiverId='+receivers[0].id+'" class="link"><i class="icon icon-tick"></i></a>')
    		}
    		
    	}
    });
    </script>
</body>
</html>