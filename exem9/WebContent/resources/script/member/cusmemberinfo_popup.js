/*function cusmemberinfo_popup(title,cusId) {*/
function cusmemberinfo_popup(title) {
	var rowNum_end = rowNum +1;
	alert(rowNum);
	alert(rowNum_end);
	var str="<div class=\"bg_div\" id=\"bg_div\"></div>";
	str += "<div class=\"popup_div\" id=\"popup_div\">";
	str += "<div class=\"popup_title\">&nbsp;"+title+"</div>";
	str += "<div id=\"popup_content_id\" class=\"popup_content\">";
	str += "<ul>";
	str += "<li class=\"popup_input_title popup_input_01 popup_inputTxtFont\">고객명</li>";
	str += "<li class=\"popup_input_title popup_input_02 popup_inputTxtFont\">고객연락처</li>";
	str += "<li class=\"popup_input_title popup_input_03 popup_inputTxtFont\">고객 이메일</li>";
	str += "</ul>";	
	/*str += "<thead><tr><td>담당자명</td><td>연락처</td><td>이메일</td></tr></thead>";
	str += "<tbody id=\"member_list\"></tbody>";
	str += "</table>";*/
/*	str += "<input type=\"text\" class=\"memNo\" id=\"memNo\"  onkeydown='if (event.keyCode == 13) fncCheck();' />";*/
	str += "<br/>"; // 간격조정을 위해
	str += "<br/>"; // 간격조정을 위해
/*	str += "<div  id=\"popup_content_data_input_id\">";
	str += "</div>";*/
	str += "<div  id=\"popup_content_input_id\">";
	str += "<input class=\"popup_input_txt popup_input_txt_01_1 popup_inputTxtFont\" type=\"text\" id=\"cusNm_id"+rowNum+"\" >";
	str += "<input class=\"popup_input_txt popup_input_txt_01_2 popup_inputTxtFont\" type=\"text\" id=\"cusPhone_id_"+rowNum+"\" onkeydown=\"return onlyNumber(event)\" onkeyup=\"removeChar(event)\" style=\"ime-mode:disabled\">";
	str += "<input class=\"popup_input_txt popup_input_txt_01_3 popup_inputTxtFont\" type=\"text\" id=\"cusMail_id_"+rowNum+"\" >";
	str += "<input class=\"popup_input_txt popup_input_txt_01_4 popup_inputTxtFont\" type=\"button\" id=\"save_Btn_id_"+rowNum+"\" value=\"저장\">";
	str += "<input class=\"popup_input_txt popup_input_txt_01_5 popup_inputTxtFont\" type=\"button\" id=\"remove_Btn_id\" value=\"삭제\">";
	str += "<input class=\"popup_input_txt popup_input_txt_02_4 popup_inputTxtFont\" type=\"button\" id=\"add_Btn_id\" value=\"추가\">";	
	str += "</div>";
	str += "</div>";
	str += "<input type=\"button\" id=\"ok_btn\" class=\"popup_inBtt_OK\" value=\"확인\" />";
/*	str += "<input type=\"button\" id=\"ct_btn\" class=\"popup_inBtt_OK_2\" value=\"취소\" />";*/
	str += "</div>";
	
	$("body").prepend(str);
	
	$("#bg_div").fadeIn(); // 애니메이션을 걸겠다.
	$("#bg_div").css("display","block");
	
	$("#popup_div").fadeIn();
	$("#popup_div").css("display","block");
	
	/*IMatService.getcusmemberinfo(cusId, getcusmemberinfoCallBack);*/
	
	/*ICustomerService.getUsermember(list, testCallBack);*/
	
	$("#ok_btn").unbind(); // 기존 바인드를 푼다. 그래야 시스템이 느려지는걸 방지한다.
	$("#ok_btn").bind("click",function(){
		//fpNo=$("#memNo").val();  // 사원 로그인 데이터
		$("#popup_div").remove();
		$("#bg_div").remove();
		rowNum = 0;
		rowNum_end = 0;
		rowNum_add = 0;
	/*	IMainService.getName(fpNo,mainCallBack);*/
	});
	
	$("#add_Btn_id").unbind(); // 기존 바인드를 푼다. 그래야 시스템이 느려지는걸 방지한다.
	$(document).on("click","#add_Btn_id",function(){	
		
		rowNum_end = rowNum_end + 1;	
		
		var str ="";
		for(var i = rowNum+1; i <= rowNum_end; i++){
			str += "<input class=\"popup_input_txt popup_input_txt_0"+i+"_1 popup_inputTxtFont\" type=\"text\" id=\"cusNm_id_"+i+"\" >";
			str += "<input class=\"popup_input_txt popup_input_txt_0"+i+"_2 popup_inputTxtFont\" type=\"text\" id=\"cusPhone_id_"+i+"\" onkeydown=\"return onlyNumber(event)\" onkeyup=\"removeChar(event)\" style=\"ime-mode:disabled\">";
			str += "<input class=\"popup_input_txt popup_input_txt_0"+i+"_3 popup_inputTxtFont\" type=\"text\" id=\"cusMail_id_"+i+"\" >";		
			str += "<input class=\"popup_input_txt popup_input_txt_0"+i+"_4 popup_inputTxtFont\" type=\"button\" id=\"save_Btn_id_"+i+"\" value=\"저장\">";
			str += "<input class=\"popup_input_txt popup_input_txt_0"+i+"_5 popup_inputTxtFont\" type=\"button\" id=\"remove_Btn_id\" value=\"삭제\">";
		}
		
		rowNum_add = 0;
		rowNum_add = rowNum_end +1;
		if(rowNum_add < 8 ){
			str += "<input class=\"popup_input_txt popup_input_txt_0"+rowNum_add+"_4 popup_inputTxtFont\" type=\"button\" id=\"add_Btn_id\" value=\"추가\">";
		}
						
		$("#popup_content_input_id").html(str);	

	});
	
	$("#remove_Btn_id").unbind(); // 기존 바인드를 푼다. 그래야 시스템이 느려지는걸 방지한다.
	$(document).on("click","#remove_Btn_id",function(){	
		rowNum_end = rowNum_end - 1;	
		
		var str ="";
		for(var i = rowNum+1; i <= rowNum_end; i++){
			str += "<input class=\"popup_input_txt popup_input_txt_0"+i+"_1 popup_inputTxtFont\" type=\"text\" id=\"cusNm_id"+i+"\" >";
			str += "<input class=\"popup_input_txt popup_input_txt_0"+i+"_2 popup_inputTxtFont\" type=\"text\" id=\"cusPhone_id_"+i+"\" onkeydown=\"return onlyNumber(event)\" onkeyup=\"removeChar(event)\" style=\"ime-mode:disabled\">";
			str += "<input class=\"popup_input_txt popup_input_txt_0"+i+"_3 popup_inputTxtFont\" type=\"text\" id=\"cusMail_id_"+i+"\" >";		
			str += "<input class=\"popup_input_txt popup_input_txt_0"+i+"_4 popup_inputTxtFont\" type=\"button\" id=\"save_Btn_id_"+i+"\" value=\"저장\">";
			str += "<input class=\"popup_input_txt popup_input_txt_0"+i+"_5 popup_inputTxtFont\" type=\"button\" id=\"remove_Btn_id\" value=\"삭제\">";
		}
		
		rowNum_add = 0;
		rowNum_add = rowNum_end +1;
		if(rowNum_add < 8 ){
			str += "<input class=\"popup_input_txt popup_input_txt_0"+rowNum_add+"_4 popup_inputTxtFont\" type=\"button\" id=\"add_Btn_id\" value=\"추가\">";
		}
						
		$("#popup_content_input_id").html(str);	
	});
	
	$(".memNo").focus();
}
/*
function getcusmemberinfoCallBack(res){
	var str ="";	
	
	for(var i = 0; i < res.length; i++){
		rowNum = rowNum + i;
		str += "<input class=\"popup_input_txt popup_input_txt_0"+rowNum+"_1 popup_inputTxtFont\" type=\"text\" id=\"cusNm_id_"+rowNum+"\" value=\""+res[i].cususerNm+"\">";
		str += "<input class=\"popup_input_txt popup_input_txt_0"+rowNum+"_2 popup_inputTxtFont\" type=\"text\" id=\"cusPhone_id_"+rowNum+"\" value=\""+res[i].cususerPhone+"\" onkeydown=\"return onlyNumber(event)\" onkeyup=\"removeChar(event)\" style=\"ime-mode:disabled\">";
		str += "<input class=\"popup_input_txt popup_input_txt_0"+rowNum+"_3 popup_inputTxtFont\" type=\"text\" id=\"cusMail_id_"+rowNum+"\" value=\""+res[i].cususerMail+"\">";		
		str += "<input class=\"popup_input_txt popup_input_txt_0"+rowNum+"_4 popup_inputTxtFont\" type=\"button\" id=\"save_Btn_id_"+rowNum+"\" value=\"저장\">";
		str += "<input class=\"popup_input_txt popup_input_txt_0"+rowNum+"_5 popup_inputTxtFont\" type=\"button\" id=\"remove_Btn_id\" value=\"삭제\">";
	}
	
	rowNum_add = 0;
	rowNum_add = rowNum +1;
	if(rowNum_add < 8 ){
		str += "<input class=\"popup_input_txt popup_input_txt_0"+rowNum_add+"_4 popup_inputTxtFont\" type=\"button\" id=\"add_Btn_id\" value=\"추가\">";
	}
	
	$("#popup_content_data_input_id").html(str);
}*/


/*function getcusmemberCallBack(res){
	var str ="";	
	alert("dddddddddddd");
	
	for(var i = 0; i < res.length; i++){
		str += "<tr>";
		str += "<td>"+res[i].cususerNm+"</td>";
		str += "<td>"+res[i].cususerPhone+"</td>";
		str += "<td>"+res[i].cususerMail+"</td>";
		str += "</tr>";
	}
	
	$("#member_list").html(str);
}*/
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