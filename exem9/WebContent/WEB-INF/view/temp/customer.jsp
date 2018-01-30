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
<script src="resources/script/jquery/jquery.prettydropdowns.js"></script> 

<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ICustomerService.js"></script> 
<script type="text/javascript" src="dwr/interface/ICommonService.js"></script> 

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

$(document).ready(function(){  
	
	/* 고객사관리 좌측 버튼 이벤트  : 고객사 관리 버튼 클릭 시 */
    $("#cus_managed").bind("click", function(){	
    	location.href = "customer_edit";
    });
    
    $("#mail_btn").bind("click", function(){	
    /* 	ICommonService.sendMail("pjh@ex-em.com","pjh@ex-em.com","테스트메일입니다.","테스트내용입니다.",sendMailCallBack); */
    });
    
    /* 고객사관리 좌측 버튼 이벤트  : 고객사 수정 버튼 클릭 시 */
/*     $("#cus_edit").bind("click", function(){	
    	location.href = "customer_edit";
    }); */
    
/*     $("#cus_edit1").bind("click", function(){	
    	location.href = "customer_edit1";
    }); */
    
    
    /* 고객사관리 좌측 버튼 이벤트  : 고객사 수정 버튼 클릭 시 */
    $("#cus_insert").bind("click", function(){	
    	location.href = "customer_insert";
    });
        
    /* 조회조건 설정 후 검색버튼 클릭 시 이벤트*/
    $("#select_btn").bind("click", function(){	
    	
    	if($("#select_text").val() == "검색 조건을 선택하세요."){
    		$("#select_text").val("");
    	}
    	
    	if($("#cus_select4").val() == 0){
    		$("#userId_hidden_id").val(userId);    	    		
    	}else{
    		$("#userId_hidden_id").val(""); 
    	}
    	
  /*   	$("#userId_hidden_id").val(); */
    	
    	/* 고객사 리스트 정보 가져오기 */
    	ICustomerService.getcusinfo($("#userId_hidden_id").val(),$("#cus_select1").val(),$("#cus_select2").val(),$("#cus_select3").val(),$("#cus_select4").val(),$("#select_text").val(),$("#nowPage").val(),cusinfoCallBack);
    	
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
    	
    	/* 고객사 리스트 정보 가져오기 */
    	ICustomerService.getcusinfo($("#userId_hidden_id").val(),$("#cus_select1").val(),$("#cus_select2").val(),$("#cus_select3").val(),$("#cus_select4").val(),$("#select_text").val(),$("#nowPage").val(),cusinfoCallBack);
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
    	
    	/* 고객사 리스트 정보 가져오기 */
    	ICustomerService.getcusinfo($("#userId_hidden_id").val(),$("#cus_select1").val(),$("#cus_select2").val(),$("#cus_select3").val(),$("#cus_select4").val(),$("#select_text").val(),$("#nowPage").val(),cusinfoCallBack);
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
    	
    	/* 고객사 리스트 정보 가져오기 */
    	ICustomerService.getcusinfo($("#userId_hidden_id").val(),$("#cus_select1").val(),$("#cus_select2").val(),$("#cus_select3").val(),$("#cus_select4").val(),$("#select_text").val(),$("#nowPage").val(),cusinfoCallBack);
    });
});

