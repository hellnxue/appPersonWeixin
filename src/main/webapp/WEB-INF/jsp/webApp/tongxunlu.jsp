<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="${appName}" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">通讯录</h1>
  <div class="am-titlebar-right"><!-- <a title="" class="select_ico"><em class="tongxunlu-ico"></em></a> --></div>
</header>
<div class="select_list none">
          <ul class="tab tab_menu">
            <li class="cur">按部门</li>
            <li>按职位</li>
          </ul>
          <div class="cont tab_cont_view">
            <div>
              <ul class="menu-list-item">
                <li class="subli">
                	<a>分公司</a>
                    <ul class="gsidlist">
                        <li data-gsid="5"><a>研发部</a></li>
                        <li data-gsid="5"><a>研发部</a></li>
                        <li data-gsid="5"><a>研发部</a></li>
                    </ul>
                </li>
                <li class="subli">
                	<a>分公司</a>
                <ul class="gsidlist">
                	<li data-gsid="5"><a>研发部</a></li>
                    <li data-gsid="5"><a>研发部</a></li>
                    <li data-gsid="5"><a>研发部</a></li>
                </ul>
                </li>
                <li data-gsid="5"><a>研发部</a></li>
                <li data-gsid="5"><a>研发部</a></li>
              </ul>
            </div>
            <div class="none">
              <ul class="menu-list-item">
                <li class="subli">
                	<a>按职位</a>
                    <ul class="gsidlist">
                        <li data-gsid="5"><a>研发部</a></li>
                        <li data-gsid="5"><a>研发部</a></li>
                        <li data-gsid="5"><a>研发部</a></li>
                    </ul>
                </li>
                <li class="subli">
                	<a>分公司</a>
                <ul class="gsidlist">
                	<li data-gsid="5"><a>研发部</a></li>
                    <li data-gsid="5"><a>研发部</a></li>
                    <li data-gsid="5"><a>研发部</a></li>
                </ul>
                </li>
                <li data-gsid="5"><a>研发部</a></li>
                <li data-gsid="5"><a>研发部</a></li>
              </ul>
            </div>
          </div>
          <div class="btns"><a class="am-btn am-btn-secondary am-radius">重置</a> <a class="am-btn am-btn-primary am-radius">确定</a></div>
        </div>
        <div class="page-header am-cf">
        <div class="am-g" data-posturl="sosuo.html">
          <div class="search-main">
          <div class="search_ico"><input type="text" id="searchkeyword" class="search-keyword" placeholder="搜索" value="" onkeyup="handle(this)"><a class="clearico"></a>
          </div>
           <a class="page-back none">取消</a></div>
         </div>
      </div>
<div class="city_list"> 
  <div class="city-wrapper" id="clist">
   <!--  <h3 class="cityhli city-key-A">A</h3>
    <ul id="A">
    </ul>
    <h3 class="cityhli city-key-B">B</h3>
    <ul id="B">
     
    </ul>
    <h3 class="cityhli city-key-C">C</h3>
    <ul id="C">
      
    </ul>
    <h3 class="cityhli city-key-D">D</h3>
    <ul id="D">
      
    </ul>
    <h3 class="cityhli city-key-E">E</h3>
    <ul id="E">
      
    </ul>
    <h3 class="cityhli city-key-F">F</h3>
    <ul id="F">
     
    </ul>
    <h3 class="cityhli city-key-G">G</h3>
    <ul id="G">
      
    </ul>
    <h3 class="cityhli city-key-H">H</h3>
    <ul id="H">
      
    </ul>
    <h3 class="cityhli city-key-J">J</h3>
    <ul id="J">
      
    </ul>
    <h3 class="cityhli city-key-K">K</h3>
    <ul id="K">
     
    </ul>
    <h3 class="cityhli city-key-L">L</h3>
    <ul id="L">
      
    </ul>
    <h3 class="cityhli city-key-M">M</h3>
    <ul id="M">
     
    </ul>
    <h3 class="cityhli city-key-N">N</h3>
    <ul id="N">
     
    </ul>
	 <h3 class="cityhli city-key-O">O</h3>
    <ul id="O">
     
    </ul>
    <h3 class="cityhli city-key-P">P</h3>
    <ul id="P">
     
    </ul>
    <h3 class="cityhli city-key-Q">Q</h3>
    <ul id="Q">
      
    </ul>
    <h3 class="cityhli city-key-R">R</h3>
    <ul id="R">
      
    </ul>
    <h3 class="cityhli city-key-S">S</h3>
    <ul id="S">
      
    </ul>
    <h3 class="cityhli city-key-T">T</h3>
    <ul id="T">
      
    </ul>
	 <h3 class="cityhli city-key-U">U</h3>
    <ul id="U">
      
    </ul>
	 <h3 class="cityhli city-key-V">V</h3>
    <ul id="V">
      
    </ul>
    <h3 class="cityhli city-key-W">W</h3>
    <ul id="W">
      
    </ul>
    <h3 class="cityhli city-key-X">X</h3>
    <ul id="X">
      
    </ul>
    <h3 class="cityhli city-key-Y">Y</h3>
    <ul id="Y">
      
    </ul>
    <h3 class="cityhli city-key-Z">Z</h3>
    <ul id="Z">
    </ul> -->
  </div>
  <ul class="city-nav phonenav" id="clistByKey">
  <li data-key="A">A</li><li data-key="B">B</li><li data-key="C">C</li><li data-key="D">D</li><li data-key="E">E</li><li data-key="F">F</li><li data-key="G">G</li><li data-key="H">H</li><li data-key="J">J</li><li data-key="K">K</li><li data-key="L">L</li><li data-key="M">M</li><li data-key="N">N</li><li data-key="P">P</li><li data-key="Q">Q</li><li data-key="R">R</li><li data-key="S">S</li><li data-key="T">T</li><li data-key="W">W</li><li data-key="X">X</li><li data-key="Y">Y</li><li><a href="#Z">Z</a></li>
  </ul>
