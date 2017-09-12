<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- spring security custom tag를 사용하기 위한 선언 --%>
<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- 알림창 CDN -->
<script src="//cdn.jsdelivr.net/alertifyjs/1.7.1/alertify.min.js"></script><!-- JavaScript -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.7.1/css/alertify.min.css"/><!-- CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.7.1/css/themes/default.min.css"/><!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.7.1/css/themes/semantic.min.css"/><!-- Semantic UI theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.7.1/css/themes/bootstrap.min.css"/><!-- Bootstrap theme -->
<script type="text/javascript">
	$(function() {
		$("#searhAll").click(function(){
			if($.trim($("#keywordAll").val())==""){
				alert("검색어를 입력하세요");
				$("#keywordAll").focus();
				return ;
			}else{
				location.href = "searchListByKeyword.do?keyword="+$.trim($("#keywordAll").val());
			}
		}); // click(searhAll)
		
		$( "#keywordAll" ).autocomplete({
	        source : function( request, response ) {
	             $.ajax({
	                    type: "get",
	                    url: "autoKeyword.do",
	                    dataType: "json",
	                    data: "keyword="+$.trim($("#keywordAll").val()),
	                    success: function(data) {
	                        response(
	                            $.map(data, function(item) {
	                                return {
	                                    label: item.KEYWORD,
	                                    value: item.KEYWORD
	                                } // return
	                            }) // map
	                        ); // response
	                    } // success
	               }); // ajax
	            }, // source
	    });	// autocomplete
	});	// function
</script>
<style>
.alertify-notifier .ajs-message.ajs-success{
	  background-color: #2196F3;
      color: white;
}
#toTop {
	z-index: 1030;
	width: 70px;
	height: 70px;
	border: 2px solid #72bbf8;
	background: #72bbf8;
	text-align: center;
	position: fixed;
	bottom: 50px;
	right: 50px;
	cursor: pointer;
	display: none;
	color: white;
	opacity: 0.6;
	filter: alpha(opacity = 60);
	-webkit-border-radius: 30px;
	-moz-border-radius: 30px;
	-o-border-radius: 30px;
	border-radius: 20px;
	-webkit-transition: all .25s linear;
	-moz-transition: all .25s linear;
	-o-transition: all .25s linear;
	transition: all .25s linear;
	padding: 5px;
}

#toTop:hover {
	background: #0d86ea;
	border: 2px solid #0d86ea;
}
</style>

<div class="col-md-12 nav-wrapper">
   <div class="navbar-header" style="width: 100%;">
   <sec:authorize ifNotGranted="ROLE_MEMBER">
   		<a class="navbar-brand"><span class = "fa fa-gift fa-lg" style = "margin-top:-5px; margin-left:-17px;"></span></a>	
		<a href="home.do" class="navbar-brand"> <b>YOLO WA</b></a>	
	</sec:authorize>
   
	<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN">
      <div class="opener-left-menu is-open">
         <span class="top"></span> <span class="middle"></span> <span
            class="bottom"></span>
      </div>
	</sec:authorize>
	
		<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN">
				 <a href="mainAllContent.do" class="navbar-brand"> <b>YOLO WA</b></a>
				  <ul class="nav navbar-nav search-nav">
         <li>
            <div class="search">
               <span class="fa fa-search icon-search" style="font-size: 23px; color:white;" id="searhAll"></span>
               <div class="form-group form-animate-text">
                  <input type="text" class="form-text" id="keywordAll" required>
                  <span class="bar"></span> <label class="label-search" style = "color:white;">Type
                     anywhere to <b style = "color:white;">Search</b>
                  </label>
               </div>
            </div>
         </li>
      </ul>
		</sec:authorize>
				
     
      <ul class="nav navbar-nav navbar-right user-nav">
          <sec:authorize ifNotGranted="ROLE_MEMBER">
               <li><a href="${pageContext.request.contextPath}/loginView.do"><span class="fa fa-power-off">
                        LogIn</span></a></li>
               <li><a href="${pageContext.request.contextPath}/registerView.do"><span class="fa fa-user">
                        SignUp</span></a></li>
           </sec:authorize>
            <sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN">
               <li class="user-name"><span><sec:authentication property="principal.name"/>(<span><sec:authentication property="principal.grade"/>)</span></li>
               <li class="dropdown avatar-dropdown"><img
                  src="${pageContext.request.contextPath }/<sec:authentication property="principal.filePath"/>"
                  class="img-circle avatar" alt="user name" data-toggle="dropdown"
                  aria-haspopup="true" aria-expanded="true" />
                  <ul class="dropdown-menu user-dropdown">
                     <li><a href="myMessagePage.do"><span class="fa fa-envelope"></span>　My Message</a></li>
                     <li><a href="mypage.do?id=<sec:authentication property="principal.id"/>"><span class="fa fa-user"></span>　 My Page</a></li>   
                     <li role="separator" class="divider"></li>
                     <li><a href="#" id="logoutClick"><span class="fa fa-power-off "></span>　 Logout</a></li>
                     <li><a href="withdrawView.do" ><span class="fa fa-ban "></span>　 Withdraw</a></li>
                  </ul>
               </li>
               <li><a href="#" class="opener-right-menu"><span
                     class="icon-list" id="tabBtn"></span></a></li>
                 </sec:authorize>
      </ul>
   </div>
</div>

<!-- Top 버튼 -->
<div id="toTop" align="right" ><i class="fa fa-angle-double-up fa-3x"></i><font size="4px">  Top</font></div>

<script type="text/javascript">
   $(document).ready(function() {
	   var sound = new Audio("${pageContext.request.contextPath}/resources/asset/media/alarm.mp3");
      $("#logoutClick").click(function() {
         var flag = confirm("로그아웃을 하시겠습니까?");
         if (flag == true) {
            location.href = "logout.do";
         }//if
      });//click
      /* 알림 script */
    	  $.ajax({
				type:"get",
				url:"requestList.do",
				dataType:"json",
				success:function(data){
					if(data != ""){
						alertify.success('친구 신청이 왔어요!!~~');
						sound.play();
						setInterval(() => {
							alertify.success('친구 신청이 왔어요!!~~');
							sound.play();
						}, 20000);
					}//if
				}//success
			});//ajax
			
			$.ajax({
				type:"get",
				url:"requestMsg.do",
				dataType:"json",
				success:function(data){
					if(data != ""){
						alertify.success('메세지가 왔어요!!~~');
						sound.play();
						setInterval(() => {
							alertify.success('메세지가 왔어요!!~~');
							sound.play();
						}, 20000);
					}//if
				}//success
			});//ajax
			
			$("#toTop").bind("click", function() {
				$("body").animate({scrollTop : 0}, 200);
				});//bind
			$(window).scroll(function() {
				if ($(this).scrollTop() != 0) {
					$('#toTop').fadeIn();
					} else {
						$('#toTop').fadeOut();
						}
				});//scroll
      });//ready
</script>

