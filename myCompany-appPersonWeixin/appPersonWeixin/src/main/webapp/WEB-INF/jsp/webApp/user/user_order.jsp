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
        我的订单
        <a href="javascript:history.go(-1)" class="h_back"><i class="icon icon-backward"></i></a>
    </div>
    <div class="container" id="tab">
        <div class="panel-heading hd">
            <ul class="panel-nav">
                <li><a href="javascript://">全部</a></li>
                <li><a href="javascript://">待付款</a></li>
                <li><a href="javascript://">待发货</a></li>
                <li><a href="javascript://">待收货</a></li>
                <li><a href="javascript://">交易成功</a></li>
            </ul>
        </div>
        <div class="panel-body bd" id="tab-bd">
            <div class="panel-body-content">
                <ul class="li-m-b" id="allorder">
                </ul>
            </div>
            <div class="panel-body-content">
                <ul class="li-m-b" id="daifukuan">
                </ul>
            </div>
            <div class="panel-body-content">
                <ul class="li-m-b" id="daifahuo">
                </ul>
            </div>
            <div class="panel-body-content">
                <ul class="li-m-b" id="daishouhuo">
                </ul>
            </div>
             <div class="panel-body-content">
                <ul class="li-m-b" id="jiaoyichengong">
                </ul>
            </div>
        </div>
    </div>
    <script src="${ctx}/static/huifuli/js/jquery.js"></script>
    <script src="${ctx}/static/huifuli/js/TouchSlide.1.1.js"></script>
    <script src="${ctx}/static/huifuli/js/main.js"></script>
    <script type="text/javascript">
        TouchSlide({
            slideCell: '#tab',
            endFun: function(i) { //高度自适应
                var bd = document.getElementById('tab-bd');
                bd.parentNode.style.height = bd.children[i].children[0].offsetHeight + 'px';
                if ( i>0 ) {
                    bd.parentNode.style.transition = '200ms';
                }
            }
        });
        
        var resultObj=${result};
        $(function(){
       	 		var obj=resultObj.obj.orderList;
       	 		for(var i=0;i<obj.length;i++){
       	 			var orderStatus=obj[i].orderStatus;
       	 			var orderSn=obj[i].orderSn;
       	 			var orderItems=obj[i].orderItems;
       	 			var createDate=obj[i].createDate;//缺少
       	 			var orderPrice=obj[i].orderPrice;
       	 			var orderStr="";
       	 			var style="";
       	 			if(orderStatus == 4){
       	 			style="text-green fr";
       	 			}else{
       	 			style="text-red fr";
       	 			}
       	 			switch(orderStatus)
       	 			{
       	 			case "0":
       	 			orderStr="已取消";
       	 	 		 break;
       	 			case "1":
       	 			orderStr="待付款";
       	 	 		 break;
       	 			case "2":
       	 			orderStr="待发货";
      	 			break;
       	 			case "3":
       	 			orderStr="待收货";
     	 			break;
       				case "4":
       				orderStr="交易成功";
  	 		 		break;
       	 			default:
       	 			orderStr="";
       	 			}
       	 			var orderiten="";
       	 			for(var j=0;j<orderItems.length;j++){
       	 				orderiten +='<p class="clearfix"><span class="fl">'+orderItems[j].name+'</span>';
       	 				if(j == 0){
       	 				orderiten +='<span class="fr">'+orderPrice+'</span>';	
       	 				}
       	 				orderiten +='</p>';
       	 				var orderQuantity=orderItems[j].quantity;
       	 			}
       	 			var allhtml='<li class="p-40-30 bg-white border">'+
                    			'<div class="panel-body-content-top clearfix">'+
                                '<strong>订单号：'+orderSn+'</strong>'+
                                '<span class="'+style+'">'+orderStr+'</span></div>'+
                             	'<div class="panel-body-content-botton">'+
                             	 orderiten+
                                '<p class="clearfix text-grayer">'+createDate+'<span class="fr">X'+orderQuantity+'</span></p></div>'+
                             	'<a href="${ctx}/webApp/anon/user/user_orderDetail?userName=${userName}&orderSn='+orderSn+'"class="panel-body-content-link"></a></li>';
                             
                  	$("#allorder").append(allhtml);		
                  	switch(orderStatus)
       	 			{
       	 			case "1":
       	 			$("#daifukuan").append(allhtml);
       	 	 		 break;
       	 			case "2":
       	 			$("#daifahuo").append(allhtml);
      	 			break;
       	 			case "3":
       	 			$("#daishouhuo").append(allhtml);
     	 			break;
       				case "4":
       				$("#jiaoyichengong").append(allhtml);
  	 		 		break;
       	 			default:
       	 			
       	 			}
       	 		}
        	 
         });
    </script>
</body>
</html>