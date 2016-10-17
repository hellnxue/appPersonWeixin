<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=750">
    <title>填写福利信息</title>
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/normalize.css">
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/main.css">
    <script src="${ctx}/static/huifuli/js/hotcss.min.js"></script>
</head>
<body>
    <div class="header">
        填写福利信息
        <a href="javascript:history.go(-1)" class="h_back"><i class="icon icon-backward"></i></a>
    </div>
    <div class="confirm">
        <!-- 没有填过地址显示这个 -->
        <div class="address-new">
            <a href="${ctx}/webApp/anon/user/user_addAddressPath?userName=${userName}&code=${code}">
                <i class="icon icon-add"></i>添加收货地址
            </a>
        </div>
        <!-- 填过地址显示下面这个 -->
        <div class="address-info info-list" id="address">
            
        </div>
        <div class="prod-info">
            <div class="title">已选商品</div>
            <div class="list">
                <div class="items" id="product">
                    
                </div>
            </div>
        </div>
        <div class="bot-link">
            <a href="javascript:history.go(-1)" class="gray">上一步</a>
            <a href="javascript:add()" class="red">提 交</a>
        </div>
    </div>
    <script src="${ctx}/static/huifuli/js/jquery.js"></script>
    <script src="${ctx}/static/huifuli/js/TouchSlide.1.1.js"></script>
    <script src="${ctx}/static/huifuli/js/main.js"></script>
    <script>
    var resultObj=${result}; 
    var obj=resultObj.obj;
    var receiverId=${receiverId}; 
    var ids="";
    $(function() {
    	var  receivers=obj.receivers;
    	var index=0;
    	for(var i=0;i<receivers.length;i++){
    		var isDefault=receivers[i].isDefault;
    		if(receiverId !="-1"){
    			if(receiverId ==receivers[i].id){
    				index=i;
    			}
    		}else{
    			if(isDefault == 1){
        			index=i;
        		}
    		}
    	}
    	var consignee=receivers[index].consignee;
    	var phone=receivers[index].phone;
    	var address=receivers[index].address;
    	var id=receivers[index].id;
    	
    	$("#address").html('<p><span class="fs30" id="'+id+'">'+consignee+'&nbsp;'+phone+'</span></p>'+
    	        		   '<p><i class="icon icon-locate"></i>'+address+'</p>'+
    	        		   '<a href="${ctx}/webApp/anon/user/user_confirm?userName=${userName}&code=${code}&type=2&receiverId='+id+'" class="link"><i class="icon icon-forward"></i></a>');
    	
    	
    	var str = localStorage.list,
    		productList = JSON.parse(str);
    	for(var i=0;i<productList.length;i++){
    		var product=productList[i];
    		ids +=product[0]+","; 
    		var image=product[1];
    		var name=product[2];
    		var price=product[3];
    		
    		var html='<div class="item">'+
                	'<div class="pic">'+
            		'<img src="'+image+'" alt=""></div>'+
        			'<div class="info">'+
            		'<span class="name">'+name+'</span>'+
            		'<span class="price">'+price+'</span>'+
            		'<span class="amount">×1</span></div></div>';
            $('#product').append(html);		
    	}
    });
    
    function add() {
    	var products=ids.substring(0,ids.length-1);
    	var id=$('.fs30').attr('id');
    	localStorage.clear();
    	localStorage.arr = '[]';
    	window.location ="${ctx}/webApp/anon/user/user_addWelfare?userName=${userName}&code=${code}&products="+products+"&receiverId="+id;
    };
    </script>
</body>
</html>