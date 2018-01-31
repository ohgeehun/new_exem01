<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- <link rel="stylesheet" type="text/css" href="./resources/css/prettydropdowns.css" media="all" />  -->
<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/jquery/jquery-ui-1.8.custom.css"/>  

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<!-- <script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script> -->
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.custom.js"></script>  
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>

<script src="resources/script/jquery/jquery.prettydropdowns.js"></script> 

<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ICustomerService.js"></script> 
<script type="text/javascript" src="dwr/interface/IMemberService.js"></script>

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

$(document).ready(function(){
	
	/* 사용자관리 좌측 버튼 이벤트  : 사용자 관리 버튼 클릭 시 */
    $("#mem_managed").bind("click", function(){	
	    	location.href = "member_edit";
	    });
	    
	    /* 사용자관리 좌측 버튼 이벤트  : 사용자 등록 버튼 클릭 시 */
    $("#mem_insert").bind("click", function(){	
	    	location.href = "member_insert";
	    });
	 
	// 검증에 사용할 함수명들을 배열에 담아준다.
	var idFuncArray = ["spaceCheck","spaceCheck1"];
	// 1. span태그 obj, 2. input태그 obj, 3. 위에서 정의한 함수명 배열, 4. 검증에 걸렸을 때 나타날 텍스트, 5. 검증을 통과했을 때 나타날 텍스트, 6. span태그의 좌측 폭 위치.
	spanValidation($("#idSpan"), $("#cusName_id"), idFuncArray, "로그인ID는 영문으로 입력하십시오!", "등록 가능한 형식입니다.", "5px");
	
	/* 고객사 등록 버튼 이벤트 */
    $("#edit_update_btn").bind("click", function(){   	
    	
    	var user_id = $("#user_id").val();
    	var user_name = $("#user_name").val();
    	var user_password = $("#user_password").val();
    	var user_team_id = $("#user_team_id").val();
    	var user_dbms_id = $("#user_dbms_id").val();
    	var user_department_id = $("#user_department_id").val();
    	var user_phone = $("#user_phone").val();
    	var user_mail = $("#user_mail").val();
    	var user_position_id = $("#user_position_id").val();
    	var usr_point = $("#usr_point").val();  	
    	
     	if(user_id == ""){     		
     		alert("로그인ID를 입력해주세요.");	   		
     	}else{
			if(user_name == ""){
				alert("이름을 입력해주세요.");
     		}else{
     			IMemberService.insertMeminfo(user_id, user_name, user_password,
						user_team_id, user_dbms_id,
						user_department_id, user_phone, 
						user_mail, user_position_id, 
						usr_point, insertMeminfoCallBack)
     		}     	
     	}    	
    });
	
    /* 고객사 등록 시 기존 고객사명 리스트를 가져오는 이벤트 */
    ICustomerService.getcusNminfo(cusNminfoCallBack);
    
    /* 고객사 프로젝트명 입력 후 이벤트 */
     $("#cusproName_id").blur(function(){
    	 
    	 if ($("#cusproName_id").val() != ""){    		 
    		 if ($("#cusName_id").val() != ""){    	    		
    	    		var cusNm = $("#cusName_id").val();
    	    		var cusProNm = $("#cusproName_id").val();
    	    		
    	    		ICustomerService.getcusNmProinfo(cusNm, cusProNm,cusNmProinfoCallBack1);
    		 }  
    	 }    	
    }); 
     
    /* 고객담당자명 입력 후 이벤트 */
    $("#cusNm_id").blur(function(){    
    	if ($("#cusNm_id").val() != ""){
    		var cusUser = $("#cusNm_id").val();    		
    		var cusId = $("#cusName_hidden_id").val();
    		       	
    		if (cusId != ""){    		
    			ICustomerService.getcusUserinfo(cusUser, cusId, "0",cusUserinfoCallBack);	
    		}else{    			
    			$("#cusPhone_id").val("");
        		$("#cusMail_id").val("");
    		}    		
    	}else{
    		$("#cusPhone_id").val("");
    		$("#cusMail_id").val("");
    	}
 	});  
});  

