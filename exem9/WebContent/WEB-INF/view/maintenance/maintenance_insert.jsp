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
<link rel="stylesheet" type="text/css" href="./resources/css/maintenance/maintenance_insert.css" media="all" />
<!-- <link id="themecss" rel="stylesheet" type="text/css" href="//www.shieldui.com/shared/components/latest/css/light/all.min.css" /> -->

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<!-- <script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script> -->
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.custom.js"></script>  
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/common/jquery-1.11.1.min.js"></script>  
<script type="text/javascript" src="resources/script/common/shieldui-all.min.js"></script>

<!--popup event -->
<link type="text/css" rel="stylesheet" href="resources/css/member/cusmemberinfo_popup.css" />
<script type="text/javascript" src="resources/script/member/cusmemberinfo_popup.js"></script>

<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ICustomerService.js"></script> 
<script type="text/javascript" src="dwr/interface/IMatService.js"></script> 

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";
var rowNum = 1;
var rowNum_end = 0;
var rowNum_add = 0;

var temp = [];
$(document).ready(function(){

	$("#mat_insert").bind("click", function(){	
	    location.href = "maintenance_insert";
	});
	
	$("#mat_managed").bind("click", function(){	
	   	location.href = "maintenance";
	});
	
	$("#test_Btn").bind("click", function(){
		 var cusId = $("#cusName_hidden_id").val();
		 
		cusmemberinfo_popup("고객담당자 관리 페이지", cusId);
	});
	
	/* 유지보스 등록 버튼 이벤트 */
    $("#edit_update_btn").bind("click", function(){   	
    	var cusNm = $("#cusName_id").val();
    	var proNm = $("#cusproName_id").val();
    	var dbmsId = $("#dbms_select_id").val();    	
    	var dbmsVersion = $("#dbmsVer_id").val();
    	var cusUserId = $("#cusUser_select_id").val();
    	var salesmanId =$("#salesman_select_id").val();
    	var user1Id = $("#user1_select_id").val();
    	var user2Id = $("#user2_select_id").val();
    	var supoLeverId = $("#supo_level_select_id").val();
    	var supoVisitId = $("#supo_state_select_id").val();
    	var supoinstallData = $("#install_date_id").val();
        var supostateDate = $("#supo_start_date_id").val();
        var supoendDatae = $("#supo_end_date_id").val();
        var etc = $("#etc_id").val();
	
        
  /*       alert(cusNm);
        alert(proNm);
    	alert(dbmsId);
    	alert(dbmsVersion);
    	alert(salesmanId);
    	alert(user1Id);
    	alert(user2Id);
    	alert(supoLeverId);
    	alert(supoVisitId);
    	alert(supoinstallData);
    	alert(supostateDate);
    	alert(supoendDatae);
    	alert(etc);
    	 */

     	if(proNm == ""){     		
     		alert("프로젝트명을 선택하세요.");	   		
     	}else{
			if(dbmsId == "0"){
				alert("업무를 선택해주세요.");
     		}else{
     			if(salesmanId == "0"){
     				alert("담당영업을 선택하세요.");
     			}else{
     				if(user1Id == "0"){
     					alert("담당엔지니어를 선택하세요.");
     				}else{     	
     					if(supoLeverId == "0"){
         					alert("MA 현 상태를 선택하세요.");
         				}else{     				
     					
     						IMatService.insertMatinfo(cusNm, proNm, dbmsId, dbmsVersion, cusUserId, salesmanId,
     													user1Id, user2Id, supoLeverId, supoVisitId, supoinstallData,
     													supostateDate, supoendDatae, etc, insertMatinfoCallBack);
         				}
     				}
     			}     		
     		}     	
     	}     	
    });
	
	$("#cusName_id").shieldComboBox({
    	dataSource: {
            data: ""
        },        	        
        enabled: false
	}); 
	
	$("#cusproName_id").shieldComboBox({
    	dataSource: {
            data: ""
        },	        
        enabled: false
        
	});  
	
	
	$("#dbms_select_id").change(function (){
		 var cusId = $("#cusName_hidden_id").val();
		 var proId = $("#cusproName_hidden_id").val();
		 var dbmsId = $("#dbms_select_id").val();

		if(dbmsId > 0){	
			/* IMatService.getdeptteam(dbmsId, getTeaminfoCallBack); */
			IMatService.getprodbmsmemberinfo(cusId, proId, dbmsId, getcusmemberCallBack);
		}else{
			$("#cusUser_select_id").val("0");
			$("#cusUser_select_id").val("0").prop("selected", true);
			
			$("#team_select_id").val("0");
			$("#team_select_id").val("0").prop("selected", true);
			$("#user1_select_id").val("0");
			$("#user1_select_id").val("0").prop("selected", true);
			$("#user2_select_id").val("0");
			$("#user2_select_id").val("0").prop("selected", true);
			$("#team_select_id").prop("disabled",true);				
			$("#user1_select_id").prop("disabled",true);
			$("#user2_select_id").prop("disabled",true);							
		} 	
	});
	
	$("#dept_select_id").change(function (){
		
		var deptId = $("#dept_select_id").val();	

		if(deptId > 0){	
			$("#user1_select_id").val("0");
			$("#user1_select_id").val("0").prop("selected", true);
			$("#user2_select_id").val("0");
			$("#user2_select_id").val("0").prop("selected", true);
			$("#user1_select_id").prop("disabled",true);
			$("#user2_select_id").prop("disabled",true);	
			
			IMatService.getdeptteam(deptId, getTeaminfoCallBack);	 
		}else{		
			$("#team_select_id").val("0");
			$("#team_select_id").val("0").prop("selected", true);
			$("#user1_select_id").val("0");
			$("#user1_select_id").val("0").prop("selected", true);
			$("#user2_select_id").val("0");
			$("#user2_select_id").val("0").prop("selected", true);
			$("#team_select_id").prop("disabled",true);
			$("#user1_select_id").prop("disabled",true);
			$("#user2_select_id").prop("disabled",true);							
		}	
	});
	
	$("#team_select_id").change(function (){
	
		var teamId = $("#team_select_id").val();	

		if(teamId > 0){	
			IMatService.getTeammember(teamId, "", getUserinfo1CallBack);	 
		}else{			
			$("#user1_select_id").val("0");
			$("#user1_select_id").val("0").prop("selected", true);
			$("#user2_select_id").val("0");
			$("#user2_select_id").val("0").prop("selected", true);
			$("#user1_select_id").prop("disabled",true);
			$("#user2_select_id").prop("disabled",true);							
		}	
	});	
	
	$("#user1_select_id").change(function (){
		
		var user1Nm = $("#user1_select_id").val();	
		var teamId = $("#team_select_id").val();	
		
		if( user1Nm != "0"){	
			IMatService.getTeammember(teamId, user1Nm, getUserinfo1CallBack1);			
		}else{		
			$("#user2_select_id").val("0");
			$("#user2_select_id").val("0").prop("selected", true);
			$("#user2_select_id").prop("disabled",true);												
		}	
	});
	
	
	$("#supo_level_select_id").change(function (){
		var supoLevel = $("#supo_level_select_id").val();	
		
	 	if( supoLevel > 0){	
	 		IMatService.getSupovisit(supoLevel, getsupolevelinfoCallBack);
		}else{
			$("#supo_state_select_id").val("0");
			$("#supo_state_select_id").val("0").prop("selected", true);
			$("#supo_state_select_id").prop("disabled",true);						
		}	 
	});
	
	ICustomerService.getcusNminfo(cusNminfoCallBack);
	
});

