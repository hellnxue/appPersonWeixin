<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf"%>
<!-- 设置密码 -->
<es:webAppNewHeader title="${appName}" description="智阳网络技术"
	keywords="智阳网络技术" />
<head>
<style type="text/css">
.menuTree {
	margin-left: -30px;
}

.menuTree div {
	padding-left: 30px;
}

.menuTree div ul {
	overflow: hidden;
	display: none;
	height: auto;
}

.org{
    height: 50px;
	line-height: 50px;
}

.menuTree span {
	display: block;
	height: 50px;
	line-height: 50px;
	padding-left: 5px;
	margin: 1px 0;
	cursor: pointer;
	border-bottom: 1px solid #CCC;
}

.menuTree span:hover {
	background-color: #e6e6e6;
	color: #cf0404;
}

.menuTree a {
	color: #333;
	text-decoration: none;
}

.menuTree a:hover {
	color: #06F;
}

.btn {
	height: 30px;
	margin-top: 10px;
	border-bottom: 1px solid #CCC;
}
</style>
</head>
<header class="am-header am-header-default am-no-layout"
	data-am-widget="header">
	<div class="am-titlebar-left">
		<a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a>
	</div>
	<h1 class="am-header-title">通讯录</h1>
	<div class="am-titlebar-right">
		<!-- <a title="" class="select_ico"><em class="tongxunlu-ico"></em></a> -->
	</div>
</header>

<div class="city_list">
	<div class="btn">
		<input name="" type="button" id="btn_open" value="全部展开" /> <input
			name="" type="button" id="btn_close" value="全部收缩" />
	</div>
	<div id="menuTree" class="menuTree"></div>

</div>
<es:webAppNewFooter />
<script src="${ctx}/static/assets/js/pin.js"></script>
<script>
    var resultdata="";
	$(function() {
		var json;
		var s="" ;
		$("ul li[data-rmk='txl']").addClass("cur");
		$.get("${ctx}/webApp/tree", function(result){
		json = JSON.parse(result); 
		var hash  = window.location.hash.slice(1);
  		
  		var strs= new Array(); //定义一数组 
  		strs=hash.split("-"); //字符分割 
		/*添加无级树*/
		$("#menuTree").html(forTree(json));
		//给有子对象的元素加[+-]
		
		
		
		$("#menuTree ul").each(function(index, element) {
			var ulContent = $(element).html();
			var spanContent = $(element).siblings("span").html();
			if (ulContent) {
				$(element).siblings("span").html("[+] " + spanContent);
				if(index==0){
				$("#menuTree ul:eq(0)").siblings("span").html("[-] " + spanContent);
				$("#menuTree").find("div span").siblings("ul:eq(0)").show();
				}
				for (i=0;i<strs.length ;i++ ) 
				{ 
				var id = "#"+strs[i];				
				$(id).show();
				} 
				if($(element).css("display") == "none"){
					$(element).siblings("span").html("[+] " + spanContent);
				}
				else{
					$(element).siblings("span").html("[-] " + spanContent);
				}
			}
			
		});
		/*树形菜单*/
		$("#menuTree").find("div span").click(function() {
			var ul = $(this).siblings("ul");
			var spanStr = $(this).html();
			var spanContent = spanStr.substr(3, spanStr.length);
			if (ul.find("div").html() != null) {
				if (ul.css("display") == "none") {
				    s += ul.attr("id")+"-";
				    resultdata = s;	
					ul.show(300);
					$(this).html("[-] " + spanContent);
				} else {
					s = resultdata.replace(resultdata , ul.attr("id"));
					ul.hide(300);
					$(this).html("[+] " + spanContent);
				}
			}
		})
		
		$(".s").click(function() {
			resultdata = resultdata + hash;
			document.location.replace(getFilterUrl(resultdata));
		})
		/*展开*/
		$("#btn_open").click(function() {
			$("#menuTree ul").show(300);
			curzt("-");
		})
		/*收缩*/
		$("#btn_close").click(function() {
			$("#menuTree ul").hide(300);
			curzt("+");
		})
			});

		//点击取消
		$(".page-back").click(function() {
			$(".page-back").hide();
			$("#searchkeyword").parent().removeClass("cur");
		});
	});
	/*递归实现获取无级树数据并生成DOM结构*/
	var str = "";
	
	function getFilterUrl(resultdata){
		  return document.location.protocol + '//' + document.location.host + document.location.pathname + document.location.search + '#' + resultdata;
	}
	
	//加载通讯录
    function forTree(json) {

		for (var i=0 ; i<json.length ; i++) {
			var urlstr = "";
			try {
				if (json[i].children != null&&json[i].children!="") {
					urlstr = "<div><span>" + json[i].organizationName + "</span><ul id="+json[i].organizationId+">";
				} else {
					var url = "${ctx}/webApp/person?organizationId="+json[i].organizationId;
					urlstr = "<div class = 's'><a class ='changurl' href="+ url +"><div class='org'>"
							+ json[i].organizationName + "</div></a><ul>";
							
				}
				str += urlstr;
				if (json[i].children != null) {
					forTree(json[i].children);
				}
				str += "</ul></div>";
			} catch (e) {
			}
		}
		return str;
	}
	
	function curzt(v) {
		$("#menuTree span").each(function(index, element) {
			var ul = $(this).siblings("ul");
			var spanStr = $(this).html();
			var spanContent = spanStr.substr(3, spanStr.length);
			if (ul.find("div").html() != null) {
				
				$(this).html("[" + v + "] " + spanContent);
			}
		});
	}
</script>
</body>
</html>