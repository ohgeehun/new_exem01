<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- !DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>EXEM</title> 
<link rel="stylesheet" type="text/css" media="screen" href="./resources/css/exem_mem.css"/>

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

function clearText(thefield){
	if (thefield.defaultValue==thefield.value){
		thefield.value = "";
	}
}  
</script>

<meta name="viewport" content="width=device-width,initial-scale=1.0, user-scalable=no"> 
<style>

@-ms-viewport{width:device-width,initial-scale=1.0, user-scalable=no;}
@-o-viewport{width:device-width,initial-scale=1.0, user-scalable=no;}
@viewport{width:device-width,initial-scale=1.0, user-scalable=no;} 

</style>

<body>



<div class="outer">
	<div class="wrap">
		<div class="nLoginBase">
			<li class="inPut_guideTitle">EXEM 일정관리시스템</li>
			<li class="inPut_guideMessage">EXEM 일정관리시스템은 사내 직원용으로 부여된 <br>아이디와 패스워드 인증을 거친 후 사용 가능합니다.
</li>

			<input type="text" id="userId" name="user_id" class="inPutBox_id" value="user id" onFocus="clearText(this);">
			<input type="password" id="userPw" name="user_pw" class="inPutBox_pw" value="passwd" onFocus="clearText(this);">

			<input type="checkbox" class="inPut_chkbx">
			<li class="inPut_IdSave">User Id 저장</li>
 
			<input type="submit"  id="loginBtn" name="OK" class="inBtt_OK" value="Log In">
			<input type="submit" name="search_pass" class="inBtt_PassSearch" value="Password Search">
		</div>
	</div>
</div>



</body>
</html>













