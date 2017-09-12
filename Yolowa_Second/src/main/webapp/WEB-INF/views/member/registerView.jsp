<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- CSS -->
<link rel="stylesheet"
   href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
<link rel="stylesheet"
   href="${pageContext.request.contextPath }/resources/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
   href="${pageContext.request.contextPath }/resources/assets/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet"
   href="${pageContext.request.contextPath }/resources/assets/css/form-elements.css">
<link rel="stylesheet"
   href="${pageContext.request.contextPath }/resources/assets/css/style.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<!-- Favicon and touch icons -->
<link rel="apple-touch-icon-precomposed" sizes="144x144"
   href="${pageContext.request.contextPath }/resources/assets/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
   href="${pageContext.request.contextPath }/resources/assets/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
   href="${pageContext.request.contextPath }/resources/assets/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
   href="${pageContext.request.contextPath }/resources/assets/ico/apple-touch-icon-57-precomposed.png">


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

.login-form .form-group .form-username {
   display: inline;
   width: 65%;
   margin-left: 80px;
   height: 50px;
}

.login-form .form-group .form-password {
   display: inline;
   width: 65%;
   margin-left: 59px;
   height: 50px;
   
}

#blankDiv {
   margin-top: 30px;
}

.login-form .form-group .phoneInput1{
   margin-left: 58px;
   width: 80px;
   height: 50px;
   
}
.login-form .form-group .phoneInput2{
   margin-left: 5px;
   width: 80px;
   height: 50px;
}
.login-form .form-group .phoneInput3{
   margin-left: 5px;
   width: 80px;
   height: 50px;
}

.login-form .form-group .check-form{
    margin-left: 55px;
    width: 20px;
    height: 20px;
} 
.login-form .form-group .form-address{
   margin-left: 75px;
   width: 130px;
}
.socialForm{
   margin-left: 10px;
   padding-bottom: 5px;
   height: 50px;
}
.form-group .addressText{
      margin-left: 140px;
      width: 65%;
}
label[for="c"] {
        position: relative;
        bottom: 6px;
      }

</style>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 


<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
      $(document).ready(function() {
         
         $("#sample6_postcode").click(function(){
            $("#searchBtn").trigger("click");
         });
         var checkResultId="";   
          $("#signUp").click(function(){
               if(checkResultId==""){
                  alert("아이디 중복확인을 하세요");
                  return false;
               }
               if($("#id").val()==""){
                  alert("아이디를 입력하세요");
                  return false;
               }
               if($("#password").val()==""){
                  alert("패스워드를 입력하세요");
                  return false;
               }
               if($("#name").val()==""){
                  alert("이름을 입력하세요");
                  return false;
               }
               if($("#phone2").val() =="" || $("#phone3").val()==""){
                  alert("핸드폰 번호를 입력하세요.");
                  return false;
               }
               if($("#phone2").val().length < 4 || $("#phone2").val().length > 4){
					alert("정확한 핸드폰 번호를 입력하세요.");
					return false;
				}
				if($("#phone3").val().length < 4 || $("#phone3").val().length > 4){
					alert("정확한 핸드폰 번호를 입력하세요.");
					return false;
				}
               if(isNaN(parseInt($("#phone2").val()))==true || isNaN(parseInt($("#phone3").val()))==true){
                  alert("숫자를 입력하세요.");
                  return false;
               }
               var addressDetail =$("#sample6_postcode").val();
               addressDetail +="/"+$("#sample6_address").val();
               addressDetail +="/"+$("#sample6_address2").val();
               $("#addressTxt").val(addressDetail);
               
               if($(":input[name=checkbox_category]:checked").length<1||
                     $(":input[name=checkbox_category]:checked").length>3){
                  alert("카테고리를 1개 이상 3개 이하 선택하세요");
                  return false;
               }
                var category=$(":input[name=checkbox_category]:checked");
               var tmp="";
               for(var i=0;i<category.length;i++){
                  tmp +="<input type='hidden'name='cNo' value="+$(category[i]).val()+">"; 
               }  
               var phoneNumber = "010";
               phoneNumber +="-"+$("#phone2").val();
               phoneNumber +="-"+$("#phone3").val();
               $("#phoneToString").val(phoneNumber);
               $("#category").html(tmp);
               $("#form-signin").submit();   
         }); //click
         // 아이디 중복 체크
         $(":input[name=id]").keyup(function(){
            var id=$(this).val().trim();
            if(id.length<4 || id.length>10){
               $("#idCheckView").html("아이디는 4자이상 10자 이하여야 함!").css(
                     "color","pink");
               checkResultId="";
               return;
            }         
            $.ajax({
               type:"POST",
               url:"${pageContext.request.contextPath}/idcheckAjax.do",         
               data:"id="+id,   
               success:function(data){                  
                  if(data=="fail"){
                  $("#idCheckView").html(id+" 사용불가!").css("color","red");
                     checkResultId="";
                  }else{                  
                     $("#idCheckView").html(id+" 사용가능!").css("color",
                           "white");      
                     checkResultId=id;
                  }               
               }//callback         
            });//ajax
         });//keyup
      }); //ready
      function sample6_execDaumPostcode() {
           new daum.Postcode({
               oncomplete: function(data) {
                   // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                   // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                   // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                   var fullAddr = ''; // 최종 주소 변수
                   var extraAddr = ''; // 조합형 주소 변수

                   // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                   if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                       fullAddr = data.roadAddress;

                   } else { // 사용자가 지번 주소를 선택했을 경우(J)
                       fullAddr = data.jibunAddress;
                   }

                   // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                   if(data.userSelectedType === 'R'){
                       //법정동명이 있을 경우 추가한다.
                       if(data.bname !== ''){
                           extraAddr += data.bname;
                       }
                       // 건물명이 있을 경우 추가한다.
                       if(data.buildingName !== ''){
                           extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                       }
                       // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                       fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                   }

                   // 우편번호와 주소 정보를 해당 필드에 넣는다.
                   document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                   document.getElementById('sample6_address').value = fullAddr;

                   // 커서를 상세주소 필드로 이동한다.
                   document.getElementById('sample6_address2').focus();
               }
           }).open();
       }
   </script>

