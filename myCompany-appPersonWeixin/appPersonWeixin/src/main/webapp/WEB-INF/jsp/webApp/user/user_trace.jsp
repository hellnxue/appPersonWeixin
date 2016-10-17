<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=750">
    <title>物流信息</title>
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/normalize.css">
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/main.css">
    <script src="${ctx}/static/huifuli/js/hotcss.min.js"></script>
</head>
<body>
    <div class="header">
        物流信息
        <a href="javascript:history.go(-1)" class="h_back"><i class="icon icon-backward"></i></a>
    </div>
    <div class="trace">
        <!--  div class="set-info info-list">
            <p><b>兑换福利套餐名称</b></p>
            <p>卡号：220284198413654987</p>
        </div-->
        <div id="slide" class="slide">
            <div class="bd">
                <div class="bd-inner">
                    <div class="box">
                        <div class="prod-info">
                            <div class="list">
                                <div class="items">
                                    <div class="item" id="product">
                                       
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="trace-info info-list" id="wuliu">
                            
                        </div>
                        <div class="trace-record">
                            <ul id="wuliuDetail">
                               
                            </ul>
                        </div>

                    </div>
                </div>
                <!--  div class="bd-inner">
                    <div class="box">bbb</div>
                </div>
                <div class="bd-inner">
                    <div class="box">ccc</div>
                </div-->
            </div>
            <div class="hd">
                <ul></ul>
            </div>
        </div>
    </div>
    <script src="${ctx}/static/huifuli/js/jquery.js"></script>
    <script src="${ctx}/static/huifuli/js/TouchSlide.1.1.js"></script>
    <script src="${ctx}/static/huifuli/js/main.js"></script>
    <script type="text/javascript">
    	TouchSlide({ 
      	  slideCell: '#slide',
       	 titCell: '.hd ul',
       	 autoPage: '<li></li>'
   		 });
        
        var resultObj=${result};
        $(function(){
        		var traceStatus=resultObj.obj.status;
        		if(traceStatus == "1"){
       	 		var obj=resultObj.obj.delivery;
       	 		var products=obj.products;
       	 		var corp=obj.corp;
       	 		var order=obj.order;
       	 		var trackingNO=obj.trackingNO;
       	 		var status=obj.status;
       	 		
       	 		var name=products[0].name;
       	 		var price=products[0].price;
       	 		var image=products[0].image;
       	 		var quantity=products[0].quantity;
       	 	
       	 			
       	 		var product='<div class="pic">'+
                    		'<img src="'+image+'" alt=""></div>'+
                			'<div class="info">'+
                    		'<span class="name">'+name+'</span>'+
                    		'<span class="price">'+price+'</span>'+
                   			'<span class="amount">'+quantity+'</span></div>';
                   			$("#product").append(product);		   			
       	 			
       	 		var wuliu='<p>订单号：'+order+'</p>'+
                   	 	  '<p>承运快递：'+corp+'</p>'+
                    	  '<p>运单号：'+trackingNO+'</p>'+
                    	  '<a href="${ctx}/webApp/anon/user/user_orderDetail?userName=${userName}&orderSn='+order+'" class="link"><i class="icon icon-forward"></i></a>';
                          $("#wuliu").append(wuliu);		
                
                if(status == 200){
                     var detail=obj.detail;
                     for(var i=0;i<detail.length;i++){
                    	 var time=detail[i].time;
                    	 var context=detail[i].context;
                    	 var wuliuDetail='<li><p>'+context+'</p>'+
                             			 '<p>'+time+'</p></li>';
                    	 $("#wuliuDetail").append(wuliuDetail);	    			 
                     }
                }else{
                	$("#wuliuDetail").append('<li><p>暂无物流信息</p>');	
                }
        		}else{
        			var tip=resultObj.obj.tip;
        			$(".box").html(tip);
        		}
        	 
         });
    </script>
</body>
</html>