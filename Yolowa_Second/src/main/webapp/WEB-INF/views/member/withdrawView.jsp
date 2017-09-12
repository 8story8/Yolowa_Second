<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- spring security custom tag를 사용하기 위한 선언 --%>
<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<!-- CSS -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
        <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/form-elements.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/style.css">

        <!-- Favicon and touch icons -->
        <link rel="shortcut icon" href="assets/ico/favicon.png">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath }/resources/assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath }/resources/assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath }/resources/assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/resources/assets/ico/apple-touch-icon-57-precomposed.png">


<style type="text/css">
.top-content {
	width: 100%;
}

.inner-bg {
	margin: auto;
	width: 1000px;
}

#loginForm {
	margin: auto;
	width: 100%;
}

#loginForm #secondLoginForm {
	margin: auto;
	width: 1000px;
}

#loginForm #secondLoginForm #lForm {
	margin: auto;
	width: 450px;
}
#blankDiv{
	margin-top: 30px;
}
</style>


</head>

<body>

	<!-- Top content -->
	<div class="top-content">

		<div class="inner-bg">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2 text">
					<h1>You only live Once</h1>
					<div class="description">
						<p>
							<strong>YOLO</strong> 라는 뜻은 <strong>"You Only Live Once"</strong>  입니다.<br>
							보다 더 좋은 서비스를 위해 저희는 고객의 입장에서 항상 생각 합니다. <br> <a
								href="${pageContext.request.contextPath }/home.do" ><strong>YoloWa</strong></a>
							 ← 누르시면 이전 페이지로 이동 합니다.<br>
						</p>
					</div>
				</div>
			</div>
	<div class="row" id="blankDiv"></div>
			<div class="row" id="loginForm">
				<div id="secondLoginForm">
					<div class="form-box" id="lForm">
						<div class="form-top">
							<div class="form-top-left">
								<h3>Withdraw to our site</h3>
								<p>Enter password to Withdraw:</p>
							</div>
							<div class="form-top-right">
								<i class="fa fa-key"></i>
							</div>
						</div>
						<div class="form-bottom">
							<form role="form" action="withdraw.do" method="post" class="login-form">
								<div class="form-group">
									<label class="sr-only" for="form-username">Username</label> <input
										type="text" name="id" placeholder="User ID..."
										class="form-username form-control" id="form-username"
										value="<sec:authentication property="principal.id"/>" readonly="readonly">
								</div>
								<div class="form-group">
									<label class="sr-only" for="form-password">Password</label> <input
										type="password" name="password" placeholder="Password..."
										class="form-password form-control" id="form-password">
									<span id="passCheckView" 
									style="margin-top: 10px;"></span>
								</div>
								<button type="submit" class="btn">Withdraw!</button>
							</form>
						</div>
					</div>

					<div class="social-login">
						<div class="social-login-buttons">
							<a class="btn btn-link-1 btn-link-1-facebook" href="home.do"> <i
								class="fa"></i>Home
							</a> <a class="btn btn-link-1 btn-link-1-twitter" href="changePassCheck.do"> <i
								class="fa"></i>Change Pass
							</a> <a class="btn btn-link-1 btn-link-1-google-plus" href="registerView.do"> <i
								class="fa"></i>Sign up
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<footer>
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					<div class="footer-border"></div>
					<p>
						Made by Kosta145  <a href="${pageContext.request.contextPath }/home.do" ><strong>YoloWa</strong></a>
						having a lot of fun. <i class="fa fa-smile-o"></i>
					</p>
				</div>
			</div>
	</footer>
        <!-- Javascript -->
        <script src="${pageContext.request.contextPath }/resources/assets/js/jquery-1.11.1.min.js"></script>
        <script src="${pageContext.request.contextPath }/resources/assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath }/resources/assets/js/jquery.backstretch.min.js"></script>
        <script src="${pageContext.request.contextPath }/resources/assets/js/scripts.js"></script>
</body>
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			var checkResultPass="";
			$(":input[name=password]").keyup(function(){
				var pass=$(this).val().trim();
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath}/passCheckAjax.do",			
					data:"password="+pass,	
					success:function(data){						
						if(data=="fail"){
						$("#passCheckView").html("불일치!").css("color", "orange");
							checkResultpass="";
						}else{						
							$("#passCheckView").html("일치!").css("color", "white");		
							checkResultPass=pass;
						}					
					}//callback			
				});//ajax
			});//keyup
		});
</script>
</html>