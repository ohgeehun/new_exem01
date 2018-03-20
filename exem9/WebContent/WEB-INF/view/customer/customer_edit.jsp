<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- <link rel="stylesheet" type="text/css" href="./resources/css/prettydropdowns.css" media="all" />  -->
<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" /> 
<link rel="stylesheet" type="text/css" href="./resources/css/customer/customer_edit.css" media="all" />

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<!-- <script src="resources/script/jquery/jquery-latest.min.js"></script> 
<script src="resources/script/jquery/jquery.prettydropdowns.js"></script>  -->


<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ICustomerService.js"></script> 

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

$(document).ready(function(){  
	
	/* var dateControl = document.querySelector('input[type="date"]');
	dateControl.value = '2017-06-01'; */
		
	/* 체크박스 이벤트 */
	$("#checkall").click(function(){
        //클릭되었으면
        if($("#checkall").prop("checked")){
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
            $("input[name=chk]").prop("checked",true);
            //클릭이 안되있으면
        }else{
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
            $("input[name=chk]").prop("checked",false);
        }
    });

	// 고객명 추가 입력하는 input box를 안보이게 처리
    $("input[name=input_cususer]").hide();

	/* 고객명 추가입력 선택 시 inputbox 생성 */
    $("select[name=select_cususer]").on("change", function(){
    	//console.log("---------------------------------------------------------------");
    	if ($(this).val() == '-1'){ // 추가입력인 경우,    		
    		//alert("점색어를 입력하세요.");
    		var selectboxId = $(this).attr('id');
    		//alert(selectboxId);
    		var strTemp = selectboxId.split('_'); 
    		var tempId = 'input_cususer_' + strTemp[2] + '_' + strTemp[3] + '_' + strTemp[4] + '_' + strTemp[5] ;
    		//console.log('------------------------' + tempId);
    		//console.log('------------------------' + selectboxId);
    		//alert(tempId);
    		$('#'+selectboxId).hide();  // 콤보박스 안보이게 처리
    		$('#'+tempId).show();   // 콤보박스에 '추가입력' 선택 시만 고객명 보이게 전환
			//$("#form1").submit();
    	} else { // 특정 고객명 선택시 해당하는 고객의 연락처,이메일 정보가 출력되도록 이벤트 처리 필요
    		
    	} 	
    });
	
	$("#edit_update_btn").bind("click", function(){	 // 수정버튼 클릭 시
		
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("수정할 행을 선택하세요.");
		} else{
			
			$('#checkbox_id:checked').each(function() {   	    
   	            var chkId = $(this).val(); // id_id_id_id
   	    
  	        	var userId = "<%=(String)session.getAttribute("sUserId")%>";
  	        	var cusNm = $("#input_cus_"+chkId).val();
  	        	var pjtNm = $("#input_pjt_"+chkId).val();
      	        var cuslocation = $("#input_location_"+chkId).val();
      	        var etc = $("#input_etc_"+chkId+"").val();
     	        var newDbmsId = $("#select_dbms_"+chkId+" option:selected").val();
     	       	var salesmanId = $("#select_salesman_"+chkId+" option:selected").val();
     	       	var cususerId = $("#select_cususer_"+chkId+" option:selected").val();
     	       	var cususerNm = $("#input_cususer_"+chkId).val();
     	       	var phone = $("#input_phone_"+chkId+"").val();
     	       	var email = $("#input_email_"+chkId+"").val();
      	 
      	        //ICustomerService.updateCusInfo(userId, cusproId, cususer, cuslocation, salseman, etc, CusupdateCallBack); 
      	      	ICustomerService.updateCusInfo2(userId, chkId, cusNm, pjtNm, newDbmsId, cususerId, cususerNm, phone, email, cuslocation, salesmanId, etc, CusupdateCallBack);
   	    	});	   
		}
	});

	// 삭제 처리(사용하지 않음)
	$("#edit_delete_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("삭제할 행을 선택하세요.");
		} else{
			
	   	    $('#checkbox_id:checked').each(function() {   	    
   	    	    var chkId = $(this).val();
				 
	   	    	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
	 				
	 		   	    $('#checkbox_id:checked').each(function() {   	    
	 	   	    	    var chkId = $(this).val();
							
		 	   	    		ICustomerService.deleteCusinfo( 
		   	         			chkId, 
		   	         			deleteCusinfoCallBack );
	 		   	    });
	 			
	 			}else{   //취소
	 			    return;
	 			}
   	         	
	   	    });	
		}
	});
	
	
	// 고객담당자 삭제 처리
	$("#edit_delete_cusmember_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("삭제할 행을 선택하세요.");
		} else{
   	    	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
   	    		 
 		   	    $('#checkbox_id:checked').each(function() {   	    
 		   	 		// 담당자가 없는 행을 선택하였으면, 삭제할 담당자가 없습니다 표시
 	   				var chkId = $(this).val();  // chkId구조는 고객사ID_프로젝트ID_제품ID_고객담당자ID, 값이 없으면 10_5__ 이렇게 들어온다.
 	   				var strArray = chkId.split('_');
 	   				//alert(strArray[0] + "_" + strArray[1] + "_" + strArray[2] + "_" + strArray[3] );
 					var dbmsId = $('#select_dbms_'+chkId+' option:selected').val();
 	   				if( dbmsId == '0' ) {
 						dbmsId = '';
 					} 
 					
 	   				if (strArray[3]== "") {
 						alert( $('#input_cus_'+chkId).val() + " / " + $('#input_pjt_'+chkId).val() + " / " + 
 								 dbmsId + "에 삭제할 고객담당자가 없습니다.");
 					} else {
	 	   	    		ICustomerService.deleteCusmemberinfo( 
	   	         			chkId, 
	   	         			deleteCusinfoCallBack );
 					}
						
 		   	    });
 			
 			}else{   //취소
 			    return;
 			}
		}
	});
	
	// 프로젝트의 업무 삭제 처리
	$("#edit_delete_dbms_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("삭제할 행을 선택하세요.");
		} else{
   	    	 if (confirm("프로젝트에 등록된 제품이 삭제되면, \n해당 업무에 등록된 고객담당자와 담당영업대표 정보도 같이 삭제됩니다. \n정말 삭제하시겠습니까??") == true){    //확인
   	    		 
 		   	    $('#checkbox_id:checked').each(function() {   	    
 		   	 		// 제품(업무)가 없는 행을 선택하였으면, 삭제할 업무가 없습니다 표시
 	   				var chkId = $(this).val();  // chkId구조는 고객사ID_프로젝트ID_제품ID_고객담당자ID, 값이 없으면 10_5__ 이렇게 들어온다.
 	   				var strArray = chkId.split('_');
 	   				//alert(strArray[0] + "_" + strArray[1] + "_" + strArray[2] + "_" + strArray[3] );
 					/*
 	   				var dbmsId = $('#select_dbms_'+chkId+' option:selected').val();
 	   				if( dbmsId == '0' ) {
 						dbmsId = '';
 					} */
 					
 	   				if (strArray[2]== "") { // 제품이 없으면
 						alert( $('#input_cus_'+chkId).val() + " / " + $('#input_pjt_'+chkId).val() +  
 								  "에 삭제할 제품(업무)가 없습니다.");
 					} else {
	 	   	    		ICustomerService.deleteCusPjtDbmsinfo( 
	   	         			chkId, 
	   	         			deleteCusinfoCallBack );
 					}
						
 		   	    });
 			
 			}else{   //취소
 			    return;
 			}
		}
	});
	
	// 프로젝트 삭제 처리
	$("#edit_delete_project_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("삭제할 행을 선택하세요.");
		} else{
   	    	 if (confirm("프로젝트가 삭제되면, \n해당 프로젝트에 등록된 모든 제품(업무)에 대한 정보와 \n 해당 업무에 등록된 고객담당자와 담당영업대표 정보도 같이 삭제됩니다. \n정말 삭제하시겠습니까??") == true){    //확인
   	    		 
 		   	    $('#checkbox_id:checked').each(function() {   	    
 		   	 		// 제품(업무)가 없는 행을 선택하였으면, 삭제할 업무가 없습니다 표시
 	   				var chkId = $(this).val();  // chkId구조는 고객사ID_프로젝트ID_제품ID_고객담당자ID, 값이 없으면 10_5__ 이렇게 들어온다.
 	   				var strArray = chkId.split('_');
 	   				//alert(strArray[0] + "_" + strArray[1] + "_" + strArray[2] + "_" + strArray[3] );
 					/*
 	   				var dbmsId = $('#select_dbms_'+chkId+' option:selected').val();
 	   				if( dbmsId == '0' ) {
 						dbmsId = '';
 					} */
 					
 	   				if (strArray[1]== "") { // 프로젝트가 없으면, 없을리가 없음
 						alert( $('#input_cus_'+chkId).val() +   
 								  "에 삭제할 프로젝트가 없습니다.");
 					} else {
	 	   	    		ICustomerService.deleteCusPjtinfo( 
	   	         			chkId, 
	   	         			deleteCusinfoCallBack );
 					}
						
 		   	    });
 			
 			}else{   //취소
 			    return;
 			}
		}
	});
	
	// 프로젝트 삭제 처리
	$("#edit_delete_customer_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("삭제할 행을 선택하세요.");
		} else{
   	    	 if (confirm("고객사가 삭제되면, 고객사의 모든 프로젝트가 삭제되며,\n해당 프로젝트에 등록된 모든 제품(업무)에 대한 정보와 \n 해당 업무에 등록된 고객담당자와 담당영업대표 정보도 같이 삭제됩니다. \n정말 삭제하시겠습니까??") == true){    //확인
   	    		 
 		   	    $('#checkbox_id:checked').each(function() {   	    
 		   	 		// 제품(업무)가 없는 행을 선택하였으면, 삭제할 업무가 없습니다 표시
 	   				var chkId = $(this).val();  // chkId구조는 고객사ID_프로젝트ID_제품ID_고객담당자ID, 값이 없으면 10_5__ 이렇게 들어온다.
 	   				var strArray = chkId.split('_');
 	   				//alert(strArray[0] + "_" + strArray[1] + "_" + strArray[2] + "_" + strArray[3] );
 					/*
 	   				var dbmsId = $('#select_dbms_'+chkId+' option:selected').val();
 	   				if( dbmsId == '0' ) {
 						dbmsId = '';
 					} */
 					
 	   				if (strArray[0]== "") { // 고객사가 없으면, 없을리가 없음
 						alert( $('#input_cus_'+chkId).val() +   
 								  "에 삭제할 고객사가 없습니다.");
 					} else {
	 	   	    		ICustomerService.deleteCusinfo( 
	   	         			chkId, 
	   	         			deleteCusinfoCallBack );
 					}
						
 		   	    });
 			
 			}else{   //취소
 			    return;
 			}
		}
	});
	
	/* 고객사관리 좌측 버튼 이벤트  : 고객사 관리 버튼 클릭 시 */
    $("#cus_managed").bind("click", function(){	
    	location.href = "customer_edit";
    });
    
    /* 고객사관리 좌측 버튼 이벤트  : 고객사 수정 버튼 클릭 시 */
