<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript">
	function openModal(bNo) {
		$("#myModal" + bNo).modal();
	}
</script>
<div class="col-md-12 padding-0">
	<div class="panel">
		<div class="panel-heading" style="background-color:#2196F3;">
			<h4>
				<b style="color: #FFFFFF;">실시간 급상승</b>
			</h4>
		</div>
		<div class="panel-body">
			<div class="col-md-12 list-timeline">
				<div class="col-md-12 list-timeline-section bg-light">
					<div class="col-md-12 list-timeline-detail">
							<c:forEach items="${requestScope.rankList }" var="reportMap">
								<c:choose>
									<c:when test="${reportMap.RANKING==1}">
								<div>
								<h5>
									<span class="label label-danger">
									${reportMap.RANKING}</span>
									<a href="searchListByKeyword.do?keyword=${reportMap.KEYWORD}"><span style="margin-left: 30px;color:#5D676B;">
									${reportMap.KEYWORD}</span></a>
									<span class="badge badge-info"
									style="float: right;">
									${reportMap.COUNT}</span>
								</h5>
								</div><hr>
								</c:when>
								<c:otherwise>
								<div>
								<h5>
									<span class="label label-primary">
									${reportMap.RANKING}</span>
									<a href="searchListByKeyword.do?keyword=${reportMap.KEYWORD}"><span style="margin-left: 30px;color:#5D676B;">
									${reportMap.KEYWORD}</span></a>
									<span class="badge badge-info"
									style="float: right;">
									${reportMap.COUNT}</span>
									
								</h5>
								</div><br>
								</c:otherwise>
								</c:choose>
							</c:forEach>
					</div>
				</div>	
			</div>
		</div>
	</div>
</div>
<!-- funding List 보여주기 -->
<div class="col-md-12 padding-0">
	<div class="panel">
		<div class="panel-heading" style="background-color:#2196F3;">
			<h4>
			<b style="color: #FFFFFF;"> 진행중인 펀딩 </b>
			</h4>
		</div>
		<div class="panel-body">
			<div class="col-md-12 list-timeline-section bg-light">
				<div class="col-md-12 list-timeline-detail">
					<c:forEach var="fList" items="${fList}">
						<c:if test="${fList.fTitle ne '0'}">
						<fmt:parseNumber value = "${fList.count}" pattern = "0,000.00" var = "count"/>
						<fmt:parseNumber value = "${fList.fPeople}" pattern = "0,000.00" var = "fPeople"/>
							<c:choose>
								<c:when test="${fList.bType eq '스포츠'}">
									<div class="media">
										<div class="media-left">
											<span class=" icon-social-dribbble icons"
												style="font-size: 2em;" onclick="openModal('${fList.bNo}')"></span>
										</div>
										<div class="media-body">
											<h5 class="media-heading">${fList.fTitle}</h5>
											<div class="progress progress-mini">
												<div class="progress-bar" role="progressbar"
													aria-valuenow="${fList.count}" aria-valuemin="0"
													aria-valuemax="${fList.fPeople}"
													style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
											</div>
										</div>
									</div>
								</c:when>
								<c:when test="${fList.bType eq '영화'}">
									<div class="media">
										<div class="media-left">
											<span class="icon-camrecorder icons" style="font-size: 2em;"
												onclick="openModal('${fList.bNo}')"></span>
										</div>
										<div class="media-body">
											<h5 class="media-heading">${fList.fTitle}</h5>
											<div class="progress progress-mini">
												<div class="progress-bar" role="progressbar"
													aria-valuenow="${fList.count}" aria-valuemin="0"
													aria-valuemax="${fList.fPeople}"
													style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
											</div>
										</div>
									</div>
								</c:when>
								<c:when test="${fList.bType eq '게임'}">
									<div class="media">
										<div class="media-left">
											<span class="icon-game-controller icons"
												style="font-size: 2em;" onclick="openModal('${fList.bNo}')"></span>
										</div>
										<div class="media-body">
											<h5 class="media-heading">${fList.fTitle}</h5>
											<div class="progress progress-mini">
												<div class="progress-bar" role="progressbar"
													aria-valuenow="${fList.count}" aria-valuemin="0"
													aria-valuemax="${fList.fPeople}"
													style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
											</div>
										</div>
									</div>
								</c:when>
								<c:when test="${fList.bType eq '도서'}">
									<div class="media">
										<div class="media-left">
											<span class="icon-book-open icons" style="font-size: 2em;"
												onclick="openModal('${fList.bNo}')"></span>
										</div>
										<div class="media-body">
											<h5 class="media-heading">${fList.fTitle}</h5>
											<div class="progress progress-mini">
												<div class="progress-bar" role="progressbar"
													aria-valuenow="${fList.count}" aria-valuemin="0"
													aria-valuemax="${fList.fPeople}"
													style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
											</div>
										</div>
									</div>
								</c:when>
								<c:when test="${fList.bType eq '여행'}">
									<div class="media">
										<div class="media-left">
											<span class="icon-plane icons" style="font-size: 2em;"
												onclick="openModal('${fList.bNo}')"></span>
										</div>
										<div class="media-body">
											<h5 class="media-heading">${fList.fTitle}</h5>
											<div class="progress progress-mini">
												<div class="progress-bar" role="progressbar"
													aria-valuenow="${fList.count}" aria-valuemin="0"
													aria-valuemax="${fList.fPeople}"
													style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
											</div>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="media">
										<div class="media-left">
											<span class=" icon-home icons" style="font-size: 2em;"
												onclick="openModal('${fList.bNo}')"></span>
										</div>
										<div class="media-body">
											<h5 class="media-heading">${fList.fTitle}</h5>
											<div class="progress progress-mini">
												<div class="progress-bar" role="progressbar"
													aria-valuenow="${fList.count}" aria-valuemin="0"
													aria-valuemax="${fList.fPeople}"
													style="width:${((count+0.0)/(fPeople+0.0))*100}%;"></div>
											</div>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal -->
