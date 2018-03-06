<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- <link rel="stylesheet" type="text/css" href="./resources/css/prettydropdowns.css" media="all" />  -->
<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" /> 

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>

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

	$("#edit_update_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("수정할 행을 선택하세요.");
		} else{
			
	   	    $('#checkbox_id:checked').each(function() {   	    
   	    	    var chkId = $(this).val();

   	         	var userId = $("#userId_"+chkId).val();
   	         	var userNm = $("#userNm_"+chkId).val();
   	         	var DeptId = $("#userDept_"+chkId+" option:selected").val();
   	         	var TeamId = $("#userTeam_"+chkId+" option:selected").val();
   	         	var DbmsId = $("#userDbms_"+chkId+" option:selected").val();
   	         	var PosiId = $("#userPosi_"+chkId+" option:selected").val();
   	         	var userPhone = $("#userPhone_"+chkId).val();
   	         	var userMail = $("#userMail_"+chkId).val();
   	         	var userPoint = $("#userPoint_"+chkId).val();
   	         	
   	         	console.debug(" | " + userId + " | " + userNm + " | " +DeptId + " | " +TeamId + " | " + DbmsId + " | " + 
   	         			PosiId + " | " + userPhone + " | " +userMail + " | " + userPoint + " | " + chkId);
   	         	
   	         	IMemberService.updateMeminfo( userId, userNm, "1",
    	         		TeamId, DbmsId,
 	   	         	DeptId, userPhone, 
 	   	        	userMail, PosiId, 
 	   	      		userPoint, chkId, updateMeminfoCallBack );
	   	    });	
		}
	});

	$("#edit_delete_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("삭제할 행을 선택하세요.");
		} else{
			
	   	    $('#checkbox_id:checked').each(function() {   	    
   	    	    var chkId = $(this).val();

	   	    	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
	 				
	 		   	    $('#checkbox_id:checked').each(function() {   	    
	 	   	    	    var chkId = $(this).val();
	
		 	   	    		IMemberService.deleteMeminfo( 
		   	         			chkId, 
		   	         			deleteMeminfoCallBack );
	 		   	    });
	 			
	 			}else{   //취소
	 			    return;
	 			}
   	         	
	   	    });	
		}
	});

	/* 사용자관리 좌측 버튼 이벤트  : 사용자 관리 버튼 클릭 시 */
    $("#mem_managed").bind("click", function(){	
    	location.href = "member_edit";
    });
    
    /* 사용자관리 좌측 버튼 이벤트  : 사용자 등록 버튼 클릭 시 */
    $("#mem_insert").bind("click", function(){	
    	location.href = "member_insert";
    });
    
    /* 조회조건 설정 후 검색버튼 클릭 시 이벤트*/
    $("#select_btn").bind("click", function(){	
    	//if ($("#mem_select4").val() == 0){    		
    		//alert("점색조건을 선택하세요.");
    	//	$("#select_text").val("");
    	//}else{
    		$("#form1").submit();	
    	//}   	
    });
    
    /*페이지 처리(이전 버튼 이벤트 )*/
    $("#backVal").live("click", function(){
    	if($("#select_text").val() == "검색 조건을 선택하세요."){
    		$("#select_text").val("");
    	}    	
    	
    	if($("#mem_select4").val() == 0){
    		$("#userId_hidden_id").val(userId);    	    		
    	}else{
    		$("#userId_hidden_id").val(""); 
    	}
    	
    	$("#nowPage").val($("#nowPage").val() - 1);    	
    	
    	$("#form1").submit();	
    	
    });
    
    /*페이지 처리(다음 버튼 이벤트 )*/
    $("#nextVal").live("click", function(){
    	if($("#select_text").val() == "검색 조건을 선택하세요."){
    		$("#select_text").val("");
    	}    	
    	
    	if($("#mem_select4").val() == 0){
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
    	
    	if($("#mem_select4").val() == 0){
    		$("#userId_hidden_id").val(userId);    	    		
    	}else{
    		$("#userId_hidden_id").val(""); 
    	}
    	
    	$("#nowPage").val($(this).attr("id"));
    	
    	$("#form1").submit();	
    });
});


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

function updateMeminfoCallBack(res){
	if(res == "FAILED"){
		alert("실패");
		location.href = "member_edit";
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "member_edit";
	}
}

function deleteMeminfoCallBack(res){
	if(res == "FAILED"){
		alert("실패");
		location.href = "member_edit";
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "member_edit";
	}
}

</script>

<style>
/*
#customer_list td,tr {    
    border: 2px solid #ddd;
    text-align: center;
    padding-top: 5px;
    padding-bottom: 5px;
    padding-right: 5px;
    padding-left: 5px;
    font-size: 10px;
}
*/
.tb_search_lmargin {
	margin-left : 270px;
}
.fltBox1 {
	width: 85px;
}

.box2_01 {
	width:39px;
}

.box2_02 {
	width:113px;
}

.box2_03 {
	width:75px;
}

.box2_04 {
	width:135px;
}

.box2_05 {
	width:135px;
}

.box2_06 {
	width:135px;
}

.box2_07 {
	width:75px;
}

.box2_08 {
	width:135px;
}

.box2_09 {
	width:135px;
}
.box2_10 {
	width:75px;
}
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

<div class="top_mainDisplayPart">
	<div align="center"><h3>사용자 관리 페이지</h3></div>
		
