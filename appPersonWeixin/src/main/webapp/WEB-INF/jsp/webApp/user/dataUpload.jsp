<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">员工资料上传</h1>
 <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<body style="background-color: white" >
	 <form action="" class="am-form am-form-horizontal" id="doc-vld-msg">
	    <div  class="am-form-group" style="margin-top: 20px;">
		    <div style="float:left;text-align: center;margin-left: 20px;"> 身 份 证 ：</div>
		    <div class="am-form-group am-form-file" style="float:left">
			  <button type="button" class="am-btn  am-btn-secondary am-radius">
			    <i class="am-icon-cloud-upload"></i> 
			           浏览
			    </button>
			  <input id="myfiles1" name='myfiles'  type="file" multiple ><span  >未选择文件</span>
			</div> 
	    </div>
		 
		<div class="am-form-group">
		    <div style="float:left;text-align: center;margin-left: 20px;"> 户 口 薄 ：</div>
		    <div class="am-form-group am-form-file" style="float:left">
			  <button type="button" class="am-btn  am-btn-secondary am-radius">
			    <i class="am-icon-cloud-upload"></i> 
			          浏览
			    </button>
			  <input id="myfiles2" name='myfiles'  type="file" multiple><span  >未选择文件</span>
			</div> 
		</div>
		
		<div class="am-form-group">
		    <div style="float:left;text-align: center;margin-left: 20px;"> 学 历 证 ：</div>
		    <div class="am-form-group am-form-file" style="float:left">
			  <button type="button" class="am-btn am-btn-secondary am-radius">
			    <i class="am-icon-cloud-upload"></i> 
			          浏览
			    </button>
			  <input id="myfiles3" name='myfiles'  type="file" multiple><span >未选择文件</span>
			</div> 
		</div>
		
		<div class="am-form-group">
		    <div style="float:left;text-align: center;margin-left: 20px;"> 简&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;历 ：</div>
		    <div class="am-form-group am-form-file" style="float:left">
			  <button type="button" class="am-btn am-btn-secondary am-radius">
			    <i class="am-icon-cloud-upload"></i> 
			          浏览
			    </button>
			  <input id="myfiles4" name='myfiles'  type="file" multiple><span  >未选择文件</span>
			</div> 
		</div>
		
		<div class="am-form-group">
		    <div style="float:left;text-align: center;margin-left: 20px;"> 离职证明：</div>
		    <div class="am-form-group am-form-file" style="float:left">
			  <button type="button" class="am-btn am-btn-secondary am-radius">
			    <i class="am-icon-cloud-upload"></i> 
			          浏览
			    </button>
			  <input id="myfiles5" name='myfiles'  type="file" multiple><span  >未选择文件</span>
			</div> 
		</div>
		
		<div class="am-form-group">
		    <div style="float:left;text-align: center;margin-left: 20px;"> 健康证明：</div>
		    <div class="am-form-group am-form-file" style="float:left">
			  <button type="button" class="am-btn am-btn-secondary am-radius">
			    <i class="am-icon-cloud-upload"></i> 
			          浏览
			    </button>
			  <input id="myfiles6" name='myfiles'  type="file" multiple><span  >未选择文件</span>
			</div> 
		</div>
		
		<div class="am-form-group">
		    <div style="float:left;text-align: center;margin-left: 20px;"> 薪资证明：</div>
		    <div class="am-form-group am-form-file" style="float:left">
			  <button type="button" class="am-btn am-btn-secondary am-radius">
			    <i class="am-icon-cloud-upload"></i> 
			          浏览
			    </button>
			  <input id="myfiles7" name='myfiles'  type="file" multiple><span  >未选择文件</span>
			</div> 
		</div>

		<div class="btns am-g am-text-center">
		
		  <input type="button" class="am-btn am-btn-primary am-radius blue_btn am-radius am-btn-block" id="upload" value="提 交">
		
		</div> 
		
		
		
	 </form>  
