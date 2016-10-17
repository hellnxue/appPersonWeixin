<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=750">
    <title>福利套餐</title>
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/normalize.css">
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/main.css">
    <script src="${ctx}/static/huifuli/js/hotcss.min.js"></script>
</head>
<body>
    <div class="header">
        福利套餐
        <a href="javascript:history.go(-1)" class="h_back"><i class="icon icon-backward"></i></a>
    </div>
    <div class="set">
        <div class="top" id="taocan">
            
        </div>
        <div class="prod">
            <div class="items" id="products">
                
            </div>
        </div>
        <div class="cart">
            <p>已选择<span id="cur_amount">0</span>款商品，还可选择<span id="rest_amount"></span>款</p>
            <a href="" id="submit" class="submit">确 定</a>
        </div>
        <div id="rule" style="display:none;">
            <div class="rule">
                <div class="title">兑换规则</div>
                <div class="content">
                    <ul id="guize">
                    </ul>
                    <div class="bot-link">
                        <a href="" class="red close_rule">确定</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="${ctx}/static/huifuli/js/jquery.js"></script>
    <script src="${ctx}/static/huifuli/js/TouchSlide.1.1.js"></script>
    <script src="${ctx}/static/huifuli/js/layer/layer.js"></script>
    <script src="${ctx}/static/huifuli/js/main.js"></script>
    <script>
    	var resultObj=${result}; 
        var obj=resultObj.obj;
    	var desc=obj.desc;
    	var name=obj.name;
    	var price=obj.price;
    	var products=obj.products;
    	for(var i=0;i<products.length;i++){
    		var pimage=products[i].image;
    		var pname=products[i].name;
    		var pprice=products[i].price;
    		var pid=products[i].id;
    		var product='<a href="${ctx}/webApp/anon/user/user_setDetail?name='+pname+'&price='+pprice+'&image='+pimage+'&code=${code}&userName=${userName}&id='+pid+'" class="item" data-id="'+pid+'">'+
                		'<img src="'+pimage+'" alt="" class="pic">'+
            			'<p class="info">'+
                		'<span class="name">'+pname+'</span>'+
                		'<span class="price">'+pprice+'</span></p>'+
            			'<i class="tag"></i></a>';
    		$("#products").append(product);			
    	}
    	var taocan='<span class="name">'+name+'</span>'+
            		'<p class="notice">可任选以下任意<span id="amount"></span>款商品兑换</p>'+
            		'<span class="price">'+price+'</span>'+
            		'<a href="" id="view" class="view">查看规则</a>';
    	$("#taocan").append(taocan);    	
    	
    	var guize='<li>'+desc+'</li>';
    	$("#guize").append(guize);
    	
    	// 查看规则
        var rule = $('#rule').html();
        $('#taocan').on('click', '#view', function(e) {
            e.preventDefault();
            layer.open({
                content: rule,
                type: 1,
                shadeClose: false
            });
        });
        
        var amount =obj.exchangeNum;
        
        $('#submit').click(function(e) {
            e.preventDefault();
        	if( $('#cur_amount').text() == '0' ) {
        		alert('至少选择一件商品！');
        	}else if($('#cur_amount').text() != amount){
        		alert('请选择'+amount+'件商品才能提交！');
        	}else {
        		var list=[];
        		$('.on').each(function(){
        			var product=[];
        			product.push($(this).data('id'));
        			product.push($(this).children('.pic').attr('src'));
        			product.push($(this).find('.name').text());
        			product.push($(this).find('.price').text());
        			list.push(product);
        		});
        		var list = JSON.stringify(list);
                localStorage.list = list;
                
        		window.location = "${ctx}/webApp/anon/user/user_confirm?userName=${userName}&code=${code}&type=1&receiverId=-1";
        	}
        });
        
        
        if ( localStorage.arr ) {
            var str = localStorage.arr,
                arr = JSON.parse(str),
                len = arr.length;
            for ( var i=0; i<arr.length; i++ ) {
                $('.item[data-id=' + arr[i] + ']').addClass('on');
            }
            $('#cur_amount').text(len);
            $('#rest_amount').text( amount - Number(len) );
        } else {
            localStorage.arr = '[]';
            $('#cur_amount').text('0');
            $('#rest_amount').text(amount);
        }
        $(function() {
            $('#amount').text(amount);
            // 单个商品点击
            $('.item').click(function(e) {
                var id = $(this).data('id');
                e.preventDefault();
                if ( !$(this).is('.on') ) {
                    if( len<amount ) {
                        window.location = $(this).attr('href');
                    } else {
                        alert('您已经选择了' + amount + '件商品了，无法继续选择了，请取消后继续浏览！');
                    }
                } else {
                    $(this).removeClass('on');
                    for ( var i=0; i<arr.length; i++ ) {
                        if ( arr[i] == id ) {
                            arr.splice(i, 1);
                            str = JSON.stringify(arr);
                            localStorage.arr = str;
                        }
                    }
                    len = arr.length;
                    $('#cur_amount').text(len);
                    $('#rest_amount').text( amount - Number(len) );
                }
            });


            $(document).on('click', '.close_rule', function(e) {
                e.preventDefault();
                layer.closeAll();
            });
    });
    </script>
</body>
</html>