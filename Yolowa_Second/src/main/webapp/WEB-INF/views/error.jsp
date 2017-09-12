<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Miminium Admin Template v.1">
<meta name="author" content="Isna Nur Azis">
<meta name="keyword" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>login</title>

<jsp:include page="/resources/asset/util/plugutill.html"></jsp:include>

</head>

<body id="mimin" class="dashboard form-signin-wrapper">

	<div class="container">

		<form class="form-signin" style="max-width: 500px;">
			<div class="panel periodic-login">
				<div class="panel-body text-center">
					<!-- <h1 class="atomic-symbol">YOLO WA!</h1> -->
					<a href="home.do"><h1>YOLO WA!</h1></a>
					<p class="element-name">You Only Live Once</p>
					<br>
					<br>
					<h2>죄송합니다.</h2>
					<h3>요청하신 페이지를 찾을 수가 없습니다.</h3><br>
					찾으시려는 페이지는 주소를 잘못 입력하였거나<br>
					페이지 주소의 변경 또는 삭제 등의 이유로 페이지를 찾을 수 없습니다.<br>
					입력하신 페이지의 주소와 경로가 정확한지 한번더 확인 후 이용하시기 바랍니다. <br>
					 <input type="button" id="home" class="btn col-md-12" value="확인" />
				</div>
			</div>
		</form>

	</div>
	<jsp:include page="/resources/asset/util/scriptutill.html"></jsp:include>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#home").click(function(){
				location.href="home.do";
			})
		});
	</script>
	<!-- end: Javascript -->
</body>
</html>