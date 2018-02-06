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
<!-- <link id="themecss" rel="stylesheet" type="text/css" href="//www.shieldui.com/shared/components/latest/css/light/all.min.css" /> -->
<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<!-- <script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script> -->
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.custom.js"></script>  
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/common/jquery-1.11.1.min.js"></script>  
<script type="text/javascript" src="resources/script/common/shieldui-all.min.js"></script>
<!-- <script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script> -->

<!--popup event -->
<link type="text/css" rel="stylesheet" href="resources/css/member/member_list_popup.css" />
<script type="text/javascript" src="resources/script/member/member_list_popup.js"></script>

<!-- <script src="resources/script/jquery/jquery-latest.min.js"></script> 
<script src="resources/script/jquery/jquery.prettydropdowns.js"></script> 

<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ICustomerService.js"></script> 
<script type="text/javascript" src="dwr/interface/IMatService.js"></script> 

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

var temp = [];
$(document).ready(function(){

	$("#mat_insert").bind("click", function(){	
	    location.href = "maintenance_insert";
	});
	
	
	$("#mat_managed").bind("click", function(){	
	   	location.href = "maintenance";
	});
	
	/* 유지보스 등록 버튼 이벤트 */
    $("#edit_update_btn").bind("click", function(){   	
    	var cusNm = $("#cusName_id").val();
    	var proNm = $("#cusproName_id").val();
    	var dbmsId = $("#dbms_select_id").val();    	
    	var dbmsVersion = $("#dbmsVer_id").val();
    	var cusUserNm = $("#cusUser_id").val();
    	var salesmanId =$("#salesman_select_id").val();
    	var user1Id = $("#user1_select_id").val();
    	var user2Id = $("#user2_select_id").val();
    	var supoLeverId = $("#supo_level_select_id").val();
    	var supoVisitId = $("#supo_state_select_id").val();
    	var supoinstallData = $("#install_date_id").val();
        var supostateDate = $("#supo_start_date_id").val();
        var supoendDatae = $("#supo_end_date_id").val();
        var etc = $("#etc_id").val();
	
/*         alert(proId);
    	alert(dbmsId);
    	alert(dbmsVersion);
    	alert(cusNm);
    	alert(salesmanId);
    	alert(user1Id);
    	alert(user2Id);
    	alert(supoLeverId);
    	alert(supoVisitId);
    	alert(supoinstallData);
    	alert(supostateDate);
    	alert(supoendDatae);
    	alert(etc); */
    	
    	alert(supoinstallData);
    	
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
     					IMatService.insertMatinfo(cusNm, proNm, dbmsId, dbmsVersion, cusUserNm, salesmanId,
     											user1Id, user2Id, supoLeverId, supoVisitId, supoinstallData,
     											supostateDate, supoendDatae, etc, insertMatinfoCallBack);     	                       
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
		var dbmsId = $("#dbms_select_id").val();	
		
		if(dbmsId > 0){	
			IMatService.getdeptteam(dbmsId, getTeaminfoCallBack);
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
	        	change : function(e){   
        			var cusNm =  $("#cusName_id").val();	        			
        		
        			$("#cusUser_id").val("");
       			    ICustomerService.getcusNmProinfo(cusNm,"", cusNmProinfoCallBack);	           			   
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
	        	change : function(e){    
        			var cusNm = $("#cusName_id").val();   		 
        			var proNm = $("#cusproName_id").val();	        			
        		
       			    ICustomerService.getcusNmProinfo(cusNm,proNm, cusNmProcheckCallBack);	 
       			    
	        	}
	        }	       
		});  	
		
	}else{
		alert("해당 고객사는 존재하지 않습니다.");

		$("#cusproName_id").swidget().enabled(false);
		
		$("#salesman_select_id").prop("disabled",true);	
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
}	

function cusNmProcheckCallBack(res){
	if (res.length > 0){
		$("#cusUser_id").val(res[0].cus1Nm);	
		if (res[0].salseId != null){
			$("#salesman_select_id").val(res[0].salseId).prop("selected", true);	
		}else{
			$("#salesman_select_id").val("0").prop("selected", true);
		}		
		
		$("#dbms_select_id").attr("disabled",false);

	}else{
		alert("해당 프로젝트는 존재하지 않습니다.");	
		
		$("#salesman_select_id").prop("disabled",true);	
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

    .sui-combobox
    {
        font-family: Arial, sans-serif;
        font-size: 14px;
    }
    
</style>

</head>
<body>
<c:import url="/main_upview"></c:import>
<div class="row">
	 <div class="column side">
		   <h4>유지보수 관리 페이지</h4></br>
		   <a href="#" id="mat_managed">유지보수 관리</a></br>		    
		   <a href="#" id="mat_insert">유지보수 등록</a></br>		 
	 </div>
	 <div class="column middle">
	  
	 	<h3>유지보수 등록 정보</h3>
		<div id="customer_list">		
			<table id="cus_list">	
				<thead id="cus_list_th">
					<tr>
						<td>고객사명*</td>
						<td>		
						    <input id="cusName_id"/>		
						</td>
					</tr>
					<tr>
						<td>프로젝트명*</td>
						<td>
							<input id='cusproName_id'>										
						</td>	
					</tr>	
					<tr>
						<td>업무명*</td>	
						<!-- <td>	<input id='dbms_id'></input>	</td>	 -->											
						<td>
							<select class="sui-input" id='dbms_select_id' disabled="disabled">
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="dl" items="${dbms_list}">
				 	    			<option value="${dl.dbmsId}">${dl.dbmsNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						</td>
					</tr>			
					<tr>
						<td>제품 버전</td>						
						<td><input class="sui-input" type='text' id='dbmsVer_id' value=""></td>												
							
					</tr>
					<tr>
						<td>고객담당자</td>						
						<td><input class="sui-input" type='text' id='cusUser_id' value="" readonly="readonly"></td>													
					</tr>					
					<tr>
						<td>담당영업*</td>
						<td>
							<select class="sui-input" id='salesman_select_id'>
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="sl" items="${salseman_list}">
				 	    			<option value="${sl.userId}">${sl.userNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						</td>								
					</tr>
					<tr>
						<td>담당부서</td>
						<!-- <td><input id='team_id'></td>	 -->
						<td>
							<select class="sui-input" id='team_select_id' disabled="disabled">
								<option value="0" selected>지정하지 않음.</option>							  	
							</select>
						</td>
					</tr>
					<tr>
						<td>담당 엔지니어(정)</td>						
						<!-- <td><input id='user1_id'></td> -->		
						<td>
							<select class="sui-input" id='user1_select_id' disabled="disabled">
								<option value="0" selected>지정하지 않음.</option>							  	
							</select>
						</td>												
					</tr>
					<tr>
						<td>담당 엔지니어(부)</td>						
						<!-- <td><input id='user2_id'></td> -->														
						<td>
							<select class="sui-input" id='user2_select_id' disabled="disabled">
								<option value="0" selected>지정하지 않음.</option>							  	
							</select>
						</td>	
					</tr>	
					<tr>
						<td>최초 설치일</td>						
						<td><input class="sui-input" type='date' id='install_date_id'></td>														
					</tr>
					<tr>
						<td>MA 현 상태</td>												
						<td>
							<select class="sui-input" id='supo_level_select_id'>
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="sll" items="${supo_level_list}">
				 	    			<option value="${sll.supoId}">${sll.supoNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						</td>														
					</tr>
					<tr>
						<td>MA 유형</td>						
						<td>
						    <select class="sui-input" id='supo_state_select_id' disabled="disabled">
								<option value="0" selected>지정하지 않음.</option>
							  <%--   <c:forEach var="svl" items="${supo_visit_list}">
				 	    			<option value="${svl.supoVisitId}">${svl.supoVisitNm}</option>		 	    	
				 	    		</c:forEach> --%>
							</select>
						</td>														
					</tr>																			
				</thead>
				<tbody id="cus_list_tb">				    	
			 		<tr>
						<td>MA 시작일</td>						
						<td><input class="sui-input" type='date' id='supo_start_date_id'></td>														
					</tr>
					<tr>
						<td>MA 종료일</td>						
						<td><input class="sui-input" type='date' id='supo_end_date_id'></td>															
					</tr>	 -
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


