<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" /> 
<link rel="stylesheet" type="text/css" href="./resources/css/maintenance/maintenance.css" media="all" ></link>
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.min.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/jquery/jquery.datetimepicker.min.css">


<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<!-- <script src="resources/script/jquery/jquery-latest.min.js"></script> 
<script src="resources/script/jquery/jquery.prettydropdowns.js"></script>  -->
<script type="text/javascript" src="resources/script/jquery/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/moment.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/fullcalendar.min.js"></script>

<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ICustomerService.js"></script>
<script type="text/javascript" src="dwr/interface/IMatService.js"></script> 

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

$(document).ready(function(){  
	
	// dateTimePicker 한글화
	$.datetimepicker.setLocale('ko');
	
	// dateTimePicker moment.js와 연동. 시간 단위로 선택하도록 설정하는 작업
 	$.datetimepicker.setDateFormatter({	
		
	    parseDate: function (date, format) {
	        var d = moment(date, format);
	        return d.isValid() ? d.toDate() : false;
	    },
	 
	    formatDate: function (date, format) {
	        return moment(date).format(format);
	    }
	       
	});
	
    // datetimepicker 선택시 팝업창 표시
    $('.datetimepicker').datetimepicker({
          format:'YYYY-MM-DD',
          formatTime:'HH:mm',
          formatDate:'YYYY-MM-DD'
    });
	
    $("#mat_insert").bind("click", function(){	
    	location.href = "maintenance_insert";
    });
	
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
	
	// 이전에 선택된 검색조건의 필터항목을 유지하기 위한 처리
	$("#mat_select4").val("${selectBtnVal}");
	
	// 등록내용 수정
	$("#edit_update_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("수정할 행을 선택하세요.");
		} else{
			
	   	    $('#checkbox_id:checked').each(function() {   	    
   	    	    var chkId = $(this).val();

   	         	var custId = $("#edit_cust_list_select_"+chkId+" option:selected").val();
   	         	var pjtId = $("#edit_pjt_list_select_"+chkId+" option:selected").val();
   	         	var cususerId = $("#edit_cususer_list_select_"+chkId+" option:selected").val();
   	         	var dbmsId = $("#edit_dbms_list_select_"+chkId+" option:selected").val();
   	         	var user1Id = $("#edit_user1_list_select_"+chkId+" option:selected").val();
   	         	var user2Id = $("#edit_user2_list_select_"+chkId+" option:selected").val();
   	         	var salesmanId = $("#edit_salseman_list_select_"+chkId+" option:selected").val();
   	         	var installDay = $("#supoInsDate_id_"+chkId).val();
   	         	var contractId = $("#edit_supo_list_select_"+chkId+" option:selected").val();
	         	var visitId = $("#edit_supoVisit_list_select_"+chkId+" option:selected").val();
   	         	var startDay = $("#supoStartDate_id_"+chkId).val();
   	        	var endDay = $("#supoEndDate_id_"+chkId).val();
   	      		var etc = $("#etc_id_"+chkId).val();
   	         	
   	         	console.debug(" | " + custId + " | " + pjtId + " | " +cususerId + " | " +dbmsId + " | " + user1Id + " | " + 
   	         			user2Id + " | " + salesmanId + " | " +installDay + " | " + contractId + " | " + visitId + " | " + 
   	         			startDay + " | " + endDay + " | " + etc + " | " + chkId );
   	         	
   	         	IMatService.updateMatinfo(custId, pjtId, cususerId, dbmsId, 
							user1Id, user2Id,  salesmanId, installDay, contractId, visitId, startDay, endDay, etc,
							chkId,
							updateMatinfoCallBack);
	   	    });	
		}
	});
	
	// 삭제 처리
	$("#edit_delete_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("삭제할 행을 선택하세요.");
		} else{
			
	   	    $('#checkbox_id:checked').each(function() {   	    
   	    	    var chkId = $(this).val();

	   	    	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
	 				
	 		   	    $('#checkbox_id:checked').each(function() {   	    
	 	   	    	    var chkId = $(this).val();
							
		 	   	    		IMatService.deleteMatinfo( 
		   	         			chkId, 
		   	         			deleteMatinfoCallBack );
	 		   	    });
	 			
	 			}else{   //취소
	 			    return;
	 			}
   	         	
	   	    });	
		}
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
    
    // 검색어 입력 후 엔터처리
    $("#select_text").keypress(function (e) {
    	if (e.which == 13){
    		$("#select_btn").click();  // 실행할 이벤트
 		}
    });
	
	/*페이지 처리(이전 버튼 이벤트 )*/
    $("#backVal").live("click", function(){
    	
    	$("#nowPage").val($("#nowPage").val() - 1);    	
    	
    	$("#form1").submit();	
    	
    });
    
    /*페이지 처리(다음 버튼 이벤트 )*/
    $("#nextVal").live("click", function(){
    	
    	$("#nowPage").val($("#nowPage").val()*1 + 1);
    	
    	$("#form1").submit();	
    });

    /*페이지 처리(페이지 숫자 버튼 이벤트 )*/
    $("a[name='moreArea']").live("click", function(){
    	
    	$("#nowPage").val($(this).attr("id"));
    	
    	$("#form1").submit();	
    });
	
});

