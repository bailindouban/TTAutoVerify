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

<title>Auto Verify Bug System</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/styles.css">

</head>

<body>
	<center>
		<!-- Title -->
		<jsp:include page="selector/title.html" />

		<!-- Info Table -->
		<form action="main_tab.action" method="post">
			<table>
				<tr>
					<th colspan="2"><h2>Please fill this information table
							according to TT</h2></th>
				</tr>
				<tr>
					<td>User Name:</td>
					<td><input name="userInfo.username" type="text" value="Input your TT name"></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input name="userInfo.password" type="password" value=""></td>
				</tr>
				<tr>
					<td>Project:</td>
					<td><jsp:include page="selector/project.html" /></td>
				</tr>
				<tr>
					<td>TT RD Manager:</td>
					<td><jsp:include page="selector/rd_manager.html" /></td>
				</tr>
				<tr>
					<td>TT Developer:</td>
					<td><jsp:include page="selector/developer.html" /></td>
				</tr>
				<tr>
					<td>Ready, Baby&nbsp;?</td>
					<td><input id="submit" type="submit" value="Let's Go ~~">&nbsp;&nbsp;<input
						id="reset" type="reset" value="Reset"></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>