/*     $("#cus_edit").bind("click", function(){	
    	location.href = "customer_edit";
    }); */
    
    /* 고객사관리 좌측 버튼 이벤트  : 고객사 수정 버튼 클릭 시 */
    $("#cus_insert").bind("click", function(){	
    	location.href = "customer_insert";
    });
    
    /* 조회조건 설정 후 검색버튼 클릭 시 이벤트*/
    $("#select_btn").bind("click", function(){	
    	if ($("#select_text").val() == ''){    		
    		alert("점색어를 입력하세요.");
    	}else{
    		//alert($("#select_text").val());
    		$("#form1").submit();	
    	}  	
    });
    
    /*페이지 처리(이전 버튼 이벤트 )*/
    $("#backVal").live("click", function(){
    	if($("#select_text").val() == "검색 조건을 선택하세요."){
    		$("#select_text").val("");
    	}    	
    	
    	if($("#cus_select4").val() == 0){
    		$("#userId_hidden_id").val(userId);    	    		
    	}else{
    		$("#userId_hidden_id").val(""); 
    	}
    	
    	$("#nowPage").val($("#nowPage").val() - 1);    	
    	
    	$("#form1").submit();	
    	/* 고객사 리스트 정보 가져오기 */
    	//ICustomerService.getcusinfo($("#cus_select4").val(),$("#select_text").val(),$("#nowPage").val(),cusinfoCallBack);
    });
    
    /*페이지 처리(다음 버튼 이벤트 )*/
    $("#nextVal").live("click", function(){
    	if($("#select_text").val() == "검색 조건을 선택하세요."){
    		$("#select_text").val("");
    	}    	
    	
    	if($("#cus_select4").val() == 0){
    		$("#userId_hidden_id").val(userId);    	    		
    	}else{
    		$("#userId_hidden_id").val(""); 
    	}
    	
    	$("#nowPage").val($("#nowPage").val()*1 + 1);
    	
    	$("#form1").submit();	
    });

    /*페이지 처리(페이지 숫자 버튼 이벤트 )*/
    $("a[name='moreArea']").live("click", function(){
    	if($("#select_text").val() == "검색 조건을 선택하세요."){
    		$("#select_text").val("");
    	}    	
    	
    	if($("#cus_select4").val() == 0){
    		$("#userId_hidden_id").val(userId);    	    		
    	}else{
    		$("#userId_hidden_id").val(""); 
    	}
    	
    	$("#nowPage").val($(this).attr("id"));
    	
    	$("#form1").submit();	
    });
    
});

