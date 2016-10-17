		<c:forEach items="${content}" var="news">
	        <li class="am-g am-list-item-desced"> <a href="${ctx}/webApp/news/newDetail?id=${news.id}" class="am-list-item-hd ">${news.title==""?"无题":news.title}</a>
	          <div class="am-list-item-text">${news.content}</div>
	          <p class="time">2015-06-10 <span><i class="am-icon-eye"></i> 63</span></p>
	        </li>		
		</c:forEach>