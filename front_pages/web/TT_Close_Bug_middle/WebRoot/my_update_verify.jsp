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

<title>My JSP 'my_update_verify.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="jQuery/jquery-1.7.1.min.js" type="text/javascript"></script>
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
	function operateF(op) {
		var oper = $("#operate");
		if(op == 'update') {
			oper.val(1); 
		} else if(op == 'verify') {
			oper.val(-3);
		}
		
	}
</script>

</head>

<body>
	<center>
		<h2>My Update &amp; Verify Bug</h2>
		<form id="uv_form" action="my_uv.action" method="get">
			<input type="hidden" id="operate" name="operate" value="-9">
			
			<input type="submit" value="Update All" onclick="operateF('update')">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="submit" value="Verify All" onclick="operateF('verify')">
		</form>
		
		<hr>
		Log:<s:property value="msg"/>
	</center>
</body>
</html>