/*팀 셀렉트 박스 변경 시 담당엔지니어 정보변경 이벤트*/
/* function edit_team_select_change_event(value){	
	var userTeam =  $("#edit_team_list_select_"+value+"").val();
	
	$("#cusId_hidden_id").val(value);

	ICustomerService.getUsermember(userTeam,editCusUser1Callback); 
} */

/*계약조건 셀렉트 박스 변경 시 방문주기 변경 이벤트*/
/* function edit_supo_select_change_event(value){	
	var supoState =  $("#edit_supo_list_select_"+value+"").val();
	
	$("#cusId_hidden_id").val(value);

	ICustomerService.getSupovisit(supoState,editsupoVisitCallback); 
} */

/* 고객사 리스트 정보 총 row 정보 가져오기에 대한 응답 데이터 처리(tfoot 처리)*/
/*function NcountCallBack(res){
 	$("#nowPage").val(res.nowPage);
		var resHtml = "";
		resHtml += "<tr>";
		resHtml += "	<td colspan='6'>";
		if(res.nowPage > 1) {
			resHtml += "<a href='#' id='backVal'>이전</a>";
		}
		for(var i = res.startPage ; i <= res.endPage ; i++) {
			if(res.nowPage == i){
		    	resHtml += "<a id='" + i + "' name='moreArea'> " + i + " </a>";
			}else{
		    	resHtml += "<a href='#' id='" + i + "' name='moreArea'> " + i + " </a>";
			}
		}
		if(res.maxPage > res.nowPage) {
		    resHtml += "<a href='#' id='nextVal'>다음</a>";
		}
	    resHtml += "	</td>";
	    resHtml += " <td colspan='3'> <input type='password' placeholder='정보 수정 비밀번호 입력.' id='editPw' required>&nbsp;&nbsp;";
	    resHtml += " <input type='button' id='edit_update_btn' value='변경'></input></td>";	    
	    resHtml += "</tr>";
    $("#cus_list_tf").html(resHtml);
} */
/* 
function editCusUser1Callback(res){
	var cusproId = $("#cusId_hidden_id").val();
	var resHtml = "";
	var resHtm2 = "";	
	var user1Id = $("#edit_user1_list_select_"+cusproId+"").val();
	var user2Id = $("#edit_user2_list_select_"+cusproId+"").val();
	
	for(var i = 0; i < res.length; i++){			
		if(user1Id == "0"){
			resHtml += "<option value='0' selected>지정필요.</option>";
			user1Id = "";
		}
		if(res[i].userId == null){
			resHtm1 += "<option value='0' selected>지정필요.</option>";
		}
		else if(user1Id == res[i].userId){
			resHtml += "<option value="+res[i].userId+" selected>"+res[i].userNm+"</option>";
		}else{
			resHtml += "<option value="+res[i].userId+">"+res[i].userNm+"</option>";
		}
		
		
		if(user2Id == "0"){
			resHtm2 += "<option value='0' selected>지정필요.</option>";			
			user2Id = "";
		}
		if(res[i].userId == null){
			resHtm2 += "<option value='0' selected>지정필요.</option>";
		}
		else if(user2Id == res[i].userId){
			resHtm2 += "<option value="+res[i].userId+" selected>"+res[i].userNm+"</option>";
		}else{
			resHtm2 += "<option value="+res[i].userId+">"+res[i].userNm+"</option>";
		}
	}
	
   $("#edit_user1_list_select_"+cusproId+"").html(resHtml); 
   $("#edit_user2_list_select_"+cusproId+"").html(resHtm2);
} */


