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

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

$(document).ready(function(){  
   
});  
</script>

<style>

</style>

</head>
<body>
<c:import url="/main_upview"></c:import>
<div class="row">
	 <div class="column side">
		   <h4>유저 관리 페이지</h4></br>
		   <a href="#" id="cus_managed">유저 관리</a></br>		    
		   <a href="#" id="cus_insert">유저 등록</a></br>		 
	 </div>
	 <div class="column middle">
	  
	 	<h3>유저 등록 정보</h3>
		<div id="customer_list">		
			<table id="cus_list">	
				<thead id="cus_list_th">
					<tr>
						<td>고객사명*</td>
						<td>							
							<div id="div_cusName_id">
								<input type="hidden" id="cusName_hidden_id" value="0"/>
								<input id='cusName_id' value=""  style='text-transform: uppercase' onblur="onblur_event();"></input>
								<span id="idSpan" class="redText"></span>	
							</div>									
						</td>
					</tr>
					<tr>
						<td>프로젝트명*</td>
						<td><input type='text' id='cusproName_id' value="" style='text-transform: uppercase'>			
						<span id="idSpan1" class="redText"></span>
						</td>	
					</tr>	
					<tr>
						<td>고객명</td>												
						<td><input type="hidden" id="cusNm_hidden_id" value="0"/>
						<input type='text' id='cusNm_id' value=""  style='text-transform: uppercase'></td>															
					</tr>			
					<tr>
						<td>고객 연락처</td>						
						<td><input type='text' id='cusPhone_id' value="" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'></td>															
					</tr>
					<tr>
						<td>고객 이메일</td>						
						<td><input type='text' id='cusMail_id' value=""></td>													
					</tr>		
					<tr>
						<td>고객사 위치</td>						
						<td><input type='text' id='cuslocation_id' value=""  style='text-transform: uppercase'></td>														
					</tr>
					<tr>
						<td>담당영업</td>
						<td>
						<select id='salesman_select_id'>
							<option value="0" selected>지정하지않음.</option>
						    <c:forEach var="dl" items="${dept_list}">
			 	    			<option value="${dl.deptId}">${dl.deptNm}</option>		 	    	
			 	    		</c:forEach>	
						</select>
						</td>									
					</tr>							
				</thead>
				<tbody id="cus_list_tb">
					<tr>
						<td>비고</td>						
						<td><textarea id="etc_id" rows="5" cols="30" name="contents"></textarea></td>													
					</tr>																											
				</tbody>
				<tfoot id="cus_list_tf"> 					
					<tr>	
					<td colspan="2">
						  <input type="password" placeholder="등록 비밀번호 입력." id="editPw" required>&nbsp;&nbsp;
						  <input type="button" id="edit_update_btn" value="등록"></input>
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


