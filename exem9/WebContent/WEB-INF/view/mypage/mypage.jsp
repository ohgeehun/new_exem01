<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" />

<title>MyPage</title>

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/IMypageService.js"></script>

<style type="text/css">
 table, td, th {    
    border: 1px solid #ddd;
    text-align: left;
}

table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    padding: 15px;
}

</style>
<script type="text/javascript">	
	var userId = "<%=(String)session.getAttribute("sUserId")%>";
<%-- 	var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";
	var userPosi = "<%=(String)session.getAttribute("sUserPosi")%>"; --%>
	var userDbms = "";
	var userPosi = "";

	$(document).ready(function(){		
	    
		IMypageService.getUserinfo(userId, userInfoCallBack);		
		
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
	 <div class="column side">
		   <h4>MyPage</h4></br>
		   <a href="#" id="UIedit">개인정보 변경</a></br>		    
		   <a href="#" id="PWedit">비밀번호 변경</a></br>
	 </div>
	 <div class="column middle">
	   <h3>개인정보</h3>    
	   
	   <table id ="mypageview">		
	   </table> 
	   </br>		
		
 	    <div id="UIeditBtn" align="center">
 	   		 <button>변경하기</button>
		</div> 
	</div>
</div>
<c:import url="/main_botview"></c:import>

</body>
</html>