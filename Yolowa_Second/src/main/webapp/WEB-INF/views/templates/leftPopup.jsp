<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<style>
	#usageCountTable{
		margin:auto;
		margin-top:30px;
		width:80%;
		height:50px;
	}
</style>
<c:set var="categoryListSize" value="${fn:length(sessionScope.categoryList)}" />
<script>
function categoryListByType(type){
	location.href = "${pageContext.request.contextPath}/mainAllCategory.do?category="+type;
}
</script>
<div class="sub-left-menu scroll">
	<ul class="nav nav-list">
		<li><div class="left-bg"></div></li>
		<li class="time">
			<h1 class="animated fadeInLeft">21:00</h1>
			<p class="animated fadeInRight">Sat,October 1st 2029</p>
		</li>
		 <sec:authorize ifNotGranted="ROLE_MEMBER">
			<table id = "usageCountTable" frame=void>
				<tr>
					<td><img src = "${pageContext.request.contextPath}/resources/asset/img/memberCount.png" style ="width:70px; height:70px; margin-left:9px;"></td>
					<td><h3><b>&nbsp;&nbsp;${usageCount.memberCount}</b></h3></td>
				</tr>
				<tr>
					<td><img src = "${pageContext.request.contextPath}/resources/asset/img/contentCount.png" style ="width:70px; height:70px; margin-left:9px;"> </td>
					<td><h3><b>&nbsp;&nbsp;${usageCount.contentCount}</b></h3></td>
				</tr>
				<tr>
					<td><img src = "${pageContext.request.contextPath}/resources/asset/img/fundingCount.png" style ="width:70px; height:70px; margin-left:9px;"></td>
					<td><h3><b>&nbsp;&nbsp;${usageCount.fundingCount}</b></h3></td>
				</tr>
			</table>
		 </sec:authorize>
		
		<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN">
		<li class="active ripple">
			<a class="tree-toggle nav-header">
				<span class="fa"></span> 카테고리
				<span class="fa-angle-right fa right-arrow text-right"></span> 
			</a>
				<%-- href ="${pageContext.request.contextPath}/mainAllCategory.do?category=${category.cType} --%>
	
			<ul class="nav nav-list tree">
			<c:forEach items="${categoryList}" var="category" varStatus="order">
				<li><a onclick = "categoryListByType('${category.cType}')">${category.cType}</a></li>
			</c:forEach>
			</ul>
		</li>
		</sec:authorize>
	</ul>
</div>


