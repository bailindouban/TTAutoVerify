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
<script type="text/javascript">
	function operate(form, user_operate, op) {
		var operate = $(user_operate);
		if (op == 'update') {
			operate.val(1);
		} else if (op == 'verify') {
			operate.val(-3);
		}
		$(form).submit;
	}
</script>

</head>

<body>
	<h2>Register - ${userInfo.username }: ${userInfo.project }</h2>


	${userInfo.msg }
	<br>
	<br>
	<font color="red">${userInfo.prompt }</font>
	<br>
	<br>
	<!-- Verify Fixed Bugs -->
	<table width="70%" border="1" style="border-collapse: collapse;">
		<tr align="center">
			<th>Verified Bugs By Tools</th>
			<th>Tag</th>
			<th>APK Version</th>
			<th>Change Link</th>
			<th>Device</th>
			<th>Branch</th>
		</tr>
		<s:iterator value="usercur.closedBugs" id="close_bug" status="st">
			<s:if test="#st.Odd">
				<tr align="center" bgcolor="#D0FFFF">
			</s:if>
			<s:else>
				<tr align="center">
			</s:else>
			<td><s:property value="ttBug" /></td>
			<td><s:property value="tag" /></td>
			<td><s:property value="apkVersion" /></td>
			<td><s:property value="changeLink" /></td>
			<td><s:property value="device" /></td>
			<td><s:property value="branch" /></td>
			</tr>
		</s:iterator>
	</table>
	<br>
	<br>
	<table width="70%" border="1" style="border-collapse: collapse;">
		<tr align="center">
			<th>Updated Bugs By Tools</th>
			<th>APK Version</th>
			<th>Change Link</th>
			<th>Device</th>
			<th>Branch</th>
		</tr>
		<s:iterator value="usercur.updatedBugs" id="update_bug" status="st">
			<s:if test="#st.Odd">
				<tr align="center" bgcolor="#D0FFFF">
			</s:if>
			<s:else>
				<tr align="center">
			</s:else>
			<td><s:property value="ttBug" /></td>
			<td><s:property value="apkVersion" /></td>
			<td><s:property value="changeLink" /></td>
			<td><s:property value="device" /></td>
			<td><s:property value="branch" /></td>
			</tr>
		</s:iterator>
	</table>
	<br>
</body>
</html>
