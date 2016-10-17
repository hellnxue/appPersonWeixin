var json = "";
var resultHtml = "";
$(function() {
	$("ul li[data-rmk='txl']").addClass("cur");
	// 点击取消
	$(".page-back").click(function() {
		$(".page-back").hide();
		$("#searchkeyword").parent().removeClass("cur");
		console.log(tempObject);
		if (tempObject) {
			console.log("可以查询了");
			showTongxunlu(tempObject);
		}

	});
	// 加载通讯录
	$.getJSON("/amaze/webApp/tree", function(data1) {

		if (data1.errorMessage !== undefined) {
			console.log("错误消息==" + data.errorMessage);
			return;
		}
		json = data1;

	});
});

/* 递归实现获取无级树数据并生成DOM结构 */
var str = "";
var forTree = function(o) {
	for (var i = 0; i < o.length; i++) {
		var urlstr = "";
		try {
			if (o[i]["children"] != null) {
				urlstr = "<div><span>" + o[i]["organizationName"]
						+ "</span><ul>";
			} else {
				var url = "/amaze/webApp/person?organizationId="
						+ o[i]["organizationId"];
				urlstr = "<div><a href=" + url + "><div class='org'>"
						+ o[i]["organizationName"] + "</div></a><ul>";
			}
			str += urlstr;
			if (o[i]["children"] != null) {
				forTree(o[i]["children"]);
			}
			str += "</ul></div>";
		} catch (e) {
		}
	}
	return str;
}
/* 添加无级树 */
document.getElementById("menuTree").innerHTML = forTree(json);
/* 树形菜单 */
var menuTree = function() {
	// 给有子对象的元素加[+-]
	$("#menuTree ul").each(function(index, element) {
		var ulContent = $(element).html();
		var spanContent = $(element).siblings("span").html();
		if (ulContent) {
			$(element).siblings("span").html("[+] " + spanContent)
		}
		$("#menuTree").find("div span").siblings("ul:eq(0)").show();
	});
	$("#menuTree").find("div span").click(function() {
		var ul = $(this).siblings("ul");
		var spanStr = $(this).html();
		var spanContent = spanStr.substr(3, spanStr.length);
		if (ul.find("div").html() != null) {
			if (ul.css("display") == "none") {
				ul.show(300);
				$(this).html("[-] " + spanContent);
			} else {
				ul.hide(300);
				$(this).html("[+] " + spanContent);
			}
		}
	})
}()

/* 展开 */
$("#btn_open").click(function() {
	$("#menuTree ul").show(300);
	curzt("-");
})
/* 收缩 */
$("#btn_close").click(function() {
	$("#menuTree ul").hide(300);
	curzt("+");
})
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
