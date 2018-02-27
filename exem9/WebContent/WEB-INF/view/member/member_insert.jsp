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
/*
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
*/

</style>

</head>
<body>
<c:import url="/main_upview"></c:import>

		<div class="top_SubMenuPart">
			<div class="top_MenuBase">
				<a href="#" class="top_SubMenu01_m" id="mem_managed">사용자 관리</a>
				<a href="#" class="top_SubMenu02_m" id="mem_insert">사용자 등록</a>
			</div>
		</div>
		
<div class="row">
	
	
			<div class="top_mainDisplayPart">
				<div class="top_mainDisplayBase" >
					<li class="input_title input_01 inputTxtFont">로그인ID*</li>
					<li class="input_title input_02 inputTxtFont">이름*</li>
					<li class="input_title input_03 inputTxtFont">패스워드</li>
					<li class="input_title input_04 inputTxtFont">부서</li>
					<li class="input_title input_05 inputTxtFont">팀*</li>
					<li class="input_title input_06 inputTxtFont">업무</li>
					<li class="input_title input_07 inputTxtFont">직급</li>
					<li class="input_title input_08 inputTxtFont">연락처</li>
					<li class="input_title input_09 inputTxtFont">메일</li>
					<li class="input_title input_10 inputTxtFont">포인트</li>
					
					<input id="user_id" type="text" class="input_txt input_01 inputTxtFont">
					<input id="user_name" type="text" class="input_txt input_02 inputTxtFont">
					<input id="user_password" type="text" class="input_txt input_03 inputTxtFont">
					
					<!-- input type="text" name="customer" class="input_txt input_01 inputTxtFont"-->
					<select id='user_department_id' class="input_txt input_04 inputTxtFont">
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="dept" items="${dept_list}">
				 	    			<option value="${dept.deptId}">${dept.deptNm}</option>		 	    	
				 	    		</c:forEach>	
					</select>
					<!-- input type="text" name="project" class="input_txt input_02 inputTxtFont"-->
					<select id='user_team_id' class="input_txt input_05 inputTxtFont">
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="team" items="${team_list}">
				 	    			<option value="${team.teamId}">${team.teamNm}</option>		 	    	
				 	    		</c:forEach>	
					</select>
					<!-- input type="text" name="product" class="input_txt input_03 inputTxtFont"-->
					<select id='user_dbms_id' class="input_txt input_06 inputTxtFont">
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="dbms" items="${dbms_list}">
				 	    			<option value="${dbms.dbmsId}">${dbms.dbmsNm}</option>		 	    	
				 	    		</c:forEach>	
					</select>
					<!-- input type="text" name="support" class="input_txt input_04 inputTxtFont"-->
					<select id='user_position_id' class="input_txt input_07 inputTxtFont">
								<option value="0" selected>지정하지않음.</option>
							    <c:forEach var="posi" items="${posi_list}">
				 	    			<option value="${posi.posiId}">${posi.posiNm}</option>		 	    	
				 	    		</c:forEach>	
					</select>
					
					<input id="user_phone" type="text" class="input_txt input_08 inputTxtFont">
					<input id="user_mail" type="text" class="input_txt input_09 inputTxtFont">
					<input id="user_point" type="text" class="input_txt input_10 inputTxtFont">
					
					<!-- input type="submit" name="OK" class="input_submit inBtt_OK" value="일정등록하기"-->
					<input type="button" id="edit_update_btn" name="OK" class="input_submit inBtt_OK" value="등록"></input>
					
				</div>
			</div>
			
</div>
<c:import url="/main_botview"></c:import>
</body>
</html>