/* function editsupoVisitCallback(res){

	var cusproId = $("#cusId_hidden_id").val();
	var resHtml = "";
	
	var supoVisitId = $("#edit_supoVisit_list_select_"+cusproId+"").val();

	for(var i = 0; i < res.length; i++){				
		if(res[i].supoNm == null){
			resHtm1 += "<option value='0' selected>지정필요.</option>";
		}
		else if(supoVisitId == res[i].supoVisitId){
			resHtml += "<option value="+res[i].supoVisitId+" selected>"+res[i].supoVisitNm+"</option>";
		}else{
			resHtml += "<option value="+res[i].supoVisitId+">"+res[i].supoVisitNm+"</option>";	
		
		}
	}	
   $("#edit_supoVisit_list_select_"+cusproId+"").html(resHtml); 
} */

function CusupdateCallBack(res){ //고객사 정보  변경 성공 여부
	if(res == "FAILED"){
		alert("실패");
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "customer_edit";
	}
}

/*검색 텍스트 처리 이벤트*/
$(function() {
    var input = $('input[id=select_text]');
    input.focus(function() {
	// 포커스 된경우 초기화
         $(this).val('');

    }).blur(function() {
         var el = $(this);
		 // 공백이 아니면 다시 값 넣어주기

         if(el.val() == '') {
             el.val("검색 조건을 선택하세요.");
		}
    });
 });  
 
