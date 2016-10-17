<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=750">
    <title>我的福利</title>
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/normalize.css">
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/main.css">
    <script src="${ctx}/static/huifuli/js/hotcss.min.js"></script>
</head>
<body>
    <div class="header">
        我的福利
        <a href="javascript:history.go(-1)" class="h_back"><i class="icon icon-backward"></i></a>
    </div>
    <div id="slide" class="welfare">
        <div class="hd">
            <ul>
                <li>全部</li>
                <li>可用</li>
                <li>已使用</li>
                <li>已失效</li>
            </ul>
        </div>
        <div id="bd" class="bd">
            <div class="coupon">
                <div class="items" id="all">
                    
                </div>
            </div>
            <div class="coupon">
                <div class="items" id="keyong">
                    
                </div>
            </div>
            <div class="coupon">
                <div class="items" id="yishiyong">
                    
                </div>
            </div>
            <div class="coupon">
                <div class="items" id="yishixiao">
                    
                </div>
            </div>
        </div>
    </div>
    <script src="${ctx}/static/huifuli/js/jquery.js"></script>
    <script src="${ctx}/static/huifuli/js/TouchSlide.1.1.js"></script>
    <script src="${ctx}/static/huifuli/js/main.js"></script>
    <script>
    TouchSlide({ 
        slideCell: '#slide',
        endFun: function(i) {
            var bd = document.getElementById('bd');
            bd.parentNode.style.height = bd.children[i].children[0].offsetHeight + 'px';
            if( i > 0 ) {
                bd.parentNode.style.transition = '200ms';
            }
        }
    });
    var resultObj=${result};
    $(function() {
    	var coupons=resultObj.obj.coupons;
	 		for(var i=0;i<coupons.length;i++){
	 			var name=coupons[i].name;
	 			var price=coupons[i].price;
	 			var effectiveDate=coupons[i].effectiveDate;
	 			var image=coupons[i].image;
	 			var state=coupons[i].state;
	 			var code=coupons[i].code;
	 			var stateStr="";
	 			var btnStr="";
	 			var satestyle=""
	 			var btnstyle="";
	 			if(state == 0){
	 				btnstyle="btn btn1";
	 			}else{
	 				satestyle="name";
	 				btnstyle="btn btn2";
	 			}
	 			switch(state)
	 			{
	 			case "0":
	 				stateStr="可用";
	 				btnStr='<a href="javascript:duihuan(\''+code+'\')" class="'+btnstyle+'">兑 换</a></div>';
	 	 		 break;
	 			case "1":
	 				stateStr="已使用";
	 				btnStr='<a href="${ctx}/webApp/anon/user/user_welfareDetail?userName=${userName}&code='+code+'" class="'+btnstyle+'">详 情</a></div>';
	 	 		 break;
	 			case "2":
	 				stateStr="已过期";
	 			break;
	 			case "3":
	 				stateStr="不可用";
	 			break;
	 			default:
	 				stateStr="";
	 			}
	 			var allhtml='<div class="item item-valid">'+
            			'<div class="pic">'+
                        '<img src="'+image+'" alt=""></div>'+
                        ' <div class="info">'+
                     	'<p><b class="'+satestyle+'">'+name+'</b><span class="status">'+stateStr+'</span></p>'+
                     	'<p><span class="price">'+price+'</span></p>'+
                        '<p><span class="date">有效期至'+effectiveDate+'</span></p></div>'+btnStr;  
                        
                            
                            	
          	$("#all").append(allhtml);		
          	switch(state)
	 			{
	 			case "0":
	 			$("#keyong").append(allhtml);
	 	 		 break;
	 			case "1":
	 			$("#yishiyong").append(allhtml);
	 			break;
	 			case "2":
	 			$("#yishixiao").append(allhtml);
	 			break;
	 			case "3":
		 		$("#yishixiao").append(allhtml);
		 		break;
	 			default:
	 			
	 			}
	 		}
    });
    function duihuan(code){
    	localStorage.clear();
    	localStorage.arr = '[]';
    	window.location = "${ctx}/webApp/anon/user/user_set?userName=${userName}&code="+code;
    }
    </script>
</body>
</html>