</div>
<!-- 用户详细信息 -->
<form action="${ctx }/webApp/tongxunluDetail" method="post" id="form2">
  <input type="hidden" name="tusername" id="tusername">
  <input type="hidden" name="tdept" id="tdept">
  <input type="hidden" name="tposition" id="tposition">
  <input type="hidden" name="tmobile" id="tmobile">
  <input type="hidden" name="tphone" id="tphone">
  <input type="hidden" name="temail" id="temail">
</form>
<es:webAppNewFooter/>
<script src="${ctx}/static/assets/js/pin.js"></script> 
<script>
 var zimuArray=[ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',  
	             'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'  
	              ]; 
	              
  var tempObject=null;
  
  //存放读取的名字数组
 // var nameArray=null;
  
$(function() {

	  //点击取消
	   $(".page-back").click(function(){
			$(".page-back").hide();
			$("#searchkeyword").parent().removeClass("cur");
			  console.log(tempObject);
			if(tempObject){
				console.log("可以查询了");
				showTongxunlu(tempObject);
			}
			
		});
  
           /**
		   	 调用通讯录接口
		  **/
		   $.getJSON("${ctx}/hrhelper-platform/contantList", function (data1) {
		         
		        if(data1.errorMessage!==undefined){
	              console.log("错误消息=="+data.errorMessage);
	              return;
	             }
		         tempObject=data1;
		         showTongxunlu(data1);
		         
		        });
           
		  
});
//点击选项时的样式,显示通讯录详情
function updateClass(index,name,dept,position,mobile,phone,email){
	
	//蓝色勾样式
	//$('.city-wrapper ul li').removeAttr('class');
	//$('[data-id='+index+']').prop('class','cur');
	
	if(name!=="undefined"){
		$("#tusername").val(name);
	}
	if(dept!=="undefined"){
		$("#tdept").val(dept);
	}
	if(position!=="undefined"){
		$("#tposition").val(position);
	}
	if(mobile!=="undefined"){
		$("#tmobile").val(mobile);
	}
	if(phone!=="undefined"){
		$("#tphone").val(phone);
	}
	if(email!=="undefined"){
		$("#temail").val(email);
	}

	$("#form2").submit();
}

