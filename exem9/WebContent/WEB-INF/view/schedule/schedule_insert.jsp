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
<link rel="stylesheet" type="text/css" href="./resources/css/jquery/jquery-ui-1.8.custom.css"> 
<link rel="stylesheet" type="text/css" href="./resources/css/jquery/jquery.datetimepicker.min.css"> 

<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" />
<link id="themecss" rel="stylesheet" type="text/css" href="./resources/css/common/all.min.css"/>
<link rel="stylesheet" type="text/css" media="not all and (max-width:430px)" href="./resources/css/exem_mem.css"/>
<link rel="stylesheet" type="text/css" media="only all and (max-width:430px)" href="./resources/css/exem_mem_m.css"/>

<title>Insert title here</title>

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<!--  <script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script> -->
 <script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.custom.js"></script>  
 <script type="text/javascript" src="resources/script/common/jquery-1.11.1.min.js"></script>  
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/moment.min.js"></script> 
<!---->
<script type="text/javascript" src="resources/script/common/shieldui-all.min.js"></script>


<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/IScheduleService.js"></script>
<script type="text/javascript" src="dwr/interface/IMypageService.js"></script>
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
	 
    // datetimepicker init
    $('.datetimepicker').datetimepicker({
          format:'YYYY-MM-DD HH:mm',
          formatTime:'HH:mm',
          formatDate:'YYYY-MM-DD'
    });
	
	$('#customer_name_id').bind('change', function() {
		var customer_id = $(this).val();
		ICustomerService.getProinfo2(customer_id, getProinfoCallBack);
	});
	
	/* 내일정 등록 버튼 이벤트 */ 
    $("#edit_update_btn").bind("click", function(){   	
    	
    	var user_id = userId;    // 세션에서 가져와야 함
    	var customer_id = $("#cusName_hidden_id").val();
    	var project_id = $("#cusPro_hidden_id").val();
    	var dbms_id = $("#dbms_id").val();
    	var category_id = $("#category_id").val();
    	var start_time = $("#startDate").val();
    	var end_time = $("#endDate").val();
    	var contents = $("#etc_id").val();
    	
    	//alert(customer_id);
    	//alert(project_id);
    	
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
	
	$("#customer_name_id").shieldComboBox({
    	dataSource: {
            data: ""
        },        	        
        enabled: false
	}); 
	
 	$("#customer_project_id").shieldComboBox({
    	dataSource: {
            data: ""
        },        	        
        enabled: false
	});  
 	
	 /* 고객사 등록 시 기존 고객사명 리스트를 가져오는 이벤트 */
	ICustomerService.getcusNminfo(cusNminfoCallBack);
	

});

function cusNminfoCallBack(res){
	var availableTags = [];
	
	for(var i = 0; i < res.length; i++){	
		availableTags.push(res[i].cusNm);			
	}	

	 $("#customer_name_id").swidget().destroy();
	 
	 $("#customer_name_id").shieldComboBox({
	    	dataSource: {
	            data: availableTags
	        },	        
	        autoComplete: {
	            enabled: true
	        },events: {
	        	select : function(e){   	        		
	        		
     				var cusNmtemp =  $("#customer_name_id").swidget().value();
     				var cusNm = cusNmtemp.toUpperCase();
     				//alert(cusNm);
     				$("#customer_name_id").val(cusNm);
     						
     				$("#cusPro_hidden_id").val("0");
     				$("#customer_project_id").val("");     	 
     		       
    			    ICustomerService.getProinfo(cusNm, cusNmProinfoCallBack);	           			   
     	   		}
	        }
 	}); 	
}

function cusNmProinfoCallBack(res){
	var availableTags = [];	 
	
	$("#chk_id").prop("disabled",false);
	
	if(res.length > 0){		
		
		for(var i = 0; i < res.length; i++){			
			availableTags.push(res[i].proNm);			
		
	        $("#cusName_hidden_id").val(res[i].cusId);	         
		}
		
		 $("#customer_project_id").swidget().destroy();
			
		 $("#customer_project_id").shieldComboBox({			 	
		    	dataSource: {
		            data: availableTags
		        },	        
		        autoComplete: {
		            enabled: true
		        },events: {
		        	select : function(e){   
		        	var cusNm = $("#customer_name_id").val();
		        	var proNmtemp =  $("#customer_project_id").swidget().value();
     				var proNm = proNmtemp.toUpperCase();     				
     		     				
     				$("#customer_project_id").val(proNm);     		   			  
	  		               
     				ICustomerService.getCusProCheck(cusNm,proNm, getCusProCheckCallBack);	        
	  	   			}
		        }
		}); 

	}else{
	
		$("#cusName_hidden_id").val("0");		
		
		$("#cusPro_hidden_id").val("0");
		$("#customer_project_id").val("");
		 			 	  
		$("#customer_project_id").swidget().destroy();
		 
    	$("#customer_project_id").shieldComboBox({
        	dataSource: {
                data: ""
            },        	        
            enabled: true,
            events: {
            	select : function(e){   
            		var cusNm = $("#customer_name_id").val();
            		var proNmtemp =  $("#customer_project_id").swidget().value();
     				var proNm = proNmtemp.toUpperCase();
     				
     				$("#customer_project_id").val(proNm);	  				
	  			 
	        	}
            }
    	}); 
	}	
}

