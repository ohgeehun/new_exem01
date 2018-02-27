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
	 
	/* 체크박스 이벤트 */
	$("#chk_id").click(function(){
		var cusNm = $("#cusName_id").val();
        //클릭되었으면
        if($("#chk_id").prop("checked")){
          
            $("#cusproName_id").swidget().destroy();			
			$("#cusproName_id").val($("#cusName_id").val());
			$("#cusproName_id").prop("disabled",true);	
			
			$("#dbms_select_id").prop("disabled",false);	
						
			alert($("#cusproName_id").val());
        }else{         	
        	$("#cusproName_id").val("");
        	$("#cusNm_hidden_id").val("0");	   
        	$("#dbms_select_id").prop("disabled",true);	
        	ICustomerService.getcusNmProinfo(cusNm,"", cusNmProinfoCallBack);	
        }
    });
	
 	$("#cusproName_id").shieldComboBox({
    	dataSource: {
            data: ""
        },        	        
        enabled: false
	});  
		
 	
	$("#cusNm_id").shieldComboBox({
    	dataSource: {
            data: ""
        },        	        
        enabled: false
	});  
	
	$("#dbms_select_id").change(function (){
		var dbmsId = $("#dbms_select_id").val();	
		
		if(dbmsId > 0){	
			var cusNm = $("#cusName_id").val();
			var proNm = $("#cusproName_id").val();			
			
			alert(cusNm);
			alert(proNm);
			alert(dbmsId);
			
			ICustomerService.getprodbmsManagedinfo(cusNm, proNm, dbmsId, getprodbmsManagedinfoCallBack);
		}else{
			$("#cusNm_id").swidget().destroy();
			$("#cusNm_id").shieldComboBox({
		    	dataSource: {
		            data: ""
		        },        	        
		        enabled: false
			});  			
		}	
	});
	
	/* 고객사 등록 버튼 이벤트 */
    $("#edit_update_btn").bind("click", function(){   	
    	
    	var cusNm_hidden = $("#cusName_hidden_id").val();
    	var cusPro_hidden = $("#cusPro_hidden_id").val();
    	var cusDbms_hidden = $("#dbmsNm_hidden_id").val();
    	var cusUser_hidden = $("#cusNm_hidden_id").val();
    	
    	var cusNm = $("#cusName_id").val();
    	var cusproNm = $("#cusproName_id").val();
    	var dbmsNm = $("#dbms_select_id").val();
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
     			ICustomerService.insertCusinfo(cusNm_hidden,  cusPro_hidden, cusDbms_hidden, cusUser_hidden, 
	                       cusNm, cusproNm, dbmsNm,
	                       cususerNm, cususerPhone, cususerMail, cuslocation, 
	                       salesmanId, etc, insertCusinfoCallBack); 
     		}     	
     	}    	
    });
	
    /* 고객사 등록 시 기존 고객사명 리스트를 가져오는 이벤트 */
    ICustomerService.getcusNminfo(cusNminfoCallBack);
    
});  

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
	        	blur : function(e){   	        		
	        		
     				var cusNmtemp =  $("#cusName_id").swidget().value();
     				var cusNm = cusNmtemp.toUpperCase();
     				//alert(cusNm);
     				$("#cusName_id").val(cusNm);
     						
     				$("#cusPro_hidden_id").val("0");
     				$("#cusproName_id").val("");     				
     				
      			    $("#dbmsNm_hidden_id").val("0");
      			    $("#dbms_select_id").val("0");
      			    $("#dbms_select_id").val("0").prop("selected", true);
      			    $("#dbms_select_id").prop("disabled",true);	
      			    
      		        $("#cusNm_hidden_id").val("0");	          			    
     		        $("#cusNm_id").val("");
     		        
     		       $("#chk_id").attr("checked", false);
     		        
    			    ICustomerService.getcusNmProinfo(cusNm,"", cusNmProinfoCallBack);	           			   
     	   		}
	        }
 	}); 	
	/* $( "#cusName_id" ).autocomplete({
		  source: availableTags
	}); */
}

