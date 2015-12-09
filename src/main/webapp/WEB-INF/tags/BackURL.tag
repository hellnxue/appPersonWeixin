<%@ tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ tag import="com.fnst.es.common.Constants" %>
<%@ tag import="org.springframework.util.StringUtils" %>
<%@ attribute name="hiddenInput" type="java.lang.Boolean" required="false" description="是否是隐藏展示" %><%
    if(!StringUtils.isEmpty(request.getParameter(Constants.IGNORE_BACK_URL))) {
        return;
    }
    String backURL = (String) request.getAttribute(Constants.BACK_URL);
    if(hiddenInput != null && hiddenInput.equals(Boolean.TRUE)) {
        out.write("<input type=\"hidden\" name=\"" + Constants.BACK_URL + "\" value=\"" + backURL + "\">");
    } else if (backURL != null) {
        out.write(backURL);
    }
    return;
%>