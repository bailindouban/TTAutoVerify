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
<script type="text/javascript">
	function operate_single(op, bugId, branch, cl, tag) {
		var input = $("<input>").attr("type", "hidden").attr("name",
				"userInfo.operate");
		var input_bug = $("<input>").attr("type", "hidden").attr("name",
				"userInfo.param_bugIds").val(bugId + '_' + branch);
		$("#id_cl").val(cl);
		$("#id_tag").val(tag);
		if (op == 'update') {
			$(input).val("1");
		} else if (op == 'verify') {
			$(input).val("-3");
		}

		$("#verify_form").append($(input));
		$("#verify_form").append($(input_bug));
		$("#verify_form").submit();
	}
</script>

</head>

<body>
	<h2>Content - Bug Verify Fix</h2>
	<table cellpadding="4">
		<s:iterator value="messageStore.bugInfo" id="bi" status="st">
			<form id="verify_form" method="get" action="">
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td>Order:</td>
					<td><s:property value="#st.count" /><jsp:include
							page="input_text/hidden_basic.jsp" /> <input type="hidden"
						name="userInfo.operate" value="-3"> <input type="hidden"
						name="userInfo.param_bugIds"
						value="<s:property value="bugId" />_<s:property value="branch" />"></td>
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
					<td><jsp:include page="input_text/version_fixed.jsp" /></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" value="Verify"></td>
				</tr>
			</form>
		</s:iterator>
	</table>
	<br>
	<jsp:include page="input_text/log.jsp" />
</body>
</html>