/* 고객사 리스트 정보 가져오기에 대한 응답 데이터 처리(tbody 처리)*/
function cusinfoCallBack(res){
	
	var resHtml = "";		

	for(var i = 0; i < res.length; i++){	
		resHtml += "<tr>";
		resHtml += "	<td>";
		resHtml += 			res[i].cusNm;
		resHtml += "	</td>";
		resHtml += "	<td>";
		resHtml += 			res[i].proNm;
		resHtml += "	</td>";
		if (res[i].teamNm == null){
			resHtml += "	<td></td>";
		}else if(res[i].teamNm == 0){
			resHtml += "	<td></td>";
		}else{
			resHtml += "	<td>"+res[i].teamNm+"</td>";	
		}	
		
		if (res[i].dbmsNm == null){
			resHtml += "	<td></td>";
		}else if(res[i].dbmsNm == 0){
			resHtml += "	<td></td>";
		}else{
			resHtml += "	<td>"+res[i].dbmsNm+"</td>";	
		}	
		
		if (res[i].user1Nm == null){
			resHtml += "	<td></td>";
		}else{
			resHtml += "	<td>"+res[i].user1Nm+"</td>";	
		}
		
		if (res[i].user2Nm == null){
			resHtml += "	<td></td>";
		}else{
			resHtml += "	<td>"+res[i].user2Nm+"</td>";	
		}

		if (res[i].salseNm == null){
			resHtml += "	<td></td>";
		}else{
			resHtml += "	<td>"+res[i].salseNm+"</td>";	
		}
		
		if (res[i].supoInsDate == null){
			resHtml += "	<td></td>";
		}else{
			resHtml += "	<td>"+res[i].supoInsDate+"</td>";	
		}
		if (res[i].supoState == null){
			resHtml += "	<td></td>";
		}else if(res[i].supoState == 0){
			resHtml += "	<td></td>";
		}else{
			resHtml += "	<td>"+res[i].supoState+"</td>";	
		}
		
		if (res[i].supoVisit == null){
			resHtml += "	<td></td>";
		}else if(res[i].supoVisit == 0){
			resHtml += "	<td></td>";
		}else{
			resHtml += "	<td>"+res[i].supoVisit+"</td>";	
		}
		
		if (res[i].supoStartDate == null){
			resHtml += "	<td></td>";
		}else{
			resHtml += "	<td>"+res[i].supoStartDate+"</td>";	
		}
		if (res[i].supoEndDate == null){
			resHtml += "	<td></td>";
		}else{
			resHtml += "	<td>"+res[i].supoEndDate+"</td>";	
		}
		if (res[i].etc == null){
			resHtml += "<td><textarea rows='3' cols='10' name='contents' readonly='readonly'></textarea></td>";
		}else{
			resHtml += "<td><textarea rows='3' cols='10' name='contents' readonly='readonly'>"+res[i].etc+"</textarea></td>";
		}			
		resHtml += "</tr>";
	}
	$("#cus_list_tb").html(resHtml);
	
	/* 고객사 리스트 정보 총 row 정보 가져오기*/
	ICustomerService.getNCount($("#userId_hidden_id").val(),$("#cus_select1").val(),$("#cus_select2").val(),$("#cus_select3").val(),$("#cus_select4").val(),$("#select_text").val(),$("#nowPage").val(), NcountCallBack);	
}

/* 고객사 리스트 정보 총 row 정보 가져오기에 대한 응답 데이터 처리(tfoot 처리)*/
function NcountCallBack(res){
	$("#nowPage").val(res.nowPage);
		var resHtml = "";
		resHtml += "<tr>";
		resHtml += "	<td colspan='13'>";
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
	    resHtml += "</tr>";
    $("#cus_list_tf").html(resHtml);
}

