//这是印章的控件ClassID
var sealClassId="CLSID:C1FB7513-9A44-4C64-B653-63C6965D7F4C";
//最后更新日期，如果有关键性更新，可以进行版本判断
var lastEdited=20100319;
//是否调试模式
var debug=true;

//回调函数：getToSignValue用于获取本页面的验证数据
//obj:印章控件对象
function getToSignValue(obj)
{
	var ret="dssdsdsd";
	
	var xml=new ActiveXObject("Msxml2.DOMDocument");
	xml.loadXML(obj.SealData.DataIdentity);
	var root=xml.selectSingleNode("xml");
	if (root==null)
		return ret;
		
	var arr=root.childNodes;
	for (var i=0;i<arr.length;i++)
	{
		var child=arr(i);
		var dsname=child.getAttribute("name");
		
		var ds=document.getElementById(dsname);
		if (ds==null)
			continue;
		
		ds=ds.dataField;
		var chd=child.childNodes;
		for (var j=0;j<chd.length;j++)
			ret+=ds[chd(j).text].Value;
	}
	ret=ret.replace(/ /g,"").replace(/\r/g,"").replace(/\n/g,"");
	//obj.SealData.ExtraData.push(ret);
	return ret;
}

//回调函数：getToSignValue2用于获取不在本页面的验证数据
//obj:印章控件对象
function getToSignValue2(obj)
{
	var wnd=window.parent;
	for (var i=0;i<5;i++)
	{
		if (wnd.document.Script.getToSignValue!=undefined)
			break;
		wnd=wnd.parent;
	}
	if (i<5)
		return wnd.document.Script.getToSignValue(obj);
	else
	{
		try{
			return dialogArguments[0].document.Script.getToSignValue(obj);
		}catch(e)
		{
			throw new Error(undefined,"无法找到这个文书对应的主表单页面。");
		}
	}
}

//函数：getDataIdentity用于提取页面所有要保护的字段列表
//返回值：要保护的字段列表（xml）
function getDataIdentity()
{
	var xml=null;
	try{
		xml=new ActiveXObject("Msxml2.DOMDocument");
		if (xml==null)
			throw "";
	}catch(e)
	{
		throw new Error(undefined,"无法创建Microsoft的XML组件，难道是系统补丁未装。");
	}
	xml.loadXML("<xml></xml>");
	
	var root=xml.selectSingleNode("xml");
	var arr=document.getElementsByTagName("dataset");
	for (var i=0;i<arr.length;i++)
		_getDataIdentity(xml,root,arr[i]);
	
	return xml.xml;
}

//函数：_getDataIdentity用于获取一个dataset所有要保护的字段列表
//doc:xml文档对象
//root:本dataset的列表的xml根节点
//ds:dataset对象
function _getDataIdentity(doc,root,ds)
{	
	var node=root.appendChild(doc.createElement("dataset"));
	node.setAttribute("name",ds.id);
	
	var df=ds.dataField;
	var len=df.length;
	var dl;
	for (var i=0;i<len;i++)
	{
		dl=df[i].displaylabel;
		if (dl.substring(dl.length-1)=="!")
			node.appendChild(doc.createElement("field")).text=df[i].fieldname;
	}
	if (node.childNodes.length==0)
		node.parentNode.removeChild(node);
}


//这是与警综系统结合的最高级函数，自动根据标定的字段进行签章
function signseal()
{
	//先获取要保护的字段列表
	var protect=getDataIdentity();
	
	//遍历dataset获取要签章的列表
	//req为各个类型的印章请求
	//resp为各个印章请求：dsid（dataset的id），type（类型），field（字段名）
	var req=new Object();
	var resp=new Array();
	var arr=document.getElementsByTagName("dataset");
	for (var i=0;i<arr.length;i++)
		_getRequest(req,resp,arr[i]);
	
	//请求印章
	autoseal(protect,req);
	
	//检查结果
	for (var name in req)
	{
		if (req[name]==true)
		{
			if (name=="gz")
				throw new Error(undefined,"没有找到需要的电子公章，请您重试。");
			else if (name=="qm")
				throw new Error(undefined,"没有找到需要的电子签名，请您重试。");
			else
				throw new Error(undefined,"没有找到需要的电子方章（法人章），请您重试。");
		}
	}
	
	//写入结果
	for (var i=0;i<resp.length;i++)
	{
		var obj=resp[i];
		document.getElementById(obj.dsid).setDataObject(null,obj.field,req[obj.type]);
	}
}

//函数：_getRequest用于枚举一个dataset中所有的签章请求
//req:返回值：请求类型列表
//resp:返回值：请求列表，Array of Object:{dsid(dataset的id),type(类型),field(字段名)}
//ds:dataset对象
function _getRequest(req,resp,ds)
{
	var df=ds.dataField;
	var len=df.length;
	for (var i=0;i<len;i++)
	{
		var type="";
		var dl=df[i].displaylabel;
		dl=dl.substring(dl.length-1);
		if (dl=="@")//根据协议，公章字段后面加@
			type="gz";
		else if (dl=="#")//签名字段后面加#
			type="qm";
		else if (dl=="$")//方章（法人章）后面加$
			type="frz";
			
		if (type=="")
			continue;//并非需要签章的字段

		req[type]=true;//我们将在签章时请求这个类型的章
		
		var dst=new Object();
		dst.dsid=ds.id;
		dst.type=type;
		dst.field=df[i].fieldname;
		resp.push(dst);
	}
}

