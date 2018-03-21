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
<!--  link rel="stylesheet" type="text/css" href="./resources/css/jquery/jquery-ui-1.8.custom.css"  -->
<link rel="stylesheet" type="text/css" href="./resources/css/jquery/jquery.datetimepicker.min.css">

<title>Insert title here</title>

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/moment.min.js"></script>

<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/IScheduleService.js"></script>
<script type="text/javascript" src="dwr/interface/IMypageService.js"></script>

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

var temp = [];

//////////////////
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
	
	$('.cal_start').bind('click', function(){	
	   	$('#startDate').focus();
	});
	
	$('.cal_end').bind('click', function(){	
	   	$('#endDate').focus();
	});
	
	// dateTimePicker 한글화
	$.datetimepicker.setLocale('ko');
	// dateTimePicker moment.js와 연동
	$.datetimepicker.setDateFormatter({
	    parseDate: function (date, format) {
	        var d = moment(date, format);
	        return d.isValid() ? d.toDate() : false;
	    },
	 
	    formatDate: function (date, format) {
	        return moment(date).format(format);
	    }
	});
	 
	$(function(){
	    // datetimepicker init
	    $('.datetimepicker').datetimepicker({
	          format:'YYYY-MM-DD HH:mm',
	          formatTime:'HH:mm',
	          formatDate:'YYYY-MM-DD'
	    });
	});
	
	// DWR로 사용자 정보 가져오기
	//IMypageService.getUserinfo(userId, userInfoCallBack);
	
	/* 내일정 등록 버튼 이벤트 */ //////////////////////////////////////////////////////////////
    $("#edit_update_btn").bind("click", function(){   	
    	
    	var user_id = userId;    // 세션에서 가져와야 함
    	var customer_id = $("#customer_name_id").val();
    	var project_id = $("#customer_project_id").val();
    	var dbms_id = $("#dbms_id").val();
    	var category_id = $("#category_id").val();
    	var start_time = $("#startDate").val();
    	var end_time = $("#endDate").val();
    	var contents = $("#etc_id").val();
    	
     	if(user_id == ""){     		
     		alert("세션에 사용자ID값이 없습니다.");	   		
     	}else{
			if(customer_id == ""){
				alert("고객사 명을 선택하세요.");
     		}
			else if(project_id == ""){
				alert("고객사 프로젝트명을 선택하세요.");
     		}
			else{
     			IScheduleService.insertSchinfo(
     					user_id, 
     					customer_id,
						project_id,
						dbms_id, 
						category_id, 
						start_time,
						end_time,
						contents,
						insertSchinfoCallBack
				)
     		}     	
     	}    	
    });

});

//////////////////

function insertSchinfoCallBack(res){
	if(res == "FAILED"){
		alert("실패");
		location.href = "schedule_insert";
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "schedule_insert";
	}
}
/*
	function userInfoCallBack(res){	//마이페이지 기본 화면		
		var text = "";		
		
		userId
		res[0].userNm+"</td></tr>";					
		res[0].userDept+"</td></tr>";					
		res[0].userTeam+"</td></tr>";					

		res[0].userPhone	
		
		res[0].userMail
		res[0].userPoint
		
		userDbms = res[0].userDbms;
		userPosi = res[0].userPosi;
		
		IMypageService.getdbms(dbmsCallBack);		
		IMypageService.getposi(posiCallBack);
	}
*/

</script>

<style>
#test
{
    font-family: Arial, sans-serif, bold;
    font-size: 25px;
    text-align: center; 
}
    
table, td, th {    
    border: 1px solid #ddd;
    text-align: left;
}


table {
    border-collapse: collapse;
    width: 50%;
}

th, td {
    padding: 10px;
}

