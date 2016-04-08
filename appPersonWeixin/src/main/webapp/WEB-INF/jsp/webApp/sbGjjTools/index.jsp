<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=700">
    <title>社保公积金查询页面</title>
    <link rel="stylesheet" href="${ctx }/static/sbGjjTools/css/main.css">
    <script src="${ctx }/static/sbGjjTools/lib/hotcss.min.js"></script>
  
<body class="index">
    <header><a href="javascript:history.go(-1);" style="font-size:110px"><b>&#139;</b></a>官方数据查询登录</header>
    <form action="" method="post"  >
        <dl>
            <dt>查询条件（必选）</dt>
            <dd>
                <span>&#155;</span>
                <label for="city">缴纳城市</label>
                <h2></h2>
                <select name="city" id="city">
                    <option value="shanghai" selected>上海</option>
                   <!--  <option value="beijing">北京</option>
                    <option value="guangzhou">广州</option>
                    <option value="shenzhen">深圳</option>
                    <option value="dalian">大连</option>
                    <option value="nanjing">南京</option>
                    <option value="chengdu">成都</option> -->
                </select>
            </dd>
            <dd>
                <span>&#155;</span>
                <label for="type">缴纳类型</label>
                <h2></h2>
                <select name="type" id="types">
                   
                    <option value="5" selected="selected">上海社保</option>
                   <!--  <option value="2">上海公积金</option> -->
                    
                   <!--  <option value="1" selected>上海医保</option>
                    <option value="3">北京公积金（国管）</option>
                    <option value="4">北京公积金（市管）</option> -->
                   
                </select>
            </dd>
           <!--  <dd data-type="name">
                <label for="name">用户名</label>
                <input type="text" name="name" id="name" maxlength="10">
            </dd> -->
            <dd data-type="idcard">
                <label for="idcard">身份证号</label>
                <input type="text" name="idcard" id="idcard" maxlength="18">
            </dd> 
            <dd>
                <label for="pwd">密码</label>
                <input type="password" name="pwd" id="pwd">
            </dd>
        </dl>
        <p id="tip">友情提醒：用户首次申请密码时，请携带本人有效身份证件前往就近的街镇社区事务受理服务中心或各区县社保分中心自助查询机进行设置和申请。</p>
        <input type="submit" value="查 询">
    </form>
    
<script src="${ctx }/static/sbGjjTools/lib/zepto.min.js"></script>
<script src="${ctx }/static/sbGjjTools/lib/layer/layer.min.js"></script>
<%-- <script src="${ctx}/static/assets/js/jquery.min.js"></script>  --%>
<script>
/* $(function(){
	
	$("form").on("submit",function(event){
		//console.log("kkkkkk");
		//event.preventDefault();
	});
}); */

function validateIdCard(idcard){
    if(idcard.length == 18){
        var idCardArr = idcard.split('');// 得到身份证数组
        if(isValidityBrithBy18IdCard(idcard) && isTrueValidateCodeBy18IdCard(idCardArr)){
            return true;
        }
        return false;
    }
    return false;
}
function isTrueValidateCodeBy18IdCard(idCardArr){
    var Wi = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1];//加权因子;
    var ValideCode = [1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2];//身份证验证位值，10代表X;
    var sum = 0;    //声明加权求和变量
    if(idCardArr[17].toLowerCase() == 'x'){
        idCardArr[17] = 10; //将最后位为x的验证码替换为10方便后续操作
    }
    for(var i = 0;i < 17;i++){
        sum += Wi[i] * idCardArr[i];    //加权求和
    }
    valCodePosition = sum % 11; //得到验证码所位置
    if(idCardArr[17] == ValideCode[valCodePosition]){
        return true;
    }
    return false;
}
function isValidityBrithBy18IdCard(idCard18){
    var year = idCard18.substring(6,10);
    var month = idCard18.substring(10,12);
    var day = idCard18.substring(12,14);
    var temp_date = new Date(year,parseFloat(month) - 1,parseFloat(day));
    //这里用getFullYear()获取年份，避免千年虫问题
    if(temp_date.getFullYear() != parseFloat(year) || temp_date.getMonth() != parseFloat(month) - 1 || temp_date.getDate() != parseFloat(day)){
        return false;
    }
    return true;   
}
function select($show, $select){
    $show.html($select.find('option:checked').text());
    $select.change(function(){
        $show.html($select.find('option:checked').text());
        var temp=$select.find("option:checked").val();
    	 switch(temp){
    	case "2":
    		$("#tip").html("友情提醒：用户首次登录时，请前往上海住房公积金网站注册账号，凭注册的账号密码信息即可通过“员工帮手”便捷查询上海个人社保公积金。");
    		$("form").attr("action","${ctx}/webApp/sbGjjTools/detail_paf");
    		$("[data-type='name']").show();
    		$("[data-type='idcard']").hide();
    		break;
    	case "5":
    		$("#tip").html("友情提醒：用户首次申请密码时，请携带本人有效身份证件前往就近的街镇社区事务受理服务中心或各区县社保分中心自助查询机进行设置和申请。");
    		$("form").attr("action","${ctx}/webApp/sbGjjTools/detail");
    		$("[data-type='name']").hide();
    		$("[data-type='idcard']").show();
    		break;
    	default:
    		$("form").attr("action","");
    	
    	}  
    });
}
Zepto(function(){
	
	//默认选中社保
	$("form").attr("action","${ctx}/webApp/sbGjjTools/detail");
	$("#tip").html("友情提醒：用户首次申请密码时，请携带本人有效身份证件前往就近的街镇社区事务受理服务中心或各区县社保分中心自助查询机进行设置和申请。");
	$("[data-type='name']").hide();
	
    var $selectShow = $('h2'),
        $select = $('select'),
        $form = $('form'),
        $submit = $('input[type=submit]');

    $.each($select, function(i){
        select($selectShow.eq(i), $select.eq(i));
    });

     $submit.tap(function(){
        var $idcard = $('#idcard'),
            idcard = $idcard.val(),
            nameRegexp = /^[\u4E00-\u9FA5\uF900-\uFA2D]{2,5}$/,
            $name = $('#name'),
            name = $name.val();

        /* if(!nameRegexp.test(name)){
            layer.open({
                className: 'msg',
                content: '请输入正确的姓名',
                btn: ['确 定']
            });
            $name.focus();
            return false;
        } */
         /* if(!validateIdCard(idcard)){
            layer.open({
                className: 'msg',
                content: '请输入正确的身份证号',
                btn: ['确 定']
            });
            $idcard.focus();
            return false;
        }  */
        //alert("ok");
        $form.submit();
    }); 
    
    	 
    	
});
</script>
</body>
</html>

