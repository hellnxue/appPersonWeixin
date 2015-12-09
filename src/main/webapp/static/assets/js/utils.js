	//根据时间的毫秒值处理时间获得年月日
	function getHandleDate(ms,flag) {
		var date = new Date(ms);
		var month = Number(date.getMonth() + 1) + "";
		if (month.length < 2) {
			month = "0" + month;
		}
		var day = Number(date.getDate()) + "";
		if (day.length < 2) {
			day = "0" + day;
		}
		if(flag==="yyyy-mm-dd"){
			var handleDate = date.getFullYear() + "-" + month + "-" + day;
		}else{
			 handleDate = date.getFullYear() + "年" + month + "月" + day+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
		}
		return handleDate;
	}