//加载所有通讯录数据

	function showTongxunlu(data1) {
		//nameArray=new Array();
		var resultHtml = "";
		//var dataKey="";
		for (var j = 0; j < zimuArray.length; j++) {
			var zimu = zimuArray[j];
			var reclen = data1.rec.length;
			var rec = data1.rec;

			for (var i = 0; i < reclen; i++) {

				if (zimu == rec[i].key) {

					var len = rec[i].value.length;
					var result = rec[i].value;
					var h3 = '<h3 class="cityhli city-key-'+zimu+'">' + zimu
							+ '</h3>';
					// dataKey+='<li data-key="'+zimu+'">'+zimu+'</li>';
					var liRestlut = "";
					for (var x = 0; x < len; x++) {

						//$("#"+zimu).append("<li onClick='updateClass("+result[x].USER_ID+")' data-name="+result[x].CNAME+"  data-id="+result[x].USER_ID+">"+result[x].CNAME+"</li>");
						liRestlut += '<li onClick="updateClass('
							   +"\'" + result[x].USER_ID +"\'" + ','+"\'"+result[x].CNAME+"\'"+','+"\'"+result[x].DEPT_NAME+"\'"+','+"\'"+result[x].position+"\'"+','+"\'"
							   +result[x].mobile+"\'"+','+"\'"+result[x].phone+"\'"+','+"\'"+result[x].email+"\'"+')" data-name='
								+ result[x].CNAME + '  data-id='
								+ result[x].USER_ID + '>' +'<a href='+result[x].CNAME+'>'+ result[x].CNAME+'</a>'
								+ '</li>';
						//nameArray.push(result[x].CNAME);
					}
					resultHtml += h3 + "<ul>" + liRestlut + "</ul>";
				}
			}

		}
		$("#clist").html(resultHtml);
		//$("#clistByKey").html(dataKey);

	}

	//单个字母处理
	function handlezimu1(which1) {
		
		var inputVal = which1;
		console.log("inputValinputValinputValinputValinputValinputValinputVal==="+inputVal);
		//根据输入的单个个字母查找与之匹配的首字母的数据
		//cases: 
		//for (var j = 0; j < zimuArray.length; j++) {
		//	var zimu = zimuArray[j];
			var reclen = tempObject.rec.length;
			var rec = tempObject.rec;

			for (var i = 0; i < reclen; i++) {
				
				//if (zimu == rec[i].key) {
					
					var len = rec[i].value.length;
					var result = rec[i].value;
					
					if (rec[i].key === inputVal.toUpperCase()) {
						
						$("#clist").html("");//清空
						var tempHtml = "";
						
						for (var x = 0; x < len; x++) {
							var name = result[x].CNAME;
							var first = name.substring(0, 1);
							var end = name.substring(1);
							var hfe = '<span style="color:#00FF00">' + first
									+ '</span>' + end;
							tempHtml += '<li onClick="updateClass('
								 +"\'" + result[x].USER_ID +"\'" + ','+"\'"+result[x].CNAME+"\'"+','+"\'"+result[x].DEPT_NAME+"\'"+','+"\'"+result[x].position+"\'"+','
								 +"\'"+result[x].mobile+"\'"+','+"\'"+result[x].phone+"\'"+','+"\'"+result[x].email+"\'"+ ')" data-name='
									+ result[x].CNAME + '  data-id='
									+ result[x].USER_ID + '>' + hfe + '</li>';
						}
						$("#clist").html('<ul>' + tempHtml + '</ul>');
						//break cases;
						break;
					}

				//}
			}

		//}
	}
	
	//输入多个字母时处理
	function handlezimu2(which2, zh) {

		var inputVal = which2;//输入的值
		if (zh === "dzm") {
			inputVal = which2.toUpperCase();//输入的值为字母时转成大写
		}
		 
		$("#clist").html("");//清空
		var tempHtml = "";
		var reclen = tempObject.rec.length;
		var rec = tempObject.rec;

		for (var i = 0; i < reclen; i++) {

			var len = rec[i].value.length;
			var result = rec[i].value;

			for (var x = 0; x < len; x++) {

				var tempName = result[x].CNAME;//真实姓名

				var singleGroup = tempName;
				if (zh === "dzm") {
					singleGroup = subName(tempName);//姓名首字母组合
				}
				var pinyinTempName = codefans_net_CC2PY(tempName).toUpperCase();//姓名转成全拼

				//根据nameArray中的每个名字为字母或汉字的不同，处理不同
				if (checkIsZimu(tempName)) {
					//如果nameArray中的名字为英文(包括英文中间带空格的)，不需要转拼音
					pinyinTempName = tempName.toUpperCase();
					//果nameArray中的名字为英文(包括英文中间带空格的)，不需要转成单个汉字的首字母组合
					singleGroup = "nosingleGroup";
				}

				//按单个汉字的拼音匹配 liuxue 匹配 刘雪     (pinyinTempName).indexOf(inputVal)!=-1
				if (zh === "dzm" && replaceIndexof(pinyinTempName, inputVal)) {
					var colorName = quanpin(inputVal, tempName);
					if (colorName !== undefined) {
						var end = "";
						if (colorName !== tempName) {
							end = tempName.substring(colorName.length);
						}
						var hfe = '<span style="color:#00FF00">' + colorName
								+ '</span>' + end;
						tempHtml += '<li onClick="updateClass('  + x  + ','+"'"+result[x].CNAME+"'"+','+"'"
								+result[x].DEPT_NAME+"'"+','+"'"+result[x].position+"'"+','+"'"+result[x].mobile+"'"+','+"'"+result[x].phone+"'"
								+','+"'"+result[x].email+"'"+')"  data-name=' + tempName + '  data-id=' + x
								+ '>' + hfe + '</li>';
					}

				}

				//按照汉字或者汉字拼音的首字母   singleGroup.indexOf(inputVal) != -1    replaceIndexof(singleGroup,inputVal)
				if (singleGroup !== "nosingleGroup"&& replaceIndexof(singleGroup, inputVal)) {
					var first = tempName.substr(0, inputVal.length);
					var end = tempName.substring(first.length);
					var hfe = '<span style="color:#00FF00">' + first
							+ '</span>' + end;
					tempHtml += '<li onClick="updateClass('+x + ','+"'"+result[x].CNAME+"'"+','+"'"+result[x].DEPT_NAME
							+"'"+','+"'"+result[x].position+"'"+','+"'"+result[x].mobile+"'"+','+"'"+result[x].phone+"'"+','+"'"
							+result[x].email+"'"+ ')" data-name=' + tempName + '  data-id=' + x
							+ '>' + hfe + '</li>';

				}
			}

		}

		$("#clist").html('<ul>' + tempHtml + '</ul>');

	}

	/**
	 处理模糊查询
	 **/
	function handle(which) {
		
		//取消按钮与搜索框的样式控制
		if(which.value!=""){
			$(".page-back").show();
			$("#searchkeyword").parent().addClass("cur");
		}else{
			$(".page-back").hide();
			$("#searchkeyword").parent().removeClass("cur");
		}
	
		
		if ($.trim(which.value) !== "") {//输入值为不为空的情况
			//判断字母or汉字
			var isZ = checkIsZimu(which.value);//字母
			var isC = checkIsChinese(which.value);//汉字
			var inputVal = which.value;//输入值
			var wlength = inputVal.length;//输入值的长度

			//处理输入字母的情况

			if (isZ && wlength > 0) {
				//console.log("输入的是字母====================");
				if ( wlength == 1) {
					//console.log("单个字母");
					handlezimu1(inputVal);
				}
				if ( wlength > 1) {
					//console.log("多个字母");
					handlezimu2(inputVal, "dzm");
				}

			}

			//处理输入汉字的情况
			if (isC && wlength > 0) {
				//console.log("输入的是汉字====================");
				handlezimu2(inputVal, "ll");
			}

		} else {//显示全部数据
			showTongxunlu(tempObject);

		}

	}
	/**
	    正则 判断是否是汉字
	 **/
	function checkIsChinese(str) {
		//如果值为空，通过校验
		if (str == "") {
			return false;
		}
		var pattern = /^([\u4E00-\u9FA5]|[\uFE30-\uFFA0])*$/gi;
		if (pattern.test(str)) {
			return true;
		} else {
			return false;
		}

	}
	/**
	      正则 判断是否是字母
	 **/
	function checkIsZimu(str) {
		//如果值为空，通过校验
		if (str === " " || str === "") {
			return false;
		}
		var pattern = /^[a-zA-Z ]*$/gi;
		if (pattern.test(str)) {
			return true;
		} else {
			return false;
		}

	}
	//循环截取单个字符，并转换成拼音格式的,返回姓名的单个汉字的拼音的首字母的字符串
	function subName(name) {
		var zmArray = "";
		var nl = name.length;
		if (nl > 0) {
			for (var i = 0; i < nl; i++) {
				var tempName = name.substr(i, 1);
				var tempSingle = codefans_net_CC2PY(tempName).toUpperCase();
				zmArray += tempSingle.substr(0, 1);
			}
			return zmArray;
		}
	}
	//输入全拼拼音时顺序匹配 liuxue  匹配 刘雪
	function quanpin(inputVal, tempName) {
		var tempNameLength = tempName.length;
		
		//根据真实名字是英文还是中文判断操作方法，英文直接截取，中文需要根据单个汉字逐个循环后拼成的拼音全拼操作
		if(checkIsZimu(tempName)){
		    var rname=tempName.substring(0,inputVal.length);
			return rname;
		}
		
		
		for (var i = 0; i < tempNameLength; i++) {
			var subSingleName = tempName.substr(0, i + 1);
			if (codefans_net_CC2PY(subSingleName).toUpperCase() === inputVal) {
				var resultName = subSingleName;
				break;
			}
		}
		return resultName;
	}

	//indexOf匹配后重叠字符会出错，替代方法如下
	function replaceIndexof(tempName, inputVal) {

		var c = tempName.substr(0, inputVal.length);

		if (inputVal === c) {
			return true;
		}
		return false;
	}
</script> 
</body>
</html>