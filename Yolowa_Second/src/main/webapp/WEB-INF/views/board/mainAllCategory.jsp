<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN" />
<sec:authentication var="user" property="principal" />
<style>
	[id^=initRouteBtn]{
 		color:#5D676B;
	}
	[id^=initRouteBtn]:hover{
		color: #2196F3;
	}
	[id^=findRouteBtn]{
 		color:#5D676B;
	}
	[id^=findRouteBtn]:hover{
		color: #2196F3;
	}
	[id^=like]{
 		color:#5D676B;
	}
	[id^=like]:hover{
		color: #2196F3;
	}
	
	[id^='showReply']{
		color:#5D676B;
	}
	[id^='showReply']:hover{
		color:#2196F3;
	}
	#profileImg{
	width: 50px !important;
	height: 50px !important;
}
</style>
<script>
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
			}
		}
	});
}
</script>
<c:set var="bCListSize" value="${fn:length(bCList)}" />
<c:set var="localSize" value="0"></c:set>
<c:forEach items="${bCList}" var="bCList" varStatus="bOrder">
	<c:if test="${bCList.fTitle eq '0'}">
		<div class="col-md-12">
			<!--여기-->
			<div class="panel box-v7">
				<div class="panel-body">
				<div class="panel-heading bg-white border-none">
					<ul class="nav navbar-nav navbar-right user-nav">
						<li class="dropdown avatar-dropdown"
							onclick="bookMarkCheck('${bCList.bNo}')"><span
							class="icon-options-vertical" data-toggle="dropdown" /></span>
							<ul class="dropdown-menu user-dropdown">
								<c:choose>
									<c:when test="${user.id ==bCList.id}">
										<li><a href="modifyContentView.do?bNo=${bCList.bNo}">
												<span class="fa fa-refresh"></span> 수정
										</a></li>
										<li><a href="deleteBoard.do?bNo=${bCList.bNo}"><span
												class="fa fa-trash-o"></span> 삭제 </a></li>
									</c:when>
									<c:otherwise>
										<li><a onclick="bookMark('${bCList.bNo}')"><span
												class="fa fa-star-o" id="bookMark${bCList.bNo}"> </span></a></li>
									</c:otherwise>
								</c:choose>
							</ul></li>
					</ul>
					<h4>
						<span class="icon-notebook icons"></span> ${bCList.bType}
					</h4>
					<div style="display: inline-block; width: 25%; text-align: left;">
						작성자 : ${bCList.id}</div>
					<div style="display: inline-block; width: 30%; text-align: right;">
						등록일 : ${bCList.bPostdate}</div>
				</div>
				<hr>
				<div class="panel-body padding-0">
					<div class="col-md-12 col-xs-12 col-md-12 padding-0 box-v4-alert"
						style="background-color: #FFFFFF;">
						<pre style="background-color: #FFFFFF; border: 0px;">${bCList.bContent}</pre>
						<br>
						<c:if test="${bCList.filepath ne '0'}">
							<c:set var="checkFilePath" value="${bCList.filepath}" />
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
						<c:if test="${bCList.local ne '0'}">
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
									<span class="fa fa-undo fa-2x" id="initRouteBtn${bCList.bNo}"
										onclick="initRoute()"></span>
								</div>
							</div>
							<input type="hidden" id="local${localSize}"
								value="${bCList.local}">
							<c:set var="localSize" value="${localSize+1}"></c:set>
						</c:if>
						<a onclick="adminLike('${bCList.bNo}')"> <span
							class="fa fa-thumbs-o-up fa-2x" id="like${bCList.bNo}"></span></a> <span
							id="countLike${bCList.bNo}">${bCList.countlike}</span>
						&nbsp;&nbsp;&nbsp; <a><input type="hidden"
							value="${bCList.bNo}"> <span class="fa fa-angle-down"
							id="showReply${bCList.bNo}">댓글보기</span></a>
					</div>
						<!-- 댓글 -->
						<div class="col-md-12 padding-0 box-v7-comment" id="replyDIV${bCList.bNo}">
							<c:forEach items="${replyList}" var="rList">
								<c:if test="${bCList.bNo==rList.boardVO.bNo and rList.parentsNo==0}">
									<div class="media">
										<div class="media-left">
											<a href="mypage.do?id=${rList.memberVO.id}"><img
												src="${pageContext.request.contextPath}/${rList.memberVO.filePath}"
												class="img-circle media-object box-v7-avatar"  id="profileImg"/></a>
										</div>
										<div class="media-body" id="rContentDIV${rList.rNo}">
											<h5 class="media-heading">
												<b>${rList.memberVO.id}</b>
											</h5>
											<p id="rContent${rList.rNo}">${rList.rContent}</p>
											<c:if test="${user.id == rList.memberVO.id}">
												<input type="hidden" id="hide${rList.rNo}"
													value="${bCList.bNo}">
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
									<img src="${pageContext.request.contextPath}/${user.filePath}" id="profileImg"
										class="img-circle media-object box-v7-avatar" />
								</div>
								<div class="media-body" style="text-align: center;">
									<input type="hidden" value="${bCList.bNo}">
									<textarea class="box-v7-commenttextbox"
										name="rContent${bCList.bNo}" placeholder="write comments..."
										id="rContent"></textarea>
								</div>
							</div>
						</div>
					</div>
					<!-- 댓글 끝 -->
				</div>
			</div>
		</div>
	</c:if>
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