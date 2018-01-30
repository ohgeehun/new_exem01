/*
제 목 : 공통용
*/

//AJAX
// 첨부파일 체크
function addAttFile() {
	var orderNo = $("input:file").length;

	if (orderNo >= iMaxFileCount) {
		alert("첨부파일은 5개 이상 추가할 수 없습니다.");
		return;
	}

	var sHtml = "<p><input type='file' name='attFile'/>";
	sHtml += "<input type='button' id='deleteFile" + orderNo + "' value='파일삭제' action='deleteFile'/></p>"

	$("#fileInputArea").append(sHtml); 

	$("input:button[action=deleteFile]").bind("click", function() {
		$(this).parent().remove();
	});

	$("input:file").bind("click", function() {
		$(this).css("background-color", "");
	});
}

function checkAttFile() {
	var bRet = true;
	
	$("input:file").each(function() { 
		var sFileName = jQuery.trim($(this).val()); 

		if (sFileName.length > 0) {
			sFileName = sFileName.substring(sFileName.lastIndexOf("\\")+1, sFileName.length);

			// 확장자가 없거나 파일명이 없는 파일은 등록불가!!
			if(sFileName.lastIndexOf(".") <= 0) {
				$(this).css("background-color", "red");
				alert("등록할 수 없는 파일입니다."); 
				bRet = false;
				
				return false; 
			}

			var sFileExt = sFileName.substring(sFileName.lastIndexOf(".")+1, sFileName.length);
			sFileExt = sFileExt.toLowerCase();

			// 정의된 파일확장자가 아니면 등록불가!
			if (uploadExts.toLowerCase().indexOf(sFileExt) < 0) { 
				$(this).css("background-color", "red");
				alert("확장자가 " + sFileExt.toLowerCase() + "인 파일은 업로드 할 수 없습니다."); 
				bRet = false;
				
				return false; 
			} 
		} 
	}); 
	
	return bRet;
}

function beforeDefault(formData, jqForm, options) {
	//diaOnBlockUI(3);
	return true;
}
//AJAX
function successDefault(responseXML) {
	var result = $('result', responseXML).text();
	var resultMemo = $('resultMemo', responseXML).text();

	if (result == 'Y') {
		alert("성공하였습니다");
	} else {
		//diaUnBlockUI();
		if(resultMemo=='') {
			alert('저장이 실패했습니다. \n잠시후에 다시 시도해 주세요>');
		} else {
			alert(resultMemo);
		}
	}
}
//AJAX
function ajaxSubmitForm(expression, successFunc, beforeFunc) {
	var selector = $(expression);
	selector.ajaxForm( {
		dataType :'xml',
		cache: false,
		beforeSubmit : beforeFunc,
		success : successFunc
	});
}

//확장자 체크
function fileCheck(file_name){
	//var file_name = $('input[name="upload"]').val();
	var len = file_name.length;
	var len2 = file_name.lastIndexOf(".")+1;
	var temp = file_name.substring(len2,len);
	temp = temp.toLowerCase();

	if(temp != "jpg" && temp != "gif" && temp !="bmp"){
		alert('JPG, GIF, BMP 이미지(1MB 이하)만 업로드 가능합니다.');
		return false;
	}
	return true;
}

//커서
function bindCursor(target, comment){
	$('#'+target).focus(function(e){
		if($.trim($('#'+target).val()) == comment){
			$('#'+target).val('');
		}
	}).blur(function(e){
		if($.trim($('#'+target).val()) == ''){
			$('#'+target).val(comment);
		}
	});
}

//숫자면 true, 그렇지 않으면 false
function isDigitStr(str) {
	if (/[^\d]/g.test(str)) {
		return false;
	}
	return true;
}

//숫자면 true, 그렇지 않으면 false
function isDigit(obj) {
	if (/[^\d]/g.test(obj.val())) {
		return false;
	}
	return true;
}

//영어면 true, 그렇지 않으면 false
function isAlPha(obj) {
	if (/[^a-zA-Z]/g.test(obj.val())) {
		return false;
	}
	return true;
}

