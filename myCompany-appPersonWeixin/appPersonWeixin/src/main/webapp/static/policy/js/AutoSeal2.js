var sealClassId="CLSID:C1FB7513-9A44-4C64-B653-63C6965D7F4C";
var obj;
var json;
var i=0;
/*
 * 一、 签名图片接口
1、 开始签名方法接口
function beginSign();
签名板开始接受客户签名
2、 结束签名方法接口
function endSign(dirUrl,x,y);
此方法完成三步操作：
首先返回签名图片流在页面(x,y)处的指定区域显示；
其次将签名图片保存到url所指定的目录下；
再次签名板结束客户签名。
二、 印章接口
显示印章图像
function showSeal(templateId,x,y);
此方法根据templateId寻找到业务受理模版对应的印章，返回印章图片流在页面(x,y)处的指定区域显示。
 */


function showSeal2(templateId,x,y){
	
		var protect = "protect data";
		 autoseal(protect,templateId,x,y);
}
/*
 * 获取印章数组中所需要的印章对象
 */
function autoseal(protect,templateId,x,y)
    {
    	if(i>4){
    		alert(no);
    		return false;
    	}
	    var ctrl=addctrl(protect,x,y);
	
	    var log="jsp自动盖章演示";
	    //create secure agent to access seals
	    var agent=new ActiveXObject("BCSecureLib.SecureAgent");
//	    //get seals into array
	    var arr=ctrl.CreateSealArray();
	    try{
		    arr.RawData=agent.GetAllSeals();
		    var result = arr.Count;
	    }catch(e)
	    {
	    	alert("arr erro");
        }
	    //loop seals to find usable seals (no more than two)
	    var len=arr.Count;
	    var ret=new Object();
	    var usable=0,seal,type,tt;
		    seal=arr(templateId);
		    
		   
		    tt=seal.Title;
		    //qqq = seal.CreateDocID;
		   // alert(qqq);
		    if (tt.indexOf("公章")>-1)
			    type="gz";
		    else if (tt.indexOf("法人章")>-1)
			    type="frz";
		    else
			    type="qm";
		
		var sdo=ctrl.SealData;
        	sdo.SealInfo=seal;
        	sdo.SignType=0;
       	 	sdo.SignSealInfo.OperationDescription=log;
	    	sdo.SignMyself();
        	sdo.DataValid=true;
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
		}else if(i==3){
				x=140;
				y=380;
		}else if(i==4){
				x=420;
				y=380;
		}
			obj.style.left=x+"px";	
			obj.style.top=y+"px";	
			i++;
        	
        ret = ctrl.SignedData; //印章图片数据二进制字符串	
    	document.getElementById("sealdata").value = ret+";"+document.getElementById("sealdata").value;
		document.getElementById("position").value = x+"px,"+y+"px;"+document.getElementById("position").value;
		document.getElementById("auto").value = "yes";
		document.getElementById("number").value = i;
	    return ret;
    }
/*
 * 由在印章数组里选定的印章对象进行盖章的印章显示
 */
function addctrl(protect,x,y)
    {
	    //add control to page
	    obj=document.createElement("object");
		var mt=document.getElementById("name");
		mt.appendChild(obj);
		
		obj.classid=sealClassId;
		obj.style.left=x+"px";
		obj.style.top=400+"px";
		obj.style.position="absolute";
	
	    if (obj.Authority==undefined)
		    throw new Error(undefined,"你还没有安装百成电子印章客户端呢。");
		
     	obj.Authority=0;
	    obj.SealData.DataIdentity=protect;
	    obj.OnGetProtectedData="/inputnames:dep,apply1,file1,apply2,file2,apply3,file3";
	    //obj.SignedData="sealdata";
	  
	    obj.DrawModeUnsign=8;
    	obj.DrawMode=18;
    	return obj;
    }


var xmlHttp;
function createXMLHttpRequest()
{
    if(window.ActiveXObject)
    {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if(window.XMLHttpRequest)
    {
        xmlHttp = new XMLHttpRequest();
    }
}
function startRequest()
{
    createXMLHttpRequest();
    try
    {
        xmlHttp.onreadystatechange = handleStateChange;
        var url = "1.txt?fresh=" + Math.random();
        
        xmlHttp.open("GET", url, true);
        xmlHttp.send(null);
    }
    catch(exception)
    {
        alert("xmlHttp Fail");
    }
}
function handleStateChange()
{   
	//alert(xmlHttp.readyState);
    if(xmlHttp.readyState == 4)
    {       
        if (xmlHttp.status == 200 )
        {
            var result = xmlHttp.responseText;
            json = eval("(" + result + ")");//json数据转换
            alert(json.id);//读取json数据
            //alert(json.sex);
        }
    }
}

//ajax 将表单数据以json样式写入1.txt文件
function ajaxWriteFile()
	{
	var url = "/jspDemo/writeFile.do?method=execute";
	var xmlHttp2 = new ActiveXObject("Microsoft.XMLHTTP");
	
	xmlHttp2.open("Post",url,false);
	xmlHttp2.setRequestHeader("content-type","application/x-www-form-urlencoded");
	xmlHttp2.send("11111111111111111111");
	if(xmlHttp2.status==200){
		strRet = xmlHttp2.responseText;
		xmlHttp2 = null ;
		
	}else{
		alert("download failed!"+xmlHttp2.status);
	}
}	




