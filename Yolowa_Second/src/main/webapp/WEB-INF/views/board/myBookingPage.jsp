<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN" />
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

[id^=initRouteBtn] {
	color: #5D676B;
}

[id^=initRouteBtn]:hover {
	color: #2196F3;
}

[id^=findRouteBtn] {
	color: #5D676B;
}

[id^=findRouteBtn]:hover {
	color: #2196F3;
}

[id^=like] {
	color: #5D676B;
}

[id^=like]:hover {
	color: #2196F3;
}

[id^='showReply'] {
	color: #5D676B;
}

[id^='showReply']:hover {
	color: #2196F3;
}

#profileImg {
	width: 50px !important;
	height: 50px !important;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#friendList").click(function() {
			location.href = "MyListPage.do?id=${user.id}";
		});//click
		$("#pointList").click(function() {
			$("#pointModal").modal();
		});//click
	});//ready
	
	$(function() {
		$("[id^='replyDIV']").hide();
		// 댓글보기 or 접기
		$("[id^='showReply']").click(function(){
			var bNo=$(this).prev().val();
			$("[id='replyDIV"+bNo+"']").toggle(function(){
				var result=$("[id='replyDIV"+bNo+"']").css("display")=="none";
				if(result){
					$("[id='showReply"+bNo+"']").text("댓글달기");
				}else{			
					$("[id='showReply"+bNo+"']").text("댓글접기");					
				}
			});
		});
		
	// 댓글 수정, 삭제
		$("[id^='replyDIV']").on("click","a",function(){
			var rNo="";
			var bNo="";
			if($(this).attr("title")=="update"){
				rNo=$(this).prev().val();
				bNo=$("#hide"+rNo).val();
				var rContent=$("#rContent"+rNo).text();
				var modifyText="";
				modifyText += "<input type='hidden' value='"+rNo+"'>";
				modifyText += "<textarea class='box-v7-commenttextbox' name='modiContent"+rNo+"' id='modiContent'>"+rContent+"</textarea>";
				$("#rContentDIV"+rNo).html(modifyText);
			}else if($(this).attr("title")=="delete"){
				rNo=$(this).prev().prev().val();
				bNo=$("#hide"+rNo).val();
				var mid="${user.id}";
			    var filePath="${user.filePath}";
				if(confirm("댓글을 삭제하시겠습니까?")){
					  $.ajax({
							type:"get",
							url:"deleteReply.do",
							dataType:"json",
							data:"rNo="+rNo,
							success:function(data){
								var replyText = "";
								for(var i=0; i<data.length; i++){
									if(data[i].parentsNo==0 && data[i].boardVO.bNo==bNo){
										replyText += "<div class='media'><div class='media-left'>";
										replyText += "<a href='mypage.do?id="+data[i].memberVO.id+"'><img src='${pageContext.request.contextPath}/"+data[i].memberVO.filePath+"' class='img-circle media-object box-v7-avatar' id='profileImg'/></a>";
										replyText += "</div><div class='media-body' id='rContentDIV"+data[i].rNo+"'>";
										replyText += "<h5 class='media-heading'><b>"+data[i].memberVO.id+"</b></h5>";
										replyText += "<p id='rContent"+data[i].rNo+"'>"+data[i].rContent+"</p>";
										if(mid == data[i].memberVO.id){
											replyText += "<input type='hidden' id='hide"+data[i].rNo+"' value='"+bNo+"'>";
											replyText += "<input type='hidden' value='"+data[i].rNo+"'>";
											replyText += "<a id='modifyReply' title='update' class='fa icon-pencil'>";
											replyText += "</a>&nbsp;&nbsp;<a id='deleteReply' title='delete' class='fa icon-trash'></a>";
										}
										replyText += "</div></div>";
									}
								}
								replyText += "<div class='media' style='margin-top: -1px;'><div class='media-left'>";
								replyText += "<img src='${pageContext.request.contextPath}/"+filePath+"' class='img-circle media-object box-v7-avatar' id='profileImg'/>";
								replyText += "</div><div class='media-body' style='text-align: center;'>";
								replyText += "<input type='hidden' value='"+bNo+"'>";
								replyText += "<textarea class='box-v7-commenttextbox' name='rContent"+bNo+"' placeholder='write comments...' id='rContent' ></textarea>";
								replyText += "</div></div>";
								$("#replyDIV"+bNo).html(replyText);
								$("[id='replyDIV"+bNo+"']").show();
								$("[id='showReply"+bNo+"']").text("댓글접기");	
							}//success
						});//ajax
				}else{
					return false;
				}
			}
		});	// delete Reply
		
		// 댓글 작성, 수정
		$("[id^='replyDIV']").on("keypress","textarea",function(event){
				  if(event.which == 13){
					  if($(this).attr("id")=="rContent"){
					      var rContent=$(this).val();
					      var mid="${user.id}";
					      var filePath="${user.filePath}";
					      var bNo=$(this).prev().val();
					      $.ajax({
								type:"get",
								url:"writeReply.do",
								dataType:"json",
								data:"rContent="+rContent+"&memberVO.id="+mid+"&boardVO.bNo="+bNo,
								success:function(data){
									$("#replyDIV"+bNo).empty();
									var replyText = "";
									for(var i=0; i<data.length; i++){
										if(data[i].parentsNo==0 && data[i].boardVO.bNo==bNo){
											replyText += "<div class='media'><div class='media-left'>";
											replyText += "<a href='mypage.do?id="+data[i].memberVO.id+"'><img src='${pageContext.request.contextPath}/"+data[i].memberVO.filePath+"' class='img-circle media-object box-v7-avatar' id='profileImg'/></a>";
											replyText += "</div><div class='media-body' id='rContentDIV"+data[i].rNo+"'>";
											replyText += "<h5 class='media-heading'><b>"+data[i].memberVO.id+"</b></h5>";
											replyText += "<p id='rContent"+data[i].rNo+"'>"+data[i].rContent+"</p>";
											if(mid == data[i].memberVO.id){
												replyText += "<input type='hidden' id='hide"+data[i].rNo+"' value='"+bNo+"'>";
												replyText += "<input type='hidden' value='"+data[i].rNo+"'>";
												replyText += "<a id='modifyReply' title='update' class='fa icon-pencil'>";
												replyText += "</a>&nbsp;&nbsp;<a id='deleteReply' title='delete' class='fa icon-trash'></a>";
										}
											replyText += "</div></div>";
										}
									}
									replyText += "<div class='media' style='margin-top: -1px;'><div class='media-left'>";
									replyText += "<img src='${pageContext.request.contextPath}/"+filePath+"' class='img-circle media-object box-v7-avatar' id='profileImg'/>";
									replyText += "</div><div class='media-body' style='text-align: center;'>";
									replyText += "<input type='hidden' value='"+bNo+"'>";
									replyText += "<textarea class='box-v7-commenttextbox' name='rContent"+bNo+"' placeholder='write comments...' id='rContent' ></textarea>";
									replyText += "</div></div>";
									$("#replyDIV"+bNo).html(replyText);
									$("[id='replyDIV"+bNo+"']").show();
									$("[id='showReply"+bNo+"']").text("댓글접기");	
									rContent.val("");
								}//success
							});//ajax 
					  }else if($(this).attr("id")=="modiContent"){
							var rNo=$(this).prev().val();
							var rContent=$(this).val();
							$.ajax({
								type:"get",
								url:"modifyReply.do",
								dataType:"json",
								data:"rNo="+rNo+"&rContent="+rContent,
								success:function(data){
									var modifyText = "";
									modifyText += "<h5 class='media-heading'><b>"+data.memberVO.id+"</b></h5>";
									modifyText +=  "<p id='rContent"+data.rNo+"'>"+data.rContent+"</p>";
									if("${user.id}" == data.memberVO.id){
										modifyText += "<input type='hidden' id='hide"+rNo+"' value='"+data.boardVO.bNo+"'>";
										modifyText += "<input type='hidden' value='"+rNo+"'>";
										modifyText += "<a id='modifyReply' title='update' class='fa icon-pencil'>";
										modifyText += "</a>&nbsp;&nbsp;<a id='deleteReply' title='delete' class='fa icon-trash'></a>";
									}
									$("#rContentDIV"+rNo).html(modifyText);
									$("[id='replyDIV"+data.boardVO.bNo+"']").show();
									$("[id='showReply"+data.boardVO.bNo+"']").text("댓글접기");	
								}//success
							});//ajax
						}
				  } 
			   });
	}); // function
	   
	function adminLike(bNo){
		$.ajax({
			type:"POST",
			url:"adminLike.do",
			data:{"bNo":bNo, "id":'${user.id}'},
			dataType:"json",
			success:function(data){
				var countLike = $("#countLike"+bNo);
				if(countLike.text() == parseInt(data.length-1)+'명'){
					countLike.html('회원님 외 ' + parseInt(data.length-1) + '명');
				}
				else if(countLike.text() == "회원님 외 " + parseInt(data.length) + "명"){
					countLike.html(parseInt(data.length) + '명');
				}
				else if(parseInt(countLike.text().length) == 0){
					countLike.html('${user.id}'+"님");
				}
				else if(countLike.text() == '${user.id}'+"님"){
					countLike.html("");
				}
			}
		});	
	}
