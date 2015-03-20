<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<h3>Bug Statistics : ${bugTotalNum} bugs in ${fn:length(bugTotal)} devices</h3>

<c:set var="col_num" value="6"></c:set>
<table cellpadding="4">
	<tr>
		<c:forEach var="i" begin="1" end="${col_num}" step="1">
			<th>Device</th>
			<th>Number</th>
		</c:forEach>
	</tr>

	<c:forEach items="${bugTotal}" var="bt" varStatus="st"
		step="${col_num}">
		<c:if test="${st.count % 2 == 1}">
			<tr bgcolor="#D0FFFF">
		</c:if>
		<c:if test="${st.count % 2 == 0}">
			<tr>
		</c:if>

		<c:forEach var="i" begin="0" end="${col_num - 1}" step="1">
			<c:if test="${fn:length(bugTotal) % col_num == 0 }">
				<c:set var="order"
					value="${st.count - 1 + fn:length(bugTotal) / col_num * i}"></c:set>
			</c:if>
			<c:if test="${fn:length(bugTotal) % col_num != 0 }">
				<c:set var="order"
					value="${st.count - 1 + ((fn:length(bugTotal) - fn:length(bugTotal) % col_num) / col_num + 1) * i}"></c:set>
			</c:if>
			<td align="center">${bugTotal[order].device}</td>
			<td align="center">${bugTotal[order].number}</td>
		</c:forEach>
		</tr>
	</c:forEach>

</table>