function onblur_event(){	
		if ($("#cusName_id").val() != ""){    		
			var cusNm = $("#cusName_id").val();    	
				
			 ICustomerService.getcusNmProinfo(cusNm,"", cusNmProinfoCallBack); /* 위치정보가져오기 */ 
			 ICustomerService.getcusNmUserinfo(cusNm, cusNmUserinfoCallBack); /* 고객정보가져오기 */
		}else{    	
			$("#cusproName_id").val("");
			$("#cuslocation_id").val("");
			$("#cusNm_id").val("");
			$( "#cusproName_id" ).autocomplete("off");
			$( "#cusNm_id" ).autocomplete("off");
			$("#cusPhone_id").val("");
			$("#cusMail_id").val("");
			$("#cusName_hidden_id").val("0");
			$("#cusNm_hidden_id").val("0");    		
			
		}
	}
	
function spanValidation(spanObj, inputObj, validFuncArray, redMsg, greenMsg, marginLeftPx){
	spanObj.css("margin-left", marginLeftPx); // span태그의 좌측 폭을 설정해준다.
	
	var confirmCheck = false; // 검증에 통과 여부에 사용할 flag
	
	spanObj.hide(); // span태그를 숨긴다.
	
	inputObj.bind('focusin keyup', function(){ // input태그에 포커스가 들어오거나 키가 눌렸을 때 실행됨
		var inputValue = inputObj.val();
		
		var funcResult = true; // 함수 실행 결과를 담을 flag
		
		for(i=0; i<validFuncArray.length; i++){ // 검증에 사용할 함수명 배열을 반복문으로 돌린다.
			var funcName = validFuncArray[i]; // 배열에서 함수명을 하나씩 뽑아낸다. 
			var funcObj = window[funcName]; // 함수명(string)을 객체(object)로 받는다.
			funcResult = funcObj(inputValue); // 해당 함수를 실행하여 결과값(true/false)을 변수에 담는다. 만약 함수 하나라도 통과를 하지 못하면 false가 된다.
			if(!funcResult){ // 검증에 통과하지 못한 함수가 있을 경우 반복문 탈출
				break;
			}
		}
		
		if(!funcResult){ // 검증에 통과하지 못했을 때,
			spanObj.show(); // span태그 보여준다.
			spanObj.removeClass('greenText'); // span태그에 greenText 클래스를 삭제한다.
			spanObj.addClass('redText'); // span태그에 redText 클래스를 추가한다.
			
			spanObj.text(""); //  span태그의 텍스트를 지운다.
			spanObj.append(redMsg); // span태그에  검증에 통과하지 못했을 때 나타나는 텍스트를 넣는다.
			
			confirmCheck = false; // 검증 통과 여부 flag에 false를 대입한다.
		}else{ // 검증에 통과했을 때,
			spanObj.show();
			spanObj.removeClass('redText');
			spanObj.addClass('greenText');
			
			spanObj.text("");
			spanObj.append(greenMsg);
			
			confirmCheck = true;
		}
		
	});
	
	inputObj.focusout(function(){ // 포커스가 input태그에서 벗어났을 때 실행,
		var inputValue = inputObj.val();
		if(confirmCheck || inputValue == ""){ // 검증에 통과를 했거나 input태그에 입력 값이 없을 경우,
			spanObj.hide(); // span태그를 숨긴다.
		}
	});
}

// 영문만 입력받도록 검증
function isAlphabetForSpan(str){
	var check = /[^A-Za-z\s]/;
	if(check.test(str)){
		return false;
	}
	return true;
}

// 공백 허용하지 않도록 검증
function spaceCheck(inputVal){
	var invalid = " ";
	
	if(inputVal.indexOf(invalid) > -1){
		return false;
	}else if(inputVal.length < 1){
		return false;
	}else{
		return true;
	}
}

//특수문자를 입력하지 않도록 검증
function spaceCheck1(str){
	var check = /[~!@\#$%^&*\()\-=+_']/gi; 

	if(check.test(str)){
		return false;
	}
	return true;
}

//숫자만 입력받도록 처리 
function onlyNumber(event){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9 ) 
		return;
	else
		return false;
}
function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

function cusNminfoCallBack(res){
	var availableTags = [];
	
	for(var i = 0; i < res.length; i++){	
		availableTags.push(res[i].cusNm);			
	}
	
	$( "#cusName_id" ).autocomplete({
		  source: availableTags
	});
}

function cusNmProinfoCallBack(res){
	/* var availableTags = [];	 */
	
	if(res.length > 0){
		for(var i = 0; i < res.length; i++){			
			/* availableTags.push(res[i].proNm); */			
		    $("#cusName_hidden_id").val(res[i].cusId); 
			$("#cuslocation_id").val(res[i].cusLoca);
		}

	}else{
		$("#cusName_hidden_id").val("0");
		$("#cuslocation_id").val("");
	}
}