/*검색 텍스트 처리 이벤트*/
$(function() {
    var input = $('input[type=text]');
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
 
function sendMailCallBack(res){
	if(res == "FAILED"){
		alert("실패");
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "customer";
	}
}
</script>

<style>

#customer_list td,tr {    
    border: 2px solid #ddd;
    text-align: center;
    padding-top: 5px;
    padding-bottom: 5px;
    padding-right: 15px;
    padding-left: 15px;
    font-size: 10px;
}

</style>

</head>
<body>
<c:import url="/main_upview"></c:import>
<div class="row">
	 <div class="column side">
		   <h4>고객사 관리 페이지</h4></br>
		   <a href="#" id="cus_managed">고객사 관리</a></br>		    
		   <a href="#" id="cus_insert">고객사 등록</a></br>
		<!--    <a href="#" id="cus_edit">고객사 </p>기본정보 수정</a></br>	   
		   <a href="#" id="cus_edit1">고객사 </p>계약정보 수정</a></br> -->
		 
	 </div>
	 <div class="column middle">
	  
	 	<div align="center"><h3>고객사 리스트 정보</h3></div>
	 	<%-- <input type="hidden" id="lastBoardNo" value ="${cus_list[fn:length(cus_list)-1].boardNo}"/> --%>
		<input type="hidden" id="nowPage" name="nowPage" value="${nowPage}"/>
		<input type="hidden" id=userId_hidden_id value=""/>
	 	</br>
	 	<table>
	 	<tr>
	 	<td>
		 	<div>	 		
		 		<!-- <label for="cus_select1" class="a11y-hidden">분류</label> --> 
		 	    <select id="cus_select1" name="cus_select1">
						<option value="0" selected>전체</option>
						 <c:forEach var="sl" items="${supo_list}">
		 	    			<option value="${sl.supoId}">${sl.supoNm}</option>		 	    	
		 	    		</c:forEach>
				</select>
			</div>
	 	</td>
	 	<td>	 	  
		 	<div>	 		 	
		 	    <select id="cus_select2" name="cus_select2">
		 	   		 <option value="0">전체</option>
		 	   		 <c:forEach var="dl" items="${dept_list}">
		 	    		<option value="${dl.deptId}"<c:if test="${cus_list[0].userDept == dl.deptNm}">selected</c:if>>${dl.deptNm}</option>		 	    	
		 	    	</c:forEach>		 	    		 			
				</select>
			</div>
	 	</td>
	 	<td>
		 	<div>	
		 	    <select id="cus_select3" name="cus_select3">
						<option value="0" selected>전체</option>
						<c:forEach var="dbl" items="${dbms_list}">
		 	    			<option value="${dbl.dbmsId}"<c:if test="${cus_list[0].userDbms == dbl.dbmsNm}">selected</c:if>>${dbl.dbmsNm}</option>		 	    	
		 	    		</c:forEach>	
				</select>
			</div>
	 	</td>
	 	<td>&nbsp;&nbsp;</td>
	 	<td>
	 		<div>
	 			<select id="cus_select4" name="cus_select4">
	 					<option value="0" selected>검색조건없음</option>
						<option value="1" >고객사</option>
						<option value="2">담당 엔지니어</option>
						<option value="3">영업대표</option>
				</select>
	 		</div>
	 	</td>
	 	<td>	 		
		 	<div>			 		
		 	    <input type="text" id="select_text" value="검색 조건을 선택하세요."></input>
		 	    <input type="button" id="select_btn" value="검색"></input>
			</div>
	 	</td>	 
 	 	<td>	 		
		 	<div>		
		 	    <input type="button" id="mail_btn" value="메일발송"></input>
			</div>
	 	</td>	 
	 	</tr>
	 	</table> 		 	
		<div id="customer_list">		
			<table id="cus_list">	
				<thead id="cus_list_th">
					<tr>
						<td>고객사명</td>
						<td>프로젝트명</td>
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
							<td>${cli.cusNm}</td>
							<td>${cli.proNm}</td>
							<%-- <td>${cli.deptNm}</td> --%>
							<%-- <td>${cli.teamNm}</td> --%>
							<c:choose>
									<c:when test="${cli.teamNm == '0'}">
										<td></td>
									</c:when>
									<c:otherwise>
										<td>${cli.teamNm}</td>
									</c:otherwise>
							</c:choose>			
							<%-- <td>${cli.dbmsNm}</td> --%>	
							<c:choose>
									<c:when test="${cli.dbmsNm == '0'}">
										<td></td>
									</c:when>
									<c:otherwise>
										<td>${cli.dbmsNm}</td>
									</c:otherwise>
							</c:choose>						
							<td>${cli.user1Nm}</td>							
							<td>${cli.user2Nm}</td>												
							<td>${cli.salseNm}</td>				
							<td>${cli.supoInsDate}</td>							
							<%-- <td>${cli.supoState}</td> --%>
							<c:choose>
									<c:when test="${cli.supoState == '0'}">
										<td></td>
									</c:when>
									<c:otherwise>
										<td>${cli.supoState}</td>
									</c:otherwise>
							</c:choose>	
						<%-- 	<td>${cli.supoVisit}</td> --%>
							<c:choose>
									<c:when test="${cli.supoVisit == '0'}">
										<td></td>
									</c:when>
									<c:otherwise>
										<td>${cli.supoVisit}</td>
									</c:otherwise>
							</c:choose>	
							<td>${cli.supoStartDate}</td>
							<td>${cli.supoEndDate}</td>
							<td><textarea rows="3" cols="10" name="contents" readonly="readonly">${cli.etc}</textarea></td>
						</tr>					
					</c:forEach>										
				</tbody>
				<tfoot id="cus_list_tf"> 
					<tr>
						<td colspan="13">
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
					</tr>					
				</tfoot>
	 		</table>	
		</div>
	</div>
</div>
<c:import url="/main_botview"></c:import>
</body>
</html>