//북마크
	function bookMarkCheck(bNo) {
	var check=$("#bookMark"+bNo);
	$.ajax({
		type:"POST",
		url:"bookMarkCheck.do",
		data:{"bNo":bNo, "id":'${user.id}'},
		dataType:"json",
		success:function(data){
			if(data==0){
				check.attr('class', 'fa fa-star-o')
				$("span.fa-star-o").text("즐겨찾기");
			}else if(data==1){
				check.attr('class', 'fa fa-star')
				$("span.fa-star").text("즐겨찾기 ");
			}
	}
});	
}
function bookMark(bNo) {
	var text= $("#bookMark"+bNo);
	$.ajax({
		type:"POST",
		url:"bookMark.do",
		data:{"bNo":bNo, "id":'${user.id}', "type":text.text()},
		success:function(data){
			if(data=="1"){
			text.attr('class','fa fa-star');
			}else{
			text.attr('class','fa fa-star-o');
			location.reload();
			}
		}
	});
}
	//펀딩
 function applyFunding(bNo){
	var point='${myPoint}';
	var type=$("#applyType"+bNo).val();
	var id = '${user.id}';
	if(type=="신청"){	
		if(parseInt(point)<100){
			alert("포인트가 부족합니다");
			return false;
		}
		$.ajax({
			type:"POST",
			url:"checkPaticipant.do",
			data:{"bNo":bNo, "id":id,"type":type},
			dataType:"json",
			success:function(data){
				$("#pointNow"+bNo).text(data.TOTALPOINT);
				$("#countNow"+bNo).text(data.COUNT);
				document.getElementById("nowPoint"+bNo).value = parseInt(data.TOTALPOINT);
				document.getElementById("nowCount"+bNo).value = data.COUNT;
				$("#applyFunding"+bNo).text("취소");
				$("#applyType"+bNo).val("취소");
				location.reload();
				}	
			});
	}else if(type=="취소"){
		$.ajax({
			type:"POST",
			url:"checkPaticipant.do",
			data:{"bNo":bNo, "id":id,"type":type},
			dataType:"json",
			success:function(data){
				$("#countNow"+bNo).text(data.COUNT);
				document.getElementById("nowCount"+bNo).value = data.COUNT;
				if(typeof data.TOTALPOINT == 'undefined'){
					document.getElementById("nowPoint"+bNo).value="";
					$("#pointNow"+bNo).text("");
				}else{
					document.getElementById("nowPoint"+bNo).value = parseInt(data.TOTALPOINT);
					$("#pointNow"+bNo).text(data.TOTALPOINT);
				}
				$("#applyFunding"+bNo).text("신청");
				$("#applyType"+bNo).val("신청");
				location.reload();
			}	
		});
	}else if(type=="마감"){
		alert("이미 마감되었습니다");
	}
}
 function openModal(bNo) {
		$("#myModal" + bNo).modal();
	}