function getCusProCheckCallBack(res){
	if(res.length > 0){
		for(var i = 0; i < res.length; i++){	
			 $("#cusPro_hidden_id").val(res[i].pjtId); 
		}
	}else{
		  $("#cusPro_hidden_id").val("0");	        
	}

}

function insertSchinfoCallBack(res){
	if(res == "FAILED"){
		alert("실패");
		//location.href = "schedule_insert";
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "schedule_insert";
	}
}

function getProinfoCallBack(arrayList){
	$("#customer_project_id").html("");
	if(arrayList.length > 0) { // arrayList에 프로젝트목록이 들어온다. customer_project_id 셀렉트박스목록을 갱신한다.
		for(var i=0; i<arrayList.length; i++)
		{
		    var testObj = arrayList[i];
		    $('#customer_project_id').append('<option value='+testObj.proId+'>'+testObj.proNm+'</option>');
		}
	} else {
		alert("선택한 고객사에 등록된 프로젝트가 없습니다.");
	}
}

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
					<div class="input_txt_01 input1_01 inputTxtFont">	
						<input type="hidden" id="cusName_hidden_id"> 
						<!-- <input class="sui-input" id='cusName_id' value=""  style='text-transform: uppercase' onblur="onblur_event();"></input> -->
						<input id='customer_name_id'></input>
						<!-- <span id="idSpan" class="redText"></span> -->			
					</div>
							
					<div class="input_txt_01 input1_02 inputTxtFont">	
						<input type="hidden" id="cusPro_hidden_id"> 
						<input class="input_txt_03 input_02_01 inputTxtFont sui-input"  id='customer_project_id' >	
					</div>	
				
				
					<%-- <select id='customer_name_id' class="input_txt input_01 inputTxtFont">
								<option value="0" selected>지정필요</option>
							    <c:forEach var="cusNm" items="${cusNm_list}">
				 	    			<option value="${cusNm.cusId}">${cusNm.cusNm}</option>		 	    	
				 	    		</c:forEach>	
					</select> --%>
					<!-- input type="text" name="project" class="input_txt input_02 inputTxtFont"-->
					<%-- <select id='customer_project_id' class="input_txt input_02 inputTxtFont">
								<option value="0" selected>지정필요</option>
							    
							    <c:forEach var="cusPjtNm" items="${cusPjtNm_list}">
				 	    			<option value="${cusPjtNm.pjtId}">${cusPjtNm.pjtNm}</option>		 	    	
				 	    		</c:forEach>
				 	    		
					</select> --%>
					<!-- input type="text" name="product" class="input_txt input_03 inputTxtFont"-->
					<select id='dbms_id' class="input_txt input1_03 inputTxtFont">
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="dbms" items="${dbms_list}">
				 	    			<option value="${dbms.dbmsId}">${dbms.dbmsNm}</option>		 	    	
				 	    		</c:forEach>	
					</select>
					<!-- input type="text" name="support" class="input_txt input_04 inputTxtFont"-->
					<select id='category_id' class="input_txt input1_04 inputTxtFont">
						<option value="0" selected>지정하지않음.</option>
					    <c:forEach var="cate" items="${cate_list}">
					    	<c:choose>
					    		<c:when test="${cate.small_group eq '0' }">
					    			<optgroup label="${cate.catNm}"></optgroup>
					    		</c:when>
					    		<c:otherwise>
		 	    					<option value="${cate.catId}">${cate.catNm}</option>
		 	    				</c:otherwise>
		 	    			</c:choose>		 	    	
		 	    		</c:forEach>	
					</select>
					<!-- input type="text" name="start" class="input_txt input_05 inputTxtFont"-->
					<input id="startDate" type="text" class="input_txt input1_05 inputTxtFont datetimepicker" readonly="readonly">
					<!-- input type="text" name="end" class="input_txt input_06 inputTxtFont"-->
					<input id="endDate" type="text" class="input_txt input1_06 inputTxtFont datetimepicker" readonly="readonly">
					<!-- textarea name="content" class="text_area"></textarea-->
					<textarea id="etc_id" name="contents" class="text_area"></textarea>

					<div class="cal_start"></div>
					<div class="cal_end"></div>

					<!-- input type="submit" name="OK" class="input_submit inBtt_OK" value="일정등록하기"-->
					<input type="button" id="edit_update_btn" name="OK" class="input_submit inBtt_OK" value="일정등록하기"></input>
					
				</div>
			</div>
	
</body>
</html>

