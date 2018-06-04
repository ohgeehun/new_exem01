<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.min.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/jquery/jquery.datetimepicker.min.css"/>
<link rel="stylesheet" type="text/css" media="all" href="./resources/css/exem_mem_m.css"/>
<link rel="stylesheet" type="text/css" media="all" href="./resources/css/schedule/my_schedule_m.css"/>
<link rel="stylesheet" type="text/css" media="all" href="./resources/css/jquery.mobile-1.4.5.min.css"/>

<!-- jQuery Script -->
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script> 
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/moment.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/fullcalendar.min.js"></script>

<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<!-- <script type="text/javascript" src="dwr/interface/IMypageService.js"></script> -->
<script type="text/javascript" src="dwr/interface/IScheduleService.js"></script>
<script type="text/javascript" src="dwr/interface/ICustomerService.js"></script>

<meta name="viewport" content="width=device-width,initial-scale=1.0, user-scalable=no"> 
<style>

@-ms-viewport{width:device-width,initial-scale=1.0, user-scalable=no;}
@-o-viewport{width:device-width,initial-scale=1.0, user-scalable=no;}
@viewport{width:device-width,initial-scale=1.0, user-scalable=no;}

</style>

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

var year = "${year}";
var from_day = "${from_day}";
var to_day = "${to_day}";

var currentPjtId;
//console.log(year);
//console.log(from_day);
//console.log(to_day);

