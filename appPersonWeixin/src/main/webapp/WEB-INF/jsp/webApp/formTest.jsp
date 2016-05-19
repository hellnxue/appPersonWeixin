<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="hello world" description="hello world" keywords="hello world"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="hello world" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">hello world</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="vip-center_form">
	<div class="yz_step">
    	<span class="cur">hello world</span><span>hello world</span>
        <p class="line am-cf"><em class="cur am-fl"></em><em class="am-fr"></em></p>
    </div>
  <div class="input_list" id="widget-list">
  <form id="form1" name="form1" enctype="multipart/form-data" class="form-horizontal" method="get">
    <ul class="am-list m-widget-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
      <li>
        <div class="lines"><span>
          <input id="china" name="china" class="am-form-field am-input-lg" type="text"  ><br>
           <input  name="chinaec" class="am-form-field am-input-lg" type="text"  >
          </span></div>
      </li>
      
    </ul>
    <p align="center" style="padding:0 2rem;">
      <input id="activeSubmit" type="submit" class="am-btn am-btn-primary am-radius am-btn-block am-btn-lg" value="NEXT"><br>
       <input   type="button" class="am-btn am-btn-primary am-radius am-btn-block am-btn-lg" value="Ajax"><br>
       <input   type="button" class="am-btn am-btn-primary am-radius am-btn-block am-btn-lg" value="getJSON">
    </p>
  </form>  
  </div>
</div>

<es:webAppNewFooter/>
<script>
   $(function(){
	   $("form").on("submit",function(event){
		   event.preventDefault();
		   var fval=$(":input:eq(0)").val();
		   $(":input:eq(1)").val(  encodeURI( fval));//为了防止后台接收数据时出现乱码，进行转码一次操作
		   alert(encodeURI(fval));
		   this.submit();
	   });
	   
	   
	   //ajax需要用两次转码，后台用DecodeURI的时候才能接到中文(这个说法不成立)
	   $(":button:eq(0)").on("click",function(){
		   console.log(encodeURI( encodeURI( $(":input:eq(0)").val())));
		   $.ajax({
			   url:"${ctx}/code/bmcode",
			   type:"get",
			   data:"china="+$(":input:eq(0)").val()+"&chinaec="+encodeURIComponent( encodeURIComponent( $(":input:eq(0)").val()))
			   
		   }).done(function(data){
			   
			   console.log(data);
		   });
		   
		   
	   });
	   
	   //需要转码两次
	   $(":button:eq(1)").on("click",function(){
		   $.getJSON("${ctx}/code/bmcode", {china: $(":input:eq(0)").val(),chinaec:  encodeURIComponent( $(":input:eq(0)").val() ) }, function (data) {
			   
			  console.log(data); 
		   });
		   
		   
	   });
	   
   });
</script>