//函数：autoseal用于对请求的印章进行签盖
//protect:保护的字段列表
//request:请求的印章列表，也作为返回值写入各个请求的印章的数据
//        请求的印章使用类型标定：gz公章，qm签名，frz法人章
function autoseal(protect,request)
{
	var ctrl=addctrl(protect);
	
	var log="警务综合系统签章";
	//create secure agent to access seals
	var agent=new ActiveXObject("BCSecureLib.SecureAgent");
	//get seals into array
	var arr=ctrl.CreateSealArray();
	try{
		arr.RawData=agent.GetAllSeals();
	}catch(e)
	{
	}
	
	//loop seals to find usable seals (no more than two)
	var i,len=arr.Count;
	var usable=0,seal,type,tt;
	for (i=0;i<len;i++)
	{
		seal=arr(i);
		tt=seal.Title;
		if (tt.indexOf("公章")>-1)
			type="gz";
		else if (tt.indexOf("法人章")>-1)
			type="frz";
		else
			type="qm";
		
		if (request[type]==undefined)
			continue;
		if (request[type]!=true)
			continue;
		try{
			agent.SignSeal(seal.SealId,log);
			request[type]=addseal(ctrl,seal,log);
		}catch(e)
		{
			continue;
		}
	}
}

//函数：addctrl用于创建一个页面控件
//protect:保护的字段列表
function addctrl(protect)
{
	//add control to page
	var obj=document.createElement("object");
	obj.style.display="none";
	document.body.appendChild(obj);
	obj.classid=sealClassId;
	
	if (obj.Authority==undefined)
		throw new Error(undefined,"你还没有安装百成电子印章客户端呢。");
	
	obj.Authority=1;
	obj.ScriptRatherThanFunction=false;
	obj.SealData.DataIdentity=protect;
	obj.OnGetProtectedData=getToSignValue;
	obj.DrawMode=18;
	return obj;
}

//函数：addseal用于得到一个印章的印章数据和签盖数据
//ctrl:公用的控件对象
//seal:印章对象
//log :日志信息
function addseal(ctrl,seal,log)
{
	var sdo=ctrl.SealData;
    sdo.SealInfo=seal;
    sdo.SignType=0;
    sdo.SignSealInfo.OperationDescription=log;
		sdo.SignMyself();
    sdo.DataValid=true;
    return ctrl.SignedData;
}

//////////////////////////////////////////////////////////
//下面的代码段是常用但是在这次结合中暂时用不上的脚本函数
//////////////////////////////////////////////////////////
function SaveSeal(protect,ajbh,csbh,sid)
{
	var sealdata="";
	try{
		sealdata=SignSeal(0,0,false,protect);
	}catch(e)
	{
		alert(e.message);
		return false;
	}
	if (sealdata=="")
	{
		alert("如果您不签章（签名），将无法确认您填写的内容。");
		return false;
	}
	
	var xml=undefined;
	try{
		xml=new ActiveXObject("Msxml2.XMLHTTP");
		if (xml.readyState==undefined)
			throw new Error(undefined,"");
	}catch(e)
	{
		alert("您的操作系统尚未安装Microsoft的XML补丁。");
		return false;
	}
	try{
		xml.open("POST",sealServlet+"?ajbh="+ajbh+"&csbh="+csbh+"&seal="+sid,false);
		xml.send(sealdata);
		if (xml.status==500)
			throw new Error(undefined,xml.responseText);
		if (xml.status!=200)
			throw new Error(undefined,"服务器发生未知意外："+xml.statusText);
	}catch(e)
	{
		alert(e.message);
		return false;
	}
	return true;
}

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

function ShowSeal2(ajbh,csbh)
{
	var xml=undefined;
	try{
		xml=new ActiveXObject("Msxml2.XMLHTTP");
		if (xml.readyState==undefined)
			throw new Error(undefined,"");
	}catch(e)
	{
		alert("您的操作系统尚未安装Microsoft的XML补丁。");
		return false;
	}
	try{
		xml.open("GET",sealServlet+"?ajbh="+ajbh+"&csbh="+csbh,false);
		xml.send();
		if (xml.status==500)
			throw new Error(undefined,xml.responseText);
		if (xml.status!=200)
			throw new Error(undefined,"服务器发生未知意外："+xml.statusText);
		var strs=xml.responseText.split(",");
		for (var i=0;i<strs.length;i+=2)
		{
			var str=strs[i];
			if (str.length>0)
			{
				ShowSeal(i*100,350,str);
			}
		}
	}catch(e)
	{
		alert(e.message);
		return false;
	}
	return true;
}

function ShowSeal(x,y,data)
{
	var obj=document.createElement("object");
	obj.width=100;
	obj.height=100;
	document.body.appendChild(obj);

	obj.style.left=x+"px";
	obj.style.top=y+"px";
	obj.style.position="absolute";

	obj.classid=sealClassId;
	if (obj.Authority==undefined)
		throw new Error(undefined,"你还没有安装百成电子印章客户端呢。");
	obj.Authority=0;
	obj.ScriptRatherThanFunction=false;
	obj.OnGetProtectedData=getToSignValue;
	obj.DrawModeUnsign=8;
	obj.DrawMode=18;

	obj.SignedData=data;
}

function VerifySeal(data)
{
	var obj=document.createElement("object");
	obj.style.display="none";
	obj.width=100;
	obj.height=100;
	obj=document.body.appendChild(obj);
	obj.classid=sealClassId;
	if (obj.Authority==undefined)
		throw new Error(undefined,"你还没有安装百成电子印章客户端呢。");
		
	obj.ScriptRatherThanFunction=false;
	obj.OnGetProtectedData=getToSignValue;
	obj.SignedData=data;
	return (obj.CurrentState!=0);
}
