<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/interface/ILoginService.js"></script>
</head>

<script type="text/javascript">


$(document).ready(function(){
	$("#loginBtn").bind("click", function(){
		if($("#userId").val()==""){
			alert("로그인명을 입력하세요.");
			$("#userId").focus();
		}else if($("#userPw").val() ==""){
			alert("비밀번호를 입력하세요.");
			$("#userPw").focus();
		}
		
		ILoginService.getUserInfo($("#userId").val(), $("#userPw").val(), LoginCallBack);
	});
});

function LoginCallBack(res){	
	 if(res == "ID_FAILED"){
		alert("아이디가 존재하지 않습니다.");		
		$("#userId").focus();
	}else if(res == "PW_FAILED"){		
		alert("비밀번호가 맞지 않습니다.");	
		$("#userPw").focus();	
	} else{
		location.href= "main";
	}
}
</script>
<meta name="viewport" content="width=device-width,initial-scale=1.0, user-scalable=no">
<style>

@-ms-viewport{width:device-width,initial-scale=1.0, user-scalable=no;}
@-o-viewport{width:device-width,initial-scale=1.0, user-scalable=no;}
@viewport{width:device-width,initial-scale=1.0, user-scalable=no;}

form {
    border: 3px solid #f1f1f1;
}

input[type=text], input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}

button:hover {
    opacity: 0.8;
}

.cancelbtn {
    width: auto;
    padding: 10px 18px;
    background-color: #f44336;
}

.imgcontainer {
    text-align: center;
    margin: 24px 0 12px 0;
}

img.avatar {
    width: 40%;
    border-radius: 50%;
}

.container {
    padding: 16px;
}

span.psw {
    float: right;
    padding-top: 16px;
}

</style>

<body>
	<h2>EXEM 관리시스템</h2>	
	<!-- <form method="post" action="loginResult"> -->
	  <div class="imgcontainer">
	   <!--  <img src="img_avatar2.png" alt="Avatar" class="avatar"> -->
	  </div>
	
	  <div class="container">
	    <label><b>로그인</b></label>
	    <input type="text" placeholder="로그인명" id="userId" value="${userId}">
	
	    ${userId}
	    <label><b>비밀번호</b></label>
	    <input type="password" placeholder="비밀번호" id="userPw" required>
	        
	    <button id="loginBtn">로그인</button>
	    <input type="checkbox" checked="checked"> 로그인명 저장
	    <span class="psw"><a href="#">비밀번호 찾기</a></span>	    
	  </div>
	
	  <div class="container" style="background-color:#f1f1f1">
	   <!--  <button type="button" class="cancelbtn">취소</button> -->
	  
	  </div>
	<!-- </form> 	 -->
</body>
</html>













