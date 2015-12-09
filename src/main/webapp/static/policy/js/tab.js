var defalutIndex = $.cookie('side'); 
var longinDiv = "";
var isdelete = false;
var hmfNum = 10;
var isam = true;
var isClickColor = false;
jQuery(function($){
	$(".clickTab").click(function(){
		var tabid = $(this).attr("tabid")+longinDiv;
		var url = $(this).attr("url");
		var name = $(this).attr("name");
		var type = $(this).attr("type");
		if(longinDiv != "WT"){
			CreateDiv(tabid, url, name,type);
		}else{
			CreateDivWT(tabid, url, name,type);
		}
	});
});
function dblBigPanle(tabid,url){
		var div_pannel = "div_pannel"+longinDiv;
		$("#div_"+tabid+"").siblings().hide();
		$("#"+div_pannel+"").siblings().hide();
		$("#"+div_pannel+"").css("left","0");
		$("#"+div_pannel+"").css("top","0");
		$("#"+div_pannel+"").css("width","100%");
		$("#"+div_pannel+"").css("margin-top","20px");
		$(".closeBigDetail").show();
}
 
 function setacrent(obj){  
		var tablist = document.getElementById("tabsBar"+longinDiv).getElementsByTagName('div');
		for(var i=0;i<tablist.length;i++)  
	    {  
	     	tablist[i].className="";
	    }  
		$("#"+obj+"").attr("class","crent"+longinDiv);
	}  
        
 function openUrlInFrameTab(url,name,c,d){
        var tabid = name+longinDiv;
        setacrent(tabid+longinDiv);
        var type="tab";
        if(longinDiv == "WT"){
           CreateDivWT(tabid, url, name,type);
        }else{
           CreateDiv(tabid, url, name,type);
        }
  }
        function RemoveDiv(obj)  
         {
        	isdelete = true;
            var ob = document.getElementById(obj);
            var iscrent = true;
            var obdiv = document.getElementById("div_" + obj);  
            var tablist = document.getElementById("tabsBar"+longinDiv).getElementsByTagName('div');  
            var pannellist = document.getElementById("div_pannel"+longinDiv).getElementsByTagName('iframe');  
            var hmfLength =0;
            var tabLength =0;
        	var hmfTabs ;  
            if (tablist.length > 0)  
            {
                if(ob.className.indexOf("crent")!=-1){
                 	iscrent = false;
                }
            	ob.parentNode.removeChild(ob); 
                obdiv.parentNode.removeChild(obdiv); 
                hmfTabs = document.getElementById("HMF-1"+longinDiv+"").getElementsByTagName('div');
                hmfLength = hmfTabs.length;
            	if(!iscrent){
               		if(hmfLength>0){
         	    	   hmfTabs[0].style.backgroundColor ="#f87c7e";
         	    	    hmfTabs[0].style.cssFloat="left";
         	   			hmfTabs[0].style.margin="";
         	   			hmfTabs[0].style.clear="";
         	   		    hmfTabs[0].style.marginRight="3px";
         	    	   hmfTabs[0].className = 'crent'+longinDiv;
         	    	   document.getElementById("div_"+hmfTabs[0].id).style.display = 'block';
         	    	   $("#tabsBar"+longinDiv+"").append(hmfTabs[0]);
         	    	   if(hmfTabs.length == 0){
         	    		  $(".menu-div"+longinDiv+"").hide();
         	    	   }
         	       }else{
         	    	   if(tablist.length>0){
         	    		  tablist[tablist.length - 1].className = 'crent'+longinDiv;
                          tablist[tablist.length - 1].style.backgroundColor="#f87c7e";//="height:20px; background:#f87c7e; border-radius:12px; padding:1px 8px; line-height:20px; font-size:12px; color:#FFF; float:left; margin-right:3px;";
                          pannellist[tablist.length - 1].style.display = 'block';
         	    	   }
         	    	  
           	    	 
         	       }
               	}else{
               		tabLength = tablist.length;
               		if(tabLength==hmfNum){
               		 if(hmfTabs.length==0){
          	    		  $(".menu-div"+longinDiv+"").hide();
          	    	   }
               		}else{
               			if(hmfLength>0){
               			   hmfTabs[0].style.cssFloat="left";
          	   			   hmfTabs[0].style.margin="";
          	   			   hmfTabs[0].style.clear="";
          	   		       hmfTabs[0].style.marginRight="3px";
               	    	   $("#tabsBar"+longinDiv+"").append(hmfTabs[0]);
               	    	   if(hmfTabs.length==0){
               	    		  $(".menu-div"+longinDiv+"").hide();
               	    	   }
               	       }
               		}
               	}
            }         
        } 
        function RemoveCrentDiv()  
        {
           isdelete = true;
           var ob ;
           var obj;
           var iscrent = true;
           var obdiv ;  
           var tablist = document.getElementById("tabsBar"+longinDiv).getElementsByTagName('div');  
           var pannellist = document.getElementById("div_pannel"+longinDiv).getElementsByTagName('iframe');  
           var hmfLength =0;
           var tabLength =0;
       	   var hmfTabs = document.getElementById("HMF-1"+longinDiv+"").getElementsByTagName('div');  
       	   hmfLength = hmfTabs.length;
           if (tablist.length > 0)  
           {  
           for(var i=0;i<tablist.length;i++) 
            {
                if(tablist[i].className.indexOf("crent")!=-1){
                	obj = tablist[i].id;
                	ob = document.getElementById(obj);
                	ob.parentNode.removeChild(ob);
                	obdiv = document.getElementById("div_" + obj);
                	obdiv.parentNode.removeChild(obdiv); 
                   	iscrent = false;
                }
            }
           	if(!iscrent){
           	   if(hmfLength>0){
     	    	   hmfTabs[0].style.backgroundColor ="#f87c7e";
	   	    	   hmfTabs[0].style.cssFloat="left";
	   	   		   hmfTabs[0].style.margin="";
	   	   		   hmfTabs[0].style.clear="";
	   	   		   hmfTabs[0].style.marginRight="3px";
     	    	   hmfTabs[0].className = 'crent'+longinDiv;
     	    	   document.getElementById("div_"+hmfTabs[0].id).style.display = 'block';
     	    	   $("#tabsBar"+longinDiv+"").append(hmfTabs[0]);
     	    	   if(hmfTabs.length==0){
       	    		  $(".menu-div"+longinDiv+"").hide();
       	    	   }
     	       }else{
     	    	  if(tablist.length>0){
     	    	    tablist[tablist.length - 1].className = 'crent'+longinDiv;
                 	tablist[tablist.length - 1].style.backgroundColor="#f87c7e";//="height:20px; background:#f87c7e; border-radius:12px; padding:1px 8px; line-height:20px; font-size:12px; color:#FFF; float:left; margin-right:3px;";
                    pannellist[tablist.length - 1].style.display = 'block';
     	    	  }
     	       }
           	}
           }         
        }