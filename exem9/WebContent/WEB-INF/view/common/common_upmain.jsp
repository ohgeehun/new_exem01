<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" ></link>
<link rel="stylesheet" type="text/css" media="not all and (max-width:430px)" href="./resources/css/exem_mem.css"/>
<link rel="stylesheet" type="text/css" media="only all and (max-width:430px)" href="./resources/css/exem_mem_m.css"/>

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
		location.href = "my_schedule";
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
		location.href = "member_edit";
	});
});


</script>

		<div class="top_LogoPart">
			<div class="top_logoBase">
				<a href="#" class="top_logoImg"></a>

				<a href="#" class="top_logMyPage" id="mypageBtn">마이페이지</a>
				<a href="#" class="top_logInOut" id="logoutBtn">로그아웃 </a>
			</div>
		</div>

		<div class="top_MenuPart">
			<div class="top_MenuBase">
				<a href="#" class="top_Menu01" id="scheduleBtn">일정관리</a>
				<a href="#" class="top_Menu02" id="customerBtn">고객사관리</a>
				<a href="#" class="top_Menu03" id="maintenanceBtn">유지보수관리</a>
				<a href="#" class="top_Menu04" id="memeberBtn">사용자관리</a>
			</div>
		</div>

<!-- div class="topnav">
    <div class="topnav_right">  
	    <div style="color:#FFFFFF" align="right">
	   	로그인 계정 : ${sUserId}
	   </div>  	
	</div>
</div-->