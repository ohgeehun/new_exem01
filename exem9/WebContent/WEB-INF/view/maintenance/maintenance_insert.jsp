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
<link id="themecss" rel="stylesheet" type="text/css" href="//www.shieldui.com/shared/components/latest/css/light/all.min.css" />
<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<!-- <script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script> -->
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.custom.js"></script>  
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script>

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
	
/* 	$("#user1_id").bind("click", function(){
		popup("테스트중입니다.", "8");		
	});
	 */
	
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
	
	$("#dbms_id").shieldComboBox({
    	dataSource: {
            data: ""
        },        	        
        enabled: false
	});     
	
	$("#team_id").shieldComboBox({
    	dataSource: {
            data: ""
        },        	        
        enabled: false
	}); 
	
	$("#user1_id").shieldComboBox({
    	dataSource: {
            data: ""
        },        	        
        enabled: false
	}); 
	
	$("#user2_id").shieldComboBox({
    	dataSource: {
            data: ""
        },        	        
        enabled: false
	}); 
     
	ICustomerService.getcusNminfo(cusNminfoCallBack);
	IMatService.getdbms(dbmsinfoCallBack);
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
        		
       			    ICustomerService.getcusNmProinfo(cusNm,"", cusNmProinfoCallBack);	           			   
        	   	}
	        }
    }); 	
}

function dbmsinfoCallBack(res){
	var dbmslist = [];
	
	for(var i = 0; i < res.length; i++){	
		 dbmslist.push(res[i].dbmsNm);			
 	}	
	
	$("#dbms_id").swidget().destroy();
	
	$("#dbms_id").shieldComboBox({
    	dataSource: {
            data: dbmslist
        }, 
        autoComplete: {
            enabled: true
        },   
        enabled: false ,
        events: {
        	change : function(e){    
        		
    			//var cusNm = $("#cusName_id").val();   		 
    			//var proNm = $("#cusproName_id").val();	 
    			var dbmsNm = $("#dbms_id").val();
    		
    			IMatService.getdeptteam(dbmsNm, getTeaminfoCallBack);	      
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
		//$("#cusName_id").val("");			
		//$("#cusproName_id").val("");
		$("#cusproName_id").swidget().enabled(false);
	}
}	

function cusNmProcheckCallBack(res){
	if (res.length > 0){
		$("#cusUser_id").val(res[0].cus1Nm);
		$("#dbms_id").swidget().enabled(true);		
	}else{
		
		alert("해당 프로젝트는 존재하지 않습니다.");			
		//$("#cusproName_id").val("");
		$("#dbms_id").swidget().enabled(false);
	}
}

function getTeaminfoCallBack(res){
	var teamlist = [];
	
	if (res.length > 0){
		$("#team_id").swidget().enabled(true);
		
		for(var i = 0; i < res.length; i++){	
			teamlist.push(res[i].teamNm);			
		}
		
		$("#team_id").swidget().destroy();
		
		$("#team_id").shieldComboBox({
	    	dataSource: {
	            data: teamlist
	        }, 
	        autoComplete: {
	            enabled: true
	        } ,
	        events: {
	        	change : function(e){    
        			var teamNm = $("#team_id").val();   		
        		
        			IMatService.getTeammember(teamNm, getUserinfoCallBack);	      
	        	}
	        }	       
		});  	
	}else{
		alert("업무명을 재대로 입력해주세요.");			
		$("#team_id").swidget().enabled(false);
	}
}

function getUserinfoCallBack(res){
	var memberlist = [];
	
	if (res.length > 0){
	$("#user1_id").swidget().enabled(true);
		
		for(var i = 0; i < res.length; i++){	
			memberlist.push(res[i].userNm);			
		}
		
		$("#user1_id").swidget().destroy();
		
		$("#user1_id").shieldComboBox({
	    	dataSource: {
	            data: memberlist
	        }, 
	        autoComplete: {
	            enabled: true
	        } ,
	        events: {
	        	change : function(e){    
        			var user1Nm = $("#user1_id").val();   		 
        			alert(user1Nm);        			
        		
        			//IMatService.getTeammember(teamNm, getUserinfoCallBack);	      
	        	}
	        }	       
		});  	
	}else{
		alert("엔지니어를 재대로 입력하세요.");			
		$("#user1_id").swidget().enabled(false);
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
						<td>								
							<input id='dbms_id'>
						</td>												
					</tr>			
					<tr>
						<td>제품 버전</td>						
						<td><input type='text' id='dbmsVer_id' value=""></td>															
					</tr>
					<tr>
						<td>고객담당자</td>						
						<td><input type='text' id='cusUser_id' value="" readonly="readonly"></td>													
					</tr>					
					<tr>
						<td>담당영업*</td>
						<td>
							<select id='salesman_select_id'>
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="sl" items="${salseman_list}">
				 	    			<option value="${sl.userId}">${sl.userNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						</td>								
					</tr>
					<tr>
						<td>담당부서</td>
						<td><input id='team_id'></td>	
					</tr>
					<tr>
						<td>담당 엔지니어(정)</td>						
						<td><input id='user1_id'></td>														
					</tr>
					<tr>
						<td>담당 엔지니어(부)</td>						
						<td><input id='user2_id'></td>														
					</tr>	
					<tr>
						<td>최초 설치일</td>						
						<td><input type='date' id='install_date_id'></td>														
					</tr>
					<tr>
						<td>MA 현 상태</td>												
						<td>
							<select id='supo_level_select_id'>
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="sll" items="${supo_level_list}">
				 	    			<option value="${sll.supoId}">${sll.supoNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						</td>														
					</tr>
																								
				</thead>
				<tbody id="cus_list_tb">
				    <tr>
						<td>MA 유형</td>						
						<td>
						    <select id='supo_state_select_id'>
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="svl" items="${supo_visit_list}">
				 	    			<option value="${svl.supoVisitId}">${svl.supoVisitNm}</option>		 	    	
				 	    		</c:forEach>
							</select>
						</td>														
					</tr>	
					<tr>
						<td>MA 시작일</td>						
						<td><input type='date' id='supo_start_date_id'></td>														
					</tr>
					<tr>
						<td>MA 종료일</td>						
						<td><input type='date' id='supo_end_date_id'></td>															
					</tr>	
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


