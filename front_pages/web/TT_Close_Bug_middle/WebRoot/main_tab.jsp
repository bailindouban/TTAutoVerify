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

<title>My JSP 'helloworld.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/styles.css">

<script src="jQuery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script src="jQuery/tab/jquery.hashchange.min.js" type="text/javascript"></script>
<script src="jQuery/tab/jquery.easytabs.min.js" type="text/javascript"></script>

<style>
/* Example Styles for Tab */
.etabs {
	margin: 0;
	padding: 0;
}

.tab {
	display: inline-block;
	zoom: 1;
	*display: inline;
	background: #eee;
	border: solid 1px #999;
	border-bottom: none;
	-moz-border-radius: 4px 4px 0 0;
	-webkit-border-radius: 4px 4px 0 0;
}

.tab a {
	font-size: 14px;
	line-height: 2em;
	display: block;
	padding: 0 10px;
	outline: none;
}

.tab a:hover {
	text-decoration: underline;
}

.tab.active {
	background: #fff;
	padding-top: 6px;
	position: relative;
	top: 1px;
	border-color: #666;
}

.tab a.active {
	font-weight: bold;
}

.tab-container .panel-container {
	background: #fff;
	border: solid #666 1px;
	padding: 10px;
	-moz-border-radius: 0 4px 4px 4px;
	-webkit-border-radius: 0 4px 4px 4px;
}

.panel-container {
	margin-bottom: 10px;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$('#tab-container').easytabs();
	});
</script>

</head>

<body>
	<center>
		<!-- Title -->
		<jsp:include page="selector/title.html" />

		<div id="tab-container" class='tab-container'>
			<ul class='etabs'>
				<li class='tab'><a href="#quick_update_verify">Quick Update
						&amp; Verify</a></li>
<!-- 				<li class='tab'><a href="#update">Update</a></li> -->
<!-- 				<li class='tab'><a href="#assign_to_developer">Assign To
						Developer</a></li> -->
<!-- 				<li class='tab'><a href="#assign_verify">Assign &amp;
						Verify Bug Fix</a></li> -->
				<!-- <li class='tab'><a href="#bug_figure">Bug Figure</a></li> -->
				<li class='tab'><a href="#bug_history">Bug History</a></li>
			</ul>
			<div class='panel-container'>
				<div id="quick_update_verify">
					<!-- Content - Quick Update & Verify -->
					<jsp:include page="tab_pages/quick_update_verify.jsp" />
				</div>
<%-- 				<div id="update">
					<!-- Content - Update -->
					<jsp:include page="tab_pages/update.jsp" />
				</div> --%>
<%-- 				<div id="assign_to_developer">
					<!-- Content - Assign To Developer -->
					<jsp:include page="tab_pages/assign_developer.jsp" />
				</div> --%>
				<%-- <div id="assign_verify">
					<!-- Content - Assign & Verify Bug Fix -->
					<jsp:include page="tab_pages/assign_verify.jsp" />
				</div> --%>
				<%-- <div id="bug_figure">
					<!-- Content - Bug Figure -->
					<jsp:include page="tab_pages/bug_figure.jsp" />
				</div> --%>
				<div id="bug_history">
					<!-- Content - Bug History -->
					<jsp:include page="tab_pages/bug_history.jsp" />
				</div>
			</div>
		</div>
	</center>
</body>
</html>