function cusNmProinfoCallBack(res){
	var availableTags = [];	 
	
	$("#chk_id").prop("disabled",false);
	
	if(res.length > 0){
		for(var i = 0; i < res.length; i++){			
			availableTags.push(res[i].proNm);			
			
		    $("#cusName_hidden_id").val(res[i].cusId); 
			$("#cuslocation_id").val(res[i].cusLoca);
		}
		
		 $("#cusproName_id").swidget().destroy();
			
		 $("#cusproName_id").shieldComboBox({			 	
		    	dataSource: {
		            data: availableTags
		        },	        
		        autoComplete: {
		            enabled: true
		        },events: {
		        	blur : function(e){   		        	
		        	var proNmtemp =  $("#cusproName_id").swidget().value();
     				var proNm = proNmtemp.toUpperCase();
     				
     				$("#cusproName_id").val(proNm);
     				
	  				//var cusNm =  $("#cusName_id").val();	  				
	  				 
	   			    $("#dbmsNm_hidden_id").val("0");
	   			    $("#dbms_select_id").val("0");
	   			 	$("#dbms_select_id").val("0").prop("selected", true);
	   			    if($("#cusproName_id").val() !=''){
	   			    	$("#dbms_select_id").prop("disabled",false);			
	   			    }else {
	   			    	$("#dbms_select_id").prop("disabled",true);		
	   			    }
	   		        $("#cusNm_hidden_id").val("0");	          			    
	  		        $("#cusNm_id").val("");
	  		        
	 			    //ICustomerService.getcusNmProinfo(cusNm,"", cusNmProinfoCallBack);	           			   
	  	   			}
		        }
		}); 

	}else{
		$("#cusName_hidden_id").val("0");
		$("#cuslocation_id").val("");
		
		$("#cusPro_hidden_id").val("0");
		//$("#cusproName_id").swidget().enabled(true);
		$("#cusproName_id").val("");
		
 		$("#dbmsNm_hidden_id").val("0");
	    $("#dbms_select_id").val("0");
	    $("#dbms_select_id").val("0").prop("selected", true); 
	    $("#dbms_select_id").prop("disabled",true);	
	    
	    $("#cusNm_hidden_id").val("0");	          			    
        $("#cusNm_id").val("");
        

		$("#cusproName_id").swidget().destroy();
		 
    	$("#cusproName_id").shieldComboBox({
        	dataSource: {
                data: ""
            },        	        
            enabled: true,events: {
            	blur : function(e){   
            		var proNmtemp =  $("#cusproName_id").swidget().value();
     				var proNm = proNmtemp.toUpperCase();
     				
     				$("#cusproName_id").val(proNm);
     				
	  				//var cusNm =  $("#cusName_id").val();

	  				//alert(cusNm);
	  				//alert(proNm);		
	  				
	  			 	$("#dbmsNm_hidden_id").val("0");
	   			    $("#dbms_select_id").val("0");
	   			    $("#dbms_select_id").val("0").prop("selected", true);
	   			 	if($("#cusproName_id").val() != ''){
	   			    	$("#dbms_select_id").prop("disabled",false);			
	   			    }else {
	   			    	$("#dbms_select_id").prop("disabled",true);		
	   			    }
	   		        $("#cusNm_hidden_id").val("0");	          			    
	  		        $("#cusNm_id").val("");
	        	}
            }
    	}); 
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


//영문만 입력받도록 검증
function isAlphabetForSpan(str){
	var check = /[^A-Za-z\s]/;
	if(check.test(str)){
		return false;
	}
	return true;
}

//공백 허용하지 않도록 검증
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
		<div class="top_SubMenuPart">
			<div class="top_MenuBase">
				<a href="#" class="top_SubMenu01_c" id="cus_managed">고객사 관리</a>
				<a href="#" class="top_SubMenu02_c" id="cus_insert">고객사 등록</a>
			</div>
		</div>
		
<div class="row">
	 <!-- div class="column side">
		   <h4>고객사 관리 페이지</h4></br>
		   <a href="#" id="cus_managed">고객사 관리</a></br>		    
		   <a href="#" id="cus_insert">고객사 등록</a></br>		 
	 </div-->
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
								<!-- <input class="sui-input" id='cusName_id' value=""  style='text-transform: uppercase' onblur="onblur_event();"></input> -->
								<input class="sui-input" id='cusName_id' value=""  style='text-transform: uppercase'></input>
								<span id="idSpan" class="redText"></span>	
							</div>									
						</td>
					</tr>
					<tr> 
						<td>프로젝트명*</td>						
						<td>
							<input type="hidden" id="cusPro_hidden_id" value="0"/>
							<input class="sui-input" id='cusproName_id' value="" style='text-transform: uppercase'></input>
							<input type="checkbox" id="chk_id" name="chk_info" value="1" disabled="disabled"><font style="font-size: 12px">고객사명과 동일하게 적용</font>		
							<span id="idSpan1" class="redText"></span>			
											
						</td>	
						
					</tr>
					<tr>
						<td>업무명*</td>
						<td>
						<input type="hidden" id="dbmsNm_hidden_id" value="0"/>
						<select class="sui-input" id='dbms_select_id' disabled="disabled">
							<!-- <option value="0" selected>지정하지않음.</option> -->
						    <c:forEach var="dl" items="${dbms_list}">					    	   
				    	    	<c:choose>
									<c:when test="${dl.dbmsId == 0}">									
										<option value="${dl.dbmsId}" selected>지정하지않음.</option>		
									</c:when>
									<c:otherwise>
										<option value="${dl.dbmsId}">${dl.dbmsNm}</option>										 
									</c:otherwise>
								</c:choose>							    		
						    		 	    					    	
			 	    		</c:forEach>	
						</select>
						</td>	
					</tr>		
					<tr>
						<td>고객명</td>												
						<td><input type="hidden" id="cusNm_hidden_id" value="0"/>
						<input class="sui-input" id='cusNm_id' value=""  style='text-transform: uppercase'></td>															
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
						    	<%-- <c:if test="${sl.userId == 0}">
						    	<option value="${sl.userId}" selected>지정하지않음.</option>
						    	</c:if> --%>
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


