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
<link rel="stylesheet" type="text/css" href="./resources/css/customer/customer_insert.css" media="all" />

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
			$("#cusproName_id").val(cusNm);
			
		
			$("#cusproName_id").prop("disabled",true);	
			$("#dbms_select_id").prop("disabled",false);	
						
        }else{         	
        	$("#cusproName_id").val("");
        	$("#cusNm_hidden_id").val("0");	   
        	$("#dbms_select_id").prop("disabled",true);	
        	ICustomerService.getProinfo(cusNm,cusNmProinfoCallBack);	
        	
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
		
 	
	$("#cusNm_id").shieldComboBox({
    	dataSource: {
            data: ""
        },        	        
        enabled: false
	});  
	
	
    $("#dbms_select_id").change(function (){
		var dbmsId = $("#dbms_select_id").val();	
		
		if(dbmsId > 0){	
			var cusId = $("#cusName_hidden_id").val();
			var proNm = $("#cusproName_id").val();			
			ICustomerService.getprodbmsmemberinfo(cusId, getprodbmsManagedinfoCallBack);
		/* 	ICustomerService.getprodbmsManagedcheck(cusNm,proNm, dbmsId, getprodbmsManagedcheckCallBack); */
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
	
	
	// 제품구분 선택 시
/* 	$("#dbms_select_id").change(function (){
		var dbmsId = $("#dbms_select_id").val();	
		
		if(dbmsId > 0){	
			$("#cusNm_id").removeAttr('disabled');
			$("#cusPhone_id").removeAttr('disabled');
	    	$("#cusMail_id").removeAttr('disabled');
	    	$("#cuslocation_id").removeAttr('disabled');
	    	$("#salesman_select_id").removeAttr('disabled');
		} else {
			$("#cusNm_id").attr('disabled','disabled');
			$("#cusPhone_id").attr('disabled','disabled');
	    	$("#cusMail_id").attr('disabled','disabled');
	    	$("#cuslocation_id").attr('disabled','disabled');
	    	$("#salesman_select_id").val(0);
	    	$("#salesman_select_id").attr('disabled','disabled');
		}	
	}); */
	
	/* 고객사 등록 버튼 이벤트 */
    $("#edit_update_btn").bind("click", function(){   	
    	//var cusNm = $("#cusName_id").val();
    	//var cusproNm = $("#cusproName_id").val();
    	
		//ICustomerService.insertCusinfo2(cusNm,  cusproNm, insertCusinfoCallBack);
    	
    	//var cusNm_hidden = $("#cusName_hidden_id").val();
    	//var cusPro_hidden = $("#cusPro_hidden_id").val();
    	//var cusDbms_hidden = $("#dbmsNm_hidden_id").val();
    	//var cusUser_hidden = $("#cusNm_hidden_id").val();  
    	//alert(cusUser_hidden);
    	
    	var cusNm = $("#cusName_id").val();
    	var cusproNm = $("#cusproName_id").val();
    	var dbmsId = $("#dbms_select_id").val();
    	var cususerNm = $("#cusNm_id").val();   // 고객담당자 명
    	var cususerPhone = $("#cusPhone_id").val();   // 고객담당자 전화번호
    	var cususerMail = $("#cusMail_id").val();
    	var cuslocation = $("#cuslocation_id").val();
    	
    	var salesmanId = $("#salesman_select_id").val();  	
    	var etc = $("#etc_id").val();    
    	
    	// 고객사연락처나 이메일은 있는데, 고객명이 있으면 입력하도록 유도
    	if( cususerNm == "" && ( cususerPhone != "" || cususerMail != "" )) {
    		alert("고객담당자 정보입력시 담당자명을 입력해 주세요!");
    		return false;
    	} else {
    	
	    	ICustomerService.insertCusinfo2( 
	                cusNm, cusproNm, dbmsId,
	                cususerNm, cususerPhone, cususerMail, cuslocation, 
	                salesmanId, etc, insertCusinfoCallBack);
    	}
    	/*
    	if(cusNm_hidden > 0 && cusPro_hidden > 0 && cusDbms_hidden > 0 && cusUser_hidden > 0){
    		alert("이미 등록된 정보입니다. 고객사 리스트에서 확인해주세요.");
    	}else{
    		if(cusNm == ""){     		
         		alert("고객사명을 입력해주세요.");	   		
         	}else{
    			if(cusproNm == ""){
    				alert("프로젝트명을 입력해주세요.");
         		}else{
         			ICustomerService.insertCusinfo(cusNm_hidden,  cusPro_hidden, cusDbms_hidden, cusUser_hidden, 
    	                       cusNm, cusproNm, dbmsId,
    	                       cususerNm, cususerPhone, cususerMail, cuslocation, 
    	                       salesmanId, etc, insertCusinfoCallBack); 
         		}     	
         	}  
    	}
    	*/
    });
	
    /* 고객사 등록 시 기존 고객사명 리스트를 가져오는 이벤트 */
    ICustomerService.getcusNminfo(cusNminfoCallBack);
    
});  


function cusNminfoCallBack(res){
	var availableTags = [];
	
	for(var i = 0; i < res.length; i++){	
		availableTags.push(res[i].cusNm);			
	}	

	 $("#cusName_id").swidget().destroy();
	 
	 $("#cusName_id").shieldComboBox({
	    	dataSource: {
	            data: availableTags
	        },	        
	        autoComplete: {
	            enabled: true
	        },events: {
	        	select : function(e){   	        		
	        		
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
     		        
     		        $("#cusNm_id").swidget().destroy();
     		    	$("#cusNm_id").shieldComboBox({
     		       	dataSource: {
     		               data: ""
     		           },        	        
     		           enabled: false
     		   		});  
     		   		
     		    	$("#cusPhone_id").val('');
     			    $("#cusMail_id").val('');
     			    $("#etc_id").val('');
     		       
     		        $("#chk_id").attr("checked", false);
     		        $("#chk_id").prop("disabled",false);
     		       
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
		        	select : function(e){   
		        	var cusNm = $("#cusName_id").val();
		        	var proNmtemp =  $("#cusproName_id").swidget().value();
     				var proNm = proNmtemp.toUpperCase();     				
     		     				
     				$("#cusproName_id").val(proNm);     						
	  				 
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
	  		        
	 			    ICustomerService.getCusProCheck(cusNm,proNm, getCusProCheckCallBack);	           			   
	  	   			}
		        }
		}); 

	}else{
	
		$("#cusName_hidden_id").val("0");
		$("#cuslocation_id").val("");
		
		$("#cusPro_hidden_id").val("0");
		$("#cusproName_id").val("");
		
 		$("#dbmsNm_hidden_id").val("0");
	    $("#dbms_select_id").val("0");
	    $("#dbms_select_id").val("0").prop("selected", true); 
	    $("#dbms_select_id").prop("disabled",true);	
	    
	    $("#cusNm_hidden_id").val("0");	          			    
        $("#cusNm_id").val("");   
        
        $("#cusNm_id").swidget().destroy();
		 
    	$("#cusNm_id").shieldComboBox({
        	dataSource: {
                data: ""
            },        	        
            enabled: false
    	});  
    	
	    $("#cusPhone_id").val('');
	    $("#cusMail_id").val('');
	 	  
		$("#cusproName_id").swidget().destroy();
		 
    	$("#cusproName_id").shieldComboBox({
        	dataSource: {
                data: ""
            },        	        
            enabled: true,
            events: {
            	select : function(e){   
            		var cusNm = $("#cusName_id").val();
            		var proNmtemp =  $("#cusproName_id").swidget().value();
     				var proNm = proNmtemp.toUpperCase();
     				
     				$("#cusproName_id").val(proNm);
	  				
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

function getCusProCheckCallBack(res){
	if(res.length > 0){
		for(var i = 0; i < res.length; i++){	
			 $("#cusPro_hidden_id").val(res[i].pjtId); 
		}
	}else{
		  $("#cusPro_hidden_id").val("0");	        
	}

}

/* function getprodbmsManagedcheckCallBack(res){
	if(res.length > 0){
		for(var i = 0; i < res.length; i++){	
			 $("#dbmsNm_hidden_id").val(res[i].dbmsId); 
		}
	}else{
		  $("#dbmsNm_hidden_id").val("0");	        
	}

} */

function getprodbmsmemberinfoCallBack(res){
	if(res.length > 0){
		for(var i = 0; i < res.length; i++){	
			/* alert(res[i].cususerId); */
			 $("#cusNm_hidden_id").val(res[i].cususerId);
			 $("#cusPhone_id").val(res[i].cususerPhone);
			 $("#cusMail_id").val(res[i].cususerMail);			 
		}		
	}else{
		  $("#cusNm_hidden_id").val("0");	
		  $("#cusPhone_id").val('');
		  $("#cusMail_id").val('');
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


function insertCusinfoCallBack(res){
	if(res == "FAILED"){
		alert("실패");
		//location.href = "customer_insert";
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "customer_insert";
	}else if(res == "CUSTOMER_ALEADY_EXIST"){
			alert("이미 등록된 고객사입니다.");
			//location.href = "customer_insert";
	}
}

function getprodbmsManagedinfoCallBack(res){
	var availableTags = [];	 
	
	if(res.length > 0){
		for(var i = 0; i < res.length; i++){
			availableTags.push(res[i].cususerNm);	
			
			// $("#cusName_hidden_id").val(res[i].cusId);
		}
		
		 $("#cusNm_id").swidget().destroy();
			
		 $("#cusNm_id").shieldComboBox({			 	
		    	dataSource: {
		            data: availableTags
		        },	        
		        autoComplete: {
		            enabled: true
		        },events: {
		        	select : function(e){   
		        		var cusId = $("#cusName_hidden_id").val();
		    			var proId = $("#cusPro_hidden_id").val();		
		    			var dbmsId = $("#dbms_select_id").val();
		        		var cususerNm =  $("#cusNm_id").swidget().value();
		        		
		        		$("#cusNm_id").val(cususerNm);		        		
		        		
		        		ICustomerService.getprodbmsmemberinfo(cusId, "", "", cususerNm, getprodbmsmemberinfoCallBack);
       			   
	  	   			}
		        }
		}); 
		 
	}else{
		$("#cusNm_hidden_id").val("0");
		
		$("#cusNm_id").swidget().destroy();
		 
    	$("#cusNm_id").shieldComboBox({
        	dataSource: {
                data: ""
            },        	        
            enabled: true,
            events: {
            	select : function(e){
            		var cusId = $("#cusName_hidden_id").val();
	    			var proId = $("#cusPro_hidden_id").val();		
	    			var dbmsId = $("#dbms_select_id").val();
            		var cususerNm =  $("#cusNm_id").swidget().value();
            		$("#cusNm_id").val(cususerNm);
            		
            		ICustomerService.getprodbmsmemberinfo(cusId, "", "", cususerNm, getprodbmsmemberinfoCallBack);
	        	}
            }
    	}); 
	}
}
</script>

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
	  <div class="top_mainDisplayPart">	 
	  	<div align="center"><h3>고객사 등록 페이지</h3></div>
		<div class="top_mainDisplayBase" >
			<ul>
		 		<li class="input_title input_01 inputTxtFont">고객사명*</li>
				<li class="input_title input_02 inputTxtFont">프로젝트명*</li>
				<li class="input_title input_03 inputTxtFont">제품구분</li>
				<li class="input_title input_04 inputTxtFont">고객명</li>
				<li class="input_title input_05 inputTxtFont">고객 연락처</li>
				<li class="input_title input_06 inputTxtFont">고객 이메일</li>
				<li class="input_title input_07 inputTxtFont">고객사 위치</li>
				<li class="input_title input_08 inputTxtFont">담당영업</li>
				<li class="input_title input_09 inputTxtFont">비고</li>				
			</ul>
						
				<div class="input_txt_01 input_01 inputTxtFont">	
					<input type="hidden" id="cusName_hidden_id"> 
					<!-- <input class="sui-input" id='cusName_id' value=""  style='text-transform: uppercase' onblur="onblur_event();"></input> -->
					<input id='cusName_id'></input>
					<!-- <span id="idSpan" class="redText"></span> -->			
				</div>
						
				<div class="input_txt_01 input_02 inputTxtFont">	
					<input type="hidden" id="cusPro_hidden_id"> 
					<input class="input_txt_03 input_02_01 inputTxtFont sui-input"  id='cusproName_id' >	
				</div>	
				<div class="input_title_01 input_02 inputTxtFont">
					<input id="chk_id" type="checkbox" disabled="disabled"/> 고객사명과 동일
				</div>
				<!-- <input type="hidden" id="dbmsNm_hidden_id"> -->
				<select class="input_txt input_03 inputTxtFont" id='dbms_select_id'>
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
				
				<div  class="input_txt_01 input_04 inputTxtFont">	
					<!-- <input type="hidden" id="cusNm_hidden_id"> -->
					<input id='cusNm_id'  disabled="true">
				</div>
				
				<!-- input class="input_txt input_05 inputTxtFont" type='text' id='cusPhone_id' onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'-->
				<input class="input_txt input_05 inputTxtFont" type='text' id='cusPhone_id'>
				
				<input class="input_txt input_06 inputTxtFont" type='text' id='cusMail_id'>
				
				<input class="input_txt input_07 inputTxtFont" type='text' id='cuslocation_id'>				
				
				<select class="input_txt input_08 inputTxtFont" id='salesman_select_id'>
					<option value="0" selected>지정하지않음.</option>
					 <c:forEach var="sl" items="${salseman_list}">
					    	<option value="${sl.userId}">${sl.userNm}</option>		 	    			 	    	
	 	    		</c:forEach> 
				</select>
				<textarea  class="input_txt_02 input_09 inputTxtFont" id="etc_id" name="contents"></textarea>
				
					<input type="password" placeholder="등록 비밀번호 입력." required class="reg_pass inputTxtFont"> &nbsp;&nbsp;
					<input type="button" id="edit_update_btn" name="OK" class="miBtt_submit_top miBtt_submit" value="등록">				
				
		</div>
	</div>
</div>
<c:import url="/main_botview"></c:import>
</body>
</html>