//숫자나 영어면 true, 그렇지 않으면 false (이메일 입력 체크용)
function isEmail(obj) {
	if (/[^a-zA-Z\d]/g.test(obj.val())) {
		return false;
	}
	return true;
}

//이메일 형식 체크(뒷자리) naver.com or yahoo.co.kr
function isEmailCheck(obj) {
	if (/[a-z0-9-]{2,}\.[a-z0-9]{2,}/g.test(obj.val())) {
		return true;
	}
	return false;
}

//공백 체크
function isEmpty(obj) {
	if (obj.val() == null || obj.val().trim() == '' || obj.val() == undefined) {
		return true;
	}
	return false;
}

//셀렉트박스 체크
function isSelected(obj) {
	if (obj.val() == "") {
		return false;
	}
	return true;
}

//URL 형식 체크
function isURL(obj) {
	if (/http:\/\/[A-Za-z0-9\.-]{3,}\.[A-Za-z]{2,3}/.test(obj.val())) {
		return true;
	} else {
		obj.val('http:\/\/');
		return false;
	}
}

//천단위 콤마 출력
function addCommas(strValue) {
	strValue += '';
	var objRegExp = new RegExp('(-?[0-9]+)([0-9]{3})');
	while(objRegExp.test(strValue)) {
		strValue = strValue.replace(objRegExp, '$1,$2');
	}
	return strValue;
}

/**
 * 한글을 2byte씩 계산하여 문자열이 차지하는 byte 수를 리턴
 * @param value : byte수를 체크할 문자열
 * @return int : 문자열의 byte 수
 */
function checkByte(value) {
	var val = escape(value.trim());
	var UNICODE_LENGTH = 6;	 // %uxxxx
	var count = 0;	// 유니코드 수
	var sIndex = 0;

	while ((sIndex = val.indexOf('%u', sIndex)) > -1) {
		var regExp = val.substring(sIndex, sIndex+UNICODE_LENGTH);
		val = val.replace(regExp, '');
		count++;
	}

	return (count * 2 + val.length);
}

// 문자열을 byte로 계산하여 자른후 리턴
function cutStr(str, limit){
	var tmpStr = str;
	var byte_count = 0;
	var len = str.length;
	var dot = "";

	for(i=0; i<len; i++){
		byte_count += chr_byte(str.charAt(i));
		if(byte_count == limit-1){
			if(chr_byte(str.charAt(i+1)) == 2){
				tmpStr = str.substring(0,i+1);
				dot = "..";
			} else {
				if(i+2 != len) dot = "..";
				tmpStr = str.substring(0,i+2);
			}
			break;
		} else if(byte_count == limit){
			if(i+1 != len) dot = "..";
			tmpStr = str.substring(0,i+1);
			break;
		}
	}
	return tmpStr + dot;
}
function chr_byte(chr){
	if(escape(chr).length > 4)
		return 2;
	else
		return 1;
}


//파일 확장자 리턴
function getExtension(file_name){

	var len = file_name.length;
	var len2 = file_name.lastIndexOf(".")+1;

	var temp = file_name.substring(len2,len);
	return temp.toLowerCase();
}

//파일명 리턴
function getBaseName(file_name){
	var len = file_name.length;
	var len2 = file_name.lastIndexOf("\\")+1;

	return file_name.substring(len2,len);
}


//윈도우 팝업 시이즈 브라우저별 자동 조정
//param: target(팝업 전체 div의 id)
function resizePopupAuto(){
	var width = 0, height = 0;
	if($.browser.msie){
		width = document.body.scrollWidth + 6;
		height = document.body.scrollHeight + 60;
	} else if($.browser.mozilla){
		width = document.body.scrollWidth+8;
		height = document.body.scrollHeight + 100;
	} else {
		width = document.body.scrollWidth + 6;
		height = document.body.scrollHeight + 60;
	}
	
	resizePopup(width, height);
}

