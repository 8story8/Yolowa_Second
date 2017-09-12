<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- spring security custom tag를 사용하기 위한 선언 --%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN">
	<sec:authentication var="user" property="principal" />
	<script>
		function myFunction(type) {
			if (type == "page") {
				location.href = "${pageContext.request.contextPath}/mypage.do?id=${user.id}";
			} else if (type == "bookingList") {
				location.href = "${pageContext.request.contextPath}/myBookingPage.do?id=${user.id}";
			} else if (type == "message") {
				location.href = "${pageContext.request.contextPath}/myMessagePage.do";
			}
		}
	</script>

	<div class="sub-left-menu scroll">
		<ul class="nav nav-list">
			<li><div class="left-bg"></div></li>
			<li class="time">
				<h1 class="animated fadeInLeft">21:00</h1>
				<p class="animated fadeInRight">Sat,October 1st 2029</p>
			</li>
			<li class="active ripple"><a class="tree-toggle nav-header">
					<span class="fa"></span> My Management <span
					class="fa-angle-right fa right-arrow text-right"></span>
			</a>
				<ul class="nav nav-list tree">
					<li><a onclick="myFunction('message')">My MessageBox</a></li>
					<li><a onclick="myFunction('page')">My Page</a></li>
					<li><a onclick="myFunction('bookingList')">My BookMarkList</a></li>
				</ul></li>
		</ul>
	</div>
</sec:authorize>