</script>
<div class="row">
	<div class="profile-v1 col-md-12 col-sm-12 profile-v1-wrapper">
		<div class="col-md-9  profile-v1-cover-wrap"
			style="padding-right: 0px;">
			<c:choose>
				<c:when test="${!empty fvo}">
					<div class="profile-v1-pp">
						<ul class="nav navbar-nav navbar-right user-nav" id="name">
							<li class="dropdown avatar-dropdown"><img
								src="${pageContext.request.contextPath}/${fvo.filePath}"
								alt="user name" data-toggle="dropdown" />
								<ul style="margin-top: -13px; margin-left: -40px;">
									<h2>
										<b>${fvo.name}</b>
									</h2>
								</ul></li>
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
								</ul>
								<ul style="margin-top: -13px; margin-left: -40px;">
									<h2>
										<b>${user.name}</b>
									</h2>
								</ul></li>
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
							<p>${requestScope.friendList}</p>
						</div>
					</div>
					<div class="col-md-12 col-sm-4 profile-v1-right-wrap padding-0">
						<div
							class="col-md-12 sub-profile-v1-right text-center sub-profile-v1-right2">
							<h2>Point</h2>
							<p>${requestScope.fvo.point}</p>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col-md-12 col-sm-4 profile-v1-right-wrap padding-0">
						<div
							class="col-md-12 padding-0 sub-profile-v1-right text-center sub-profile-v1-right1"
							id="friendList">
							<h2>Friends</h2>
							<p>${requestScope.friendList}</p>
						</div>
					</div>
					<div class="col-md-12 col-sm-4 profile-v1-right-wrap padding-0">
						<div
							class="col-md-12 sub-profile-v1-right text-center sub-profile-v1-right2"
							id="pointList">
							<h2>Point</h2>
							<p>${user.point}</p>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<!--  즐겨찾기 리스트출력  -->