function resizePopup(width, height){
	if($.browser.msie){
		if($.browser.version == "7.0") {
			height = height + 25;
		}else if($.browser.version == "8.0") {
			height = height + 20;
		}
		window.resizeTo( width, height );
	}else {
		window.resizeTo( width, height );
	}
}
//팝업창을 중앙으로 이동
function centerPopup(){
	var x,y;
	if (self.innerHeight) { // IE 외 모든 브라우저
		x = (screen.availWidth - self.innerWidth) / 2;
		y = (screen.availHeight - self.innerHeight) / 2;
	}else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict 모드
		x = (screen.availWidth - document.documentElement.clientWidth) / 2;
		y = (screen.availHeight - document.documentElement.clientHeight) / 2;
	}else if (document.body) { // 다른 IE 브라우저( IE < 6)
		x = (screen.availWidth - document.body.clientWidth) / 2;
		y = (screen.availHeight - document.body.clientHeight) / 2;
	}
	window.moveTo(x,y);
}


//iframe 높이 자동 조절
function autoHeight(jqObj, context) {
	var ifrm = $(jqObj, context);
	var ifrmDoc = (ifrm.get(0).contentDocument) ? ifrm.get(0).contentDocument : ifrm.get(0).contentWindow.document;
	var height = ifrmDoc.body.offsetHeight < 600 ? 600 : ifrmDoc.body.offsetHeight;
	ifrm.height(height);
}

//팝업창 중간으로 옮기는 함수
function moveWindows(intWidth, intHeight){
	w = (screen.availWidth - intWidth) / 2;
	h =  (screen.availHeight - intHeight) / 2;
	window.moveTo(w,h);
	window.focus();
}

//이미지 리사이즈(가로, 세로 비율을 맞춤)
//param: target(이미지타겟), outline(테두리) 의 id 및 클래스
//ex) imgResize('#userImgUrl', '.idcard .photo');
function imgResize(target, outline){
	$(target).bind('resize', function() {
		imgResizing(target, outline);
	}).resize();
}

//이미지 리사이즈(가로, 세로 비율을 맞춤) 리사이징 이벤트가 없음..
//param: target(이미지타겟), outline(테두리) 의 id 및 클래스
//ex) imgResizing('#userImgUrl', '.idcard .photo');
function imgResizing(target, outline){
	var w = $(target).width(), h = $(target).height();
	if(w > 0 && h > 0){
		var tmpPw = $(outline).css('width');
		var tmpPh = $(outline).css('height');
		var pw = tmpPw.substring(0,tmpPw.indexOf('px'));
		var ph = tmpPh.substring(0,tmpPh.indexOf('px'));
		var rw = w / pw, rh = h / ph;
		var r = Math.max(rw, rh);

		$(target).width(w / r).height(h / r);
		if (rh < r) {
			$(target).css( {
				marginTop :(Math.floor(ph / 2) - Math.ceil($(target).height() / 2) - 2) + 'px'
			});
		}
		$(target).css( {
			visibility :'visible',
			display :'none'
		}).show();
	}
}

//영숫자 체크
function Char_Check(id_text){
	var alpha = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	var numeric = '1234567890';
	var nonkorean = alpha+numeric; 
	
	var i; 
	for ( i=0; i < id_text.length; i++ )  {
		if( nonkorean.indexOf(id_text.substring(i,i+1)) < 0) {
			break; 
		}
	}
	
	if ( i != id_text.length ) {
		return false; 
	}
	else{
		return true;
	} 
	
	return true;
}

// 특수문자 체크
function NonChar_Check(id_text){
	var nonchar = '~`!@#$%^&*()=+\|<>?,./;:"';
//	var numeric = '1234567890';
	var nonkorean = nonchar; 
	
	var i ; 
	for ( i=0; i < id_text.length; i++ )  {
		if( nonkorean.indexOf(id_text.substring(i,i+1)) > 0) {
			break;
		}
	}
	
	if ( i != id_text.length ) {
		return false; 
	}
	else{
		return true;
	} 
	
	return false;
}

// 연속적 문자,숫자 사용 체크
function isRepeatCharacter(value) {
	var regExp = /(.)\1{3,}/g;
	if (regExp.test(value) ) {
		return true;
	}
	return false;
}
