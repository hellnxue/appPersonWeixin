<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf"%>

<c:forEach items="${content}" var="news">
	<li class="msg" style="min-height:100px ; ">
		
		<div class="" >
			<h3 class="am-list-item-hd" style="margin-left:20px; height:50px; line-height:50px;">
			
				 <a	href="${ctx}/webApp/news/companymsgDetail?id=${news.informationId}"
					class="">${news.informationTitle==""?"无题":news.informationTitle}</a>
					
					
				<span class="" style="display:inline-block;height: 50px;
    line-height: 50px;color:#aaaaaa ;float:right ;margin-right:10px;"> ${news.startDate } ~ ${news.finishDate}</span>	
			</h3>
			
		</div>
		
		
	</li>
</c:forEach>
