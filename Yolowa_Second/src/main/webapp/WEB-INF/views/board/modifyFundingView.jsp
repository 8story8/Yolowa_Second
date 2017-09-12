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
$(document).ready(function(){
	var date = new Date();
	var year = date.getFullYear(); //년도
	var month = date.getMonth()+1; //월
	var day = date.getDate(); //일
	if ((day+"").length < 2) {       // 일이 한자리 수인 경우 앞에 0을 붙여주기 위해
	        day = "0" + day;
	    }
	if ((month+"").length < 2) {       // 일이 한자리 수인 경우 앞에 0을 붙여주기 위해
		month = "0" + month;
    }
	var getToday = year+"-"+month+"-"+day;
	
	$("#map").hide();
	$("#fundModify").click(function(){
		if($("input[name=fTitle]").val()==""){
			alert("제목을 입력하세요");
			return false;
		}
		if($("#bType").val()==""){
			alert("카테고리를 선택하세요");
			return false;
		}
		if($("input[name=fDeadLine]").val()==""){
			alert("마감일을 선택하세요");
			return false;
		}
		if($("input[name=fDeadLine]").val()< getToday){
			alert("마감일은 오늘 이후를 선택하세요");
			return false;
		}
		if($("input[name=fPeople]").val()==""){
			alert("목표인원을 입력하세요");
			return false;
		}
		if(isNaN($("input[name=fPeople]").val())){
			alert("목표인원에 숫자를 입력하세요");
			return false;
		}
		if($("input[name=fPoint]").val()==""){
			alert("목표포인트를 입력하세요");
			return false;
		}
		if(isNaN($("input[name=fPoint]").val())){
			alert("목표포인트에 숫자를 입력하세요");
			return false;
		}
		if($("#bContent").val()==""){
			alert("내용을 입력하세요");
			return false;
		}
   		$("#modifyFunding").submit();
     });
	$("#findBtn").hide();
    $("#mapContent").click(function(){
    	  $("#findBtn").toggle();
    });
    $("#findRouteBtn").on("click",function(){
    	 $("#map").show();
    	 initMap();
    });
    $("#fPeople").keyup(function(){
    	if(isNaN($(this).val())){
    		$("#fPoint").val("");
    		$("#fPoint").text("");	
    	}else{
	    	$("#fPoint").val($(this).val()*100);
    	}
    });
});
	
function remove(count) {
	alert(count);
	$(".MultiFile-label[id=" + count + "]").remove();
}
</script>
<!-- funding -->
<div id="fundingForm">
		<form id="modifyFunding" action="modifyFunding.do?type=${requestScope.type }" method="post" enctype="multipart/form-data">
			<div class="box-v5 panel">
				<div class="panel-heading padding-0 bg-white border-none">
				<table class="col-md-12 padding-0">
					<thead>
					<tr>
					<td colspan="2">제 &nbsp;&nbsp;&nbsp;목 : <input type="text" name="fTitle" size="45px" value="${mList.fTitle}"></td>
						<td> 카테고리 : <select name="bType" id="bType">
							<option value="${mList.bType}">${mList.bType}</option>
							<option value="">-----------</option>
							<c:forEach items="${requestScope.categoryList}" var="categoryList">
							<option value="${categoryList.cType}">${categoryList.cType}</option>
							</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td>마감일 : <input type="date" name="fDeadLine"></td>
						<td>목표인원 : <input type="text" name="fPeople" id="fPeople" size="10px" value="${mList.fPeople}"></td>
						<td>목표포인트: <input type="text" name="fPoint" id="fPoint" size="10px" value="${mList.fPoint}" readonly="readonly"></td>
					</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="3"><textarea id="bContent" name="bContent" class="col-md-12" style="height: 200px;">${mList.bContent}</textarea></td>
						</tr>
                  </tbody>
					<tr>
						<td width="50" colspan="3"><input type="file"
							class="multi with-preview" id="file" name="imageFile" multiple /><br>
							<input type="hidden" name="file">
									<c:if test="${mList.filepath !=null}">
							<div class="MultiFile-wrap" id="MultiFile2">
								<div class="Multifile-list" id="MultiFile2_list">
										<c:set var="checkFilePath" value="${mList.filepath}" />
										<c:set var="checkFilePathArray"
											value="${fn:split(checkFilePath,'/')}" />
										<c:forEach items="${checkFilePathArray}" var="filePath"
											varStatus="order">
											<div class="MultiFile-label" id="${order.count}">
												<a class="MultiFile-remove"
													onclick="remove('${order.count}')" href="#">제거</a> <span>
													<span class="MultiFile-label" title="${filePath }을 선택했습니다.">
														<span class="MultiFile-title">${filePath }</span> <img
														class="MultiFile-preview"
														src="${pageContext.request.contextPath}/resources/asset/upload/${filePath}"
														style=""> 
														<input type="hidden" name="file" value="${filePath}" id="photo">
												</span>
												</span>
											</div>
										</c:forEach>
								</div>
							</div>
									</c:if>
							</td>
                    </tr>
                    <tr>
                    	<td>
						<div class="col-md-6 col-sm-6 col-xs-6 padding-0">
                           <div class="col-md-6 col-sm-6 col-xs-6 tool"></div>
                           <a href="#"> <span class="fa fa-map-marker fa-2x"
                              id="mapContent"></span></a>
                        </div>
						</td>
						<td  colspan="2">
						<div class="col-md-6 col-sm-6 col-xs-6 padding-0" style="float: right;">
                           <div class="col-md-6 col-sm-6 col-xs-6 tool"></div>
                           <button id="fundModify" class="btn btn-round pull-right">
                              <span>수정</span> <span class="icon-arrow-right icons"></span>
                           </button>
                        </div>
						</td>					
					</tr>
					<tr id="findBtn"> 
						<td colspan="3"> <input type="text" id="dest" name="dest">
						<input type="button" value="길찾기" id="findRouteBtn">
						</td>
					</tr>
				</table>
				</div>
				<div class="panel-body" style="height: auto;"></div>
			</div>
			<div style="float: left; width: 100%; height: 300px;" id="map"></div>
			<input type="hidden" name="bNo" value="${mList.bNo}">
		</form>
	</div>	
<script type="text/javascript">
function initMap() {
	var map;
	var geocoder = new google.maps.Geocoder();
	var marker;
	var infoWindow;
	map = new google.maps.Map(document.getElementById('map'),{
		zoom : 16
	});
	var dest = $("#dest").val(); 
	geocoder.geocode({'address': dest}, function(results, status) {
		if (status === 'OK') {
			map.setCenter(results[0].geometry.location);
			marker = new google.maps.Marker({
			         	map: map,
			            position: results[0].geometry.location
			         });
		
			infoWindow = new google.maps.InfoWindow({
			content:dest
			});
		
		infoWindow.open(map, marker);
		}	
	});
}
</script>
<script src="resources/asset/js/plugins/jquery.MultiFile.js"></script>