<c:forEach items="${fList}" var="fList" varStatus="fOrder">
	<div class="modal fade" id="myModal${fList.bNo}" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 style="text-align: center;">
							<span class="modal-title">
							상세정보</span>
							</h4>
				</div>
				<div class="modal-body">
					<div style="display: inline-block; width: 20%; text-align: left;">
						${fList.bType}</div>
					<div style="display: inline-block; width: 50%; text-align: center;">
						제목 : ${fList.fTitle}</div>
					<div style="display: inline-block; width: 25%; text-align: right;">
						${fList.bPostdate}</div>
					<hr>
					<div>
						<pre style="background-color: #FFFFFF; border: 0px;">${fList.bContent}</pre>
					</div>
					<c:if test="${fList.filepath ne '0'}">
                     <c:set var="checkFilePath" value="${fList.filepath}" />
                     <c:set var="checkFilePathArray" value="${fn:split(checkFilePath,'/')}" />
                        <!-- Image Carousel -->
                        <div id="modalImageCarousel${fOrder.count}" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                            <ol class="carousel-indicators">
                               <c:forEach items="${checkFilePathArray}" var="filePath" varStatus="order">
                                  <c:choose>
                                     <c:when test="${order.count eq 1}">
                                        <li data-target="#modalImageCarousel${fOrder.count}" data-slide-to="${order.count}" class="active"></li>
                                     </c:when>
                                     <c:otherwise>
                                        <li data-target="#modalImageCarousel${fOrder.count}" data-slide-to="${order.count}"></li>
                                     </c:otherwise>
                                  </c:choose>
                                 </c:forEach>
                            </ol>

                            <!-- Wrapper for slides -->
                            <div class="carousel-inner">
                               <c:forEach items="${checkFilePathArray}" var="filePath" varStatus="order">
                                  <c:choose>
                                     <c:when test="${order.count eq 1}">
                                        <div class="item active">
                                            <img src="${pageContext.request.contextPath}/resources/asset/upload/${filePath}" style="width: 100%; height: 300px;" alt="아나${filePath}">
                                          </div>
                                     </c:when>
                                     <c:otherwise>
                                         <div class="item">
                                            <img src="${pageContext.request.contextPath}/resources/asset/upload/${filePath}" style="width: 100%; height: 300px;" alt="아나${filePath}">
                                          </div>
                                     </c:otherwise>
                                  </c:choose>
                                 </c:forEach>
                            </div>

                            <!-- Left and right controls -->
                            <a class="left carousel-control" href="#modalImageCarousel${fOrder.count}" data-slide="prev">
                                 <span class="glyphicon glyphicon-chevron-left"></span>
                              <span class="sr-only">Previous</span>
                            </a>
                            <a class="right carousel-control" href="#modalImageCarousel${fOrder.count}" data-slide="next">
                                 <span class="glyphicon glyphicon-chevron-right"></span>
                                 <span class="sr-only">Next</span>
                            </a>
                        </div>
                          <br>
                  </c:if>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>