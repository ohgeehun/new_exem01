<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/mypage/mypage.css" media="all" />
<!-- link rel="stylesheet" type="text/css" href="./resources/css/jquery/jquery-ui-1.8.custom.css"/-->

<link rel="stylesheet" type="text/css" media="not all and (max-width:600px)" href="./resources/css/exem_mem.css"/>
<link rel="stylesheet" type="text/css" media="only all and (max-width:600px)" href="./resources/css/exem_mem_m.css"/>

<title>MyPage</title>

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>


<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/IMypageService.js"></script>

<meta name="viewport" content="width=device-width,initial-scale=1.0, user-scalable=no"> 
<style>

@-ms-viewport{width:device-width,initial-scale=1.0, user-scalable=no;}
@-o-viewport{width:device-width,initial-scale=1.0, user-scalable=no;}
@viewport{width:device-width,initial-scale=1.0, user-scalable=no;} 
</style>

<script type="text/javascript">	
	var userId = "<%=(String)session.getAttribute("sUserId")%>";
 	var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";
	var userPosi = "<%=(String)session.getAttribute("sUserPosi")%>"; 
	var userDept = "<%=(String)session.getAttribute("sUserDept")%>";

	$(document).ready(function(){	
		
		//alert(userId + userDbms + userPosi + userDept);

	$("#edit_update_btn").bind("click", function(){		
			
		IMypageService.updateUserInfo2(  
				$("#user_id").val(),
				$("#user_name").val(),
				$("#user_password").val(),
				$("#user_department_id").val(),
				$("#user_team_id").val(),
				$("#user_dbms_id").val(),
				$("#user_position_id").val(),
                $("#user_phone").val(),
                $("#user_mail").val(),
                $("#user_point").val(), UIupdateCallBack);
		
		});		
		
		//IMypageService.getUserinfo(userId, userInfoCallBack);		
		
		$("#UIedit").bind("click", function(){ //개인정보 변경 버튼 클릭
			
			IMypageService.getUserinfo(userId, userInfoCallBack);
		});	
		
		$("#PWedit").bind("click", function(){ //비밀번호 변경 버튼 클릭	 		 
			
			var text = "";
			var text1 = "";
			
			text += "<input type='hidden' id='HD_Btn' value='2'></input>";	
			text += "<tr><td>기존비밀번호</td><td><input type='text' id='userOldPw'/></td></tr>";					
			text += "<tr><td>새비밀번호</td><td><input type='text' id='userNewPw'/></td></tr>";
			text += "<tr><td>새비밀번호확인</td><td><input type='text' id='userNewPwR'/></td></tr>";
					 
			$("#mypageview").html(text);		
		});	
		
		$("#UIeditBtn").bind("click", function(){		
			
			if ($("#HD_Btn").val() == "1"){ //개인정보 변경 시
				if($("#userMail").val() == ""){
					alert("메일을 입력하세요");
					$("#userMail").onfocus();
				}else{
					IMypageService.updateUserInfo(  
							$("#userDbms").val(),
	                        $("#userPosi").val(),
	                        $("#userPhone").val(),
	                        $("#userMail").val(), UIupdateCallBack);				
				}
			}else if ($("#HD_Btn").val() == "2"){ //비밀번호 변경 시 
				if($("#userOldPw").val() == ""){
					alert("기존비밀번호를 입력하세요.");
					$("#userOldPw").onfocus();
				}else if($("#userNewPw").val() == ""){
					alert("새비밀번호를 입력하세요.");
					$("#userNewPw").onfocus();
				}else if($("#userNewPwR").val() == ""){
					alert("새비밀번호를 한번 더 입력하세요.");
					$("#userNewPwR").onfocus();
				}
				
				if ( $("#userNewPw").val() == $("#userNewPwR").val()){
					IMypageService.updateUserPw($("#userOldPw").val(), $("#userNewPw").val(), UIupdateCallBack);
				}else{
					alert("새비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				}
			}			 
		});		
		
	});
	
	function userInfoCallBack(res){	//마이페이지 기본 화면		
		var text = "";		
		
		text += "<input type='hidden' id='HD_Btn' value='1'></input>";	
		text += "<tr><td>로그인ID</td>	<td>"+userId+"</td></tr>";
		text += "<tr><td>이름</td><td>"+res[0].userNm+"</td></tr>";					
		text += "<tr><td>부서</td><td>"+res[0].userDept+"</td></tr>";					
		text += "<tr><td>팀</td><td>"+res[0].userTeam+"</td></tr>";					
		text += "<tr><td>업무</td><td><select id='userDbms'></select>	</td></tr>";
		text += "<tr><td>직급</td><td><select id='userPosi'></select>	</td></tr>";
		if(res[0].userPhone  == null){
			text += "<tr><td>연락처</td><td><input type='text' id='userPhone' value=''></td></tr>";	
		}else{
			text += "<tr><td>연락처</td><td><input type='text' id='userPhone' value="+res[0].userPhone+"></td></tr>";	
		}		 
		text += "<tr><td>메일</td><td><input type='text' id='userMail' value="+res[0].userMail+">@ex-em.com</td></tr>";
		text += "<tr><td>포인트</td><td>"+res[0].userPoint+"</td></tr>";
		
		userDbms = res[0].userDbms;
		userPosi = res[0].userPosi;
		
		IMypageService.getdbms(dbmsCallBack);		
		IMypageService.getposi(posiCallBack);
		
		$("#mypageview").html(text);
	}
	
	function dbmsCallBack(res){	//업무 리스트 셀렉트 박스
		
		var text = "";			
		
		for(var i = 0; i < res.length; i++){
				
			 if(res[i].dbmsNm == userDbms){
				text += "<option value="+res[i].dbmsId+" selected>"+ res[i].dbmsNm+"</option>";
			}else{ 
				text += "<option value="+res[i].dbmsId+">"+res[i].dbmsNm+"</option>";
		 	} 
		}
		
		$("#userDbms").append(text);
	}
	
	function posiCallBack(res){	//직급 리스트 셀렉트 박스
		
		var text = "";	
		
		for(var i = 0; i < res.length; i++){
				
			 if(res[i].posiNm == userPosi){
				text += "<option value="+res[i].posiId+" selected>"+ res[i].posiNm+"</option>";
			}else{ 
				text += "<option value="+res[i].posiId+">"+res[i].posiNm+"</option>";
		 	} 
		}		
		$("#userPosi").append(text);
	}
	
	function UIupdateCallBack(res){ //개인/비밀번호 정보 변경 성공 여부
		if(res == "FAILED"){
			alert("실패");
		}else if(res == "SUCCESS"){
			alert("성공");
		}else if(res == "PW_FAILED"){
			alert("기존 비밀번호가 맞지 않습니다.");
			$("#userOldPw").focus();	
		}else if(res == "PW_SUCCESS"){
			alert("비밀번호를 변경하였습니다.");
			location.href = "mypage";
		}
	}

</script>

</head>
<body>

<c:import url="/main_upview"></c:import>

	<div class="row">
			<div class="top_mainDisplayPart">
			
				<div align="center"><h3>개인정보</h3></div>
				<div class="top_mainDisplayBase" >
				  
				  <ul>
					<li class="input_title input_01 inputTxtFont">로그인ID*</li>
					<li class="input_title input_02 inputTxtFont">이름*</li>
					<li class="input_title input_03 inputTxtFont">패스워드</li>
					<li class="input_title input_04 inputTxtFont">부서</li>
					<li class="input_title input_05 inputTxtFont">팀*</li>
					<li class="input_title input_06 inputTxtFont">업무</li>
					<li class="input_title input_07 inputTxtFont">직급</li>
					<li class="input_title input_08 inputTxtFont">연락처</li>
					<li class="input_title input_09 inputTxtFont">메일</li>
					<li class="input_title input_10 inputTxtFont">포인트</li> 
				  </ul>	
				  
					<input id="user_id" type="text" class="input_txt input1_01 inputTxtFont" value="${mypage_info.userId}" disabled>
					<input id="user_name" type="text" class="input_txt input1_02 inputTxtFont" value="${mypage_info.userNm}">
					<input id="user_password" type="text" class="input_txt input1_03 inputTxtFont" value="" placeholder="********">
					
					<select id='user_department_id' class="input_txt input1_04 inputTxtFont">
		 	    			<c:if test="${mypage_info.userDeptId == ''}">
								<option value="0" selected>지정필요.</option>
							</c:if>
							<c:forEach var="dept" items="${dept_list}">										
										<c:choose>
											<c:when test="${dept.deptId == mypage_info.userDeptId}">
												<option value="${dept.deptId}" selected>${dept.deptNm}</option>
											</c:when>
											<c:otherwise>
												<option value="${dept.deptId}">${dept.deptNm}</option>	
											</c:otherwise>
										</c:choose>		
							</c:forEach>	
					</select>
					<select id='user_team_id' class="input_txt input1_05 inputTxtFont">
							<c:if test="${mypage_info.userTeamId == ''}">
								<option value="0" selected>지정필요.</option>
							</c:if>
							    <c:forEach var="team" items="${team_list}">
							    	<c:choose>
							    		<c:when test="${team.teamId == mypage_info.userTeamId }">
							    			<option value="${team.teamId}" selected>${team.teamNm}</option>	
							    		</c:when>
							    		<c:otherwise>
							    			<option value="${team.teamId}">${team.teamNm}</option>
							    		</c:otherwise>
							    	</c:choose>
				 	    		</c:forEach>	
					</select>
					<!-- input type="text" name="product" class="input_txt input_03 inputTxtFont"-->
					<select id='user_dbms_id' class="input_txt input1_06 inputTxtFont">
		
				 	    	<c:if test="${mypage_info.userDbmsId == ''}">
								<option value="0" selected>지정필요.</option>
							</c:if>
							    <c:forEach var="dbms" items="${dbms_list}">
							    	<c:choose>
							    		<c:when test="${dbms.dbmsId == mypage_info.userDbmsId }">
							    			<option value="${dbms.dbmsId}" selected>${dbms.dbmsNm}</option>	
							    		</c:when>
							    		<c:otherwise>
							    			<option value="${dbms.dbmsId}">${dbms.dbmsNm}</option>
							    		</c:otherwise>
							    	</c:choose>
				 	    		</c:forEach>	
					</select>
					<!-- input type="text" name="support" class="input_txt input_04 inputTxtFont"-->
					<select id='user_position_id' class="input_txt input1_07 inputTxtFont">
				 	    	<c:if test="${mypage_info.userPosiId == ''}">
								<option value="0" selected>지정필요.</option>
							</c:if>
							    <c:forEach var="posi" items="${posi_list}">
							    	<c:choose>
							    		<c:when test="${posi.posiId == mypage_info.userPosiId }">
							    			<option value="${posi.posiId}" selected>${posi.posiNm}</option>	
							    		</c:when>
							    		<c:otherwise>
							    			<option value="${posi.posiId}">${posi.posiNm}</option>
							    		</c:otherwise>
							    	</c:choose>
				 	    		</c:forEach>	
					</select>
					
					<input id="user_phone" type="text" class="input_txt input1_08 inputTxtFont" value="${mypage_info.userPhone}">
					<input id="user_mail" type="text" class="input_txt input1_09 inputTxtFont" value="${mypage_info.userMail}">
					<input id="user_point" type="text" class="input_txt input1_10 inputTxtFont" value="${mypage_info.userPoint}"> 
		
					<!--  input type="password" id="user_pw_id" placeholder="수정 비밀번호 입력." required class="reg_pass input_11 inputTxtFont"> &nbsp;&nbsp;--> 
					<input type="button" id="edit_update_btn" name="OK" class="miBtt_submit_top miBtt_submit" value="수정">
				</div>
			</div>
			
	</div>

</body>
</html>