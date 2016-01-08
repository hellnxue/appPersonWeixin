var sealClassId="CLSID:C1FB7513-9A44-4C64-B653-63C6965D7F4C";
var obj;
var i=0;
var x=0;
var y=0;

function SignSeal(x,y,visible,protect)
{
	var obj=document.createElement("object");
	obj.width=120;
	obj.height=120;
	document.body.appendChild(obj);
	obj.style.left=x+"px";
	obj.style.top=y+"px";
	obj.style.position="absolute";
	if (!visible)
		obj.style.display="none";
	obj.classid=sealClassId;
	if (obj.Authority==undefined)
		throw new Error(undefined,"你还没有安装百成电子印章客户端呢。");

	obj.Authority=1;
	obj.ScriptRatherThanFunction=false;
	obj.SealData.DataIdentity=protect;
	obj.OnGetProtectedData=getToSignValue;
	obj.DrawModeUnsign=8;
	obj.DrawMode=18;
	obj.SignSeal(true);
	if (obj.CurrentState==0)
	{
		obj.parentElement.removeChild(obj);
		return "";
	}
	return obj.SignedData;
}

function AddSeal()
{
	//创建一个Object对象(印章)
	obj=document.createElement("object");
	obj.width=158;
	obj.height=158;
	var mt=document.getElementById("name");
	mt.appendChild(obj);  //追加Object对象
	
	//Obj的初始位置
	obj.style.left=233+"px";
	obj.style.top=347+"px";
	
	obj.style.position="absolute";   //绝对位置
	obj.classid=sealClassId;
	obj.Authority=3;    //禁止移动
//	obj.OnGetProtectedData=OnGetProtectedData;  // 受保护的字段
	
	//印章的显示模式
	obj.DrawModeUnsign=8;
	obj.DrawMode=18;
	
	//触发签章或签名、批注的方法；为'true'时签章，否则为签名或批注。
	obj.SignSeal(true);
	
	if (obj.CurrentState==0||i>2)  //（CurrentState）的状态，0－尚未签章或签名；1－已经签章；2－已经签名。
	{
		obj.parentElement.removeChild(obj);
		if(i>2){
			alert(no);
		}
		return false;
	}
	
	//签章或签名的次数
	if(i==0){
		x=100;
		y=-60;
	}else if(i==1){
		x=440;
		y=225;
	}else if(i==2){
		x=730;
		y=225;
	}
	//印章的位置
	obj.style.left=x+"px";	
	obj.style.top=y+"px";	
	i++;
	
	//赋值
	document.getElementById("sealdata").value = obj.SignedData+";"+document.getElementById("sealdata").value;
	document.getElementById("position").value = x+"px,"+y+"px;"+document.getElementById("position").value;
	document.getElementById("number").value = i;
	document.getElementById("auto").value = "no";
	//alert(document.getElementById("auto").value );
	return true;
}



function AddSign(OnGetProtectedData,SignedDataStoreElement)
{
	obj=document.createElement("object");  //创建一个Object对象(印章)
	obj.width=158;
	obj.height=158;
	var mt=document.getElementById("name");   
	mt.appendChild(obj);  //追加Object对象
	//Obj的初始位置
	obj.style.left=233+"px";
	obj.style.top=347+"px";
	
	obj.style.position="absolute";  //绝对位置
	obj.classid=sealClassId;
	obj.Authority=3;   //禁止移动
	obj.OnGetProtectedData=OnGetProtectedData;   //受保护的字段
	
	//印章的显示模式
	obj.DrawModeUnsign=8;
	obj.DrawMode=18;
	//触发签章或签名、批注的方法；为'true'时签章，否则为签名或批注。
	obj.SignSeal(true);
	
	if (obj.CurrentState==0||i>2) //（CurrentState）的状态，0－尚未签章或签名；1－已经签章；2－已经签名。
	{
		obj.parentElement.removeChild(obj);
		if(i>2){
			alert(no);
		}
		return false;
	}
	//签章或签名的次数
	if(i==0)       
		{
				x=160;
				y=225;
		}else if(i==1){
				x=440;
				y=225;
		}else if(i==2){
				x=730;
				y=225;
		}
	
	//印章的位置
	obj.style.left=x+"px";	
	obj.style.top=y+"px";	
	i++;
	
	//赋值
	document.getElementById("sealdata").value = obj.SignedData+";"+document.getElementById("sealdata").value;
	document.getElementById("position").value = x+"px,"+y+"px;"+document.getElementById("position").value;
	document.getElementById("number").value = i;
	document.getElementById("auto").value = "no";
	return true;
}



