<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN">
	<sec:authentication var="user" property="principal" />
	<script src="//code.jquery.com/jquery.min.js"></script>
	<style>
#friendList, #pointList {
	cursor: pointer
}

b {
	cursor: default
}

.dropdown {
	cursor: pointer
}

.divArea {
	background-color: white;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$(".panel-body").on("click","span",function() {
			var id = $(this).prev().val();
			$.ajax({
				type : "get",
				url : "friendDelete.do?id="+ id,
				success : function(data) {
					if (data == "ok") {
						location.href = "MyListPage.do?id=${user.id}";
					} else {
						alert("친구 삭제가 실패했습니다.");
					}
				}//success
			});//ajax
		});//on

		$("#pointList").click(function() {
			$("#pointModal").modal();
		});//click
	});//ready
</script>
	<div class="profile-v1 col-md-12 col-sm-12 profile-v1-wrapper">
		<div class="col-md-9  profile-v1-cover-wrap"
			style="padding-right: 0px;">
			<c:choose>
				<c:when test="${!empty fvo}">
					<div class="profile-v1-pp">
						<ul class="nav navbar-nav navbar-right user-nav" id="name">
							<li class="dropdown avatar-dropdown"><img
								src="${pageContext.request.contextPath}/${fvo.filePath}"
								alt="user name" data-toggle="dropdown" /></li>
							<h2>
								<b>${fvo.name }</b>
							</h2>
						</ul>
					</div>
				</c:when>
				<c:otherwise>
					<div class="profile-v1-pp">
						<ul class="nav navbar-nav navbar-right user-nav">
							<li class="dropdown avatar-dropdown"><img
								src="${pageContext.request.contextPath}/${user.filePath}"
								alt="user name" data-toggle="dropdown" />

								<ul class="dropdown-menu user-dropdown">
									<li data-toggle="modal" data-target="#myModal">
										<!-- Trigger the modal with a button --> <a href="#"> <span
											class="fa fa-instagram"></span>Change Photo
									</a>
									</li>
									<li><a href="modifyView.do?id=${user.id }"><span
											class="fa fa-user"></span> My Info</a></li>
								</ul></li>
							<h2>
								<b>${user.name }</b>
							</h2>
						</ul>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="col-md-12 profile-v1-cover">
				<img
					src="${pageContext.request.contextPath }/resources/asset/img/bg1.jpg"
					class="img-responsive">

			</div>

		</div>
		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Change Photo</h4>
					</div>
					<div class="modal-body">
						<form
							action="${pageContext.request.contextPath}/multifileupload.do"
							method="post" enctype="multipart/form-data" id="fileUpload">
							사진<input type="file" name="file[0]"><br> <input
								type="submit" value="멀티파일업로드"> <input type="hidden"
								name="userInfo" value='${user.id }'>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>
		</div>
		<div class="col-md-3 col-sm-12 padding-0 profile-v1-right">
			<c:choose>
				<c:when test="${!empty fvo}">
					<div class="col-md-12 col-sm-4 profile-v1-right-wrap padding-0">
						<div
							class="col-md-12 padding-0 sub-profile-v1-right text-center sub-profile-v1-right1">
							<h2>Friends</h2>
							<p>${requestScope.friendList }</p>
						</div>
					</div>
					<div class="col-md-12 col-sm-4 profile-v1-right-wrap padding-0">
						<div
							class="col-md-12 sub-profile-v1-right text-center sub-profile-v1-right2">
							<h2>Point</h2>
							<p>${requestScope.fvo.point }</p>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col-md-12 col-sm-4 profile-v1-right-wrap padding-0">
						<div
							class="col-md-12 padding-0 sub-profile-v1-right text-center sub-profile-v1-right1"
							id="friendList" title="친구리스트 보기">
							<h2>Friends</h2>
							<p>${requestScope.friendList }</p>
						</div>
					</div>
					<div class="col-md-12 col-sm-4 profile-v1-right-wrap padding-0">
						<div
							class="col-md-12 sub-profile-v1-right text-center sub-profile-v1-right2"
							id="pointList" title="포인트 보기">
							<h2>Point</h2>
							<p>${user.point }</p>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<!--  ㅂㅏ디  -->
	<div class="col-md-12">
	
			<div class="panel divArea">
				<div class="search-v1 panel">
					<div class="panel-body">
						<div class="col-md-12"></div>
						<h4>친구 목록</h4>
					</div>
				</div>
				<c:forEach items="${flist}" var="fList">
					<div class="col-md-3 padding-0">
						<div class="badges-v1" style="height: 250px; width: 200px;">
							<div class="panel-body text-center">
								<h1 class="atomic-symbol">
									<a href="mypage.do?id=${fList.id}"> <img
										src="${pageContext.request.contextPath}/${fList.filePath}"
										class="img-circle" width="100" height="100" /></a>
								</h1>
								<h4>${fList.id}&nbsp;
								<input type="hidden" value="${fList.id}">
								<a href="#"><span class="fa fa-user-times" title="친구삭제"></span></a>
								</h4>
								<p>
									&nbsp;이름 : ${fList.name}<br> &nbsp;타입 :
									<c:forEach items="${fList.categoryList}" var="cateList">
											${cateList.cType}&nbsp;
								</c:forEach>
								</p>
							</div>
							<div class="badges-ribbon">
								<c:choose>
									<c:when test="${fList.grade == '우수회원'}">
										<div class="badges-ribbon-content badge-primary">우수회원</div>
									</c:when>
									<c:otherwise>
										<div class="badges-ribbon-content badge-info">정회원</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

	<!-- Modal -->
	<div class="modal fade" id="pointModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" style="text-align: center;">
						<strong>포인트 적립내역</strong>
					</h4>
					<br>
					<div
						style="display: inline-block; width: 20%; text-align: center; font-size: 12pt;">
						적립시간</div>
					<div
						style="display: inline-block; width: 50%; text-align: center; font-size: 12pt;">
						적립내용</div>
					<div
						style="display: inline-block; width: 25%; text-align: center; font-size: 12pt;">
						적립포인트</div>
				</div>
				<div class="modal-body">
					<c:forEach items="${plist}" var="plist">
						<div
							style="display: inline-block; width: 20%; height: 30px; text-align: center;">
							${plist.lDate}</div>
						<div
							style="display: inline-block; width: 50%; height: 30px; text-align: left;">
							&nbsp;&nbsp;&nbsp;${plist.lContent}</div>
						<div
							style="display: inline-block; width: 25%; height: 30px; text-align: center;">
							${plist.point}&nbsp;<span class="icon-paypal"></span>
						</div>
					</c:forEach>
					<div class="modal-footer">
						<div
							style="display: inline-block; width: 25%; height: 30px; text-align: right; font-size: 12pt;">
							<span class="icon-paypal"></span><strong>총 포인트 :
								${user.point}</strong>
						</div>
						<br>
						<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</sec:authorize>