<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Miminium Admin Template v.1">
<meta name="author" content="Isna Nur Azis">
<meta name="keyword" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/resources/asset/util/plugutill.html"></jsp:include>
<!--  Tiles -->
<title><tiles:insertAttribute name="title" ignore="true" /></title>
</head>
<body id="mimin" class="dashboard">

	<nav class="navbar navbar-default header navbar-fixed-top">
		<tiles:insertAttribute name="header" />
	</nav>

	<div class="container-fluid mimin-wrapper">
		<div id="left-menu">
			<tiles:insertAttribute name="leftPopup" />
		</div>
		<div id="right-menu">
			<tiles:insertAttribute name="rightPopup" />
		</div>
		<div id="content">
			<div class="col-md-12" style="padding: 20px;">
				<div class="col-md-12 padding-0">
					<div class="col-md-8 padding-0">
						<tiles:insertAttribute name="content" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/resources/asset/util/scriptutill.html"></jsp:include>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA2tdPJbYVjbIna-8vnV5aNg-EpDEKZqZQ&callback=initMap" async defer></script>
</body>
</html>