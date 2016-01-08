function loadHtml(){
	//获取当前产品
	var type = GetQueryString("type");
	if( type != null ){
		//设置高亮并显示内容
		changeItem(type);
		//给产品绑定事件
		var itemObj = $("#div_items>.item_ul>.item_li");
		itemObj.bind("click",function(){
			changeItem($(this).index());
		});
	}
}

//切换显示产品内容
function changeItem(type){
	//移除高亮样式
	$("#div_items>.item_ul>.item_li").removeClass("item_li_cur");
	//给当前产品添加高亮样式
	$("#div_items>.item_ul>.item_li:eq("+type+")").addClass("item_li_cur");
	//隐藏所有的div
	$("#cont_items>.cont_item").css("display","none");
	//显示当前产品对应的div
	$("#cont_items>.cont_item:eq("+type+")").css("display","block");
	//动态设置高度
	var height = document.body.scrollHeight;
	window.parent.document.getElementById("contentFrame").style.height=(parseInt(height)+50)+"px";
}

//获取参数
function GetQueryString(name){
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)
     	return  unescape((r[2])); 
     return null;
}

function searchFun(val) {
	queryFun(val,0);
}

function loadMore(){
	//获取当前搜索关键词
	var keyword = $("#keyword").val();
	//获取当前页
	var pageNum = $("#pageNum").val();
	if( pageNum != null && pageNum != "" ){
		pageNum = parseInt(pageNum) + 1;
	}
	queryFun(keyword,pageNum);
}

function formatDate(val) {
	var day = new Date(val);
	var Year = 0;
	var Month = 0;
	var Day = 0;
	var Hour = 0;
	var Second = 0;
	var Day = 0;
	var CurrentDate = "";
	//初始化时间 
	Year = day.getFullYear();//ie火狐下都可以 
	Month = day.getMonth() + 1;
	Day = day.getDate();
	Hour = day.getHours();
	Minute = day.getMinutes();
	Second = day.getSeconds();
	CurrentDate += Year + "-";
	if (Month >= 10) {
		CurrentDate += Month + "-";
	} else {
		CurrentDate += "0" + Month + "-";
	}
	if (Day >= 10) {
		CurrentDate += Day;
	} else {
		CurrentDate += "0" + Day;
	}
	CurrentDate += " " + Hour + ":" + Minute + ":" + Second;
	return CurrentDate;
};