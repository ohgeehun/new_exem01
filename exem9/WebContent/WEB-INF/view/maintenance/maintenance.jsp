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
<form method="post" action="maintenance_edit_next">	 	
	 <div class="column side">
		   <h4>유지보수 관리 페이지</h4></br>
		   <a href="#" id="mat_managed">유지보수 관리</a></br>		    
		   <a href="#" id="mat_insert">유지보수 등록</a></br>		 
	 </div>
	 
	 <div class="column middle">
	 	<div align="center"><h3>유지보수 리스트 정보</h3></div>
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
		 	    <select id="cus_select1" name="supoState">
						<option value="0" selected>전체</option>
						<%--  <c:forEach var="sl" items="${supo_list}">
		 	    			<option value="${sl.supoId}">${sl.supoNm}</option>		 	    	
		 	    		</c:forEach> --%>
				</select>
			</div>
	 	</td>
	 	<td>	 	  
		 	<div>	 		 	
		 	    <select id="cus_select2" name="userDept">
		 	   		 <option value="0">전체</option>
		 	   		<%--  <c:forEach var="dl" items="${dept_list}">
		 	    		<option value="${dl.deptId}"<c:if test="${cus_list[0].userDept == dl.deptNm}">selected</c:if>>${dl.deptNm}</option>		 	    	
		 	    	</c:forEach>	 --%>	 	    		 			
				</select>
			</div>
	 	</td>
	 	<td>
		 	<div>	
		 	    <select id="cus_select3" name="userDbms">
						<option value="0" selected>전체</option>
						<%-- <c:forEach var="dbl" items="${dbms_list}">
		 	    			<option value="${dbl.dbmsId}"<c:if test="${cus_list[0].userDbms == dbl.dbmsNm}">selected</c:if>>${dbl.dbmsNm}</option>		 	    	
		 	    		</c:forEach>	 --%>
				</select>
			</div>
	 	</td>
	 	<td>&nbsp;&nbsp;</td>
	 	<td>
	 		<div>
	 			<select id="cus_select4" name="selectBtnVal">
	 					<option value="0" selected>검색조건없음</option>
						<option value="1">고객사</option>
						<option value="2">담당 엔지니어</option>
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
						<td><p style="width:50px;">고객사명</p></td>
						<td><p style="width:60px;">프로젝트명</p></td>
						<td>담당부서</td>
						<td>업무</td>
						<td>담당 엔지니어(정)</td>
						<td>담당 엔지니어(부)</td>
						<td>영업대표</td>
						<td>최초설치일</td>
						<td>계약상태</td>
						<td>방문주기</td>						
						<td>시작일</td>
						<td>종료일</td>
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
							<%-- <td>${cli.deptNm}</td> --%>							
							<td>
								<input type="hidden" id="select_team_hidden_id_${cli.proId}" value=""/>
								<input type="hidden" id="cusId_hidden_id_${cli.proId}" value=""/>
								<select id="edit_team_list_select_${cli.proId}" name="select_event" onchange="edit_team_select_change_event(${cli.proId})">
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
								<select id="edit_dbms_list_select_${cli.proId}">
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
								<select id="edit_user1_list_select_${cli.proId}" name="select_event">
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
								<select id="edit_user2_list_select_${cli.proId}" name="select_event">
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
								<select id="edit_salseman_list_select_${cli.proId}">
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
							<td><input id="supoInsDate_id_${cli.proId}" type="date" value="${cli.supoInsDate}"></td>
							<%-- <td>${cli.supoInsDate}</td> --%>
							<%-- <td>${cli.supoState}</td>  --%>
							<td>
								<select id="edit_supo_list_select_${cli.proId}" name="select_event" onchange="edit_supo_select_change_event(${cli.proId})">
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
								<select id="edit_supoVisit_list_select_${cli.proId}" name="select_event">
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
							<td><input id="supoStartDate_id_${cli.proId}" type="date" value="${cli.supoStartDate}"></td>
							<td><input id="supoEndDate_id_${cli.proId}" type="date" value="${cli.supoEndDate}"></td>							
							<td><textarea id="etc_id_${cli.proId}" rows="3" cols="15" name="contents">${cli.etc}</textarea></td>
						</tr>					
					</c:forEach>										
				</tbody>
				<tfoot id="cus_list_tf"> 
					<tr>
						<td colspan="11">
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


