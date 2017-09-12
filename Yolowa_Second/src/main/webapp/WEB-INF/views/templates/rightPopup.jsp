<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>

<sec:authorize ifAnyGranted="ROLE_MEMBER,ROLE_ADMIN">
<sec:authentication var="user" property="principal" />
<style>
textarea {
	border: 0;
	margin: 5px 0;
	padding: 3px;
	background-color: #fff;
	width: 100%;
	height: 80px;
}

#msgContent{
	background-color: #fff;
    overflow: auto;
    overflow-x: hidden; 
    height: 400px;
	max-height: 400px;
}
</style>
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	//친구 추천 리스트
	$("#recommend").click(function() {
		$("#recommandFriends").show();
		$("#requestFriends").hide();
		$.ajax({
			type:"get",
			url:"recommend.do",
			dataType:"json",
			success:function(data){
				var listTxt = "";
				for(var i=0; i < data.length; i++){
					listTxt += "<li><img src=${pageContext.request.contextPath}/"+data[i].filePath+" alt='user name'>";
					listTxt += "<div><h4><b>"+data[i].name+"</b></h4></div>";
					listTxt += "<div class='dot'>";
					listTxt += "<input type='hidden' value='"+data[i].id+"'>"
					listTxt += "<span class='fa fa-user-plus fa-2x' title='친구신청'></span>";
					listTxt += "</div></li>";
				}
				$("#recommendList").html(listTxt);
			}//success
		});//ajax
	});//click
	$("#recommendList").on("click","span",function(){
		var id = $(this).prev().val();
		$.ajax({
			type:"get",
            url:"friendAdd.do?id="+id,
            success:function(data){
            	if(data == "ok"){
   					$("#recommend").trigger("click");
   				}
   				else{
   					alert("친구 신청이 실패했습니다.");
   				}
            }//success
		});//ajax
	});//on
   //// 친구 리스트 & Message
      $("#tabBtn").click(function() {
    	  $("#recommandFriends").hide();
    	  $("#requestFriends").hide();
         $.ajax({
            type:"get",
            url:"friendsList.do",
            dataType:"json",
            success:function(data){
               var friendsListTxt = "";
               for(var i=0; i < data.length; i++){
                  friendsListTxt +="<li>";
                  friendsListTxt +="<img title='메세지창' src=${pageContext.request.contextPath}/"+data[i].filePath +" alt="+data[i].id+">";
                  friendsListTxt +="<div> <h4> <b>"+data[i].name+"</b> </h4> </div></div>";
                  friendsListTxt +="<div class='dot'>";
                  friendsListTxt +="<input type='hidden' id='hiddenId' value='"+data[i].id+"'>";
                  friendsListTxt +="<span class='fa fa-user-times fa-2x' title='친구삭제'></span></div></li>";
               }
               $("#friends").html(friendsListTxt);
            }//success
         });//ajax
      });//click   
      
      $("#friends").on("click","span",function(){
    	  var id = $(this).prev().val();
    	  $.ajax({
    		  type:"get",
              url:"friendDelete.do?id="+id,
              success:function(data){
            	  if(data == "ok"){
            		  $("#tabBtn").trigger("click");
     				}
     				else{
     					alert("친구 삭제가 실패했습니다.");
     				}
              }//success
    	  });//ajax
      });//on
      
      $("#friends").on("click","img",function(){
         //alert($(this).attr("alt"));
         var indexId = $(this).attr("alt");
         var chatName= $(this).next().text();
         $.ajax({
            type:"get",
            url:"friendsMsgBox.do?rId="+indexId,
            dataType:"json",
            success:function(data){
            	var msgTxt="<input type='hidden' name='receiveId' value="+indexId+">";
                //var msgTxt ="<div id='overflowScroll'>";
                $("#chatName").html(chatName);
                for(var i=0;i<data.msgBox.length;i++){
                	var idVal = "${user.id}";
                	if(idVal==data.msgBox[i].sId){
                	msgTxt +="<div class='row msg_container send'>";
                    msgTxt +="<div class='col-md-9 col-xs-9 bubble'>";
                    msgTxt +="<div class='messages msg_sent'>";
                    msgTxt +="<p>"+data.msgBox[i].message+"</p>";
                    msgTxt +="<time datetime='2009-11-13T20:00'>"+data.msgBox[i].mPostdate+"</time>  </div>";
                      msgTxt +="</div>";
                      msgTxt +=" <div class='col-md-3 col-xs-3 avatar-dropdown'>"
                      msgTxt +="<img src=${pageContext.request.contextPath}/${user.filePath} class='img-responsive' alt='user name'>";
                      msgTxt +="</div> </div>";
                	}
                	else{
                      msgTxt +="<div class='row msg_container receive'>";
                      msgTxt +="<div class='col-md-3 col-xs-3 avatar-dropdown'>";
                      msgTxt +="<img src=${pageContext.request.contextPath}/"+data.friend.filePath+" class='img-responsive' alt='user name'>";
                      msgTxt +="</div>";
                      msgTxt +="<div class='col-md-9 col-xs-9 bubble'>";
                      msgTxt +="<div class='messages msg_receive'>";
                      msgTxt +="<p>"+data.msgBox[i].message+"</p>";
                      msgTxt +="<time datetime='2009-11-13T20:00'>"+data.msgBox[i].mPostdate+"</time>  </div>";
                      msgTxt +="</div> </div>";
                	}
                }
                $("#msgContent").html(msgTxt); 
                $("#friendsContainer").hide();  
                $("#recommandFriends").hide();
                $("#requestFriends").hide();
                $("#msgContainer").show();
            },//success
            complete : function(){
    	    	var el = document.getElementById("msgContent"); 
  				el.scrollTop = el.scrollHeight;
    	      }
         });//ajax 
      });
      $("#closeMsgBox").click(function(){
    	  $("#friendsContainer").show();  
    	  $("#recommandFriends").hide();
    	  $("#requestFriends").hide();
          $("#msgContainer").hide();
      });// close click event
      
      
      $("#chatTxt").keypress(function(e){
    		if(e.which==13){
    	  //alert($("#chatTxt").val()); // TextArea 글
    	  //alert($("#friends img").attr("alt")); // 보낼 사람 Id
    	  var sendMsg = $("#chatTxt").val();
    	  var receiveId =$(":input[name=receiveId]").val();
    	  var sendId = "${user.id}";
    	  //alert($(":input[name=receiveId]").val());
    	  //alert("받는 사람"+receiveId);
    	  if(sendMsg ==""){
    		  alert("메세지를 입력하세요")
    	  }else{
    		  $("#chatTxt").val("");
    		  $.ajax({
            	  type:"post",
            	  url:"sendMessage.do",
           	   	  data:"sId="+sendId+"&rId="+receiveId+"&message="+sendMsg,
          	      success:function(data){
           				if(data == "ok"){
           					$("#friends img[alt="+receiveId+"]").trigger("click");
           				}
           				else{
           					alert("메세지 전송 실패했습니다.");
           				}
           				$("#chatTxt").val("");	
        	      }//success
    	       });//ajax   	 
    	 	 }
    	}
      });// chatBtn click
    
      //받은 친구신청 리스트
      $("#checkRequest").click(function() {
  		$("#requestFriends").show();
  		$.ajax({
  			type:"get",
  			url:"requestList.do",
  			dataType:"json",
  			success:function(data){
  				var listTxt = "";
  				for(var i=0; i < data.length; i++){
  					listTxt += "<li><img src=${pageContext.request.contextPath}/"+data[i].filePath+" alt='user name'>";
  					listTxt += "<div><h4><b>"+data[i].name+"</b></h4></div>";
  					listTxt += "<div class='dot'>";
  					listTxt += "<input type='hidden' id='hiddenId' value='"+data[i].id+"'>"
  					listTxt += "<span class='fa fa-user-plus fa-2x' title='친구추가'></span>";
  					listTxt += "</div></li>";
  				}
  				$("#requestList").html(listTxt);
  			}//success
  		});//ajax
  	});//click
  	$("#requestList").on("click","span",function(){
		var id = $(this).prev().val();
		$.ajax({
			type:"get",
            url:"friendCheck.do?id="+id,
            success:function(data){
            	if(data == "ok"){
   					$("#checkRequest").trigger("click");
   				}
   				else{
   					alert("친구 추가가 실패했습니다.");
   				}
            }//success
		});//ajax
	});//on
});//ready
</script>


