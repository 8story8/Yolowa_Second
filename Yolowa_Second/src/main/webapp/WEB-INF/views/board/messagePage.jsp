<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN">
<sec:authentication var="user" property="principal" />
<!-- start: Content -->
<script>
	$(document).ready(function() {
						$("#trashMsg").click(function() {
											var checkboxValues = [];
											var deleteCheck = confirm("삭제 하시겠습니까?");
											if(deleteCheck == true){
												if($(".icheck[name=checkbox1]:checked").val()==null){
													alert("삭제할 메세지가 없습니다.");
													return;
												}
												else{
													$(".icheck[name=checkbox1]:checked").each(function(index,elem) {
												checkboxValues.push($(elem).val());
											});
											//alert(checkboxValues);
											location.href = "${pageContext.request.contextPath}/deleteMessage.do?deleteMsg="
													+ checkboxValues
													+ "&type=receive&myId=${user.id}";
												}
											}
											else{
												return;
											}
										});

						$("#allCheck").on("ifChanged", function(event) {
							if (!this.changed) {
								this.changed = true;
								$(".icheck").iCheck("check");
							} else {
								this.changed = false;
								$(".icheck").iCheck("uncheck");
							}
							$("#allCheck").iCheck("update");
						});
						$(".subject").on("click", function() {
							$("#sendId").text($(this).prev().prev().text());
							$("#hiddensId").val($(this).prev().val());
							$("#receiveTime").text($(this).next().text());
							$("#receiveMsg").text($(this).text());
							//alert($(this).next().next().text());
							$(this).next().next().text("");
							var msgNum = $(this).prev().prev().prev().val();
							$.ajax({
								type:"get",
								url:"readMsg.do",
								data:"mNo="+msgNum,
								success:function(data){
								}
							});//ajax

						});
						$("#sendBtn").click(function() {
							//$("#myModal").modal("hide");
							$("#myModal2").modal("show");
							$("#receiveId").text($("#sendId").text());
							$("#hiddenrId").val($("#hiddensId").val());

						});

						$(".contact").on("click", function() {
							$("#sendId").text($(this).text());
							$("#hiddensId").val($(this).next().val());
							$("#sendBtn").trigger("click");

						});

						$("#sendMsgBtn").click(
								function() {
									var rId = $("#hiddenrId").val();// 받는 ID
									var sId = "${user.id}"; // 보내는 Id
									var msgText = $("#msgText").val();

									if (msgText == "") {
										alert("메세지를 입력하세요.");
									} else {
										$.ajax({
											type : "post",
											url : "sendMessage.do",
											data : "rId=" + rId + "&sId=" + sId
													+ "&message=" + msgText,
											success : function(data) {
												if (data == "ok") {
													alert("쪽지를 성공적으로 보냈습니다.");
												}
											}
										});//ajax
									}// else
									$("#msgText").val("");
								});//click
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

table {
	text-align: center;

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
				<table>
					<tr>
						<td><a id="trashMsg"><span class="fa fa-trash fa-1x">
									삭제</span></a></td>
					</tr>
				</table>
			</div>
			<c:set value="${requestScope.myReceiveMsg.myAllMsgList.messageList}"
				var="msgList"></c:set>
			<c:set value="${requestScope.myReceiveMsg.myAllMsgList.pagingBean}"
				var="page"></c:set>
			<c:set value="${requestScope.myReceiveMsg.memberInfo}"
				var="sendMember"></c:set>
			<div class="col-md-12 mail-right-content">
				<table class="table table-hover" >
					<thead>
						<tr>
							<td><input type="checkbox" class="icheck" name="AllCheckBox"
								id="allCheck" /></td>
							<td class="contact">보낸사람</td>
							<td class="subject">내용</td>
							<td class="subject">날짜</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="receiveMessage">
						<c:forEach items="${msgList }" var="m">
							<c:forEach items="${sendMember }" var="sId">
								<c:choose>
									<c:when test="${m.mCheck=='SM' or m.mCheck=='SD' or m.mCheck=='RM'}">
											<tr class="read">	
											<c:if test="${sId.id == m.sId }">
												<td class="check"><input type="checkbox" class="icheck" name="checkbox1" value="${m.mNo }"></td>
												<input type="hidden" name="mNo" value="${m.mNo }">
												<td class="contact">${sId.name }(${m.sId })</td>
												<input type="hidden" name="sId" value="${m.sId }">
												<td class="subject" data-toggle="modal"
													data-target="#myModal">${m.message }</td>
												<td class="subject"><a href="#">${m.mPostdate }</a></td>
												<td>
												<c:if test="${m.mCheck=='SM' }"><div style="display: inline; text-align: center;" id="readCheck">
														<span style="text-align: center;" class="label pull-right label-danger" >읽지않음</span></div>
												</c:if>
												</td>
											</c:if>
										</tr>
									</c:when>
								</c:choose>
							</c:forEach>
						</c:forEach>
					</tbody>
				</table>
				<ul class="pagination pagination-lg">
					<c:if test="${page.previousPageGroup }">
						<li><a
							href="myMessagePage.do?curPage=${page.startPageOfPageGroup-1}">◀</a></li>
					</c:if>
					<c:forEach begin="${page.startPageOfPageGroup }"
						end="${page.endPageOfPageGroup}" var="i">
						<c:choose>
							<c:when test="${i ==page.nowPage  }">
								<li><a>${i }</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="myMessagePage.do?curPage=${i}">${i }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${page.nextPageGroup }">
						<li><a
							href="myMessagePage.do?curPage=${page.endPageOfPageGroup+1}">▶</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>

	<!-- Recevie Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					보낸 사람 : <span id="sendId"></span><br> 받은 시간 : <span
						id="receiveTime"></span> <input type="hidden" id="hiddensId">
				</div>
				<div class="modal-body">
					<textarea rows="10" cols="30" name="message" readonly="readonly" id="receiveMsg"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						id="sendBtn">Send</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- send Modal -->
	<div class="modal fade" id="myModal2" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<form action="sendMsg.do">
					<div class="modal-header">
						받는 사람 : <span id="receiveId"></span><br> <input type="hidden"
							id="hiddenrId" name="receivceId">
					</div>
					<div class="modal-body">
						<textarea rows="10" cols="30" name="message"
							placeholder="Input text..." required="required" id="msgText"></textarea>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							id="sendMsgBtn">Send</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</sec:authorize>