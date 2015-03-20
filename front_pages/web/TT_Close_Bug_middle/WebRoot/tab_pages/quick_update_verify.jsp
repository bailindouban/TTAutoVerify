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
		} else if(op == 'verify'){
			operate.val(-3);
		}
		$(form).submit;
	}
</script>

</head>

<body>
	<h2>Content - Register yourself for Update and Verify Bug</h2>
	<%-- <table cellpadding="4">
		<tr>
			<th colspan="7">Bug Info for Update or Verify</th>
		</tr>
		<tr>
			<td>Order</td>
			<td>Device</td>
			<td>Branch</td>
			<td>Bug Id</td>
			<td>Tag</td>
			<td>Apk Version</td>
			<td>Change Link</td>
		</tr>
		<s:iterator value="messageStore.bugInfo" id="bi" status="st">

			<form id="quick_form" method="get">
				<s:if test="#st.Odd">
					<tr bgcolor="#D0FFFF">
				</s:if>
				<s:else>
					<tr>
				</s:else>
				<td align="center"><s:property value="#st.count" /> <jsp:include
						page="input_text/hidden_basic.jsp" /> <input
					name="userInfo.rd_manager" type="hidden"
					value="${userInfo.rd_manager}"> <input
					name="userInfo.developer" type="hidden"
					value="${userInfo.developer}"> <input type="hidden"
					id="user_operate_<s:property value="#st.count" />"
					name="userInfo.operate" value="-9"> <input type="hidden"
					name="userInfo.param_bugIds"
					value="<s:property value="bugId" />_<s:property value="branch" />"></td>
				<td><s:property value="device" /></td>
				<td><s:property value="branch" /></td>
				<td><s:property value="bugId" /></td>
				<td><s:property value="tag" /></td>
				<td><s:property value="apkVersion" /></td>
				<td><s:property value="changeLink" /></td>
				<td><s:if test="changeLink != ''">
					<input type="submit" value="Update"
						onclick="operate('#quick_form', '#user_operate_' + <s:property value="#st.count" />, 'update')">
				</s:if> <s:else>Need Change Link</s:else></td>
			<td><s:if test="tag != ''">
					<input type="submit" value="Verify"
						onclick="operate('#quick_form', '#user_operate_' + <s:property value="#st.count" />, 'verify')" />
				</s:if> <s:else>Need Tag</s:else></td>
				</tr>
			</form>
		</s:iterator>
	</table>
	<br>

	<form id="all_form" method="get">
		<jsp:include page="input_text/hidden_basic.jsp" />
		<input name="userInfo.rd_manager" type="hidden"
			value="${userInfo.rd_manager}"> <input
			name="userInfo.developer" type="hidden" value="${userInfo.developer}">
		<input type="hidden" id="user_operate_all" name="userInfo.operate"
			value="-9"> <input type="hidden" name="userInfo.param_bugIds"
			value="all">
		<!-- Submit All -->
		<s:if
			test="%{userInfo.username == 'junzheng_zhang' && userInfo.password == '123456'}">
			<input type="submit" value="Update All"
				onclick="operate('#all_form', '#user_operate_all', 'update')">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="submit" value="Verify All"
				onclick="operate('#all_form', '#user_operate_all', 'verify')">

		</s:if>
	</form> --%>
	<br>
	<jsp:include page="input_text/log.jsp" />
</body>
</html>
