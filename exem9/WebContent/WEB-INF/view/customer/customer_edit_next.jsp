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


	/* 고객사관리 좌측 버튼 이벤트  : 고객사 관리 버튼 클릭 시 */
    $("#cus_managed").bind("click", function(){	
    	location.href = "customer_edit";
    });
    
    /* 고객사관리 좌측 버튼 이벤트  : 고객사 수정 버튼 클릭 시 */
    $("#cus_insert").bind("click", function(){	
    	location.href = "customer_insert";
    });
    
    /* 조회조건 설정 후 검색버튼 클릭 시 이벤트*/
    $("#select_btn").bind("click", function(){	
    	if ($("#cus_select4").val() == 0){    		
    		alert("점색조건을 선택하세요.");
    		$("#select_text").val("");
    	}else{
    		$("#nowPage").val("1");
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

/*팀 셀렉트 박스 변경 시 담당엔지니어 정보변경 이벤트*/
function edit_team_select_change_event(value){	
	var userTeam =  $("#edit_team_list_select_"+value+"").val();
	
	$("#cusId_hidden_id").val(value);

	ICustomerService.getUsermember(userTeam,editCusUser1Callback); 
}

/*계약조건 셀렉트 박스 변경 시 방문주기 변경 이벤트*/
function edit_supo_select_change_event(value){	
	var supoState =  $("#edit_supo_list_select_"+value+"").val();
	
	$("#cusId_hidden_id").val(value);

	ICustomerService.getSupovisit(supoState,editsupoVisitCallback); 
}

/* 고객사 리스트 정보 총 row 정보 가져오기에 대한 응답 데이터 처리(tfoot 처리)*/
function NcountCallBack(res){
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
}

function editCusUser1Callback(res){
	/* alert("리턴메시지"+$("#cusId_hidden_id").val());  */
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
}


function editsupoVisitCallback(res){
	/* alert("리턴메시지"+$("#cusId_hidden_id").val());  */
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
}

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
<div class="row">
<form id="form1" method="post" action="customer_edit_next">	 	
	 <div class="column side">
		   <h4>고객사 관리 페이지</h4></br>
		   <a href="#" id="cus_managed">고객사 관리</a></br>		    
		   <a href="#" id="cus_insert">고객사 등록</a></br>
	<!-- 	   <a href="#" id="cus_edit">고객사 </p>기본정보 수정</a></br>	    -->
		   <!-- <a href="#" id="cus_edit1">고객사 </p>계약정보 수정</a></br> -->
	 </div>
	 <div class="column middle">
	 	<div align="center"><h3>고객사 리스트 정보</h3></div>
	 	<%-- <input type="hidden" id="lastBoardNo" value ="${cus_list[fn:length(cus_list)-1].boardNo}"/> --%>
		<input type="hidden" id="nowPage" name="pageNo" value="${nowPage}"/>
		<input type="hidden" id="cusId_hidden_id" name="cusId_hidden_name" value=""/>
		<input type="hidden" id="userId_hidden_id" value=""/>				
	 	</br>
	 	<table>
	 	<tr>
	 	<td>
		 	<div>	 		
		 		<!-- <label for="cus_select1" class="a11y-hidden">분류</label>  -->
		 	<%--     <select id="cus_select1" name="supoState">
						<option value="0" selected>전체</option>
						 <c:forEach var="sl" items="${supo_list}">
		 	    			<option value="${sl.supoId}">${sl.supoNm}</option>		 	    	
		 	    		</c:forEach>
				</select> --%>
			</div>
	 	</td>
	 	<td>	 	  
		 	<div>	 		 	
		<%--  	    <select id="cus_select2" name="userDept">
		 	   		 <option value="0">전체</option>
		 	   		 <c:forEach var="dl" items="${dept_list}">
		 	    		<option value="${dl.deptId}"<c:if test="${cus_list[0].userDept == dl.deptNm}">selected</c:if>>${dl.deptNm}</option>		 	    	
		 	    	</c:forEach>		 	    		 			
				</select> --%>
			</div>
	 	</td>
	 	<td>
		<%--  	<div>	
		 	    <select id="cus_select3" name="userDbms">
						<option value="0" selected>전체</option>
						<c:forEach var="dbl" items="${dbms_list}">
		 	    			<option value="${dbl.dbmsId}"<c:if test="${cus_list[0].userDbms == dbl.dbmsNm}">selected</c:if>>${dbl.dbmsNm}</option>		 	    	
		 	    		</c:forEach>	
				</select>
			</div> --%>
	 	</td>
	 <!-- 	<td>&nbsp;&nbsp;</td> -->
	 	<td>
	 		<div>
	 			<select id="cus_select4" name="selectBtnVal">
	 					<option value="0" selected>검색조건없음</option>
						<option value="1">고객사</option>						
						<option value="3">영업대표</option>
				</select>
	 		</div>
	 	</td>
	 	<td>	 		
		 	<div>			 		
		 	    <input type="text" id="select_text" name="selectTextVal" value="검색 조건을 선택하세요."></input>
		 	    <input type="button" id="select_btn" value="검색"></input>
			</div>
	 	</td>	 
	 	</tr>
	 	</table> 	
	
		<div id="customer_list">		
		 	
			<table id="cus_list">	
				<thead id="cus_list_th">
					<tr>
						<td>전체선택</br><input style="width:20px;" type="checkbox"  id="checkall"/></td>
						<td><p>고객사명</p></td>
						<td><p>프로젝트명</p></td>
						<td>고객명</td>
						<td>고객 연락처</td>
						<td>고객 이메일</td>
						<td>고객사 위치</td>
						<td>담당영업대표</td>																	
						<td>비고</td>
					</tr>					
				</thead>
				<tbody id="cus_list_tb">
					<c:forEach var="cli" items="${cus_list_info}">											
						<tr>
							<td><input type="checkbox" name="chk" id="checkbox_id" value="${cli.proId}"/>
						<%-- 	<input type="hidden" id="checkbox_hidden_id_${cli.proId}" value="${cli.proId}"/>	 --%>							
							</td>						
							<td>${cli.cusNm}</td>
							<td>${cli.proNm}</td>							
							<td>
								<input type="hidden" id="select_cus_hidden_id_${cli.proId}" value=""/>
								<select id="edit_cus_list_select_${cli.proId}" onchange="edit_cus_select_change_event(${cli.proId})">
									<c:if test="${cli.cus1Nm == ''}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="cmli" items="${cus_member_list_info}">										
									 	    <c:if test="${cli.cusId  == cmli.cusId}"> 
												<c:choose>
													<c:when test="${cli.cus1Nm == cmli.cususerNm}">
														<option value="${cmli.cususerId}" selected>${cmli.cususerNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${cmli.cususerId}">${cmli.cususerNm}</option>	
													</c:otherwise>
												</c:choose>		
										    </c:if>			 																	
									</c:forEach>			
								</select> 										
							</td>
							<td>
								<p id="edit_cus_phone_${cli.proId}"> ${cli.cus1Phone}</p>			
							</td>							
											
							<td>
								<p id="edit_cus_mail_${cli.proId}">${cli.cus1Mail}</p>	
							</td>
							
							<td>
								<input type="text" id="cuslocation_id_${cli.proId}" value="${cli.cusLoca}">								
							</td>																		
					
							<td>
								<%-- <input type="hidden" id="select_cus_hidden_id_${cli.proId}" value=""/>
								<input type="hidden" id="cusId_hidden_id_${cli.proId}" value=""/> --%>
								<select id="edit_salseman_list_select_${cli.proId}">
									<c:if test="${cli.salseId == '0'}">
										<option value="0" selected>지정필요.</option>
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
							<td><textarea id="etc_id_${cli.proId}" rows="3" cols="30" name="contents">${cli.etc}</textarea></td>
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
						<td colspan="3">
							  <input type="password" placeholder="정보 수정 비밀번호 입력." id="editPw" required>&nbsp;&nbsp;
							  <input type="button" id="edit_update_btn" value="변경"></input>
						</td>
					</tr>					
				</tfoot>
	 		</table>	
	 		
		</div>
	</div>
	</form>
</div>
<c:import url="/main_botview"></c:import>
</body>
</html>


