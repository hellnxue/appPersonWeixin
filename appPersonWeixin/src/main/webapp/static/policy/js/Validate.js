window.onload=function(){
	
    		//输出100-1000的随机数
    		var number=(Math.floor(Math.random()*1000+100));
    		  //初始化填写日期    
    		var now,n,y,r,h,m,s; 
			now=new Date(); 
			n = now.getYear(); 
			y = now.getMonth()+1; 
			r = now.getDate();  
    	
			//赋值
    		document.getElementById("id").value="biceng"+n+y+r+number;
    		document.getElementById("dep").value=n;
    		document.getElementById("file3").value=y;
    		document.getElementById("apply3").value=r;
    		
    	}
 
 