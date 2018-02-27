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
		
   	    $('#checkbox_id:checked').each(function() {   	    
   	            var cusproId = $(this).val();
   	    
  	        	var userId = "<%=(String)session.getAttribute("sUserId")%>";
      	        var cususer = $("#edit_cus_list_select_"+cusproId+" option:selected").val();
      	        var cuslocation = $("#cuslocation_id_"+cusproId).val();
      	        var salseman = $("#edit_salseman_list_select_"+cusproId+" option:selected").val();      	    
      	        var etc = $("#etc_id_"+cusproId+"").val();    	        
      	 
      	        ICustomerService.updateCusInfo(userId, cusproId, cususer, cuslocation, salseman, etc, CusupdateCallBack); 
   	    });	    
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
    	if ($("#cus_select4").val() == 0){    		
    		alert("점색조건을 선택하세요.");
    		$("#select_text").val("");
    	}else{
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
</script>

<style>

#customer_list td,tr {    
    border: 2px solid #ddd;
    text-align: center;
    padding-top: 5px;
    padding-bottom: 5px;
    padding-right: 5px;
    padding-left: 5px;
    font-size: 10px;
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
	<form id="form1" method="post" action="customer_edit_next">	 

		<input type="hidden" id="nowPage" name="pageNo" value="${nowPage}"/>
		<input type="hidden" id="cusId_hidden_id" name="cusId_hidden_name" value=""/>
		<input type="hidden" id="userId_hidden_id" value=""/>		
	
	 	<table>
	 	<tr>
	 	<td>
	 		<div class="nTitleFont">
	 			<select id="cus_select4" name="selectBtnVal" class="box_07 nTitleFont">
	 					<option value="0" selected>검색조건없음</option>
						<option value="1">로그인ID</option>						
						<option value="2">이름</option>
						<option value="3">부서</option>
						<option value="4">팀</option>
				</select>
	 		</div>
	 	</td>
	 	<td>	 		
		 	<div class="nTitleFont">			 		
		 	    <input type="text" id="select_text" name="selectTextVal" value="검색 조건을 선택하세요." class="box_07 nTitleFont"></input>
		 	    <input type="button" id="select_btn" value="검색"></input>
			</div>
	 	</td>	 
	 	</tr>
	 	</table> 	
	
	
	
		<div id="customer_list">	
			
	 		<table id="cus_list">	
				<thead id="cus_list_th">
					<tr>
						<td>
							<li class="main_title_box_2 box_01 nCheckBox">
								<input type="checkbox" id="checkall"/>
							</li>
						</td>
						<td>
							<input type="text" class="main_title_box_2 box_02 nTitleFont" value="로그인ID"/>
						</td>
						<td>
							<input type="text" class="main_title_box_2 box_02 nTitleFont" value="이름"/>
						</td>
						<td>
							<input type="text" class="main_title_box_2 box_02 nTitleFont" value="부서"/>
						</td>
						<td>
							<input type="text" class="main_title_box_2 box_02 nTitleFont" value="팀"/>
						</td>
						<td>
							<input type="text" class="main_title_box_2 box_02 nTitleFont" value="업무"/>
						</td>
						<td>
							<input type="text" class="main_title_box_2 box_02 nTitleFont" value="직급"/>
						</td>
						<td>
							<input type="text" class="main_title_box_2 box_02 nTitleFont" value="연락처"/>
						</td>																	
						<td>
							<input type="text" class="main_title_box_2 box_02 nTitleFont" value="메일"/>
						</td>
						<td>
							<input type="text" class="main_title_box_2 box_02 nTitleFont" value="로그인ID"/>
						</td>
					</tr>					
				</thead>
				<tbody id="cus_list_tb">
					<c:forEach var="mem" items="${mem_list_info}">											
						<tr>
							<td>
								<input type="checkbox" name="chk" value="${mem.userId}"/>
							</td>						
							<td>
								${mem.userId}
							</td>
							<td>
								${mem.userNm}						
							</td>							
							<td>
								<select>
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
								<select>
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
								<select>
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
								<select>
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
								${mem.userPhone}
							</td>
							<td>
								${mem.userMail}
							</td>
							<td>																		
								${mem.userPoint}
							</td>
						</tr>					
					</c:forEach>										
				</tbody>
				<tfoot id="cus_list_tf"> 
					<tr>
						<td colspan="6">
							<c:if test="${nowPage > 1}">
								<a href="#" id="backVal">이전</a>
							</c:if>
							<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
								<c:choose>
									<c:when test="${nowPage==i}">
										<a id="${i}" name="moreArea">${i}</a>
									</c:when>
									<c:otherwise>
										<a href="#" id="${i}" name="moreArea">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${maxPage > nowPage}">
								<a href="#" id="nextVal">다음</a>
							</c:if>
						</td>
						<td colspan="4">
							  <input type="password" placeholder="정보 수정 비밀번호 입력." id="editPw" required>&nbsp;&nbsp;
							  <input type="button" id="edit_update_btn" value="변경"></input>
						</td>
					</tr>					
				</tfoot>
	 		</table>
		</div>

	</form>


</body>
</html>