function deleteMatinfoCallBack(res){
	if(res == "FAILED"){
		alert("실패");
		location.href = "maintenance";
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "maintenance";
	}
}

function updateMatinfoCallBack(res){
	if(res == "FAILED"){
		//alert("실패");
		location.href = "maintenance";
	}else if(res == "SUCCESS"){
		//alert("성공");
		location.href = "maintenance";
	}
}

</script>

<style>

</style>

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

<form id="form1" method="post" action="maintenance_next">	 	
	 <!-- div class="column side">
		   <h4>유지보수 관리 페이지</h4></br>
		   <a href="#" id="mat_managed">유지보수 관리</a></br>		    
		   <a href="#" id="mat_insert">유지보수 등록</a></br>		 
	 </div-->
	 
	 <div class="top_mainDisplayPart">
	 	<div align="center"><h3>유지보수 관리 페이지</h3></div>
	 	
	 	<%-- <input type="hidden" id="lastBoardNo" value ="${cus_list[fn:length(cus_list)-1].boardNo}"/> --%>
		<input type="hidden" id="nowPage" name="pageNo" value="${nowPage}"/>
		<input type="hidden" id="cusId_hidden_id" name="cusId_hidden_name" value=""/>
		<input type="hidden" id="userId_hidden_id" value=""/>		
	
		<div id="maintenance_list">		
			<table id="mat_list">	
				<thead id="mat_list_th">
					<tr>
					 	<td colspan="14" class="left_align">
					 			<select id="mat_select4" name="selectBtnVal" class="search_filter_box nInputFont fltBox1">
					 					<option value="0" selected>전체</option>
										<option value="1">고객사</option>
										<option value="2">프로젝트명</option>
										<option value="3">제품(업무)</option>
										<option value="4">담당 엔지니어(정/부)</option>
										<option value="5">영업대표</option>
										<option value="6">계약상태</option>
								</select>
						 	    <input type="text" id="select_text" name="selectTextVal" placeholder="검색조건을 입력하세요." value="${selectTextVal}" class="search_filter_box nInputFont"></input>
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
						
						<td><input class="main_title_box_2 box2_02 nTitleFont" value="고객사명" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_03 nTitleFont" value="프로젝트명" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_04 nTitleFont" value="고객명" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_05 nTitleFont" value="제품(업무)" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_06 nTitleFont" value="엔지니어(정)" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_07 nTitleFont" value="엔지니어(부)" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_08 nTitleFont" value="영업대표" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_09 nTitleFont" value="최초설치일" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_10 nTitleFont" value="계약상태" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_11 nTitleFont" value="방문주기" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_12 nTitleFont" value="시작일" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_13 nTitleFont" value="종료일" disabled="disabled"></td>
						<td><input class="main_title_box_2 box2_14 nTitleFont" value="비고" disabled="disabled"></td>
					</tr>					
				</thead>
				<tbody id="mat_list_tb">
					<c:forEach var="mat" items="${mat_list}">											
						<tr>
							<td>
							<ul>
								<li class="main_title_box_2 box2_01 nCheckBox">
									<input type="checkbox" name="chk" id="checkbox_id" value="${mat.matId}"/>
								</li>
							</ul>
							</td>						
							<td>
								<!-- input type="text" class="main_input_box_2 box2_02 nInputFont" value="${mat.custId}"-->
								
								<select id="edit_cust_list_select_${mat.matId}" name="custId" 
									class="main_input_box_2 box2_02 nInputFont">
									<c:if test="${mat.custId == '0'}">
											<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="cus" items="${cus_list}">
										<c:choose>
											<c:when test="${cus.cusId == mat.custId}">
												<option value="${cus.cusId}" selected>${cus.cusNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${cus.cusId}">${cus.cusNm}</option>	
											</c:otherwise>
										</c:choose>		
																		
									</c:forEach>	
								</select>
								
							</td>
							<td>
								<!-- input type="text" class="main_input_box_2 box2_03 nInputFont" value="${mat.projId}"-->
								
								<select id="edit_pjt_list_select_${mat.matId}" name="pjtId" 
									class="main_input_box_2 box2_03 nInputFont">
									<c:if test="${mat.projId == '0'}">
											<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="pjt" items="${pjt_list}">
										<c:choose>
											<c:when test="${pjt.pjtId == mat.projId}">
												<option value="${pjt.pjtId}" selected>${pjt.pjtNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${pjt.pjtId}">${pjt.pjtNm}</option>	
											</c:otherwise>
										</c:choose>		
																		
									</c:forEach>	
								</select>
								
							</td>
							<td>
								<input type="hidden" id="select_team_hidden_id_${cli.proId}" value="">
								<input type="hidden" id="cusId_hidden_id_${cli.proId}" value="">
								
								<select id="edit_cususer_list_select_${mat.matId}" name="cususer" 
									class="main_input_box_2 box2_04 nInputFont" >
								<%-- 	<c:if test="${mat.cususerId == '0'}">
											<option value="0" selected>지정필요.</option>
									</c:if> --%>
									<c:forEach var="cususer" items="${cususer_list}">
										<c:choose>
											<c:when test="${cususer.matId == mat.matId}">
												<option value="${cususer.cususerId}" selected>${cususer.cususerNm}</option>
											</c:when>
											<%-- <c:otherwise>
												<option value="0" selected>지정필요.</option>
											</c:otherwise> --%>
										</c:choose>		
																		
									</c:forEach>	
								</select>
								
							</td>
							<%-- <td>${cli.dbmsNm}</td> --%>
							<td>
								<select id="edit_dbms_list_select_${mat.matId}" class="main_input_box_2 box2_05 nInputFont">
									<c:forEach var="dbms" items="${dbms_list}">
										<c:choose>
											<c:when test="${dbms.dbmsId == mat.dbmsId}">
												<option value="${dbms.dbmsId}" selected>${dbms.dbmsNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${dbms.dbmsId}">${dbms.dbmsNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>	
								</select>
							</td>							
							<%-- <td>${cli.user1Nm}</td> --%>							
							<td>
								<select id="edit_user1_list_select_${mat.matId}" name="select_event" class="main_input_box_2 box2_06 nInputFont">
									<c:if test="${mat.mem1Id =='0'}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="mem" items="${mem_list}">
										<c:choose>
											<c:when test="${mem.userId == mat.mem1Id}">
												<option value="${mem.userId}" selected>${mem.userNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${mem.userId}">${mem.userNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>	
								</select>
							</td>
							<%-- <td>${cli.user2Nm}</td> --%>
							<td>
								<select id="edit_user2_list_select_${mat.matId}" name="select_event" class="main_input_box_2 box2_07 nInputFont">
									<c:if test="${mat.mem2Id == '0'}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="mem" items="${mem_list}">
										<c:choose>
											<c:when test="${mem.userId == mat.mem2Id}">
												<option value="${mem.userId}" selected>${mem.userNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${mem.userId}">${mem.userNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>	
								</select>
							</td>																		
							<%-- <td>${cli.salseNm}</td> --%>
							<td>
								<select id="edit_salseman_list_select_${mat.matId}" class="main_input_box_2 box2_08 nInputFont">
									<!-- option value="0" selected>${mat.salesmanId}</option-->
								<%-- 	<c:if test="${mat.salesmanId == null}">
										<option value="0" selected>지정필요.</option>
									</c:if> --%>
									<c:forEach var="salman" items="${salesman_list}">
										<c:choose>
											<c:when test="${salman.userId == mat.salesmanId}">
												<option value="${salman.userId}" selected>${salman.userNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${salman.userId}">${salman.userNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>	
								</select>
							</td>
							<td>
								<input id="supoInsDate_id_${mat.matId}" type="text" value="${mat.installDay}" class="main_input_box_2 box2_09 nInputFont datetimepicker">
							</td>
							<%-- <td>${cli.supoInsDate}</td> --%>
							<%-- <td>${cli.supoState}</td>  --%>
							<td>
								<select id="edit_supo_list_select_${mat.matId}" name="select_event" 
									class="main_input_box_2 box2_10 nInputFont" onchange="edit_supo_select_change_event(${mat.matId})">
									<c:if test="${mat.contractId == '0'}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="spll" items="${supo_level_list}">
										<c:choose>
											<c:when test="${spll.supoId == mat.contractId}">
												<option value="${spll.supoId}" selected>${spll.supoNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${spll.supoId}">${spll.supoNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>	
								</select>
							</td>						
							<%-- <td>${cli.supoVisit}</td>  --%>
							<td>
								<select id="edit_supoVisit_list_select_${mat.matId}" name="select_event" class="main_input_box_2 box2_11 nInputFont">
									<c:if test="${mat.visitId == '0'}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="spvl" items="${supo_visit_list}">
										
											<c:choose>
												<c:when test="${spvl.supoVisitId == mat.visitId}">
													<option value="${spvl.supoVisitId}" selected>${spvl.supoVisitNm}</option>
												</c:when>
												<c:otherwise>
													<option value="${spvl.supoVisitId}">${spvl.supoVisitNm}</option>	
												</c:otherwise>
											</c:choose>		
																
									</c:forEach>	
								</select>
							</td>	
							<%-- <td>${cli.supoStartDate}</td>
							<td>${cli.supoEndDate}</td> --%>
							<td>
								<input type="text" id="supoStartDate_id_${mat.matId}" value="${mat.startDay}" class="main_input_box_2 box2_12 nInputFont datetimepicker">
							</td>
							<td>
								<input type="text" id="supoEndDate_id_${mat.matId}" value="${mat.endDay}" class="main_input_box_2 box2_13 nInputFont datetimepicker">
							</td>							
							<td>
								<textarea id="etc_id_${mat.matId}" name="contents" class="main_input_box_2 box2_14 nInputFont">${mat.etc}</textarea>
							</td>
						</tr>					
					</c:forEach>										
				</tbody>
				<tfoot id="mat_list_tf"> 
					
					<tr>
						<td colspan="14" class="center_align">
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
						<td colspan="14" class="center_align">
							<div>
						  		<input type="button" id="edit_update_btn" value="수정" class="inBtt_OK_2"/>
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


