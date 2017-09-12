<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
.MultiFile-title {
	border: 1px solid blue;
}

.MultiFile-remove {
	border: 1px solid yellow;
}

img {
	border: 1px solid red;
 	width: 250px;
	heigth: 150px;
	display: block;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#map").hide();
		$("#fundWrite").click(function() {
			if ($("#bType").val() == "") {
				alert("카테고리를 선택하세요");
				return false;
			}
			if($("#bContent").val()==""){
				alert("내용을 입력하세요");
				return false;
			}
			$("#writeFunding").submit();
		});
		$("#findBtn").hide();
		$("#mapContent").click(function() {
			$("#findBtn").toggle();
		});
		$("#findRouteBtn").on("click", function() {
			$("#map").show();
			initMap();
		});
	});
</script>
<!-- Context -->
<div id="Context">
	<form id="writeContext" action="writeContext.do" method="post"
		enctype="multipart/form-data">
		<div class="box-v5 panel">
			<div class="panel-heading padding-0 bg-white border-none">
				<table class="col-md-12 padding-0">
					<tbody>
						<tr>
							<td colspan="3"><textarea id="bContent" name="bContent" class="col-md-12"
									style="height: 200px;"></textarea></td>
						</tr>
					</tbody>
					<tr>
							<td colspan="3">
								<!-- 사진 --> 
								<input type="file" name="file" multiple	class="multi with-preview" />
							</td>
							
						</tr>
					<tr>
					<td>카테고리 : <select name="bType" id="bType">
								<option value="">-----------</option>
								<c:forEach items="${requestScope.categoryList}"
									var="categoryList">
									<option value="${categoryList.cType}">${categoryList.cType}</option>
								</c:forEach>
						</select></td>
					<td>
						<a href="#"> <span class="fa fa-map-marker fa-2x"
									id="mapContent"></span></a>
					</td>
					<td>
							<div class="col-md-6 col-sm-6 col-xs-6 padding-0" style="float: right;">
								<div class="col-md-6 col-sm-6 col-xs-6 tool"></div>
								<button id="fundWrite" class="btn btn-round pull-right">
									<span>작성</span> <span class="icon-arrow-right icons"></span>
								</button>
							</div>
						</td>
					</tr>
					<tr id="findBtn">
						<td colspan="3"><input type="text" id="dest" name="dest">
							<input type="button" value="길찾기" id="findRouteBtn"></td>
					</tr>
				</table>
			</div>
			<div class="panel-body" style="height: auto;"></div>
		</div>
		<div style="float: left; width: 100%; height: 300px;" id="map"></div>
	</form>
</div>
<script type="text/javascript">
	function initMap() {
		var map;
		var geocoder = new google.maps.Geocoder();
		var marker;
		var infoWindow;
		map = new google.maps.Map(document.getElementById('map'), {
			zoom : 16
		});
		var dest = $("#dest").val();
		geocoder.geocode({
			'address' : dest
		}, function(results, status) {
			if (status === 'OK') {
				map.setCenter(results[0].geometry.location);
				marker = new google.maps.Marker({
					map : map,
					position : results[0].geometry.location
				});

				infoWindow = new google.maps.InfoWindow({
					content : dest
				});

				infoWindow.open(map, marker);
			} 
		});
	}
</script>
<script src="resources/asset/js/plugins/jquery.MultiFile.js"></script>