function cusNminfoCallBack(res){
	var cuslist = [];
	
	for(var i = 0; i < res.length; i++){	
			 cuslist.push(res[i].cusNm);			
	 } 
	 
	 $("#cusName_id").swidget().destroy();
	
	 $("#cusName_id").shieldComboBox({
	    	dataSource: {
	            data: cuslist
	        },	        
	        autoComplete: {
	            enabled: true
	        },events: {
	        	select : function(e){   
        			var cusNm =  $("#cusName_id").val();	        			
        		
        			$("#cusUser_id").val("");        			
        			
        			$("#cusUser_select_id").val("0");
        			$("#cusUser_select_id").val("0").prop("selected", true);	        			        	

        			$("#salesman_select_id").val("0");	
        			$("#salesman_select_id").val("0").prop("selected", true);        			
      
        			$("#dbms_select_id").val("0");	
        			$("#dbms_select_id").val("0").prop("selected", true);
        			
       			    ICustomerService.getProinfo(cusNm, cusNmProinfoCallBack);	           			   
        	   	}
	        }
    }); 	
}

function cusNmProinfoCallBack(res){	
	var prolist = [];
	
	if (res.length > 0){		
		$("#cusproName_id").swidget().enabled(true);
		
		for(var i = 0; i < res.length; i++){	
			 prolist.push(res[i].proNm);			
		}
				
		$("#cusproName_id").swidget().destroy();
				
		$("#cusproName_id").shieldComboBox({
	    	dataSource: {
	            data: prolist
	        }, 
	        autoComplete: {
	            enabled: true
	        } ,
	        events: {
	        	select : function(e){    
        			var cusNm = $("#cusName_id").val();   		 
        			var proNm = $("#cusproName_id").val();	        			
        			
        			$("#cusUser_select_id").val("0");
        			$("#cusUser_select_id").val("0").prop("selected", true);		
        			
        			$("#salesman_select_id").val("0");	
        			$("#salesman_select_id").val("0").prop("selected", true);
        			
        			$("#dbms_select_id").val("0");	
        			$("#dbms_select_id").val("0").prop("selected", true);        			
        		
       			    ICustomerService.getcusNmProinfo(cusNm,proNm, cusNmProcheckCallBack);	 
       			    
	        	}
	        }	       
		});  	
		
	}else{
		//alert("해당 고객사는 존재하지 않습니다.");
		
		$("#cusName_hidden_id").val("");
		$("#cusproName_hidden_id").val("");

		$("#cusproName_id").swidget().enabled(false);		

		$("#cusUser_select_id").val("0");
		$("#cusUser_select_id").val("0").prop("selected", true);		
		
		$("#salesman_select_id").val("0");	
		$("#salesman_select_id").val("0").prop("selected", true);
		
		$("#dbms_select_id").prop("disabled",true);	
		$("#dbms_select_id").val("0");	
		$("#dbms_select_id").val("0").prop("selected", true);
		
		$("#team_select_id").prop("disabled",true);	
		$("#team_select_id").val("0");
		$("#team_select_id").val("0").prop("selected", true);
		
		$("#user1_select_id").prop("disabled",true);	
		$("#user1_select_id").val("0");
		$("#user1_select_id").val("0").prop("selected", true);
		
		$("#user2_select_id").prop("disabled",true);	
		$("#user2_select_id").val("0");
		$("#user2_select_id").val("0").prop("selected", true);
	}
	
	var text = "";			
	
	text += "<option value='0' selected>지정하지 않음.</option>";
	
	$("#cusUser_select_id").html(text);
}	