var temp = [];
$(document).ready(function(){
	// dateTimePicker 한글화
	$.datetimepicker.setLocale('ko');
	
	// dateTimePicker moment.js와 연동. 시간 단위로 선택하도록 설정하는 작업
	$.datetimepicker.setDateFormatter({
	    parseDate: function (date, format) {
	        var d = moment(date, format);
	        return d.isValid() ? d.toDate() : false;
	    },
	 
	    formatDate: function (date, format) {
	        return moment(date).format(format);
	    }
	})
	
	$('#weekilter').val(from_day);

    // datetimepicker 선택시 팝업창 표시
    $('.datetimepicker').datetimepicker({
          format:'YYYY-MM-DD HH:mm',
          formatTime:'HH:mm',
          formatDate:'YYYY-MM-DD'
    });
	
	$('textarea[name=contents]').bind('mouseenter', function() {
		$(this).addClass('enlarged_textarea');
	})
	
	$('textarea[name=contents]').bind('mouseout', function() {
		$(this).removeClass('enlarged_textarea');
	})
	
	$("#sch_insert").bind("click", function(){	
	   	location.href = "schedule_insert";
	});
	
	$("#my_sch").bind("click", function(){	
	   	location.href = "my_schedule";
	});
	
	$("#team_sch").bind("click", function(){	
	   	location.href = "team_schedule";
	});
	
	$("#thisWeek").bind("click", function(){	
	   	location.href = "my_schedule";
	});
	
	$("ul").on("click", "li", function(){
		
		/* $.post("schedule_edit_m",{supoId:$(this).val()});  */
		/* location.href = "schedule_edit_m"; */
	  	/* var supoId = {"supoId":$(this).val()}; */
		 $.ajax({   
			   type: "POST"  
			  ,url: "schedule_edit_m"
			  ,data: {supoId: $(this).val()}
			  ,success:function(data){
			    alert("성공");
			  } 
			  ,error:function(data){
				    alert("error");
			  }
		  });  
		 
 		/* alert($(this).val());
		
		$(this).submit(); */
	});
		
	/* 체크박스 이벤트 */
	$("#checkall").click(function(){
        //클릭되었으면
        if($("#checkall").prop("checked")){
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
            $("input[name=chk]").prop("checked",true);
            //클릭이 안되있으면
        }else{
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
            $("input[name=chk]").prop("checked",false);
        }
    });
	
	// 수정버튼 클릭 시
	$("#edit_update_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("수정할 행을 선택하세요.");
		} else{
			
	   	    $('#checkbox_id:checked').each(function() {   	    
   	    	    var chkId = $(this).val();

   	    	 	var user_id = userId;    // 세션에서 가져와야 함
   	    	 	//var startDay = $("#startDay_"+chkId).val();
   	    	    var cusId = $("#cusNm_"+chkId+" option:selected").val();
   	         	var pjtId = $("#pjtNm_"+chkId+" option:selected").val();
   	         	var startTime = $("#startTime_"+chkId).val();
   	         	var endTime = $("#endTime_"+chkId).val();
   	         	var dbmsId = $("#dbmsId_"+chkId+" option:selected").val();
   	         	var cateId = $("#cateId_"+chkId+" option:selected").val();
   	         	var contents = $("#contents_"+chkId).val();
   	         	
   	         	//console.debug( " | " + cusId + " | " + pjtId + " | " +startTime + " | " + endTime + " | " + dbmsId + " | " + cateId + " | " +contents + " | " + chkId );
   	         	
   	         	IScheduleService.updateSchinfo(
  					user_id, 
  					cusId,
  					pjtId,
					dbmsId, 
					cateId, 
					startTime,
					endTime,
					contents,
					chkId,
					updateSchinfoCallBack
				)
	   	    });	
		}
	});
	
	$("#edit_delete_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("삭제할 행을 선택하세요.");
		} else{
			if (confirm("정말 삭제하시겠습니까??") == true){    //확인
				
		   	    $('#checkbox_id:checked').each(function() {   	    
	   	    	    var chkId = $(this).val();

	   	         	IScheduleService.deleteSchinfo(
	  					chkId,
						deleteSchinfoCallBack
					)
		   	    });
			
			}else{   //취소
			    return;
			}

		}
	});
	
	$('#week-label-year').val(year);	
	$('#week-label-from-day').val(from_day);	
	$('#week-label-to-day').val(to_day);	
	
	// 이전주, 다음주 클릭시 이벤트 처리
	$("#prevWeek").bind("click", function(){	
		// 현재 셋팅된 날짜를 가지고 와서, 이값을 입력하면 이전주의 시작일과 종료일을 리턴한다.
		
		//var yyyy = $('#week-label-year').text();
		var yyyy = $('#week-label-year').val();
		var mmdd = $('#week-label-from-day').val();
		//var mm = mm-dd.substring(0,2);
		//var dd = mm-dd.substring(3,5);
		var selectedDay = yyyy + '-' + mmdd;  // yyyy-mm-dd로 입력
	
		var cal_yyyymmdd_yyyymmdd = calWeek(selectedDay,'prev'); // yyyy-mm-ddyyyy-mm-dd 이렇게 계산한다.
		
		yyyy = cal_yyyymmdd_yyyymmdd.substring(0,4);
		mmdd = cal_yyyymmdd_yyyymmdd.substring(5,10);
		mmdd2 =  cal_yyyymmdd_yyyymmdd.substring(15,20);
		
		//$('#week-label-year').text(yyyy);
		$('#week-label-year').val(yyyy);
		$('#week-label-from-day').val(mmdd);
		$('#week-label-to-day').val(mmdd2);
		
		$('#weekilter').val(mmdd);
		
		$("#form1").submit();
	});
	
	$("#nextWeek").bind("click", function(){	
		// 현재 셋팅된 날짜를 가지고 와서, 이값을 입력하면 다음주의 시작일과 종료일을 리턴한다.
		
		//var yyyy = $('#week-label-year').text();
		var yyyy = $('#week-label-year').val();
		var mmdd = $('#week-label-from-day').val();
		//var mm = mm-dd.substring(0,2);
		//var dd = mm-dd.substring(3,5);
		var selectedDay = yyyy + '-' + mmdd;  // yyyy-mm-dd로 입력
	
		var cal_yyyymmdd_yyyymmdd = calWeek(selectedDay,'next'); // yyyy-mm-ddyyyy-mm-dd 이렇게 계산한다.
		
		yyyy = cal_yyyymmdd_yyyymmdd.substring(0,4);
		mmdd = cal_yyyymmdd_yyyymmdd.substring(5,10);
		mmdd2 =  cal_yyyymmdd_yyyymmdd.substring(15,20);
		
		//$('#week-label-year').text(yyyy);
		$('#week-label-year').val(yyyy);
		$('#week-label-from-day').val(mmdd);
		$('#week-label-to-day').val(mmdd2);
		
		$('#weekilter').val(mmdd);
		
		$("#form1").submit();
	});
	
	/*페이지 처리(이전 버튼 이벤트 )*/
    $("#backVal").live("click", function(){
    	$("#nowPage").val($("#nowPage").val() - 1);    	
    	$("#form1").submit();	
    	
    });
    
    /*페이지 처리(다음 버튼 이벤트 )*/
    $("#nextVal").live("click", function(){
    	$("#nowPage").val($("#nowPage").val()*1 + 1);
    	$("#form1").submit();	
    });

    /*페이지 처리(페이지 숫자 버튼 이벤트 )*/
    $("a[name='moreArea']").live("click", function(){
    	$("#nowPage").val($(this).attr("id"));
    	$("#form1").submit();	
    });
    
    // 고객사 선택시 프로젝트목록 자동 변경 처리
    $('select[name=select_cust]').change(function(){
    	var cusId = $(this).val();
    	console.log("cusId: " + cusId)
    	// 현재 Id로 부터 선택된 행을 알아내어, 프로젝트 선택박스ID 찾는데 사용
    	var currentCusId = $(this).attr('id'); 
    	var temps = currentCusId.split('_');
    	currentPjtId = 'pjtNm_' + temps[1];
    	console.log("currentPjtId: " + currentPjtId)
    	
    	// cusId를 입력하여 해당 프로젝트 목록 정보를 가져오는 서비스 호출
    	ICustomerService.getProinfo2(cusId, getProinfoCallBack);
    });
    
    // 프로젝트명 선택박스 선택시 프로젝트목록 자동 변경 처리
    $('select[name=select_pjt]').click(function(){
    	//$(this).html('');
    	var pjtId = $(this).val();
    	//console.log("pjtId: " + pjtId)
    	// 현재 Id로 부터 선택된 행을 알아내어, 프로젝트 선택박스ID 찾는데 사용
    	currentPjtId = $(this).attr('id'); 
    	var temps = currentPjtId.split('_');
    	var currentCusId = 'cusNm_' + temps[1];
    	//console.log("currentCusId: " + currentPjtId)
    	var cusId = $('#'+currentCusId).val();
    	
    	// cusId를 입력하여 해당 프로젝트 목록 정보를 가져오는 서비스 호출
    	ICustomerService.getProinfo2(cusId, getProinfoCallBack);
    });
    
});
			
