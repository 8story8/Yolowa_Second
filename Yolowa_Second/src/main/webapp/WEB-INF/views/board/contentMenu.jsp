<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN" />
<sec:authentication var="user" property="principal" />
<style>
#tabs-demo6 {
	margin: auto;
}

.contentMenu {
	font-size: 1.0em;
}
</style>
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
		$("#grantedMember").click(function(){
			var userGrade = "${user.grade}";
			if(userGrade =="정회원"){
				alert("회원 등급 '우수회원'만 이용 가능 합니다.");
				return;
			}
			else{
				location.href="${pageContext.request.contextPath}/writeFundingView.do";
			}
			
			
		});
	});
</script>

<!-- Content/Funding -->
<div class="search-v1 panel">
	<div class="panel-body">
		<ul id="tabs-demo6" class="nav nav-tabs nav-tabs-v6 masonry-tabs" style = "margin-left:23px;"
			role="tablist">
			<li role="presentation"><a style="color:#5D676B;"
				href="${pageContext.request.contextPath}/mainAllCustomizedContent.do"
				class="contentMenu">맞춤형 컨텐츠 보기</a></li>

			<li role="presentation"><a style="color:#5D676B;"
				href="${pageContext.request.contextPath}/mainAllContent.do"
				class="contentMenu">전체 컨텐츠 보기</a></li>

			<li role="presentation"><a style="color:#5D676B;"
				href="${pageContext.request.contextPath}/writeContentView.do"
				class="contentMenu">컨텐츠 쓰기</a></li>

			<li role="presentation"><a style="color:#5D676B;"
				href="${pageContext.request.contextPath}/mainAllFunding.do"
				class="contentMenu">펀딩 글보기</a></li>

			<li role="presentation"><a style="color:#5D676B;"
				href="#"
				class="contentMenu" id="grantedMember">펀딩 글쓰기</a></li>
				<!-- ${pageContext.request.contextPath}/writeFundingView.do -->
		</ul>
	</div>
</div>