.sui-combobox{
        font-family: Arial, sans-serif;
        font-size: 14px;
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

		<div class="top_mainDisplayPart">
		<div align="center"><h3>일정 등록 페이지</h3></div>
				<div class="top_mainDisplayBase" >
					<li class="input_title input_01 inputTxtFont">고객사명*</li>
					<li class="input_title input_02 inputTxtFont">프로젝트명*</li>
					<li class="input_title input_03 inputTxtFont">제품구분</li>
					<li class="input_title input_04 inputTxtFont">지원유형(범주)</li>
					<li class="input_title input_05 inputTxtFont">시작일시</li>
					<li class="input_title input_06 inputTxtFont">종료일시</li>
					<li class="input_title input_07 inputTxtFont">요청내역 및 지원목적</li>

					<!-- input type="text" name="customer" class="input_txt input_01 inputTxtFont"-->
					<select id='customer_name_id' class="input_txt input_01 inputTxtFont">
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="cusNm" items="${cusNm_list}">
				 	    			<option value="${cusNm.cusId}">${cusNm.cusNm}</option>		 	    	
				 	    		</c:forEach>	
					</select>
					<!-- input type="text" name="project" class="input_txt input_02 inputTxtFont"-->
					<select id='customer_project_id' class="input_txt input_02 inputTxtFont">
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="cusPjtNm" items="${cusPjtNm_list}">
				 	    			<option value="${cusPjtNm.pjtId}">${cusPjtNm.pjtNm}</option>		 	    	
				 	    		</c:forEach>	
					</select>
					<!-- input type="text" name="product" class="input_txt input_03 inputTxtFont"-->
					<select id='dbms_id' class="input_txt input_03 inputTxtFont">
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="dbms" items="${dbms_list}">
				 	    			<option value="${dbms.dbmsId}">${dbms.dbmsNm}</option>		 	    	
				 	    		</c:forEach>	
					</select>
					<!-- input type="text" name="support" class="input_txt input_04 inputTxtFont"-->
					<select id='category_id' class="input_txt input_04 inputTxtFont">
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="cate" items="${cate_list}">
				 	    			<option value="${cate.catId}">${cate.catNm}</option>		 	    	
				 	    		</c:forEach>	
					</select>
					<!-- input type="text" name="start" class="input_txt input_05 inputTxtFont"-->
					<input id="startDate" type="text" class="input_txt input_05 inputTxtFont datetimepicker">
					<!-- input type="text" name="end" class="input_txt input_06 inputTxtFont"-->
					<input id="endDate" type="text" class="input_txt input_06 inputTxtFont datetimepicker">
					<!-- textarea name="content" class="text_area"></textarea-->
					<textarea id="etc_id" name="contents" class="text_area"></textarea>

					<div class="cal_start"></div>
					<div class="cal_end"></div>

					<!-- input type="submit" name="OK" class="input_submit inBtt_OK" value="일정등록하기"-->
					<input type="button" id="edit_update_btn" name="OK" class="input_submit inBtt_OK" value="일정등록하기"></input>
					
				</div>
			</div>

	<!-- 
	 <div class="column middle">
	 
		
		<h3>일정 등록 정보</h3>
		<div id="customer_list">		
			<table id="cus_list">	
				<thead id="sch_list_th">
					<tr>
						<td>고객사 명*</td>
						<td>							
							<select id='customer_name_id'>
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="cusNm" items="${cusNm_list}">
				 	    			<option value="${cusNm.cusId}">${cusNm.cusNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>							
						</td>
					</tr>
					<tr>
						<td>프로젝트 명*</td>
						<td>
							<select id='customer_project_id'>
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="cusPjtNm" items="${cusPjtNm_list}">
				 	    			<option value="${cusPjtNm.pjtId}">${cusPjtNm.pjtNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>									
						</td>	
					</tr>
					<tr>
						<td>제품구분</td>
						<td>
							<select id='dbms_id'>
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="dbms" items="${dbms_list}">
				 	    			<option value="${dbms.dbmsId}">${dbms.dbmsNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>			
						</td>	
					</tr>	
					<tr>
						<td>지원 유형(범주)</td>												
						<td>
							<select id='category_id'>
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="cate" items="${cate_list}">
				 	    			<option value="${cate.catId}">${cate.catNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						</td>															
					</tr>			
					<tr>
						<td>시작일시</td>						
						<td>
							<input id="startDate" type="text" class="datetimepicker">
						</td>															
					</tr>
					<tr>
						<td>종료일시</td>						
						<td>
							<input id="endDate" type="text" class="datetimepicker">
						</td>															
					</tr>							
				</thead>
				<tbody id="sch_list_tb">
					<tr>
						<td>요청 내역 및 지원 목적</td>						
						<td><textarea id="etc_id" rows="5" cols="30" name="contents"></textarea></td>													
					</tr>																											
				</tbody>
					<tr>	
					<td colspan="2">
					  	<input type="button" id="edit_update_btn" value="등록"></input>
					</td>
					</tr>
				</tfoot>
	 		</table>	
		</div>
		
		
		
		  
	</div>
</div>
	<c:import url="/main_botview"></c:import>
	-->
	
</body>
</html>

