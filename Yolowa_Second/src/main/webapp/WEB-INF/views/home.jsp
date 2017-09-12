<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%-- <c:forEach items="${categoryList}" var ="cList">
	<img src = "${pageContext.request.contextPath}/resources/asset/img/${cList.cType}.jpg" alt = "${cList.cType}" style = "width: 50%; height:50%;">
</c:forEach> --%>
<div class="col-md-1"></div>
<div class="col-md-6">
<table style = "margin-left:-76px;">
	<tr>
		<c:forEach items="${categoryList}" var ="cList" begin="0" end="2">
		<td><img src = "${pageContext.request.contextPath}/resources/asset/img/${cList.cType}.jpg" alt = "${cList.cType}" style = "width:345px; height:250px;"></td>
		</c:forEach>
	</tr>
	<tr>
		<c:forEach items="${categoryList}" var ="cList" begin="3" end="5">
		<td><img src = "${pageContext.request.contextPath}/resources/asset/img/${cList.cType}.jpg" alt = "${cList.cType}" style = "width:345px; height:250px;"></td>
		</c:forEach>
	</tr>
</table>
</div>