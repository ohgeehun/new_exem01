<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" ></link>
<link rel="stylesheet" type="text/css" media="not all and (max-width:430px)" href="./resources/css/exem_mem.css"/>
<link rel="stylesheet" type="text/css" media="only all and (max-width:430px)" href="./resources/css/exem_mem_m.css"/>

<style>
html.open { overflow: hidden; } 
.btn { width: 50px; height: 50px; position: absolute; right: 0px; top: 0px; z-index: 1; background-image: url("http://s1.daumcdn.net/cfs.tistory/custom/blog/204/2048858/skin/images/menu.png"); background-size: 50%; background-repeat: no-repeat; background-position: center; cursor: pointer; } 
.close { width: 50px; height: 50px; position: absolute; right: 0px; top: 0px; background-image: url("http://s1.daumcdn.net/cfs.tistory/custom/blog/204/2048858/skin/images/close.png"); background-size: 50%; background-repeat: no-repeat; background-position: center; cursor: pointer; } 
#menu { width: 150px; height: 100%; position: fixed; top: 0px; right: -152px; z-index: 10; border: 1px solid #c9c9c9; background-color: white; text-align: center; transition: All 0.2s ease; -webkit-transition: All 0.2s ease; -moz-transition: All 0.2s ease; -o-transition: All 0.2s ease; } 
#menu.open { right: 0px; } .page_cover.open { display: block; } .page_cover { width: 100%; height: 100%; position: fixed; top: 0px; left: 0px; background-color: rgba(0,0,0,0.4); z-index: 4; display: none; }

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

$(".btn").click(function () { 
	$("#menu,.page_cover,html").addClass("open");
	window.location.hash = "#open"; 
 }); 
 
 window.onhashchange = function () { if (location.hash != "#open") { 
	 $("#menu,.page_cover,html").removeClass("open"); 
	 } };




</script>

<div class="top_LogoPart">
	<div class="top_logoBase">
		<a href="#" class="top_logoImg"></a>

		<a href="#" class="top_logMyPage" id="mypageBtn">마이페이지</a>
		<a href="#" class="top_logInOut" id="logoutBtn">로그아웃 </a>
	</div>
</div>

<div class="btn"> </div> 
<div onclick="history.back();" class="page_cover"></div> 

<div id="menu">
	<a href="#" class="top_Menu01" id="scheduleBtn">일정관리</a>
	<a href="#" class="top_Menu02" id="customerBtn">고객사관리</a>
	<a href="#" class="top_Menu03" id="maintenanceBtn">유지보수관리</a>
	<a href="#" class="top_Menu04" id="memeberBtn">사용자관리</a> 

   	<div onclick="history.back();" class="close"></div>
</div>




<!-- 		<div class="top_MenuPart">
			<div class="top_MenuBase">
				<a href="#" class="top_Menu01" id="scheduleBtn">일정관리</a>
				 <a href="#" class="top_Menu02" id="customerBtn">고객사관리</a>
				<a href="#" class="top_Menu03" id="maintenanceBtn">유지보수관리</a>
				<a href="#" class="top_Menu04" id="memeberBtn">사용자관리</a> 
			</div>
		</div> -->

<!-- div class="topnav">
    <div class="topnav_right">  
	    <div style="color:#FFFFFF" align="right">
	   	로그인 계정 : ${sUserId}
	   </div>  	
	</div>
</div-->