function cusNmProinfoCallBack1(res){
	if(res.length > 0){
		alert("해당 고객사에 해당 프로젝트는 이미 등록되어 있습니다.");
		$("#cusproName_id").val("");
		$("#cusproName_id").focus();
	}
}

function cusNmUserinfoCallBack(res){
	var availableTags = [];	
	
	if(res.length > 0){
		
		for(var i = 0; i < res.length; i++){	
			availableTags.push(res[i].cususerNm);
		}
		$( "#cusNm_id" ).autocomplete({
			  source: availableTags
		});
	}else{
		$("#cusNm_id").val("");
	}
}

function cusUserinfoCallBack(res){
	if(res.length > 0){
		for(var i = 0; i < res.length; i++){	
			$("#cusPhone_id").val(res[i].cususerPhone);
			$("#cusMail_id").val(res[i].cususerMail);
			
			$("#cusNm_hidden_id").val(res[i].cususerId);
		}
	}else{
		$("#cusPhone_id").val("");
		$("#cusMail_id").val("");
		$("#cusNm_hidden_id").val("0");
	}
}

function insertMeminfoCallBack(res){
	if(res == "FAILED"){
		alert("실패");
		location.href = "member_insert";
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "member_insert";
	}
}
</script>

<style>
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

.redText{display: block;color: red;margin-left:10px;}
.greenText{display: block;color: green;margin-left:10px;}


</style>

</head>
<body>
<c:import url="/main_upview"></c:import>
<div class="row">
	 <div class="column side">
		   <h4>사용자 관리 페이지</h4></br>
		   <a href="#" id="mem_managed">사용자 관리</a></br>		    
		   <a href="#" id="mem_insert">사용자 등록</a></br>		 
	 </div>
	 <div class="column middle">
	  
	 	<h3>사용자 등록 정보</h3>
		<div id="customer_list">		
			<table id="cus_list">	
				<thead id="cus_list_th">
					<tr>
						<td>로그인ID*</td>
						<td>							
							<div id="div_cusName_id">
								<input id='user_id' value=""  style='text-transform: uppercase' onblur="onblur_event();"></input>
								<span id="idSpan" class="redText"></span>	
							</div>									
						</td>
					</tr>
					<tr>
						<td>이름*</td>
						<td><input type='text' id='user_name' value="" style='text-transform: uppercase'>			
						<span id="idSpan1" class="redText"></span>
						</td>	
					</tr>
					<tr>
						<td>패스워드*</td>
						<td><input type='text' id='user_password' value="password">			
						<span id="idSpan1" class="redText"></span>
						</td>	
					</tr>	
					<tr>
						<td>부서</td>												
						<td>
							<select id='user_department_id'>
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="dept" items="${dept_list}">
				 	    			<option value="${dept.deptId}">${dept.deptNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						</td>															
					</tr>			
					<tr>
						<td>팀*</td>						
						<td>
							<select id='user_team_id'>
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="team" items="${team_list}">
				 	    			<option value="${team.teamId}">${team.teamNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						</td>															
					</tr>
					<tr>
						<td>업무</td>						
						<td>
							<select id='user_dbms_id'>
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="dbms" items="${dbms_list}">
				 	    			<option value="${dbms.dbmsId}">${dbms.dbmsNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						</td>															
					</tr>
					<tr>
						<td>직급</td>						
						<td>
							<select id='user_position_id'>
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="posi" items="${posi_list}">
				 	    			<option value="${posi.posiId}">${posi.posiNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						</td>														
					</tr>
					<tr>
						<td>연락처</td>
						<td>
							<input type='text' id='user_phone' value="" style='text-transform: uppercase'>
						</td>									
					</tr>
					<tr>
						<td>메일</td>
						<td>
							<input type='text' id='user_mail' value="" style='text-transform: uppercase'>
						</td>									
					</tr>
					<tr>
						<td>포인트</td>
						<td>
							<input type='text' id='user_point' value="0">
						</td>									
					</tr>							
				</thead>
					<tr>	
					<td colspan="2">
						  <input type="password" placeholder="등록 비밀번호 입력." id="editPw" required>&nbsp;&nbsp;
						  <input type="button" id="edit_update_btn" value="등록"></input>
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


