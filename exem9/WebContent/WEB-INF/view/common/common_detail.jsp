<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
	#cus_name {
		width: 200px;
		height: 30px;
		text-align: center;
		font-size: 20pt;
		font-family: 고딕;
		
	}
	#div_detail {
		width:100%;
		height:100%;
		display: inline-block;
	}
	
	li {
		cursor: pointer;
	}
	
	li:link    { text-decoration:none }
	li:visited { text-decoration:none }
	li:hover   { text-decoration:underline }
	li:active  { text-decoration:none }
	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$(".plan").click(function(){
			if($("#plan_down").css("display") == "none") {
				$("#plan_down").fadeIn("slow");
				$("#plan_down").css("display","inline-block");
			} else {
				$("#plan_down").fadeOut("slow");
				$("#plan_down").css("display","none");
			}
		});
		
		$(".pt").click(function(){
			if($("#pt_down").css("display") == "none") {
				$("#pt_down").fadeIn("slow");
				$("#pt_down").css("display","inline-block");
			} else {
				$("#pt_down").fadeOut("slow");
				$("#pt_down").css("display","none");
			}
		});
		
		$("#ptp").click(function(){
			if($("#prog").val()==0) {
				alert("설문지를 먼저 작성해주세요.");
			} else if($("#prog").val()==1) {
				alert("상담을 통해 포트폴리오를 먼저 제작하세요.");
			} else {
				document.getElementById("goPtP").submit();
			}
		});
		
		$("#fill_in").click(function(){
			if($("#prog").val()!=0) {
				alert("고객님은 이미 설문을 완료하였습니다.");
			} else {
				location.href='survey';
			}
		});
		$("#fill_in_result").click(function(){
			if($("#prog").val()==0) {
				alert("설문지를 먼저 작성해주세요.");
			} else {
				location.href='result';
			}
		});
		$("#one_result").click(function(){
			if($("#prog").val()==0) {
				alert("설문지를 먼저 작성해주세요.");
			} else {
				location.href='adviceResult';
			}
		});
	});
</script>
</head>
<body>
<form action="ppPage" method="post" id="goPtP">
<input type="hidden" name="progress" id="prog"/>
</form>
<br/>
<br/>
<div id="div_detail" > 
	<div align="center"> 
		<input type="text" id="cus_name" readonly="readonly" value="${nm}" onclick="location.href='progress'">
	</div>
	<br/>
	<ul>
		<li class="plan">종합재무설계</li><br/>
			<ul id="plan_down" style="display: none; padding-left: 10px;">
			     <li id="fill_in">설문조사작성</li><br/>
			     <li id="fill_in_result">설문조사결과</li><br/>
			     <li id="one_result">1차상담결과</li><br/>
		     </ul>
		<li class="pt">포트폴리오 관리</li><br/>
			<ul id="pt_down" style="display: none; padding-left: 10px;">
				     <li id="ptp">최적포트폴리오</li><br/>
		     </ul>
	</ul>
</div>
</body>
</html>