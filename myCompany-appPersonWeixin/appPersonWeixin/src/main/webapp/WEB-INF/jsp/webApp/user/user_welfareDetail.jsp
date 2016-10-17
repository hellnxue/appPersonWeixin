<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=750">
    <title>兑换详情</title>
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/normalize.css">
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/main.css">
    <script src="${ctx}/static/huifuli/js/hotcss.min.js"></script>
</head>
<body>
    <div class="header">
        兑换详情
        <a href="javascript:history.go(-1)" class="h_back"><i class="icon icon-backward"></i></a>
    </div>
    <div class="welfare-detail">
        <div class="address-info info-list" id="renyuanxinxi">
            
        </div>
        <div class="set-info">
            <div class="title">套餐信息</div>
            <div class="content info-list" id="taocanxinxi">
               
            </div>
        </div>
        <div class="prod-info">
            <div class="title">已选商品</div>
            <div class="list">
                <div class="items" id="productlist">
                    
                </div>
            </div>
        </div>
        <div class="bot-link" id="wuliu">
           
        </div>
    </div>
    <script src="${ctx}/static/huifuli/js/jquery.js"></script>
    <script src="${ctx}/static/huifuli/js/TouchSlide.1.1.js"></script>
    <script src="${ctx}/static/huifuli/js/main.js"></script>
    <script>
    var resultObj=${result};
    $(function() {
    	var obj=resultObj.obj;
    	var receiver=obj.receiver;
    	var address=obj.address;
    	var name=obj.name;
    	var code=obj.code;
    	var tip=obj.tip;
    	
    	var factory=obj.factory;
	 		for(var i=0;i<factory.length;i++){
	 			var products=factory[i].products;
	 			for(var j=0;j<products.length;j++){
	 				var pname=products[j].name;
	 				var pimage=products[j].image;
	 				var pprice=products[j].price;
	 				var pquantity=products[j].quantity;
	 				
	 				var productlist='<div class="item">'+
                        			'<div class="pic">'+
                    				'<img src="'+pimage+'" alt=""></div>'+
                					'<div class="info">'+
                    				'<span class="name">'+pname+'</span>'+
                    				'<span class="price">'+pprice+'</span>'+
                    				'<span class="amount">×'+pquantity+'</span></div></div>';
	 				$("#productlist").append(productlist);	
	 			}
	 		}
	 		var renyuanxinxi='<p><span class="fs30">'+receiver+'</span></p>'+
            				 '<p><i class="icon icon-locate"></i>'+address+'</p>';
            $("#renyuanxinxi").append(renyuanxinxi);	
            
            var taocanxinxi='<p><b>'+name+'</b></p>'+
                			'<p>卡号：'+code+'</p>'+
                			'<p>发货时间：'+tip+'</p>';	
            $("#taocanxinxi").append(taocanxinxi);
                			
	 		var orderSn=factory[0].order;
	 		 $("#wuliu").html('<a href="${ctx}/webApp/anon/user/user_trace?userName=${userName}&orderSn='+orderSn+'" class="red">查看物流信息</a>')
    });
    </script>
</body>
</html>