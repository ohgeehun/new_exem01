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
<link id="themecss" rel="stylesheet" type="text/css" href="./resources/css/common/all.min.css"/>

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<!-- <script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script> -->
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.custom.js"></script>  
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/common/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="resources/script/common/shieldui-all.min.js"></script>
<!-- <script src="resources/script/jquery/jquery-latest.min.js"></script> 
<script src="resources/script/jquery/jquery.prettydropdowns.js"></script> 

<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ICustomerService.js"></script> 

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

$(document).ready(function(){
	
	/* 고객사관리 좌측 버튼 이벤트  : 고객사 관리 버튼 클릭 시 */
    $("#cus_managed").bind("click", function(){	
	    	location.href = "customer_edit";
	    });
	    
	    /* 고객사관리 좌측 버튼 이벤트  : 고객사 수정 버튼 클릭 시 */
    $("#cus_insert").bind("click", function(){	
	    	location.href = "customer_insert";
	    });
	 
	// 검증에 사용할 함수명들을 배열에 담아준다.
/* 	var idFuncArray = ["isAlphabetForSpan", "spaceCheck"]; */
	var idFuncArray = ["spaceCheck","spaceCheck1"];
	/* var idFuncArray1 = ["spaceCheck1"]; */
	// 1. span태그 obj, 2. input태그 obj, 3. 위에서 정의한 함수명 배열, 4. 검증에 걸렸을 때 나타날 텍스트, 5. 검증을 통과했을 때 나타날 텍스트, 6. span태그의 좌측 폭 위치.
	spanValidation($("#idSpan"), $("#cusName_id"), idFuncArray, "고객사명은 특수문자, 공백없이 입력하십시오!", "등록 가능한 형식의 고객사명입니다.", "5px");
	/* spanValidation($("#idSpan1"), $("#cusproName_id"), idFuncArray1, "프로젝트명은 특수문자없이 입력하십시오!", "등록 가능한 형식의 프로젝트명입니다.", "5px"); */
	
	/* 고객사 등록 버튼 이벤트 */
    $("#edit_update_btn").bind("click", function(){   	
    	
    	var cusNm_hidden = $("#cusName_hidden_id").val();
    	var cusUser_hidden = $("#cusNm_hidden_id").val();
    	
    	var cusNm = $("#cusName_id").val();
    	var cusproNm = $("#cusproName_id").val();
    	
    	var cususerNm = $("#cusNm_id").val();
    	var cususerPhone = $("#cusPhone_id").val();
    	var cususerMail = $("#cusMail_id").val();
    	var cuslocation = $("#cuslocation_id").val();
    	
    	var salesmanId = $("#salesman_select_id").val();  	
    	
    	var etc = $("#etc_id").val();   	
    	
     	if(cusNm == ""){     		
     		alert("고객사명을 입력해주세요.");	   		
     	}else{
			if(cusproNm == ""){
				alert("프로젝트명을 입력해주세요.");
     		}else{
     			ICustomerService.insertCusinfo(cusNm_hidden, cusUser_hidden,  
	                       cusNm, cusproNm,  
	                       cususerNm, cususerPhone, cususerMail, cuslocation, 
	                       salesmanId, etc, insertCusinfoCallBack); 
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

/*  function dept_select_change_event(){
	var deptId = $("#dept_select_id").val();	
	
	if(deptId == 0){
		var teamId = 0;
		ICustomerService.getdeptteam(deptId, deptchangeCallBack);
		$("#team_select_id").prop("disabled",true);
		ICustomerService.getdeptdbms(deptId, dept1changeCallBack);
		$("#dbms_select_id").prop("disabled",true);
		ICustomerService.getteamuser(teamId, teamchangeCallBack);	
		$("#user1_select_id").prop("disabled",true);
		$("#user2_select_id").prop("disabled",true);
	}else{
		ICustomerService.getdeptteam(deptId, deptchangeCallBack);		
		$("#team_select_id").prop("disabled",false);		
		ICustomerService.getdeptdbms(deptId, dept1changeCallBack);
		$("#dbms_select_id").prop("disabled",false);
		
	}	
} 

function deptchangeCallBack(res){
	var text = "";			
	
		text += "<option value='0' selected>지정하지않음.</option>";
	for(var i = 0; i < res.length; i++){			
		 
		text += "<option value="+res[i].teamId+">"+res[i].teamNm+"</option>";
	 	
	}
	
	$("#team_select_id").html(text);
}

function dept1changeCallBack(res){
	var text = "";			
	
	text += "<option value='0' selected>지정하지않음.</option>";
	for(var i = 0; i < res.length; i++){			
		 
		text += "<option value="+res[i].dbmsId+">"+res[i].dbmsNm+"</option>";
	 	
	}
	
	$("#dbms_select_id").html(text);
}

function team_select_change_event(){
	var teamId = $("#team_select_id").val();

	if(teamId == 0){
		ICustomerService.getteamuser(teamId, teamchangeCallBack);	
		$("#user1_select_id").prop("disabled",true);
		$("#user2_select_id").prop("disabled",true);
		
	}else{
		ICustomerService.getteamuser(teamId, teamchangeCallBack);
		
		$("#user1_select_id").prop("disabled",false);		
	}
}

function teamchangeCallBack(res){
	var text = "";			
	
	text += "<option value='0' selected>지정하지않음.</option>";
	for(var i = 0; i < res.length; i++){		 
		text += "<option value="+res[i].userId+">"+res[i].userNm+"</option>";	 	
	}	
	
	$("#user1_select_id").html(text);	
	$("#user2_select_id").html(text);	
	$("#user2_select_id").prop("disabled",true);
}

function user1_select_change_event(){
	var teamId = $("#team_select_id").val();
	var userId = $("#user1_select_id").val();
	
	if(userId == 0){
		ICustomerService.getteamuser(teamId, teamchangeCallBack);		
	}else{
		
		ICustomerService.getteamuser1(teamId, userId, user1changeCallBack);
		$("#user2_select_id").prop("disabled",false);		
	}
}

function user1changeCallBack(res){
	var text = "";			
	
	text += "<option value='0' selected>지정하지않음.</option>";
	for(var i = 0; i < res.length; i++){			
		 
		text += "<option value="+res[i].userId+">"+res[i].userNm+"</option>";	 	
	}
	
	$("#user2_select_id").html(text);
}

function support_select_change_event(){
	var supoId = $("#support_select_id").val();
	var text = "";
	
	if(supoId == 3){ //프리세일즈 ID : 3
		ICustomerService.getSupovisit(supoId,supochangeCallBack);		
		$("#visit_select_id").prop("disabled",true);	
		
		text += "<tr><td>비고</td><td><textarea id='etc_id' rows='5' cols='30' name='contents'></textarea></td></tr>";

		$("#cus_list_tb").html(text);
	}else{
		ICustomerService.getSupovisit(supoId,supochangeCallBack);		
		$("#visit_select_id").prop("disabled",false);	
		
		text += "<tr><td>계약시작일</td><td><input id='supoStartDate_id' type='date' value=''></td></tr>";
		text += "<tr><td>계약종료일</td><td><input id='supoEndDate_id' type='date' value=''></td></tr>";
		
		text += "<tr><td>비고</td><td><textarea id='etc_id' rows='5' cols='30' name='contents'></textarea></td></tr>";
	
		$("#cus_list_tb").html(text);
	}		
}

function supochangeCallBack(res){
	var text = "";			
	
	for(var i = 0; i < res.length; i++){			
		 
		text += "<option value="+res[i].supoVisitId+">"+res[i].supoVisitNm+"</option>";	 	
	}
	
	$("#visit_select_id").html(text);
} */

function cusNminfoCallBack(res){
	var availableTags = [];
	
	for(var i = 0; i < res.length; i++){	
		availableTags.push(res[i].cusNm);			
	}
	
	 $("#cusName_id").shieldComboBox({
	    	dataSource: {
	            data: availableTags
	        },	        
	        autoComplete: {
	            enabled: true
	        },events: {
	        	change : function(e){   
     				var cusNm =  $("#cusName_id").val();	        			
     		
     				$("#cusUser_id").val("");
    			    ICustomerService.getcusNmProinfo(cusNm,"", cusNmProinfoCallBack);	           			   
     	   		}
	        }
 	}); 	
	/* $( "#cusName_id" ).autocomplete({
		  source: availableTags
	}); */
}

function cusNmProinfoCallBack(res){
	/* var availableTags = [];	 */
	
	if(res.length > 0){
		for(var i = 0; i < res.length; i++){			
			/* availableTags.push(res[i].proNm); */			
		    $("#cusName_hidden_id").val(res[i].cusId); 
			$("#cuslocation_id").val(res[i].cusLoca);
		}
/* 		$( "#cusproName_id" ).autocomplete({
			  source: availableTags
		}); */
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
/* 		$( "#cusNm_id" ).autocomplete({
			  source: availableTags
		}); */
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

function insertCusinfoCallBack(res){
	if(res == "FAILED"){
		alert("실패");
		location.href = "customer_insert";
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "customer_insert";
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
		   <h4>고객사 관리 페이지</h4></br>
		   <a href="#" id="cus_managed">고객사 관리</a></br>		    
		   <a href="#" id="cus_insert">고객사 등록</a></br>		 
	 </div>
	 <div class="column middle">
	  
	 	<h3>고객사 등록 정보</h3>
		<div id="customer_list">		
			<table id="cus_list">	
				<thead id="cus_list_th">
					<tr>
						<td>고객사명*</td>
						<td>							
							<div id="div_cusName_id">
								<input type="hidden" id="cusName_hidden_id" value="0"/>
								<input class="sui-input" id='cusName_id' value=""  style='text-transform: uppercase' onblur="onblur_event();"></input>
								<span id="idSpan" class="redText"></span>	
							</div>									
						</td>
					</tr>
					<tr>
						<td>프로젝트명*</td>
						<td><input class="sui-input" type='text' id='cusproName_id' value="" style='text-transform: uppercase'>			
						<span id="idSpan1" class="redText"></span>
						</td>	
					</tr>	
					<tr>
						<td>고객명</td>												
						<td><input type="hidden" id="cusNm_hidden_id" value="0"/>
						<input class="sui-input" type='text' id='cusNm_id' value=""  style='text-transform: uppercase'></td>															
					</tr>			
					<tr>
						<td>고객 연락처</td>						
						<td><input class="sui-input" type='text' id='cusPhone_id' value="" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'></td>															
					</tr>
					<tr>
						<td>고객 이메일</td>						
						<td><input class="sui-input" type='text' id='cusMail_id' value=""></td>													
					</tr>		
					<tr>
						<td>고객사 위치</td>						
						<td><input class="sui-input" type='text' id='cuslocation_id' value=""  style='text-transform: uppercase'></td>														
					</tr>
					<tr>
						<td>담당영업</td>
						<td>
						<select class="sui-input" id='salesman_select_id'>
							<option value="0" selected>지정하지않음.</option>
						    <c:forEach var="sl" items="${salseman_list}">
			 	    			<option value="${sl.userId}">${sl.userNm}</option>		 	    	
			 	    		</c:forEach>	
						</select>
						</td>									
					</tr>							
				</thead>
				<tbody id="cus_list_tb">
					<tr>
						<td>비고</td>						
						<td><textarea id="etc_id" rows="5" cols="30" name="contents"></textarea></td>													
					</tr>																											
				</tbody>
				<tfoot id="cus_list_tf"> 					
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


