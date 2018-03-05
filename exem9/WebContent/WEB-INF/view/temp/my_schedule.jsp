<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.min.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.css" media="all" /> 


<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>

<script type="text/javascript" src="resources/script/jquery/moment.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/fullcalendar.min.js"></script>
<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<!-- <script type="text/javascript" src="dwr/interface/IMypageService.js"></script> -->

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

var temp = [];
$(document).ready(function(){

	$("#sch_insert").bind("click", function(){	
	   	location.href = "schedule_insert";
	});
	
	$("#my_sch").bind("click", function(){	
	   	location.href = "my_schedule";
	});
	
	$("#team_sch").bind("click", function(){	
	   	location.href = "team_schedule";
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
	
	// 이번주 날짜 셋팅하기
	$('#week-label-year').text(yyyy);
	$('#week-label-from-day').text(mm + '-' + dd);
	$('#week-label-to-day').text(mm2 + '-' + dd2 );
	
	// 이전주, 다음주 클릭시 이벤트 처리
	$("#prevWeek").bind("click", function(){	
		// 현재 셋팅된 날짜를 가지고 와서, 이값을 입력하면 이전주의 시작일과 종료일을 리턴한다.
		
		var yyyy = $('#week-label-year').text();
		var mmdd = $('#week-label-from-day').text();
		//var mm = mm-dd.substring(0,2);
		//var dd = mm-dd.substring(3,5);
		var selectedDay = yyyy + '-' + mmdd;  // yyyy-mm-dd로 입력
	
		var cal_yyyymmdd_yyyymmdd = calWeek(selectedDay,'prev'); // yyyy-mm-ddyyyy-mm-dd 이렇게 계산한다.
		
		yyyy = cal_yyyymmdd_yyyymmdd.substring(0,4);
		mmdd = cal_yyyymmdd_yyyymmdd.substring(5,10);
		mmdd2 =  cal_yyyymmdd_yyyymmdd.substring(15,20);
		
		$('#week-label-year').text(yyyy);
		$('#week-label-from-day').text(mmdd);
		$('#week-label-to-day').text(mmdd2);
	});
	
	$("#nextWeek").bind("click", function(){	
		// 현재 셋팅된 날짜를 가지고 와서, 이값을 입력하면 다음주의 시작일과 종료일을 리턴한다.
		
		var yyyy = $('#week-label-year').text();
		var mmdd = $('#week-label-from-day').text();
		//var mm = mm-dd.substring(0,2);
		//var dd = mm-dd.substring(3,5);
		var selectedDay = yyyy + '-' + mmdd;  // yyyy-mm-dd로 입력
	
		var cal_yyyymmdd_yyyymmdd = calWeek(selectedDay,'next'); // yyyy-mm-ddyyyy-mm-dd 이렇게 계산한다.
		
		yyyy = cal_yyyymmdd_yyyymmdd.substring(0,4);
		mmdd = cal_yyyymmdd_yyyymmdd.substring(5,10);
		mmdd2 =  cal_yyyymmdd_yyyymmdd.substring(15,20);
		
		$('#week-label-year').text(yyyy);
		$('#week-label-from-day').text(mmdd);
		$('#week-label-to-day').text(mmdd2);
	});
	
});
 			
</script>

<script>
// 이번주 월요일 날짜 구하기
var currentDay = new Date();  
var theYear = currentDay.getFullYear();
var theMonth = currentDay.getMonth();
var theDate  = currentDay.getDate();
var theDayOfWeek = currentDay.getDay(); //요일
 
var thisMonday;
var thistoSunday;
 
var resultDay = new Date(theYear, theMonth, theDate - theDayOfWeek +1 ); //이번주 월요일 날짜
var yyyy = resultDay.getFullYear();
var mm = Number(resultDay.getMonth()) + 1;
var dd = resultDay.getDate();

mm = String(mm).length === 1 ? '0' + mm : mm;
dd = String(dd).length === 1 ? '0' + dd : dd;

thisMonday = yyyy + '-' + mm + '-' + dd;
//////// 이번주 주일 날짜 구하기
var resultDay2 = new Date(theYear, theMonth, theDate - theDayOfWeek +7 ); //이번주 주일 날짜
var mm2 = Number(resultDay2.getMonth()) + 1;
var dd2 = resultDay2.getDate();

var yyyy2 = resultDay2.getFullYear();
mm2 = String(mm2).length === 1 ? '0' + mm2 : mm2;
dd2 = String(dd2).length === 1 ? '0' + dd2 : dd2;

thistoSunday = yyyy2 + '-' + mm2 + '-' + dd2;

//console.log(thisMonday);

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

</script>

<style>

#customer_list td,tr {    
    border: 2px solid #ddd;
    text-align: center;
    padding-top: 5px;
    padding-bottom: 5px;
    padding-right: 5px;
    padding-left: 5px;
    font-size: 10px;
}
/*
a {
    text-decoration: none;
    display: inline-block;
    padding: 8px 16px;
}

a:hover {
    background-color: #ddd;
    color: black;
}
*/

.previous {
    background-color: #4CAF50;
    color: white;
}

.next {
    background-color: #4CAF50;
    color: white;
}
/*    */
.week-label {
    padding: 8px;
}

.week-label > div {
    /* text-align: center; */
    color: #4CAF50;
    font-size: 20px;
}
</style>

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
		
<div class="row">

	 <!-- div class="column side">
		   <h4>일정 관리 페이지</h4></br>
		   <a href="#" id="sch_insert">일정 등록</a></br>
		   <a href="#" id="my_sch">내 일정 보기</a></br>		    
		   <a href="#" id="team_sch">팀 일정 보기</a></br>
	 </div-->
	 
	 
	 <div class="column middle">
	 	<div align="center"><h3>내 일정 정보</h3></div>
	 	
		<input type="hidden" id="nowPage" name="pageNo" value="${nowPage}"/>
		<input type="hidden" id="userId_hidden_id" value=""/>				
	 	</br>
 	 	
	 	<table>
	 	<tr>
	 	<td>
	 		<div>
	 			<a href="#" class="previous" id="prevWeek">&laquo; 이전주</a>
				
	 		</div>
	 	</td>
	 	<td>	 		
	 	    <div class="week-label">
			  <div id="week-label-year" style='display:inline;'></div>
			  <div style='display:inline;'>년 &nbsp;    </div>
			  <div id="week-label-from-day" style='display:inline;'>01-01</div>
			  <div style='display:inline;'>(월) ~ </div>
			  <div id="week-label-to-day" style='display:inline;'>02-05</div>
			  <div style='display:inline;'>(일)</div>
			</div>
	 	</td>
	 	<td>	 		
		 	<div>			 		
		 	    <a href="#" class="next" id="nextWeek">다음주 &raquo;</a>
			</div>
	 	</td>	 
	 	</tr>
	 	</table> 	
	
		<div id="customer_list">		
	 		<table id="cus_list">	
				<thead id="cus_list_th">
					<tr>
						<td>전체선택</br>
						<input style="width:20px;" type="checkbox"  id="checkall"/></td>
						<td>지원일자</td>
						<td><p>고객사명</p></td>
						<td><p>프로젝트 명</p></td>
						<td>지원일시<br>(시작)</td>
						<td>지원일시<br>(종료)</td>
						<td>지원 유형(범주)</td>
						<td>요청내역 및 지원목적</td>
					</tr>					
				</thead>
				<tbody id="cus_list_tb">
					<c:forEach var="sch" items="${sch_list}">											
						<tr>
							<td>
								<input type="checkbox" name="chk" value="${sch.schId}"/>
							</td>
							<td>
								${sch.start_day}	
							</td>						
							<td>
								${sch.schCusNm}
							</td>
							<td>
								${sch.schPjtNm}						
							</td>							
							<td>
								${sch.start_time}	
							</td>
							<td>
								${sch.end_time}
							</td>
							<td>
								<select>
									<c:if test="${sch.category_name == ''}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="cat" items="${cat_list}">
												<c:choose>
													<c:when test="${cat.catId  == sch.category_id}">
														<option value="${cat.catId}" selected>${cat.catNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${cat.catId}">${cat.catNm}</option>	
													</c:otherwise>
												</c:choose>
									</c:forEach>			
								</select>
							</td>
							<td>
								<textarea id="etc_id_${sch.schId}" rows="3" cols="30" name="contents">${sch.contents}</textarea>
							</td>			
						</tr>					
					</c:forEach>										
				</tbody>
				<tfoot id="cus_list_tf"> 
					<tr>
						<td colspan="6">
							<c:if test="${nowPage > 1}">
								<a href="#" id="backVal">이전</a>
							</c:if>
							<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
								<c:choose>
									<c:when test="${nowPage==i}">
										<a id="${i}" name="moreArea">${i}</a>
									</c:when>
									<c:otherwise>
										<a href="#" id="${i}" name="moreArea">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${maxPage > nowPage}">
								<a href="#" id="nextVal">다음</a>
							</c:if>
						</td>
						<td colspan="2">
							  <input type="password" placeholder="정보 수정 비밀번호 입력." id="editPw" required>&nbsp;&nbsp;
							  <input type="button" id="edit_update_btn" value="변경"></input>
						</td>
					</tr>					
				</tfoot>
	 		</table>
	 		
	 		
		</div>
	</div>
</div>

<c:import url="/main_botview"></c:import>
</body>
</html>

