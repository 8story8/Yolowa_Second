<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN">
	<sec:authentication var="user" property="principal" />
	<div class="col-md-3 mail-left">
		<div class="col-md-12 mail-left-header">
			<center>
				<input type="button" class="btn  btncompose-mail"
					value="My Message Box" disabled="true" />
			</center>
		</div>

		<!--  left Send&Receive Msg option menu -->
		<div class="col-md-12 mail-left-content" style="margin-top: 50px;">

			<ul class="nav">
				<li><a
					href="${pageContext.request.contextPath }/writeFormMessage.do"><span
						class="fa icon-envelope-letter"></span>WriteMessage</a></li>
				<li><a
					href="${pageContext.request.contextPath }/myMessagePage.do"><span
						class="fa fa-inbox"></span>Receive Message</a></li>
				<li><a
					href="${pageContext.request.contextPath }/sendMessagePage.do"><span
						class="fa fa-send-o"></span> Send Message</a></li>
				<li><hr /></li>
				<li><h5>Tags</h5></li>
				<li>
					<ul class="tags">
						<li><a href=""><span class="fa fa-tag"></span> Hackingz</a></li>
						<li><a href=""><span class="fa fa-tag"></span> Phising</a></li>
						<li><a href=""><span class="fa fa-tag"></span> Cracking</a></li>
						<li><a href=""><span class="fa fa-tag"></span> CSRF</a></li>
						<li><a href=""><span class="fa fa-tag"></span> XSS</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</sec:authorize>