<ul class="nav nav-tabs" >
   <li>
      <a data-toggle="tab" href="#right-menu-user">
         <span class="fa fa-comment-o fa-2x" title="친구리스트"></span>
      </a>
   </li>
   <li>
      <a data-toggle="tab" href="#right-menu-userRecommend">
         <span class="icon-people fa-2x" id="recommend" title="친구추천"></span>
      </a>
   </li>
   <li>
      <a data-toggle="tab" href="#right-menu-friendRequest">
         <span class="icon-user-follow fa-2x" id="checkRequest" title="받은친구신청"></span>
      </a>
   </li>
</ul>

<!--  오른쪽 커피 누르면 나오는 메뉴 바 -->
<div class="tab-content">
   <c:set value="${requestScope.friendsList }" var="map"></c:set>
   <!--  커피 바 영역-->
   <div id="right-menu-user" class="tab-pane fade in active">
    
      <!--  친구 목록 -->
      <div class="user col-md-12" id="friendsContainer">
         <ul class="nav nav-list" id="friends">
         </ul>
      </div>
      
      <div class="col-md-12 chatbox" id ="msgContainer">
         <!--  한 세트 -->
         <div class="col-md-12">
            <a href="#" class="close-chat" id="closeMsgBox">X</a>
            <h4 id="chatName">
               <!--  채팅 주인 이름 -->
            </h4>
         </div>
         <div class="chat-area" >
            <div class="chat-area-content" >
               <div class="msg_container_base" id="msgContent">
               </div>
                 <textarea id="chatTxt" placeholder="메세지를 입력하세요..."></textarea>
            </div>
         </div>
      <!--    <div class="user-list"  id="chatBox">
            
              <input type="button" value="Send" id="chatBtn">
          </div> -->
      </div>
      
      
   </div>
  
   <!--  메세지 끝 -->
   <!-- 친구추천 -->
   <div id="right-menu-userRecommend" class="tab-pane fade in active">
      <!-- 추천리스트 -->
      <div class="user col-md-12" id="recommandFriends">
         <h4 align="center"><b>친구 추천</b></h4><hr>
         <ul class="nav nav-list" id="recommendList"></ul>
      </div>
   </div>
   <!-- 받은 친구 신청 리스트 -->
   <div id="right-menu-friendRequest" class="tab-pane fade in active">
      <div class="user col-md-12" id="requestFriends">
         <h4 align="center"><b>받은 친구 신청</b></h4><hr>
         <ul class="nav nav-list" id="requestList"></ul>
      </div>
   </div>
   </div>
<!-- end: right menu -->
</sec:authorize>

