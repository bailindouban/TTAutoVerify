<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'bug_figure.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>

<body>
	<h2>Content - Update</h2>
	<table cellpadding="4">
		<s:iterator value="messageStore.bugInfo" id="bi" status="st">

			<form id="update_form" method="get" action="">
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td>Order:</td>
					<td><s:property value="#st.count" /><jsp:include
							page="input_text/hidden_basic.jsp" />
							<input type="hidden" name="userInfo.operate" value="1">
							<input type="hidden" name="userInfo.param_bugIds" value="<s:property value="bugId" />_<s:property value="branch" />"></td>
				</tr>
				<tr>
					<td>Bug Info:</td>
					<td><jsp:include page="input_text/bug_info.jsp" /></td>
				</tr>
				<tr>
					<td>RD Manager:</td>
					<td><jsp:include page="../selector/rd_manager.html" /></td>
				</tr>
				<tr>
					<td>Developer:</td>
					<td><jsp:include page="../selector/developer.html" /></td>
				</tr>
				<tr>
					<td><jsp:include page="input_text/action_for_rc.jsp" /></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" value="Update" onclick="ss('t')"></td>
				</tr>
			</form>
		</s:iterator>
	</table>

	<br>
	<jsp:include page="input_text/log.jsp" />
</body>
</html>
