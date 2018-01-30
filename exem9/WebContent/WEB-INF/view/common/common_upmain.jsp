<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" />

<style type="text/css">

</style>

<script type="text/javascript">
$(document).ready(function(){
	$("#logoutBtn").bind("click", function(){
		location.href = "logout";
	});
});

$(document).ready(function(){
	$("#mypageBtn").bind("click", function(){
		location.href = "mypage";
	});
});

$(document).ready(function(){
	$("#scheduleBtn").bind("click", function(){
		location.href = "schedule";
	});
});

$(document).ready(function(){
	$("#customerBtn").bind("click", function(){
		location.href = "customer_edit";
	});
});

$(document).ready(function(){
	$("#maintenanceBtn").bind("click", function(){
		location.href = "maintenance";
	});
});

$(document).ready(function(){
	$("#memeberBtn").bind("click", function(){
		location.href = "member";
	});
});


</script>

<div class="header">
  <h1>EXEM 관리 시스템</h1>
  <p>EXEM 고객 지원 시스템입니다.</p>
</div>

<div class="topnav">
	<div class="topnav_left">
    	<a href="#" id="scheduleBtn">일정관리</a>
  		<a href="#" id="customerBtn">고객사관리</a>
    	<a href="#" id="maintenanceBtn">유지보수관리</a>
    	<a href="#" id="memeberBtn">사용자관리</a>      
	</div>    
    
    <div class="topnav_right">  
	    <div style="color:#FFFFFF" align="right">
	   	로그인 계정 : ${sUserId}
	   </div>  	
    	<a href = "#" id="mypageBtn">마이페이지</a>
		<a href = "#" id="logoutBtn">로그아웃</a>
	</div>
</div>