<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.min.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.css" media="all" /> 
<title>Insert title here</title>

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>

<script type="text/javascript" src="resources/script/jquery/moment.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/fullcalendar.min.js"></script>
<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<!-- <script type="text/javascript" src="dwr/interface/IMypageService.js"></script> -->

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

var temp = [];
$(document).ready(function(){

	$("#sch_insert").bind("click", function(){	
	   	location.href = "schedule_insert";
	});
	
	$("#my_sch").bind("click", function(){	
	   	location.href = "my_schedule";
	});
	
	$("#team_sch").bind("click", function(){	
	   	location.href = "team_schedule";
	});
});
 			
</script>

<script>
$(function(){

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
/*
#customer_list td,tr { table-layout: fixed;  }
#customer_list tr { border-bottom:1px solid #e9e9e9; }
#customer_list thead td, th {border-left: 1px solid #f2f2f2; border-right: 1px solid #d5d5d5; background: #ddd url("../images/sprites4.png") repeat-x scroll 0 100% ; font-weight: bold; text-align:center;}
#customer_list tr td, th { border:1px solid #D5D5D5; padding:5px;}
#customer_list tr:hover { background:#fcfcfc;}
#customer_list tr ul.actions {margin: 0;}
#customer_list tr ul.actions li {display: inline; margin-right: 5px;}
*/
</style>

</head>

<body>
<c:import url="/main_upview"></c:import>
<div class="row">
	 <div class="column side">
		   <h4>일정 관리 페이지</h4></br>
		   <a href="#" id="sch_insert">일정 등록</a></br>
		   <a href="#" id="my_sch">내 일정 보기</a></br>		    
		   <a href="#" id="team_sch">팀 일정 보기</a></br>
	 </div>
	 
	 
	 <div class="column middle">
	 	<div align="center"><h3>내 일정 정보</h3></div>
	 	
		<input type="hidden" id="nowPage" name="pageNo" value="${nowPage}"/>
		<input type="hidden" id="userId_hidden_id" value=""/>				
	 	</br>
	 	
	 	<table>
	 	<tr>
	 	<td>
	 		<div>
	 			<select id="cus_select4" name="selectBtnVal">
	 					<option value="0" selected>검색조건없음</option>
						<option value="1">로그인ID</option>						
						<option value="2">이름</option>
						<option value="3">부서</option>
						<option value="4">팀</option>
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
						<td>전체선택</br>
						<input style="width:20px;" type="checkbox"  id="checkall"/></td>
						<td><p>고객사명</p></td>
						<td><p>프로젝트 명</p></td>
						<td>지원일시<br>(시작)</td>
						<td>지원일시<br>(종료)</td>
						<td>지원 유형(범주)</td>
						<td>요청내역 및 지원목적</td>
					</tr>					
				</thead>
				<tbody id="cus_list_tb">
					<c:forEach var="sch" items="${sch_list}">											
						<tr>
							<td>
								<input type="checkbox" name="chk" value="${sch.schId}"/>
							</td>						
							<td>
								${sch.schCusNm}
							</td>
							<td>
								${sch.schPjtNm}						
							</td>							
							<td>
								${sch.start_time}	
							</td>
							<td>
								${sch.end_time}
							</td>
							<td>
								<select>
									<c:if test="${sch.category_name == ''}">
										<option value="0" selected>지정필요.</option>
									</c:if>
									<c:forEach var="cat" items="${cat_list}">
												<c:choose>
													<c:when test="${cat.catId  == sch.category_id}">
														<option value="${cat.catId}" selected>${cat.catNm}</option>
													</c:when>
													<c:otherwise>
														<option value="${cat.catId}">${cat.catNm}</option>	
													</c:otherwise>
												</c:choose>
									</c:forEach>			
								</select>
							</td>
							<td>
								${sch.contents}										
								</select>
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
						<td colspan="1">
							  <input type="password" placeholder="정보 수정 비밀번호 입력." id="editPw" required>&nbsp;&nbsp;
							  <input type="button" id="edit_update_btn" value="변경"></input>
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

