function popup(title) {
	var fpNo="";
	var str="<div class=\"bg_div\" id=\"bg_div\"></div>";
	str += "<div class=\"popup_div\" id=\"popup_div\">";
	str += "<div class=\"popup_title\">&nbsp;"+title+"</div>";
	str += "<div class=\"popup_content\">";
/*	str += "<input type=\"text\" class=\"memNo\" id=\"memNo\"  onkeydown='if (event.keyCode == 13) fncCheck();' />";*/
	str += "<br/>"; // 간격조정을 위해
	str += "<br/>"; // 간격조정을 위해
	str += "<input type=\"button\" class=\"ok_btn\" value=\"확인\" />";
	str += "</div>";
	str += "</div>";
	
	$("body").prepend(str);
	
	$("#bg_div").fadeIn(); // 애니메이션을 걸겠다.
	$("#bg_div").css("display","block");
	
	$("#popup_div").fadeIn();
	$("#popup_div").css("display","block");
	
	$(".ok_btn").unbind(); // 기존 바인드를 푼다. 그래야 시스템이 느려지는걸 방지한다.
	$(".ok_btn").bind("click",function(){
		//fpNo=$("#memNo").val();  // 사원 로그인 데이터
		$("#popup_div").remove();
		$("#bg_div").remove();
	/*	IMainService.getName(fpNo,mainCallBack);*/
	});
	
	$(".memNo").focus();
}
/*function fncCheck(){
	fpNo=$("#memNo").val();  // 사원 로그인 데이터
	$("#popup_div").remove();
	$("#bg_div").remove();
	IMainService.getName(fpNo,mainCallBack);
}

function mainCallBack(name) {
	if(name==null) {
		alert("아이디를 확인해 주세요.");
		popup("사원코드를 입력해주세요.");
	} else {
		location.href="main";
	}
}*/