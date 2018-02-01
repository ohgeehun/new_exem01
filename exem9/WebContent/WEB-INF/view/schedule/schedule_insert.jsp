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
	          format:'YYYY-MM-DD HH:mm:ss',
	          formatTime:'HH:mm',
	          formatDate:'YYYY-MM-DD'
	    });
	});

});

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
<div class="row">
	 <div class="column side">
		   <h4>일정 관리 페이지</h4></br>
		   <a href="#" id="sch_insert">일정 등록</a></br>
		   <a href="#" id="my_sch">내 일정 보기</a></br>		    
		   <a href="#" id="team_sch">팀 일정 보기</a></br>
	 </div>
	 <div class="column middle">
		<!--  -->
		
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
		
		
		
		<!--  -->
	</div>
</div>
	<c:import url="/main_botview"></c:import>
</body>
</html>