</head>

<body>

   <!-- Top content -->
   <div class="top-content">
      <div class="inner-bg">
         <div class="row">
            <div class="col-sm-8 col-sm-offset-2 text">
               <h1>You Only Live Once</h1>
               <div class="description">
                  <p>
                     <strong>YOLO</strong> 라는 뜻은 <strong>"You Only Live Once"</strong>
                     입니다.<br> 보다 더 좋은 서비스를 위해 저희는 고객의 입장에서 항상 생각 합니다. <br> <a
                        href="${pageContext.request.contextPath }/home.do"><strong>YoloWa</strong></a>
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
                        <h3>New Create Account</h3>
                        <p><strong>YoloWa</strong> 페이지는 회원가입이 필수 입니다.</p>
                     </div>
                     <div class="form-top-right">
                        <i class="fa fa-key"></i>
                     </div>
                  </div>
                  <div class="form-bottom">
                     <form role="form" action="${pageContext.request.contextPath}/registerMember.do" method="post"
                        class="login-form" id="form-signin">
                        <div class="form-group">
                           <font style="font-size: 20px; color: white"> 아이디</font><input
                              type="text" name="id" placeholder="ID"
                              class="form-username form-control" id="form-username">
                           <span id="idCheckView" style="margin-top: 10px"></span>
                        </div>
                        <div class="form-group">
                           <font style="font-size: 20px; color: white"> 비밀번호</font><input
                              type="password" name="password" placeholder="Password"
                              class="form-password form-control" >
                        </div>
                        <div class="form-group">
                           <font style="font-size: 20px; color: white"> 이름　</font><input
                              type="text" name="name" placeholder="Name"
                              class="form-username form-control" >
                        </div>
                        <div class="form-group">
                           <font style="font-size: 20px; color: white">전화번호</font>
                           <input type="text" name="phone1"  readonly="readonly" value="010" class="form-username phoneInput1">
                           <input type="text" id="phone2"  class="form-username phoneInput2">
                           <input type="text" id="phone3"  class="form-username phoneInput3">
                           <input type="hidden" name="phone"  id="phoneToString">
                        </div>
                        <div class="form-group">
                           <font style="font-size: 20px; color: white"> 주소　</font>
                           <input type="text" id="sample6_postcode" placeholder="우편번호" class="form-username form-address" >
                           <input type="button" onclick="sample6_execDaumPostcode()" 
                           value="우편번호 찾기" class="btn socialForm" id="searchBtn">
                        </div>
                        <div class="form-group">
                           <input type="text" id="sample6_address" placeholder="주소" class="addressText">
                           <div class="form-group"></div>
                           <input type="text" id="sample6_address2" placeholder="상세주소" class="addressText">
                           <input type="hidden" name="address" id="addressTxt">
                        </div>
                        <div class="form-group">
                              <font style="font-size: 20px;" color="white"> 카테고리</font><br>
                              <hr>
                           <div class="checkBoxStyle">
                           <c:forEach items="${categoryList}" var="category" varStatus="index">
                           <input type="checkbox" name="checkbox_category" value="${category.cNO}"  class="check-form" ><label for="c"><font style="font-size: 16px; color: white;">${category.cType}</font></label> 
                              <c:if test="${index.count ==3 }">
                                 <br>
                              </c:if>
                           </c:forEach>
                           </div>
                        </div>
                        <div id="category"></div>
                        <button type="submit" class="btn" id="signUp">Create Account !</button>
                  </form>
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
               Made by Kosta145 <a
                  href="${pageContext.request.contextPath }/home.do"><strong>YoloWa</strong></a>
               having a lot of fun. <i class="fa fa-smile-o"></i>
            </p>
         </div>
      </div>
   </footer>
   <!-- Javascript -->
   <script
      src="${pageContext.request.contextPath }/resources/assets/js/jquery-1.11.1.min.js"></script>
   <script
      src="${pageContext.request.contextPath }/resources/assets/bootstrap/js/bootstrap.min.js"></script>
   <script
      src="${pageContext.request.contextPath }/resources/assets/js/jquery.backstretch.min.js"></script>
   <script
      src="${pageContext.request.contextPath }/resources/assets/js/scripts.js"></script>
</body>
</html>