function cusNmProcheckCallBack(res){
	if (res.length > 0){
		
		$("#dbms_select_id").prop("disabled",false);
		
		$("#cusName_hidden_id").val(res[0].cusId);
		$("#cusproName_hidden_id").val(res[0].proId);
		
		$("#cusUser_id").val(res[0].cus1Nm);	
		if (res[0].salseId != null){
			$("#salesman_select_id").val(res[0].salseId).prop("selected", false);
		} else{
			$("#salesman_select_id").val("0").prop("selected", true);
		}	 
		
		$("#dbms_select_id").attr("disabled",false);

	}else{
		//alert("해당 프로젝트는 존재하지 않습니다.");		
		
		$("#cusName_hidden_id").val("");
		$("#cusproName_hidden_id").val("");
		

		$("#cusUser_select_id").val("0");
		$("#cusUser_select_id").val("0").prop("selected", true);
		

		$("#salesman_select_id").val("0");	
		$("#salesman_select_id").val("0").prop("selected", true);
		
		$("#dbms_select_id").prop("disabled",true);	
		$("#dbms_select_id").val("0");	
		$("#dbms_select_id").val("0").prop("selected", true);
		
		$("#team_select_id").prop("disabled",true);	
		$("#team_select_id").val("0");
		$("#team_select_id").val("0").prop("selected", true);
		
		$("#user1_select_id").prop("disabled",true);	
		$("#user1_select_id").val("0");
		$("#user1_select_id").val("0").prop("selected", true);
		
		$("#user2_select_id").prop("disabled",true);	
		$("#user2_select_id").val("0");
		$("#user2_select_id").val("0").prop("selected", true);
				
	}
	var text = "";			
	
	text += "<option value='0' selected>지정하지 않음.</option>";
	
	$("#cusUser_select_id").html(text);
}