function edit_cus_select_change_event(value){
	var cususerId =  $("#edit_cus_list_select_"+value+"").val();	

	$("#cusId_hidden_id").val(value);
	$("#select_cus_hidden_id_"+value+"").val(value);
	if(cususerId == 0 ){
		var resHtml = "";
		var resHtm2 = "";	
		 $("#edit_cus_phone_"+value+"").html(resHtml); 
		 $("#edit_cus_mail_"+value+"").html(resHtm2);
	}else{
		ICustomerService.getcusUserinfo("","0",cususerId,editcusMemberCallback);
	}	
}

function editcusMemberCallback(res){	
	var cusproId = $("#cusId_hidden_id").val();
	var resHtml = "";
	var resHtm2 = "";	
	
	for(var i = 0; i < res.length; i++){
		resHtml += res[i].cususerPhone;
		resHtm2 += res[i].cususerMail;
	}
	
    $("#edit_cus_phone_"+cusproId+"").html(resHtml); 
    $("#edit_cus_mail_"+cusproId+"").html(resHtm2);
}

function deleteCusinfoCallBack(res){
	if(res == "FAILED"){
		alert("실패");
		location.href = "customer_edit";
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "customer_edit";
	}
}
/*
function cususerListener(obj){
	if (obj.value == '-1'){ // 추가입력인 경우,    		
		//alert("점색어를 입력하세요.");
		//var selectboxId = $(this).attr('id');
		var selectboxId = this.id;
		alert(selectboxId);
		var strTemp = selectboxId.split('_'); 
		var tempId = 'input_cususer_' + strTemp[2] + '_' + strTemp[3] + '_' + strTemp[4] + '_' + strTemp[5] ;
		console.log('------------------------' + tempId);
		console.log('------------------------' + selectboxId);
		//alert(tempId);
		$('#'+selectboxId).hide();  // 콤보박스 안보이게 처리
		$('#'+tempId).show();   // 콤보박스에 '추가입력' 선택 시만 고객명 보이게 전환
		//$("#form1").submit();
	}
}
*/
</script>

