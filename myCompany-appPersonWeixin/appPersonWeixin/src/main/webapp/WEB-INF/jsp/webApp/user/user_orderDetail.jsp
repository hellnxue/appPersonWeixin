<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=750">
    <title>我的订单</title>
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/normalize.css">
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/main.css">
    <script src="${ctx}/static/huifuli/js/hotcss.min.js"></script>
</head>
<body>
  <div class="header">
        订单详情
        <a href="" class="h_back"><i class="icon icon-backward"></i></a>
    </div>
    <div class="order-detail" id="orderDetail">
    </div>
    <script src="${ctx}/static/huifuli/js/jquery.js"></script>
    <script src="${ctx}/static/huifuli/js/TouchSlide.1.1.js"></script>
    <script src="${ctx}/static/huifuli/js/main.js"></script>
    <script>
    var resultObj=${result};
    //var resultObj2=${result2};
    $(function() {
    	var obj=resultObj.obj;
    	//var obj2=resultObj2.obj.delivery;
    	
    	var orderSn=obj.orderSn;
	 	var orderStatus=obj.orderStatus;
	 	var createDate=obj.createDate;
	 	var trackingNo=obj.trackingNO;
	 	var deliveryCorp=obj.deliveryCorp;
	 	var consignee=obj.consignee;
	 	var phone=obj.phone;
	 	var address=obj.address;
	 	var freight=obj.freight;
	 	var orderPrice=obj.orderPrice;
	 	var orderItems=obj.orderItems;
	 	var orderItem='<div class="prod-info info-list">';
	 	var orderStr="";
	 	if(deliveryCorp == undefined){
	 		deliveryCorp="";
	 	}
	 	if(trackingNo == undefined){
	 		trackingNo="";
	 	}
	 	var style=""
	 			if(orderStatus == 4){
	 			style="status";
	 			}else{
	 			style="status";
	 			}
	 			switch(orderStatus)
	 			{
	 			case "0":
	 			orderStr="已取消";
	 	 		 break;
	 			case 1:
	 			orderStr="待付款";
	 	 		 break;
	 			case 2:
	 			orderStr="待发货";
	 			break;
	 			case 3:
	 			orderStr="待收货";
	 			break;
				case 4:
				orderStr="交易成功";
		 		break;
	 			default:
	 			orderStr="";
	 			}
	 	var html='<div class="order-info info-list">'+
           		 '<p><b>订单号：'+orderSn+'</b></p>'+
            	'<p>'+createDate+'</p>'+
            	'<span class="'+style+'">'+orderStr+'</span></div>'+
        		'<div class="trace-info info-list">'+
           		' <p><b>运单号：'+trackingNo+'</b></p>'+
            	'<p>承运快递：'+deliveryCorp+'</p>'+
        		'<div class="address-info info-list">'+
            	'<p>收货人：'+consignee+'&nbsp'+phone+'</p>'+
            	'<p><i class="icon icon-locate"></i>'+address+'</p></div>';		
	 	for(var i=0;i<orderItems.length;i++){
	 		var  productSn=orderItems[i].productSn;
	 		var  name=orderItems[i].name;
	 		var  price=orderItems[i].price;
	 		 	 orderItem +='<p>商品编号：'+productSn+'</p>'+
	            		  '<p>商品名称：'+name+'</p>'+
	           			  '<p>商品价格：'+price+'</p></br>';
	 	}
	 	orderItem += '<p>运费：'+(freight/200)+'元</p><p>总计：'+orderPrice+'</p></div><div class="bot-link">'+
       		 	     '<a href="${ctx}/webApp/anon/user/user_trace?userName=${userName}&orderSn='+orderSn+'" class="red">查看物流信息</a></div>';
	 	html +=	orderItem;
	 	$("#orderDetail").html(html);
	 	
    });
    </script>
</body>
</html>