function getcusmemberCallBack(res){
	var text = "";			
	
	text += "<option value='0' selected>지정하지 않음.</option>";

	if (res.length > 0){
	
		$("#cusUser_select_id").prop("disabled",false);	
		
		for(var i = 0; i < res.length; i++){				
			text += "<option value="+res[i].cususerId+" selected>"+res[i].cususerNm+"</option>";
		}
	}else{
		$("#cusUser_select_id").val("0").prop("selected", true);
	}
		
	
	$("#cusUser_select_id").html(text);
}

function getTeaminfoCallBack(res){
	var text = "";			
	
	text += "<option value='0' selected>지정하지 않음.</option>";

	if (res.length > 0){
	
		$("#team_select_id").prop("disabled",false);	
		
		for(var i = 0; i < res.length; i++){	
			
			text += "<option value="+res[i].teamId+">"+res[i].teamNm+"</option>";
		}
	}
	
	$("#team_select_id").html(text);	
}

function getUserinfo1CallBack(res){
var text = "";			
	
	text += "<option value='0' selected>지정하지 않음.</option>";

	if (res.length > 0){
	
		$("#user1_select_id").prop("disabled",false);	
		
		for(var i = 0; i < res.length; i++){	
			
			text += "<option value="+res[i].userId+">"+res[i].userNm+"</option>";
		}
	}
	
	$("#user1_select_id").html(text);
} 		   

function getUserinfo1CallBack1(res){
	var text = "";			
		
		text += "<option value='0' selected>지정하지 않음.</option>";

		if (res.length > 0){
		
			$("#user2_select_id").prop("disabled",false);	
			
			for(var i = 0; i < res.length; i++){	
				
				text += "<option value="+res[i].userId+">"+res[i].userNm+"</option>";
			}
		}
		
		$("#user2_select_id").html(text);
	} 		 
	
function getsupolevelinfoCallBack(res){
	var text = "";	
	
	text += "<option value='0' selected>지정하지 않음.</option>";

	if (res.length > 0){
	
		$("#supo_state_select_id").prop("disabled",false);	
		
		for(var i = 0; i < res.length; i++){	
			
			text += "<option value="+res[i].supoVisitId+">"+res[i].supoVisitNm+"</option>";
		}
	}
	
	$("#supo_state_select_id").html(text); 	
}