<div class="row">
	<div class="col-sm-7">
		<c:set var="bListSize" value="${fn:length(bList)}" />
		<c:set var="localSize" value="0"></c:set>
		<c:forEach items="${bList}" var="bList" varStatus="bOrder">
			<!--여기-->
			<div class="col-md-7 panel box-v7" style="width: 110%;">
				<div class="panel-body" style="width: 100%;">
					<div class="panel-heading bg-white border-none">
						<ul class="nav navbar-nav navbar-right user-nav">
							<li class="dropdown avatar-dropdown"
								onclick="bookMarkCheck('${bList.bNo}')"><span
								class="icon-options-vertical" data-toggle="dropdown" /></span>
								<ul class="dropdown-menu user-dropdown">
									<c:choose>
										<c:when test="${user.id ==bList.id}">
											<li><a href="modifyContentView.do?bNo=${bList.bNo}">
													<span class="fa fa-refresh"></span> 수정
											</a></li>
											<li><a href="deleteBoard.do?bNo=${bList.bNo}"><span
													class="fa fa-trash-o"></span> 삭제 </a></li>
										</c:when>
										<c:otherwise>
											<li><a onclick="bookMark('${bList.bNo}')" href="#"><span
													class="fa fa-star-o" id="bookMark${bList.bNo}"> </span></a></li>
										</c:otherwise>
									</c:choose>
								</ul></li>
						</ul>
						<h4>
							<span class="icon-notebook icons"></span> ${bList.bType}
						</h4>
						<div style="display: inline-block; width: 25%; text-align: left;">
							작성자 : ${bList.id}</div>
						<div style="display: inline-block; width: 30%; text-align: right;">
							등록일 : ${bList.bPostdate}</div>
					</div>
					<div class="panel-body padding-0">
						<div class="col-md-12 col-xs-12 col-md-12 padding-0 box-v4-alert"
							style="background-color: #FFFFFF;">
							<c:if test="${bList.filepath ne '0'}">
								<c:set var="checkFilePath" value="${bList.filepath}" />
								<c:set var="checkFilePathArray"
									value="${fn:split(checkFilePath,'/')}" />
								<!-- Image Carousel -->
								<div id="imageCarousel${bOrder.count}" class="carousel slide"
									data-ride="carousel">
									<!-- Indicators -->
									<ol class="carousel-indicators">
										<c:forEach items="${checkFilePathArray}" var="filePath"
											varStatus="order">
											<c:choose>
												<c:when test="${order.count eq 1}">
													<li data-target="#imageCarousel${bOrder.count}"
														data-slide-to="${order.count}" class="active"></li>
												</c:when>
												<c:otherwise>
													<li data-target="#imageCarousel${bOrder.count}"
														data-slide-to="${order.count}"></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</ol>

									<!-- Wrapper for slides -->
									<div class="carousel-inner">
										<c:forEach items="${checkFilePathArray}" var="filePath"
											varStatus="order">
											<c:choose>
												<c:when test="${order.count eq 1}">
													<div class="item active">
														<img
															src="${pageContext.request.contextPath}/resources/asset/upload/${filePath}"
															style="width: 100%; height: 300px;" alt="아나${filePath}">
													</div>
												</c:when>
												<c:otherwise>
													<div class="item">
														<img
															src="${pageContext.request.contextPath}/resources/asset/upload/${filePath}"
															style="width: 100%; height: 300px;" alt="아나${filePath}">
													</div>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</div>

									<!-- Left and right controls -->
									<a class="left carousel-control"
										href="#imageCarousel${bOrder.count}" data-slide="prev"> <span
										class="glyphicon glyphicon-chevron-left"></span> <span
										class="sr-only">Previous</span>
									</a> <a class="right carousel-control"
										href="#imageCarousel${bOrder.count}" data-slide="next"> <span
										class="glyphicon glyphicon-chevron-right"></span> <span
										class="sr-only">Next</span>
									</a>
								</div>
								<br>
							</c:if>
							<c:if test="${bList.fTitle !=null}">
								<div
									style="display: inline-block; width: 35%; text-align: center;">
									현재/목표포인트 <br> <span id="pointNow${bList.bNo}">${bList.totalpoint}</span>
									<progress id="nowPoint${bList.bNo}" value="${bList.totalpoint}"
										max="${bList.fPoint}"> </progress>
									${bList.fPoint}<br>
								</div>
								<div
									style="display: inline-block; width: 35%; text-align: center;">
									현재/목표인원 <br> <span id="countNow${bList.bNo}">
										${bList.count} </span>
									<progress id="nowCount${bList.bNo}" value="${bList.count}"
										max="${bList.fPeople}"> </progress>
									${bList.fPeople}<br>
								</div>
								<div
									style="display: inline-block; width: 25%; text-align: center;">
									마감일<br> ${bList.fDeadLine}
								</div>
								<br>
								<br>
							</c:if>
							<pre style="background-color: #FFFFFF; border: 0px;">${bList.bContent}</pre>
							<c:if test="${bList.local ne '0'}">
								<div class="map" id="map${localSize}"
									style="width: 100%; height: 300px;"></div>
								<br>
								<div class="form-group row" style="margin-left: 1px;">
									<div class="col-xs-6" style="padding: 0px;">
										<input type="text" class="form-control" id="org${localSize}">
									</div>
									<div class="col-xs-1">
										<span class="fa fa-search fa-2x icon-search"
											id="findRouteBtn${localSize}"></span>
									</div>
									<div class="col-xs-2">
										<span class="fa fa-undo fa-2x" id="initRouteBtn${bList.bNo}"
											onclick="initRoute()"></span>
									</div>
								</div>

								<input type="hidden" id="local${localSize}"
									value="${bList.local}">
								<c:set var="localSize" value="${localSize+1}"></c:set>
							</c:if>
							<a onclick="adminLike('${bList.bNo}')"> <span
								class="fa fa-thumbs-o-up fa-2x" id="like${bList.bNo}"></span></a> <span
								id="countLike${bList.bNo}">${bList.countlike}</span>
							<c:if test="${bList.fTitle !=null}">
								<c:choose>
									<c:when test="${bList.id != user.id}">
										<div class="col-md-6 col-sm-6 col-xs-6 padding-0"
											style="float: right;">
											<div class="col-md-6 col-sm-6 col-xs-6 tool"></div>
										</div>
									</c:when>
									<c:when test="${bList.id == user.id}">
									</c:when>
								</c:choose>
							</c:if>
							&nbsp;&nbsp;&nbsp; <a><input type="hidden"
								value="${bList.bNo}"> <span class="fa fa-angle-down"
								id="showReply${bList.bNo}">댓글보기</span></a>
						</div>
						<!-- 댓글 -->
						<div class="col-md-12 padding-0 box-v7-comment"
							id="replyDIV${bList.bNo}">
							<c:forEach items="${replyList}" var="rList">
								<c:if
									test="${bList.bNo==rList.boardVO.bNo and rList.parentsNo==0}">
									<div class="media">
										<div class="media-left">
											<a href="mypage.do?id=${rList.memberVO.id}"><img
												src="${pageContext.request.contextPath}/${rList.memberVO.filePath}"
												class="img-circle media-object box-v7-avatar"
												id="profileImg" /></a>
										</div>
										<div class="media-body" id="rContentDIV${rList.rNo}">
											<h5 class="media-heading">
												<b>${rList.memberVO.id}</b>
											</h5>
											<p id="rContent${rList.rNo}">${rList.rContent}</p>
											<c:if test="${user.id == rList.memberVO.id}">
												<input type="hidden" id="hide${rList.rNo}"
													value="${bList.bNo}">
												<input type="hidden" value="${rList.rNo}">
												<a id="modifyReply" title="update" class="fa icon-pencil">
												</a>&nbsp;&nbsp;<a id="deleteReply" title="delete"
													class="fa icon-trash"></a>
											</c:if>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<!-- 댓글 쓰기 -->
							<div class="media">
								<div class="media-left">
									<img src="${pageContext.request.contextPath}/${user.filePath}"
										id="profileImg" class="img-circle media-object box-v7-avatar" />
								</div>
								<div class="media-body" style="text-align: center;">
									<input type="hidden" value="${bList.bNo}">
									<textarea class="box-v7-commenttextbox"
										name="rContent${bList.bNo}" placeholder="write comments..."
										id="rContent"></textarea>
								</div>
							</div>
						</div>
					</div>
					<!-- 댓글 끝 -->
				</div>
			</div>
		</c:forEach>
	</div>
	<!-- funding List 보여주기 -->
	<div class="col-sm-4" style="width: 400px; margin-left: 62px;">
		<div class="panel">
			<div class="panel-heading" style="background-color: #2196F3;">
				<h4>
					<b style="color: #FFFFFF;"> 진행중인 펀딩 </b>
				</h4>
			</div>
			<div class="panel-body">
				<div class="col-md-12 list-timeline-section bg-light">
					<div class="col-md-12 list-timeline-detail">
						<c:forEach var="fList" items="${requestScope.fList}">
							<c:if test="${fList.fTitle ne '0'}">
								<fmt:parseNumber value="${fList.count}" pattern="0,000.00"
									var="count" />
								<fmt:parseNumber value="${fList.fPeople}" pattern="0,000.00"
									var="fPeople" />
								<c:choose>
									<c:when test="${fList.bType eq '스포츠'}">
										<div class="media">
											<div class="media-left">
												<span class=" icon-social-dribbble icons"
													style="font-size: 2em;" onclick="openModal('${fList.bNo}')"></span>
											</div>
											<div class="media-body">
												<h5 class="media-heading">${fList.fTitle}</h5>
												<div class="progress progress-mini">
													<div class="progress-bar" role="progressbar"
														aria-valuenow="${fList.count}" aria-valuemin="0"
														aria-valuemax="${fList.fPeople}"
														style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
												</div>
											</div>
										</div>
									</c:when>
									<c:when test="${fList.bType eq '영화'}">
										<div class="media">
											<div class="media-left">
												<span class="icon-camrecorder icons" style="font-size: 2em;"
													onclick="openModal('${fList.bNo}')"></span>
											</div>
											<div class="media-body">
												<h5 class="media-heading">${fList.fTitle}</h5>
												<div class="progress progress-mini">
													<div class="progress-bar" role="progressbar"
														aria-valuenow="${fList.count}" aria-valuemin="0"
														aria-valuemax="${fList.fPeople}"
														style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
												</div>
											</div>
										</div>
									</c:when>
									<c:when test="${fList.bType eq '게임'}">
										<div class="media">
											<div class="media-left">
												<span class="icon-game-controller icons"
													style="font-size: 2em;" onclick="openModal('${fList.bNo}')"></span>
											</div>
											<div class="media-body">
												<h5 class="media-heading">${fList.fTitle}</h5>
												<div class="progress progress-mini">
													<div class="progress-bar" role="progressbar"
														aria-valuenow="${fList.count}" aria-valuemin="0"
														aria-valuemax="${fList.fPeople}"
														style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
												</div>
											</div>
										</div>
									</c:when>
									<c:when test="${fList.bType eq '도서'}">
										<div class="media">
											<div class="media-left">
												<span class="icon-book-open icons" style="font-size: 2em;"
													onclick="openModal('${fList.bNo}')"></span>
											</div>
											<div class="media-body">
												<h5 class="media-heading">${fList.fTitle}</h5>
												<div class="progress progress-mini">
													<div class="progress-bar" role="progressbar"
														aria-valuenow="${fList.count}" aria-valuemin="0"
														aria-valuemax="${fList.fPeople}"
														style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
												</div>
											</div>
										</div>
									</c:when>
									<c:when test="${fList.bType eq '여행'}">
										<div class="media">
											<div class="media-left">
												<span class="icon-plane icons" style="font-size: 2em;"
													onclick="openModal('${fList.bNo}')"></span>
											</div>
											<div class="media-body">
												<h5 class="media-heading">${fList.fTitle}</h5>
												<div class="progress progress-mini">
													<div class="progress-bar" role="progressbar"
														aria-valuenow="${fList.count}" aria-valuemin="0"
														aria-valuemax="${fList.fPeople}"
														style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
												</div>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="media">
											<div class="media-left">
												<span class=" icon-home icons" style="font-size: 2em;"
													onclick="openModal('${fList.bNo}')"></span>
											</div>
											<div class="media-body">
												<h5 class="media-heading">${fList.fTitle}</h5>
												<div class="progress progress-mini">
													<div class="progress-bar" role="progressbar"
														aria-valuenow="${fList.count}" aria-valuemin="0"
														aria-valuemax="${fList.fPeople}"
														style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
												</div>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
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
<c:forEach items="${requestScope.fList}" var="fList" varStatus="fOrder">
	<div class="modal fade" id="myModal${fList.bNo}" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" style="text-align: center;">상세정보</h4>
				</div>
				<div class="modal-body">
					<div style="display: inline-block; width: 20%; text-align: left;">
						${fList.bType}</div>
					<div style="display: inline-block; width: 50%; text-align: center;">
						제목 : ${fList.fTitle}</div>
					<div style="display: inline-block; width: 25%; text-align: right;">
						${fList.bPostdate}</div>
					<hr>
					<div>
						<pre>${fList.bContent}</pre>
					</div>
					<c:if test="${fList.filepath ne '0'}">
						<c:set var="checkFilePath" value="${fList.filepath}" />
						<c:set var="checkFilePathArray"
							value="${fn:split(checkFilePath,'/')}" />
						<!-- Image Carousel -->
						<div id="modalImageCarousel${fOrder.count}" class="carousel slide"
							data-ride="carousel">
							<!-- Indicators -->
							<ol class="carousel-indicators">
								<c:forEach items="${checkFilePathArray}" var="filePath"
									varStatus="order">
									<c:choose>
										<c:when test="${order.count eq 1}">
											<li data-target="#modalImageCarousel${fOrder.count}"
												data-slide-to="${order.count}" class="active"></li>
										</c:when>
										<c:otherwise>
											<li data-target="#modalImageCarousel${fOrder.count}"
												data-slide-to="${order.count}"></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ol>

							<!-- Wrapper for slides -->
							<div class="carousel-inner">
								<c:forEach items="${checkFilePathArray}" var="filePath"
									varStatus="order">
									<c:choose>
										<c:when test="${order.count eq 1}">
											<div class="item active">
												<img
													src="${pageContext.request.contextPath}/resources/asset/upload/${filePath}"
													style="width: 100%; height: 300px;" alt="아나${filePath}">
											</div>
										</c:when>
										<c:otherwise>
											<div class="item">
												<img
													src="${pageContext.request.contextPath}/resources/asset/upload/${filePath}"
													style="width: 100%; height: 300px;" alt="아나${filePath}">
											</div>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</div>

							<!-- Left and right controls -->
							<a class="left carousel-control"
								href="#modalImageCarousel${fOrder.count}" data-slide="prev">
								<span class="glyphicon glyphicon-chevron-left"></span> <span
								class="sr-only">Previous</span>
							</a> <a class="right carousel-control"
								href="#modalImageCarousel${fOrder.count}" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right"></span> <span
								class="sr-only">Next</span>
							</a>
						</div>
						<br>
					</c:if>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>
