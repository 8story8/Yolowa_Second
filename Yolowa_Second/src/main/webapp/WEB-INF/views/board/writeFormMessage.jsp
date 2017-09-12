<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>

<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN">
<sec:authentication var="user" property="principal" />
<!-- start: Content -->
<script>
	$(document).ready(function() {
		$("#sendMsgBtn").click(function(){
			var receiveId = $("#receiveSelect").val();
			var sendMsg =$("#msgText").val();
			var sendId = "${user.id}";
			if(receiveId ==""){
				alert("받는 사람을 선택해주세요.");
			}
			else if(sendMsg ==""){
				alert("메세지를 입력하세요.");
			}
			else{
				  $.ajax({
	            	  type:"post",
	            	  url:"sendMessage.do",
	           	   	  data:"sId="+sendId+"&rId="+receiveId+"&message="+sendMsg,
	          	      success:function(data){
	           				if(data == "ok"){
	           					alert("메세지 전송 되었습니다.");
	           					location.href="myMessagePage.do";
	           				}
	           				else{
	           					alert("메세지 전송 실패했습니다.");
	           				}
	        	      }//success
	    	       });//ajax   	  
			}
		});
	});
</script>
<style>
textarea {
	border: 0;
	width: 100%;
	margin: 5px 0;
	padding: 3px;
	background-color: transparent;
}
#msgBack{
 	height: 700px;
 }
</style>
<div class="col-md-12 mail-wrapper">
	<div class="col-md-12 padding-0" id="msgBack">
		<jsp:include page="leftMessagePopup.jsp"></jsp:include>

		<!--  Message List -->
		<div class="col-md-9 mail-right">
			<div class="col-md-12 mail-right-header">

				<!--  Search Mail -->
				<div class="col-md-10 col-sm-10 padding-0">
					<div class="input-group searchbox-v1">
						<span class="input-group-addon  border-none box-shadow-none"
							id="basic-addon1"> <span class="fa fa-search"></span>
						</span> <input type="text" class="txtsearch border-none box-shadow-none"
							placeholder="Search Email..." aria-describedby="basic-addon1">
					</div>
				</div>
			</div>

			<!--  Tool -->
			<div class="col-md-12 mail-right-content mail-right-tool">
				<form action="sendMsg.do">
					<div class="modal-header">

						받는 사람 : <select id="receiveSelect">
							<option value=""></option>
							<c:forEach items="${requestScope.friends }" var="f">
								<option value="${f.id }">${f.name }(${f.id })</option>
							</c:forEach>
						</select>
					</div>
					<div class="modal-body">
						<textarea rows="10" cols="30" name="message"
							placeholder="Input text..." required="required" id="msgText"></textarea>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							id="sendMsgBtn">Send</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</sec:authorize>