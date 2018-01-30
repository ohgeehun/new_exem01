<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.min.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.css" media="all" /> 
<title>Insert title here</title>

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/jquery/fullcalendar.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/moment.min.js"></script>
<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<!-- <script type="text/javascript" src="dwr/interface/IMypageService.js"></script> -->

<script>
$(function(){
	calendarEvent();
});

function calendarEvent(eventData){
	$("#calendar").html("");
	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	var calendar = $('#calendar').fullCalendar({
		header: {
			left :"",
			center: "title",
			right: "today prev,next"
		},
		editable: true,
		titleFromat:{
			month: "yyyy년 MMMM",
			week: "[yyyy] MMM dd일{[yyyy]MMMdd일}",
			day: "yyyy년 MMMd일 dddd"
		},
		allDayDefault:false,
		defaultView:"month",
		editable:false,
		monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		monthNamesShort:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		dayNames:["일요일","월요일","화요일","수요일","목요일","금요일","토요일"],
		dayNamesShort:["일","월","화","수","목","금","토"],
		buttonText:{
			today:"오늘",
			month:"월별",
			week:"주별",
			day:"일별"
		},
		events:eventData,
		timeFromat:"HH:mm",
	});
}
</script>
<style>

</style>

</head>
<body>
<c:import url="/main_upview"></c:import>
<div class="row">
	 <div class="column side">
		   <h4>일정 관리 페이지</h4></br>
		   <a href="#" id="">내 일정 관리</a></br>		    
		   <a href="#" id="">팀 일정</a></br>
	 </div>
	 <div class="column middle">
		<div id='calendar'>		
		
		</div>
	</div>
</div>
	<c:import url="/main_botview"></c:import>
</body>
</html>