<style>
.inBtt_OK_CUS {
	width:137px;
	height:36px; 
    padding:7px;
	background:#262d31;
	border:0px;
	font-family: 'Archivo Narrow', sans-serif;
    font-size:15px;
	color:#fff;
}
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
<form id="form1" method="post" action="customer_edit_next">	 	
	 <!-- div class="column side">
		   <h4>고객사 관리 페이지</h4></br>
		   <a href="#" id="cus_managed">고객사 관리</a></br>		    
		   <a href="#" id="cus_insert">고객사 등록</a></br-->
	<!-- 	   <a href="#" id="cus_edit">고객사 </p>기본정보 수정</a></br>	    -->
		   <!-- <a href="#" id="cus_edit1">고객사 </p>계약정보 수정</a></br> -->
	 <!--  /div-->
	 <div class="top_mainDisplayPart">
	 	<div align="center"><h3>고객사 관리 페이지</h3></div>
	 	<%-- <input type="hidden" id="lastBoardNo" value ="${cus_list[fn:length(cus_list)-1].boardNo}"/> --%>
		<input type="hidden" id="nowPage" name="pageNo" value="${nowPage}"/>
		<input type="hidden" id="cusId_hidden_id" name="cusId_hidden_name" value=""/>
		<input type="hidden" id="userId_hidden_id" value=""/>				
	
		<div class="top_mainDisplayBase" >
			<table id="cus_list">	
				<thead id="cus_list_th">
					<tr>
							<td colspan="10" class="left_align">
									<select  class="main_input_box_2 nInputFont fltBox1" id="cus_select4" name="selectBtnVal">
						 					<option value="0" selected>전체</option>
											<option value="1">고객사명</option>
											<option value="2">프로젝트명</option>
											<option value="3">제품명</option>
											<option value="4">고객명</option>						
											<option value="5">영업대표</option>
									</select>
							 	    <input class="main_input_box_2 nInputFont" type="text" id="select_text" name="selectTextVal" value="검색 조건을 선택하세요."></input>
							 	   
							 	    <input class="Btt_search btnSearch" type="button" id="select_btn" value="검색"></input>
					 	    </td>
					</tr>
					<tr>
						<td>
						<ul>
							<li class="main_title_box_2 box2_01 nCheckBox">
								<input type="checkbox" id="checkall"/>
							</li>
						</ul>	
						</td>
						<td><input class="main_title_box_2 box2_02 nTitleFont" value="고객사명" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_03 nTitleFont" value="프로젝트명" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_04 nTitleFont" value="제품(업무)" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_05 nTitleFont" value="고객명" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_06 nTitleFont" value="고객 연락처" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_07 nTitleFont" value="고객 이메일" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_08 nTitleFont" value="고객사 위치" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_09 nTitleFont" value="영업대표" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_10 nTitleFont" value="비고" disabled="disabled"/></td>
					</tr>					
				</thead>
				<tbody id="cus_list_tb">
					<c:forEach var="cli" items="${cus_list_info}">											
						<tr>
							<td>
							<ul>
								<li class="main_title_box_2 box2_01 nCheckBox">
									<input type="checkbox" name="chk" value="${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}" id="checkbox_id"/>
									<input type="hidden" id="checkbox_hidden_id_${cli.proId}" value="${cli.proId}"/>
								</li>
							</ul>
							</td>							
							<td>
								<input type="text" class="main_input_box_2 box2_02 nInputFont" value="${cli.cusNm}" id="input_cus_${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}"/>
							</td>
							<td>
								<input type="text" class="main_input_box_2 box2_03 nInputFont" value="${cli.proNm}" id="input_pjt_${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}"/>
							</td>
							<td>
								<select id="select_dbms_${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}" class="main_input_box_2 box2_04 nInputFont">
									<c:if test="${cli.dbmsId eq null}">
											<option value="0" selected></option>
									</c:if>
									
									<c:forEach var="dbms" items="${dbms_list}">
										<c:choose>
											<c:when test="${dbms.dbmsId == cli.dbmsId}">
												<option value="${dbms.dbmsId}" selected>${dbms.dbmsNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${dbms.dbmsId}">${dbms.dbmsNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>
								</select>
							</td>							
							<td>
								<input type="hidden" id="select_cus_hidden_id_${cli.proId}" value=""/>
								<input type="text" id="input_cususer_${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}" name="input_cususer" value="" class="main_input_box_2 box2_05 nInputFont"/>
								<select id="select_cususer_${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}" name="select_cususer" class="main_input_box_2 box2_05 nInputFont">
								<!-- select id="select_cususer_${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}" onchange="edit_cus_select_change_event(${cli.proId})" class="main_input_box_2 box2_05 nInputFont"-->
									<%--
									<c:out value="${cli.cususerNm}"/>
									<c:forEach var="cmli" items="${cus_member_list_info}">
										<c:out value="${cmli.cususerId},${cmli.cususerNm}"/>
									</c:forEach>
									 --%>
											<c:if test="${cli.cususerNm eq null}">
												<option value="0" selected></option>
											</c:if>
											
											<c:forEach var="cmli" items="${cus_member_list_info}">
												<%--/out value=${cmli.proId}/--%>
										 	    <c:if test="${cli.proId == cmli.proId}"> 
													<c:choose>
														<c:when test="${cli.cusNm == cli.cususerId}">
															<option value="${cmli.cususerId}" selected>${cmli.cususerNm}</option>
														</c:when>
														<c:otherwise>
															<option value="${cmli.cususerId}">${cmli.cususerNm}</option>	
														</c:otherwise>
													</c:choose>	
											    </c:if>			 																	
											</c:forEach>
											<option value="-1">추가입력</option>
								</select>
							</td>
							<td>
								<input type="text" class="main_input_box_2 box2_06 nInputFont" value="${cli.cususerPhone}" id="input_phone_${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}"/>
							</td>							
											
							<td>
								<input type="text" class="main_input_box_2 box2_07 nInputFont" value="${cli.cususerMail}" id="input_email_${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}""/>
							</td>
							<td>
								<input type="text" value="${cli.cusLoca}" class="main_input_box_2 box2_08 nInputFont" id="input_location_${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}">								
							</td>																		
							<td>								
								<select class="main_input_box_2 box2_09 nInputFont" id="select_salesman_${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}">
									<c:if test="${cli.salseId eq null}">
											<option value="0" selected></option>
									</c:if>
									
									<c:forEach var="esl" items="${edit_salseman_list}">
										<c:choose>
											<c:when test="${esl.userId == cli.salseId}">
												<option value="${esl.userId}" selected>${esl.userNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${esl.userId}">${esl.userNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>
								</select>
							</td>			
							<td>
								<textarea name="contents" class="main_input_box_2 box2_10 nInputFont" id="input_etc_${cli.cusId}_${cli.proId}_${cli.dbmsId}_${cli.cususerId}">${cli.etc}</textarea>
							</td>
						</tr>					
					</c:forEach>										
				</tbody>
				<tfoot id="cus_list_tf"> 
				
					<tr>
						<td colspan="10" class="center_align">
						
							<div>
								<c:if test="${nowPage > 1}">
										<a href="#" id="backVal" class="nTitleFont">이전</a>
									</c:if>
									<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
										<c:choose>
											<c:when test="${nowPage==i}">
												<a id="${i}" name="moreArea" class="pageFont">${i}</a>
											</c:when>
											<c:otherwise>
												<a href="#" id="${i}" name="moreArea" class="pageFont">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${maxPage > nowPage}">
										<a href="#" id="nextVal" class="nTitleFont">다음</a>
									</c:if>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="10" class="center_align">
							<div>
						  		<input type="button" id="edit_update_btn" value="수정" class="inBtt_OK_CUS"/>
						  		<input type="button" id="edit_delete_customer_btn" value="고객사 삭제" class="inBtt_OK_CUS">
						  		<input type="button" id="edit_delete_project_btn" value="프로젝트 삭제" class="inBtt_OK_CUS">
						  		<input type="button" id="edit_delete_dbms_btn" value="제품(업무) 삭제" class="inBtt_OK_CUS">
						  		<input type="button" id="edit_delete_cusmember_btn" value="고객담당자 삭제" class="inBtt_OK_CUS">
						  	</div>
						</td>
					</tr>
										
				</tfoot>
	 		</table>		
		</div>
	</div>
	</form>
</div>

</body>
</html>