// 이전주와 다음주 계산하는 함수
function calWeek(yyyymmdd, isPrev ){
	console.log(yyyymmdd);
	// yyyymmdd에는 yyyy-mm-dd 형태로 값이 들어옴

	var selectedDay = new Date(yyyymmdd);  // 금주 월요일  
	console.log(selectedDay);
	
	var resultDay = new Date(selectedDay);

	var thisMonday;
	var thistoSunday;
	
	if ( isPrev == 'prev')
		resultDay.setDate( resultDay.getDate() - 7 );  // 전주 월요일
	else
		resultDay.setDate( resultDay.getDate() + 7 );  // 다음주 월요일
	
	console.log(resultDay);
	
	var yyyy = resultDay.getFullYear();
	var mm = Number(resultDay.getMonth()) + 1;
	var dd = resultDay.getDate();
	
	mm = String(mm).length === 1 ? '0' + mm : mm;
	dd = String(dd).length === 1 ? '0' + dd : dd;
	
	thisMonday = yyyy + '-' + mm + '-' + dd;
	////////
	var resultDay2 = new Date(resultDay);
	resultDay2.setDate( resultDay2.getDate() +6 ) ; // 주일 계산
	
	var mm2 = Number(resultDay2.getMonth()) + 1;
	var dd2 = resultDay2.getDate();
	
	var yyyy2 = resultDay2.getFullYear();
	mm2 = String(mm2).length === 1 ? '0' + mm2 : mm2;
	dd2 = String(dd2).length === 1 ? '0' + dd2 : dd2;
	
	thistoSunday = yyyy2 + '-' + mm2 + '-' + dd2;
	
	console.log(thisMonday+thistoSunday);
	return thisMonday+thistoSunday;  // 결과값은 yyyy-mm-ddyyyy-mm-dd 형태임
}