<div class="am-modal am-modal-alert" tabindex="-1" id="my-alert">
  <div class="am-modal-dialog">
    <div class="am-modal-hd">文件上传成功！</div>
    <div class="am-modal-footer">
      <span class="am-modal-btn" data-am-modal-confirm>确定</span>
    </div>
  </div>
</div>
<es:webAppNewFooter/>
<script src="${ctx}/static/ajaxFileUpload/ajaxfileupload.js" ></script>
<script>
var haveData="";
//是否做过上传的判断
function isUpload(){
     $.ajax({
		type:"post",
		url:"${ctx}/webApp/user/isUpload",
		async:false,
		dataType:"text",
		success:function(data){
			console.log("data~~~~~"+data);
			haveData=data;
		}
		
		
	}); 
	
}



$(function(){
	
	/* isUpload();
	
	if(haveData=="havedata"){
		$('#upload').attr("disabled","disabled");
		 
	}else{
		$('#upload').removeAttr("disabled");
	} */
	
	 $('.am-form-group input').on('change', function() {
		 
	      var fileNames = '';
	      $.each(this.files, function() {
	    	  if(this.name.length>13){
	    		  fileNames += '<span >' + this.name.replace(this.name.substring(5,this.name.indexOf(".")-2),"...") + '</span> ';  
	    	  }else{
	    		  fileNames += '<span >' + this.name + '</span> ';
	    	  }
	       
	         
	      });
	      $(this).next("span").html(fileNames);
	     
	      
	    }); 
	 
	 
	 
	$('#upload').on('click', function() {  
		/* var fileFlag=true;
		 $('.am-form-group input').each(function(){
			 if($(this).val()==""){
				 fileFlag=false;
			 } 
			 
		 }); */
		 
	//	 console.log(fileFlag);
	//	 if(fileFlag){
			 var progress = $.AMUI.progress;
			 $(this).attr("disabled","disabled");//禁止重复上传
			 progress.start();
		     $.ajaxFileUpload({
		      url: '${ctx}/webApp/user/uploadFile', //用于文件上传的服务器端请求地址
		      secureuri: false, //是否需要安全协议，一般设置为false
		      fileElementId: ['myfiles1','myfiles2' ,'myfiles3','myfiles4','myfiles5','myfiles6','myfiles7'  ], //文件上传域的ID   
		     // fileElementId:  'myfiles1' , //文件上传域的ID   
		      async:false,
		      dataType:'text',
		      type:"POST",
		      success: function (data){  //服务器成功响应处理函数
		    	  
		    	/*  if(data.errorMsg){
		    		    $('#my-alert .am-modal-hd').html("文件已上传过，不能再次上传！"); 
			      		$('#my-alert').modal();  
			      		
		    	 }else */
		    	// console.log(data);
		    	 if(data.error){
		    		 
		      		$('#my-alert .am-modal-hd').html(data.error); 
		      		$('#my-alert').modal();  
		      		$('#upload').removeAttr("disabled");
		      		 progress.done();
		      	}else{
		      		
		      	    $('#my-alert .am-modal-hd').html("文件上传成功！"); 
		      		$('#my-alert').modal(); 
		      		 progress.done();
		      		 timerc1=10;//时间初始化
					 times=setInterval(handleBtn,1000);	
		      	}		            	
		      	           		
		      } 
			});  
		/*   }else{
			    $('#my-alert .am-modal-hd').html("请全部选择文件!"); 
	      		$('#my-alert').modal();  
		 }  */
		       
	});
});


var timerc1=0; //全局时间变量（秒数）
var times;
function handleBtn(){ //加时函数
	if(timerc1 > 0){ //如果不到1秒
	    --timerc1; //时间变量自减1
	   
	};
	if (timerc1==0) {
		$('#upload').removeAttr("disabled");
	    clearInterval(times);
	 }
};
</script>

</body>
</html>