<script>
function initRoute(){
	initMap();
	for(var i = 0; i < ${localSize}; i++){
        $("#org"+i).val('');   
     }
}

   function initMap() {
      var map;
      var mapArray = new Array();
      var geocoder = new google.maps.Geocoder();
      var initMarker;
      var initInfoWindow;
      var localSize = ${localSize};
      var tempLocal = new Array();

      var directionsDisplay = new google.maps.DirectionsRenderer();
      var directionsService = new google.maps.DirectionsService;
      var onClickHandler = new Array();

      $.each($('.map'), function(index) {
         var id = this.id;
         var local = $("#local" + index).val();
         var map = new google.maps.Map(document.getElementById(id), {
                        zoom : 16
                     });
         
            geocoder.geocode({'address' : local}, function(results, status) {
            if (status === 'OK') {
               map.setCenter(results[0].geometry.location);
               initInfoWindow = new google.maps.InfoWindow({
                                    content:local
                                 });
                  
               initMarker = new google.maps.Marker({
                              map : map,
                              position : results[0].geometry.location
                           });
               
               initInfoWindow.open(map, initMarker);
               mapArray.push(map);
                                       
               tempLocal.push(results[0].geometry.location);
                                       
               onClickHandler.push(function(){
                  directionsDisplay.setMap(mapArray[index]);
                  findRoute(directionsService, directionsDisplay, index, results[0].geometry.location, mapArray);
               });

               if (tempLocal.length == localSize) {
                  for (var i = 0; i < tempLocal.length; i++) {
                     document.getElementById('findRouteBtn'+ i).addEventListener('click', onClickHandler[i]);
                  }
               }
            } 
            else {
               alert('Fail : '+ status);
            }
         });
      });
   }

var findRouteMarker;
   function findRoute(directionsService, directionsDisplay, index, dest, mapArray) {
      var org = $("#org" + index).val();
      var dest = dest;

      var request = {
         origin : org,
         destination : dest,
         travelMode : google.maps.TravelMode["TRANSIT"]
      }

      directionsService.route(request, function(response, status) {
         if (status == 'OK') {
            var route = response.routes[0].legs[0];
            directionsDisplay.setOptions({suppressMarkers: true});
            var findRouteInfoWindow = new google.maps.InfoWindow({
                  content:org
            });
      
            if (findRouteMarker && findRouteMarker.setMap) {
               findRouteMarker.setMap(null);
            }
            
            findRouteMarker = new google.maps.Marker({
                  position:route.start_location,
                  map: mapArray[index],
                  icon:'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
            });
            
            findRouteInfoWindow.open(mapArray[index], findRouteMarker);
            directionsDisplay.setDirections(response);

         } else {
            alert("Fail : " + status);
         }
      });
   }
</script>

<!-- end: content -->





