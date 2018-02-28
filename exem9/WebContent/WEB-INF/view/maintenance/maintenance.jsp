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
    $("#mat_insert").bind("click", function(){	
    	location.href = "maintenance_insert";
    });
});  
</script>

<style>

.tb_search_lmargin {
	margin-left : 320px;
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
	width:135px;
}

.box2_04 {
	width:75px;
}

.box2_05 {
	width:75px;
}

.box2_06 {
	width:95px;
}

.box2_07 {
	width:95px;
}

.box2_08 {
	width:75px;
}

.box2_09 {
	width:75px;
}
.box2_10 {
	width:75px;
}
.box2_11 {
	width:75px;
}
.box2_12 {
	width:75px;
}
.box2_13 {
	width:75px;
}
.box2_14 {
	width:175px;
}
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
<form method="post" action="maintenance_edit_next">	 	
	 <!-- div class="column side">
		   <h4>유지보수 관리 페이지</h4></br>
		   <a href="#" id="mat_managed">유지보수 관리</a></br>		    
		   <a href="#" id="mat_insert">유지보수 등록</a></br>		 
	 </div-->
	 
	 <div class="top_mainDisplayPart">
	 	
	 	<%-- <input type="hidden" id="lastBoardNo" value ="${cus_list[fn:length(cus_list)-1].boardNo}"/> --%>
		<input type="hidden" id="nowPage" name="pageNo" value="${nowPage}"/>
		<input type="hidden" id="cusId_hidden_id" name="cusId_hidden_name" value=""/>
		<input type="hidden" id="userId_hidden_id" value=""/>		
	 	
	 	<table class="tb_search">
	 	<tr>
	 	<td>
		 		<!-- <label for="cus_select1" class="a11y-hidden">분류</label>  -->
		 	    <select id="cus_select1" name="supoState" class="main_input_box_2 nInputFont tb_search_lmargin fltBox1">
						<option value="0" selected>전체</option>
						<%--  <c:forEach var="sl" items="${supo_list}">
		 	    			<option value="${sl.supoId}">${sl.supoNm}</option>		 	    	
		 	    		</c:forEach> --%>
				</select>
		 	    <select id="cus_select2" name="userDept" class="main_input_box_2 nInputFont fltBox1">
		 	   		 <option value="0">전체</option>
		 	   		<%--  <c:forEach var="dl" items="${dept_list}">
		 	    		<option value="${dl.deptId}"<c:if test="${cus_list[0].userDept == dl.deptNm}">selected</c:if>>${dl.deptNm}</option>		 	    	
		 	    	</c:forEach>	 --%>	 	    		 			
				</select>
		 	    <select id="cus_select3" name="userDbms" class="main_input_box_2 nInputFont fltBox1">
						<option value="0" selected>전체</option>
						<%-- <c:forEach var="dbl" items="${dbms_list}">
		 	    			<option value="${dbl.dbmsId}"<c:if test="${cus_list[0].userDbms == dbl.dbmsNm}">selected</c:if>>${dbl.dbmsNm}</option>		 	    	
		 	    		</c:forEach>	 --%>
				</select>
	 			<select id="cus_select4" name="selectBtnVal" class="main_input_box_2 nInputFont fltBox1">
	 					<option value="0" selected>검색조건없음</option>
						<option value="1">고객사</option>
						<option value="2">담당 엔지니어</option>
						<option value="3">영업대표</option>
				</select>
		 	    <input type="text" id="select_text" name="selectTextVal" value="검색 조건을 선택하세요." class="main_input_box_2 nInputFont"></input>
		 	    <input type="button" id="select_btn" value="검색" class="Btt_search btnSearch"></input>
	 	</td>	 
	 	</tr>
	 	</table> 
	 	
	 		
	
		<div id="customer_list">		
		 	
			<table id="cus_list">	
				<thead id="cus_list_th">
					<tr>
						<td>
							<li class="main_title_box_2 box2_01 nCheckBox">
								<input type="checkbox" id="checkall"/>
							</li>
						</td>
						
						<td><input class="main_title_box_2 box2_02 nTitleFont" value="고객사명" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_03 nTitleFont" value="프로젝트명" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_04 nTitleFont" value="담당부서" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_05 nTitleFont" value="업무" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_06 nTitleFont" value="엔지니어(정)" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_07 nTitleFont" value="엔지니어(부)" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_08 nTitleFont" value="영업대표" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_09 nTitleFont" value="최초설치일" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_10 nTitleFont" value="계약상태" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_11 nTitleFont" value="방문주기" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_12 nTitleFont" value="시작일" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_13 nTitleFont" value="종료일" disabled="disabled"/></td>
						<td><input class="main_title_box_2 box2_14 nTitleFont" value="비고" disabled="disabled"/></td>
					</tr>					
				</thead>
				<tbody id="cus_list_tb">
					<c:forEach var="cli" items="${cus_list_info}">											
						<tr>
							<td>
								<li class="main_title_box_2 box2_01 nCheckBox">
									<input type="checkbox" name="chk" id="checkbox_id" value="${cli.proId}"/>
								</li>
							</td>						
							<td>
								<input type="text" class="main_input_box_2 box2_02 nInputFont" value="${cli.cusNm}"/>
							</td>
							<td>
								<input type="text" class="main_input_box_2 box2_03 nInputFont" value="${cli.proNm}"/>
							</td>
							<td>
								<input type="hidden" id="select_team_hidden_id_${cli.proId}" value=""/>
								<input type="hidden" id="cusId_hidden_id_${cli.proId}" value=""/>
								<select id="edit_team_list_select_${cli.proId}" name="select_event" 
									class="main_input_box_2 box2_04 nInputFont" onchange="edit_team_select_change_event(${cli.proId})" >
									<c:if test="${cli.teamNm == '0'}">
											<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="etl" items="${edit_team_list}">
										<c:choose>
											<c:when test="${etl.teamNm == cli.teamNm}">
												<option value="${etl.teamId}" selected>${etl.teamNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${etl.teamId}">${etl.teamNm}</option>	
											</c:otherwise>
										</c:choose>		
																		
									</c:forEach>	
								</select>
							</td>
							<%-- <td>${cli.dbmsNm}</td> --%>
							<td>
								<select id="edit_dbms_list_select_${cli.proId}" class="main_input_box_2 box2_05 nInputFont">
									<c:forEach var="edl" items="${edit_dbms_list}">
										<c:choose>
											<c:when test="${edl.dbmsNm == cli.dbmsNm}">
												<option value="${edl.dbmsId}" selected>${edl.dbmsNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${edl.dbmsId}">${edl.dbmsNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>	
								</select>
							</td>							
							<%-- <td>${cli.user1Nm}</td> --%>							
							<td>
								<select id="edit_user1_list_select_${cli.proId}" name="select_event" class="main_input_box_2 box2_06 nInputFont">
									<c:if test="${cli.user1Nm eq null}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="eml" items="${edit_member_list}">
										<c:choose>
											<c:when test="${eml.userNm == cli.user1Nm}">
												<option value="${eml.userId}" selected>${eml.userNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${eml.userId}">${eml.userNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>	
								</select>
							</td>
							<%-- <td>${cli.user2Nm}</td> --%>
							<td>
								<select id="edit_user2_list_select_${cli.proId}" name="select_event" class="main_input_box_2 box2_07 nInputFont">
									<c:if test="${cli.user2Nm eq null}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="eml" items="${edit_member_list}">
										<c:choose>
											<c:when test="${eml.userNm == cli.user2Nm}">
												<option value="${eml.userId}" selected>${eml.userNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${eml.userId}">${eml.userNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>	
								</select>
							</td>																		
							<%-- <td>${cli.salseNm}</td> --%>
							<td>
								<select id="edit_salseman_list_select_${cli.proId}" class="main_input_box_2 box2_08 nInputFont">
									<c:if test="${cli.salseNm == '0'}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="esl" items="${edit_salseman_list}">
										<c:choose>
											<c:when test="${esl.userNm == cli.salseNm}">
												<option value="${esl.userId}" selected>${esl.userNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${esl.userId}">${esl.userNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>	
								</select>
							</td>
							<td><input id="supoInsDate_id_${cli.proId}" type="date" value="${cli.supoInsDate}" class="main_input_box_2 box2_09 nInputFont"></td>
							<%-- <td>${cli.supoInsDate}</td> --%>
							<%-- <td>${cli.supoState}</td>  --%>
							<td>
								<select id="edit_supo_list_select_${cli.proId}" name="select_event" 
									class="main_input_box_2 box2_10 nInputFont" onchange="edit_supo_select_change_event(${cli.proId})">
									<c:if test="${cli.supoState eq null}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="esll" items="${edit_supo_list}">
										<c:choose>
											<c:when test="${esll.supoNm == cli.supoState}">
												<option value="${esll.supoId}" selected>${esll.supoNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${esll.supoId}">${esll.supoNm}</option>	
											</c:otherwise>
										</c:choose>										
									</c:forEach>	
								</select>
							</td>						
							<%-- <td>${cli.supoVisit}</td>  --%>
							<td>
								<select id="edit_supoVisit_list_select_${cli.proId}" name="select_event" class="main_input_box_2 box2_11 nInputFont">
									<c:if test="${cli.supoState eq null}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="esvl" items="${edit_supo_visit_list}">
										<c:if test="${esvl.supoNm == cli.supoState}">
											<c:choose>
												<c:when test="${esvl.supoVisitNm == cli.supoVisit}">
													<option value="${esvl.supoVisitId}" selected>${esvl.supoVisitNm}</option>
												</c:when>
												<c:otherwise>
													<option value="${esvl.supoVisitId}">${esvl.supoVisitNm}</option>	
												</c:otherwise>
											</c:choose>		
										</c:if>								
									</c:forEach>	
								</select>
							</td>	
							<%-- <td>${cli.supoStartDate}</td>
							<td>${cli.supoEndDate}</td> --%>
							<td>
								<input id="supoStartDate_id_${cli.proId}" type="date" value="${cli.supoStartDate}" class="main_input_box_2 box2_12 nInputFont">
							</td>
							<td>
								<input id="supoEndDate_id_${cli.proId}" type="date" value="${cli.supoEndDate}" class="main_input_box_2 box2_13 nInputFont">
							</td>							
							<td>
								<textarea id="etc_id_${cli.proId}" name="contents" class="main_input_box_2 box2_14 nInputFont">${cli.etc}</textarea>
							</td>
						</tr>					
					</c:forEach>										
				</tbody>
				<tfoot id="cus_list_tf"> 
					
					<tr>
						<td colspan="14">
						
							<div class="center_div">
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
						<td colspan="14">
							<div class="center_div">
						  		<input type="button" id="edit_update_btn" value="수정" class="inBtt_OK_2"/>
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


