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

<title>My JSP 'bug_history.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
	<h2>
		Bug History -
		<s:property value="usercur.id.username" />
		[
		<s:property value="usercur.id.project" />
		]
	</h2>

	<table width="40%">
		<tr align="center">
			<th>Update Bugs</th>
			<th>Verify Close Fixed Bugs</th>
		</tr>
		<tr align="center">
			<td><s:iterator value="usercur.updatedBugs" id="update_bug">
					<s:iterator>
						<s:property value="updatedBug" />
						<br>
					</s:iterator>
				</s:iterator></td>
			<td><s:iterator value="usercur.closedBugs" id="close_bug">
					<s:iterator>
						<s:property value="closedBug" />
						<br>
					</s:iterator>
				</s:iterator></td>
		</tr>
	</table>


</body>
</html>