function insertMatinfoCallBack(res){
	if(res == "FAILED"){
		alert("실패");
		location.href = "maintenance_insert";
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "maintenance_insert";
	}
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
</script>

</head>
<body>
<c:import url="/main_upview"></c:import>
		<div class="top_SubMenuPart">
			<div class="top_MenuBase">
				<a href="#" class="top_SubMenu01_ma" id="mat_managed">유지보수 관리</a>
				<a href="#" class="top_SubMenu02_ma" id="mat_insert">유지보수 등록</a>
			</div>
		</div>
		
<div class="row">
	 <!-- div class="column side">
		   <h4>유지보수 관리 페이지</h4></br>
		   <a href="#" id="mat_managed">유지보수 관리</a></br>		    
		   <a href="#" id="mat_insert">유지보수 등록</a></br>		 
	 </div -->
	 <div class="top_mainDisplayPart">
		<div align="center"><h3>유지보수 등록 페이지</h3></div>
		<div id="customer_list" class="top_mainDisplayBase" >		
			 <ul>
					<li class="input_title input_01 inputTxtFont">고객사명*</li>
					<li class="input_title input_02 inputTxtFont">프로젝트명*</li>
					<li class="input_title input_03 inputTxtFont">제품 구분*</li>
					<li class="input_title input_04 inputTxtFont">제품 버전</li>
					<li class="input_title input_05 inputTxtFont">고객담당자</li>
					<li class="input_title input_06 inputTxtFont">담당영업*</li>
					<li class="input_title input_07 inputTxtFont">담당부서</li>
					<li class="input_title input_08 inputTxtFont">담당팀</li>
					<li class="input_title input_09 inputTxtFont">담당 엔지니어(정)</li>
					<li class="input_title input_10 inputTxtFont">담당 엔지니어(부)</li>
					<li class="input_title input_11 inputTxtFont">최초 설치일</li>
					<li class="input_title input_12 inputTxtFont">MA 현 상태</li>
					<li class="input_title input_13 inputTxtFont">MA 유형</li>
					<li class="input_title input_14 inputTxtFont">MA 시작일</li>
					<li class="input_title input_15 inputTxtFont">MA 종료일</li>
					<li class="input_title input_16 inputTxtFont">비고</li>
			</ul>	 			
						<div class="input_txt_01 input_01 inputTxtFont">
							<input type="hidden" id="cusName_hidden_id">
						    <input id="cusName_id"/>		
						</div>
						<div class="input_txt_01 input_02 inputTxtFont">
							<input type="hidden" id="cusproName_hidden_id">
							<input id="cusproName_id"/>										
						</div>
						
						
							<select id="dbms_select_id" class="input_txt input_03 inputTxtFont sui-input" disabled="disabled">
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="dl" items="${dbms_list}">
				 	    			<option value="${dl.dbmsId}">${dl.dbmsNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
									
						<input type="text" id='dbmsVer_id' value="" class="input_txt input_04 inputTxtFont sui-input">												
							
					<!-- 	<div class="input_txt input_05 inputTxtFont sui-input"> -->
							<select id='cusUser_select_id' class="input_txt input_05 inputTxtFont sui-input" >
								<option value="0" selected>지정하지 않음.</option>							    	
							</select>
							<!-- <button id="test_Btn">test</button> -->
						<!-- </div>						 -->
					<!-- 	<input type="text" id='cusUser_id' value="" readonly="readonly" class="input_txt input_05 inputTxtFont sui-input">	 -->												
					
							<select id='salesman_select_id' class="input_txt input_06 inputTxtFont sui-input">
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="sl" items="${salseman_list}">
				 	    			<option value="${sl.userId}">${sl.userNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>						
							
							<select id='dept_select_id' class="input_txt input_07 inputTxtFont sui-input">
									<option value="0" selected>지정하지 않음.</option>
								<c:forEach var="dept" items="${dept_list}">										
									<option value="${dept.deptId}">${dept.deptNm}</option>	
								</c:forEach>							  	
							</select>
							
							<select id='team_select_id' class="input_txt input_08 inputTxtFont sui-input" disabled="disabled">
								<option value="0" selected>지정하지 않음.</option>							  	
							</select>
						
							<select id='user1_select_id' class="input_txt input_09 inputTxtFont sui-input" disabled="disabled">
								<option value="0" selected>지정하지 않음.</option>
							<%-- 	<c:forEach var="mem" items="${mem_list}">										
									<option value="${mem.userId}">${mem.userNm}</option>	
								</c:forEach>	 --%>						  	
							</select>
						
							<select id='user2_select_id' class="input_txt input_10 inputTxtFont sui-input" disabled="disabled">
								<option value="0" selected>지정하지 않음.</option>
							<%-- 	<c:forEach var="mem" items="${mem_list}">										
									<option value="${mem.userId}">${mem.userNm}</option>	
								</c:forEach>	 --%>						  	
							</select>
												
							<input type='date' id='install_date_id' class="input_txt input_11 inputTxtFont sui-input">														
					
							<select id='supo_level_select_id' class="input_txt input_12 inputTxtFont sui-input">
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="sll" items="${supo_level_list}">
				 	    			<option value="${sll.supoId}">${sll.supoNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						
						    <select id='supo_state_select_id' class="input_txt input_13 inputTxtFont sui-input" disabled="disabled">
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="svl" items="${supo_visit_list}">
				 	    			<option value="${svl.supoVisitId}">${svl.supoVisitNm}</option>		 	    	
				 	    		</c:forEach>
							</select>
																							
							<input type='date' id='supo_start_date_id' class="input_txt input_14 inputTxtFont sui-input">														
					
							<input type='date' id='supo_end_date_id' class="input_txt input_15 inputTxtFont sui-input">															
					
							<textarea id="etc_id" name="contents" class="input_txt_02 input_16 inputTxtFont"></textarea>													
					
					
						  <input type="password" placeholder="등록 비밀번호 입력." id="editPw" required class="reg_pass inputTxtFont"> &nbsp;&nbsp;
						  <input type="button" id="edit_update_btn" name="OK" class="miBtt_submit_top miBtt_submit " value="등록">
					
		</div>
	</div>
</div>

</body>
</html>