function updateSchinfoCallBack(res){
	if(res == "FAILED"){
		//alert("실패");
		location.href = "my_schedule";
	}else if(res == "SUCCESS"){
		//alert("성공");
		location.href = "my_schedule";
	}
}

function deleteSchinfoCallBack(res){
	if(res == "FAILED"){
		//alert("실패");
		location.href = "my_schedule";
	}else if(res == "SUCCESS"){
		//alert("성공");
		location.href = "my_schedule";
	}
}

function getProinfoCallBack(arrayList){
	$("#"+currentPjtId).html("");  // 프로젝트 리스트 초기화
	if(arrayList.length > 0) { // arrayList에 프로젝트목록이 들어온다. customer_project_id 셀렉트박스목록을 갱신한다.
		for(var i=0; i<arrayList.length; i++)
		{
		    var testObj = arrayList[i];
		    console.log("testObj.proNm: " + testObj.proNm);
		    $('#'+currentPjtId).append('<option value='+testObj.proId+'>'+testObj.proNm+'</option>');
		}
	} else {
		alert("선택한 고객사에 등록된 프로젝트가 없습니다.");
	}
}

function listViewClick(e) {
   alert(e.button); // Kendo mobile Button instance
}
</script>

</head>

<body>
<c:import url="/main_upview"></c:import>
		<div class="top_SubMenuPart">
			<div class="top_MenuBase">
				<a href="#" class="top_SubMenu01" id="sch_insert">일정등록</a>
				<a href="#" class="top_SubMenu02" id="my_sch">내 일정보기</a>
				<a href="#" class="top_SubMenu03" id="team_sch">팀 일정보기</a> 
			</div>
		</div> 
		
