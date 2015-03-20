<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<script type="text/javascript" src="jQuery/canvasjs.min.js"></script>
<script type="text/javascript">
		function show_figure(bugJson) {						
			$('#chartContainer').show();
			
			var chart = new CanvasJS.Chart("chartContainer", {

				title : {
					text : "TT Bugs for ASUS Devices",					
					fontSize : 26,
				},
				axisX : {
					interval : 1,
					labelFontSize : 12,
					lineThickness : 0
				},
				axisY2 : {
					interval : 1,
					labelFontSize : 12,
					valueFormatString : "0",
					lineThickness : 0
				},
				toolTip : {
					shared : true
				},
				legend : {
					verticalAlign : "top",
					horizontalAlign : "center"

				}
			});
			
			var series1 = {
				type: "bar",
				showInLegend: true,
				name: "ASUS Devices",
				axisYType: "secondary",
				color: "#FE9A2E",
			};
			
			chart.options.data = [];
			chart.options.data.push(series1);
			
			series1.dataPoints = bugJson;
			
			chart.render();
		};
		
		function hide_figure() {
			$('#chartContainer').hide();
		}
		
	</script>

</head>

<body>
	<h2>Content - Bug Figure</h2>
	<jsp:include page="input_text/bug_total.jsp" />
	<br>
	<input type="button" value="Show Picture" onclick="show_figure([${bugJson}])">&nbsp;&nbsp;
	<input type="button" value="Hide Picture" onclick="hide_figure()">
	<div id="chartContainer" style="height: ${fn:length(bugTotal) * 12 + 100} ; width: 100%; display: none;" ></div>
</body>
</html>