<form id="form1" method="post" action="member_edit_next">	 

		<input type="hidden" id="nowPage" name="pageNo" value="${nowPage}"/>
		<input type="hidden" id="cusId_hidden_id" name="cusId_hidden_name" value=""/>
		<input type="hidden" id="userId_hidden_id" value=""/>		
	
	<div class="top_mainDisplayBase" >
		<div id="member_list">	
	 		<table id="mem_list">	
				<thead id="mem_list_th">
					<tr>
						<td colspan="10"  class="left_align">
					 			<select id="mem_select4" name="selectBtnVal" class="main_input_box_2 nInputFont fltBox1">
					 					<option value="0" selected>전체</option>
										<option value="1">로그인ID</option>						
										<option value="2">이름</option>
										<option value="3">부서</option>
										<option value="4">팀</option>
								</select>
					 	
						 	    <input type="text" id="select_text" name="selectTextVal" placeholder="검색조건을 입력하세요." value="" class="main_input_box_2 nInputFont">
						 	    <input type="button" id="select_btn" value="검색" class="Btt_search btnSearch"></input>
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
						<td>
							<input type="text" class="main_title_box_2 box2_02 nTitleFont" value="로그인ID">
						</td>
						<td>
							<input type="text" class="main_title_box_2 box2_03 nTitleFont" value="이름">
						</td>
						<td>
							<input type="text" class="main_title_box_2 box2_04 nTitleFont" value="부서">
						</td>
						<td>
							<input type="text" class="main_title_box_2 box2_05 nTitleFont" value="팀">
						</td>
						<td>
							<input type="text" class="main_title_box_2 box2_06 nTitleFont" value="업무">
						</td>
						<td>
							<input type="text" class="main_title_box_2 box2_07 nTitleFont" value="직급">
						</td>
						<td>
							<input type="text" class="main_title_box_2 box2_08 nTitleFont" value="연락처">
						</td>																	
						<td>
							<input type="text" class="main_title_box_2 box2_09 nTitleFont" value="메일">
						</td>
						<td>
							<input type="text" class="main_title_box_2 box2_10 nTitleFont" value="포인트">
						</td>
					</tr>					
				</thead>
				<tbody id="mem_list_tb">
					<c:forEach var="mem" items="${mem_list_info}">											
						<tr>
							<td>
							   <ul>
								<li class="main_title_box_2 box2_01 nCheckBox">
									<input type="checkbox" name="chk" id="checkbox_id" value="${mem.userId}">
								</li>
								</ul>
							</td>						
							<td>
								<input type="text" class="main_input_box_2 box2_02 nInputFont" value="${mem.userId}" id="userId_${mem.userId}">
							</td>
							<td>
								<input type="text" class="main_input_box_2 box2_03 nInputFont" value="${mem.userNm}" id="userNm_${mem.userId}">						
							</td>							
							<td>
								<select class="main_input_box_2 box2_04 nInputFont" id="userDept_${mem.userId}">
									<c:if test="${mem.userDept == ''}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="dept" items="${dept_list}">										
												<c:choose>
													<c:when test="${dept.deptId  == mem.userDept}">
														<option value="${dept.deptId}" selected>${dept.deptNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${dept.deptId}">${dept.deptNm}</option>	
													</c:otherwise>
												</c:choose>		
									</c:forEach>			
								</select>
							</td>
							<td>
								<select class="main_input_box_2 box2_05 nInputFont" id="userTeam_${mem.userId}">
									<c:if test="${mem.userTeam == ''}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="team" items="${team_list}">
										<c:if test="${team.deptId  == mem.userDept}">										
												<c:choose>
													<c:when test="${team.teamId  == mem.userTeam}">
														<option value="${team.teamId}" selected>${team.teamNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${team.teamId}">${team.teamNm}</option>	
													</c:otherwise>
												</c:choose>
										</c:if>		
									</c:forEach>			
								</select>
							</td>
							<td>
								<select class="main_input_box_2 box2_06 nInputFont" id="userDbms_${mem.userId}">
									<c:if test="${mem.userDbms == ''}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="dbms" items="${dbms_list}">
												<c:choose>
													<c:when test="${dbms.dbmsId  == mem.userDbms}">
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
								<select class="main_input_box_2 box2_07 nInputFont" id="userPosi_${mem.userId}">
									<c:if test="${mem.userPosi == ''}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="posi" items="${posi_list}">
											<c:choose>
												<c:when test="${posi.posiId  == mem.userPosi}">
													<option value="${posi.posiId}" selected>${posi.posiNm}</option>
												</c:when>
												<c:otherwise>
													<option value="${posi.posiId}">${posi.posiNm}</option>	
												</c:otherwise>
											</c:choose>
									</c:forEach>			
								</select>
							</td>			
							<td>
								<input type="text" class="main_input_box_2 box2_08 nInputFont" value="${mem.userPhone}" id="userPhone_${mem.userId}">
							</td>
							<td>
								<input type="text" class="main_input_box_2 box2_09 nInputFont" value="${mem.userMail}" id="userMail_${mem.userId}">
							</td>
							<td>																		
								<input type="text" class="main_input_box_2 box2_10 nInputFont" value="${mem.userPoint}" id="userPoint_${mem.userId}">
							</td>
						</tr>					
					</c:forEach>										
				</tbody>
				<tfoot id="mem_list_tf"> 
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
						<td colspan="10"  class="center_align">
							<div>
						  		<input type="button" id="edit_update_btn" value="수정" class="inBtt_OK_2">
						  		<input type="button" id="edit_delete_btn" value="삭제" class="inBtt_OK_2">
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


