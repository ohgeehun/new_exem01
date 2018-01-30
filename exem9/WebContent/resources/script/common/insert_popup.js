function popup(title,list) {
	var str="<div class=\"bg_div\" id=\"bg_div\"></div>";
	str += "<div class=\"popup_div\" id=\"popup_div\">";
	str += "<div class=\"popup_title\">&nbsp;"+title+"</div>";
	str += "<div class=\"popup_content\">";
	str += "은행고객코드 : "+list.bank_cus_code+"<br/>";
	str += "고객명 : "+list.bank_name+"<br/>";
	str += "ID : "+list.bank_id+"<br/>";
	str += "<br/>"; // 간격조정을 위해
	str += "<br/>"; // 간격조정을 위해
	str += "<input type=\"button\" class=\"ok_btn\" value=\"확인\" /> &nbsp;&nbsp;";
	str += "<input type=\"button\" class=\"cancel_btn\" value=\"취소\" />";
	str += "</div>";
	str += "</div>";
	
	$("body").prepend(str);
	
	$("#bg_div").fadeIn(); // 애니메이션을 걸겠다.
	$("#bg_div").css("display","block");
	
	$("#popup_div").fadeIn();
	$("#popup_div").css("display","block");
	
	$(".ok_btn").unbind(); // 기존 바인드를 푼다. 그래야 시스템이 느려지는걸 방지한다.
	$(".ok_btn").bind("click",function(){
		$("#popup_div").remove();
		$("#bg_div").remove();
		
		IMemberService.insertList(list.bank_cus_code,list.bank_acct_code,insertCallBack);
		
	});
	
	$(".ok_btn").focus();
	
	$(".cancel_btn").unbind(); // 기존 바인드를 푼다. 그래야 시스템이 느려지는걸 방지한다.
	$(".cancel_btn").bind("click",function(){
		$("#popup_div").remove();
		$("#bg_div").remove();
		
	});
	$(".ok_btn").focus();
}