<div class="row"> <!-- dummy -->

	<form id="form1" method="post" action="my_schedule_next">	
	     <!-- 아래는 hidden 2개는 사실상 필요없음. javascript처리와 java에서 함께 삭제해야함 -->
		 <input type="hidden" id="cus_select4" name="selectBtnVal" value="0">
		 <input type="hidden" id="select_text" name="selectTextVal" value="검색 조건을 선택하세요.">
		 
		 <!-- div class="column middle"-->
		 <div class="top_mainDisplayPart">
		 	<div align="center"><h3>내 일정 정보</h3></div>
		 	
			<input type="hidden" id="nowPage" name="pageNo" value="${nowPage}">
			<input type="hidden" id="userId_hidden_id" value="">				
		 		 				 	   
			<input type="button" id="thisWeek" class="main_title_box_2 nTitleFont" value="이번주 일정보기"/>									
			<input type="hidden" value="${weekFilter}" name="weekFilter" id="weekilter">					
				
 			<input type="button" class="main_title_box_2 nTitleFont" id="prevWeek" value="이전주"/>
 		    <input type="button" class="main_title_box_2 nTitleFont" id="nextWeek" value="다음주"/>
					 	 		
	 	    <!-- <div class="nTitleFont">
			  <div style='display:inline;'>&nbsp;</div>
			  div id="week-label-year" style='display:inline;'></div						  
			  <input type="text" id="week-label-year" name="week-label-year" class="titleFont_2" readonly="readonly">
			  <div style='display:inline;'>년</div>
			  div id="week-label-from-day" style='display:inline;'>01-01</div
			  <input type="text" id="week-label-from-day" name="week-label-from-day" class="titleFont_2" readonly="readonly">
			  <div style='display:inline;'>(월) &nbsp; ~ </div>
			  div id="week-label-to-day" style='display:inline;'>02-05</div
			  <input type="text" id="week-label-to-day" name="week-label-to-day" class="titleFont_2" readonly="readonly">
			  <div style='display:inline;'>(일)</div>
			  <div style='display:inline;'>&nbsp;</div>
			</div> -->
						
			<div id="date_list" data-role="content" class="content"/>		
					<ul data-role="listview">		
						<li data-role="list-divider"> ${year}년   ${from_day} ~ ${to_day}</li>	
					</ul>								
					<input type="hidden" id="week-label-year" name="week-label-year"/>
					<input type="hidden" id="week-label-from-day" name="week-label-from-day"/>
					<input type="hidden" id="week-label-to-day"  name="week-label-to-day"/>
					<input type="hidden" id="supo_day"  name="supo_day"/>
			</div>  
		</form>	
		<form id="form2" method="post" action="schedule_edit_m">	
			<div id="schedule_list" data-role="content" class="content">		
				   <ul data-role="listview" data-inset="true" data-click="listViewClick">					
					        <li data-role="list-divider" data-split-icon="plus">월 ( ${weeks1} )<a href="#" ></a></li>		 
					      	 <c:forEach var="sch" items="${sch_list}" >
		        	 				 <c:choose>
										<c:when test="${fn:substring(sch.start_time,5,10)  == weeks1}">
											<li><a href="#">
												 <h3>${sch.schCusNm} - ${sch.schPjtNm}</h3>
												 <p>${sch.category_name}</p></b>
								                 <p> - ${sch.contents}</p>
								                 <p class="ui-li-aside">${fn:substring(sch.start_time,11,16)}-${fn:substring(sch.end_time,11,16)}</p>
								                 <input type="hidden" id="supoId_${sch.schId}"  name="supoId" value="${sch.schId}"/> 
							            	 </a> </li>
										</c:when>									
									</c:choose>						        	 
			        	    </c:forEach>					        
					     
					       <li data-role="list-divider" >화 ( ${weeks2} )<span class="ui-li-count"></span></li>
				      	   <c:forEach var="sch" items="${sch_list}">
		        	 				 <c:choose>
										<c:when test="${fn:substring(sch.start_time,5,10)  == weeks2}">
											<li><a href="#">
												 <h3>${sch.schCusNm} - ${sch.schPjtNm}</h3>
												 <p>${sch.category_name}</p></b>
								                 <p> - ${sch.contents}</p>
								                 <p class="ui-li-aside">${fn:substring(sch.start_time,11,16)}-${fn:substring(sch.end_time,11,16)}</p>
								                 <input type="hidden" id="supoId_${sch.schId}"  name="supoId" value="${sch.schId}"/> 
							            	 </a> </li>
										</c:when>									
									</c:choose>						        	 
			        	    </c:forEach>	
						   <li data-role="list-divider" >수 ( ${weeks3} )<span class="ui-li-count"></span></li>
						   <c:forEach var="sch" items="${sch_list}">
		        	 				 <c:choose>
										<c:when test="${fn:substring(sch.start_time,5,10)  == weeks3}">
											<li><a href="#">
												 <h3>${sch.schCusNm} - ${sch.schPjtNm}</h3>
												 <p>${sch.category_name}</p></b>
								                 <p> - ${sch.contents}</p>
								                 <p class="ui-li-aside">${fn:substring(sch.start_time,11,16)}-${fn:substring(sch.end_time,11,16)}</p>
								                 <input type="hidden" id="supoId_${sch.schId}"  name="supoId" value="${sch.schId}"/>
							            	 </a> </li>
										</c:when>									
									</c:choose>						        	 
			        	    </c:forEach>	
						   <li data-role="list-divider" >목 ( ${weeks4} )<span class="ui-li-count"></span></li>
						   <c:forEach var="sch" items="${sch_list}">
		        	 				 <c:choose>
										<c:when test="${fn:substring(sch.start_time,5,10)  == weeks4}">
											<li value="${sch.schId}"><a href="#">
												 <h3>${sch.schCusNm} - ${sch.schPjtNm}</h3>
												 <p>${sch.category_name}</p></b>
								                 <p> - ${sch.contents}</p>
								                 <p class="ui-li-aside">${fn:substring(sch.start_time,11,16)}-${fn:substring(sch.end_time,11,16)}</p>
								                 <input type="hidden" id="supoId_${sch.schId}"  name="supoId" value="${sch.schId}"/>
							            	 </a> </li>
										</c:when>									
									</c:choose>						        	 
		        	       </c:forEach>	
						   <li data-role="list-divider" >금 ( ${weeks5} )<span class="ui-li-count"></span></li>
						   <c:forEach var="sch" items="${sch_list}">
		        	 				 <c:choose>
										<c:when test="${fn:substring(sch.start_time,5,10)  == weeks5}">
											<li value="${sch.schId}"><a href="#">
												 <h3>${sch.schCusNm} - ${sch.schPjtNm}</h3>
												 <p>${sch.category_name}</p></b>
								                 <p> - ${sch.contents}</p>
								                 <p class="ui-li-aside">${fn:substring(sch.start_time,11,16)}-${fn:substring(sch.end_time,11,16)}</p>
								                 <input type="hidden" id="supoId_${sch.schId}"  name="supoId" value="${sch.schId}"/>
							            	 </a> </li>
										</c:when>									
									</c:choose>						        	 
			        	    </c:forEach>	
						   <li data-role="list-divider" >토 ( ${weeks6} )<span class="ui-li-count"></span></li>
						   <c:forEach var="sch" items="${sch_list}">
		        	 				 <c:choose>
										<c:when test="${fn:substring(sch.start_time,5,10)  == weeks6}">
											<li value="${sch.schId}"><a href="#">
												 <h3>${sch.schCusNm} - ${sch.schPjtNm}</h3>
												 <p>${sch.category_name}</p></b>
								                 <p> - ${sch.contents}</p>
								                 <p class="ui-li-aside">${fn:substring(sch.start_time,11,16)}-${fn:substring(sch.end_time,11,16)}</p>
								                 <input type="hidden" id="supoId_${sch.schId}"  name="supoId" value="${sch.schId}"/>
							            	 </a> </li>
										</c:when>									
									</c:choose>						        	 
			        	    </c:forEach>	
						   <li data-role="list-divider" >일 ( ${weeks7} )<span class="ui-li-count"></span></li>
						   <c:forEach var="sch" items="${sch_list}">
		        	 				 <c:choose>
										<c:when test="${fn:substring(sch.start_time,5,10)  == weeks7}">
											<li value="${sch.schId}"><a href="#">
												 <h3>${sch.schCusNm} - ${sch.schPjtNm}</h3>
												 <p>${sch.category_name}</p></b>
								                 <p> - ${sch.contents}</p>
								                 <p class="ui-li-aside">${fn:substring(sch.start_time,11,16)}-${fn:substring(sch.end_time,11,16)}</p>
								                 <input type="hidden" id="supoId_${sch.schId}"  name="supoId" value="${sch.schId}"/>
							            	 </a> </li>
										</c:when>									
									</c:choose>						        	 
			        	    </c:forEach>											   
			    </ul>
			</div> 
		</form>	 
	</div>
</div>  <!--  dummy  -->

</body>
</html>

