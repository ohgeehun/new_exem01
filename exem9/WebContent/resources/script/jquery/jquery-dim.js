(function() 
{

	/**
	 * @description : DIM 메시지를 호출한다.
	 * @param : msg - 출력할 메시지
	 * @return : None
	 * @example : $.dimAlert('메시지');
	 * 만약 실행 후 확인 버튼 이후에 Action을 취해야 할 경우 (페이지 submit 같은 종류) 아래의 코드를 참고
	 *  
	 * $('#overlayClose').live("click" , function(e) {
	 * 		// 여기에 action 처리 
	 * });
	 */
	jQuery.dimAlert = function(msg){
		var resourceHtml = "";
		resourceHtml =   $("#dimWrap");	
		
		if(resourceHtml.length === 0) {
			resourceHtml = "<div class=\"dimWrap\" id=\"dimWrap\">";
			resourceHtml += "<div class=\"overlay\"></div>";
			resourceHtml += "<div id=\"overlay\">";
			resourceHtml += "<p class=\"close\"><button class=\"closeBtn\" title=\"닫기\" id=\"remove_layer\"><span>닫기</span></button></p>";
			resourceHtml += "<h2 class=\"txt\">알림</h2>";
			resourceHtml += "<div class=\"contWrap\">";
			resourceHtml += "<p class=\"alimTxt txt2Line\">";
			resourceHtml += msg;
			resourceHtml += "</p>";
			resourceHtml += "<div class=\"dimBtn\">";
			resourceHtml += "<p><button class=\"confirmBtn\" title=\"확인\" id=\"overlayClose\"><span>확인</span></button></p>";
			resourceHtml += "</div>";
			resourceHtml += "</div>";
			resourceHtml += "</div>";
			resourceHtml += "</div>";
		} 

		$('body').append(resourceHtml);
		wrapWindowMask();
		
		$('#overlayClose').live("click" , function(e) {
			$('#dimWrap, .overlay').fadeOut();		
			$('#dimWrap').remove();
			$('.overlay').remove();
		});
		$('.close').live("click" , function(e) {		
			$('#dimWrap, .overlay').fadeOut();
			$('#dimWrap').remove();
			$('.overlay').remove();
		});

	};
	
	

	
	function wrapWindowMask(){
		var maskHeight = $(document).height() ;
		var maskWidth = $(window).width();
		var winH = $(window).height(); 		// 윈도우 높이         
		var winW = $(window).width(); 		// 윈도우 너비 
		
		var POSLEFT = ( winW  / 2 );
		var POSTOP = (  winH  / 2 );
		
		// 마스크의 높이와 너비를 화면으로 만들어 전체 화면을 채운다.          
		$("#overlay").css('top',  POSTOP);         
		$("#overlay").css('left', POSLEFT) ;               
		$('#overlay').fadeTo("slow");		
		$('#dimWrap').css({'width' : maskWidth, 'height' : maskHeight});
		$('#dimWrap').fadeTo("slow");
		
	}
	
	/**
	 * @description : DIM 메시지, DIM 컨펌 메시지를 호출한다.
	 * @param : msg - 출력할 메시지
	 * @param : fnDifinition - 출력후 이동할 function 호출 (String 타입)
	 * @return : None
	 * @example : 
	 *  $.dimConfirm({
 			'title'	: '알림',
			'message'	: '댓글을 삭제하시겠습니까?',
			'buttons'	: {
				'Yes'	: {
					'action': function(){
			 			//TODO 
					}
				},
				'No'	: {
					'action': function(){}	
				}
			}
		});
		
	 */
	jQuery.dimConfirm = function(params) { 
		
		if($('#confirmWrap').length){
			// A confirm is already shown on the page:
			return false;
		}

		$.each(params.buttons,function(name,obj){
			// alert(name);
			if(!obj.action){
				obj.action = function(){};
			}
		});
		
		var resourceHtml = [
		'<div class="confirmWrap" id="confirmWrap">',                    
		'<div class="confirmoverlay"></div>',                    
		'<div id="confirmoverlay">',                    
		'<p class="close"><button class="closeBtn" title="닫기" id="remove_layer"><span>닫기</span></button></p>',                    
		'<h2 class="txt">',params.title,'</h2>',                    
		'<div class="contWrap">',                    
		'<p class="alimTxt txt2Line">',      
		params.message,
		'</p>',                    
		'<div class="btn" id="overlayConfirm">',                    
		'<ul>',                    
		'<li><button type="button" class="confirmBtn btns" title="확인" id="overlayOK"><span>확인</span></button></li>',                    
		'<li><button type="button" class="cancelBtn btns" title="취소" id="overlayCancel"><span>취소</span></button></li>',                    
		'</ul>',                    
		'</div>',              
		'</div>',              
		'</div>',              
		'</div>'              
		].join('');
		
		$('body').append(resourceHtml);	
		
		var buttons = $('#overlayConfirm .btns'),
		i = 0;

		$.each(params.buttons,function(name,obj){
			buttons.eq(i++).click(function(){
				obj.action();
				$.dimConfirm.hide();
				
				return false;
			});
		});
		
		$('#remove_layer').live("click" , function(e) {		
			$('.confirmWrap').remove();
		});
		
	};
	
	$.dimConfirm.hide = function(){
		$('#confirmWrap').fadeOut(function(){
			$(this).remove();
			
			return false;
		});
	};
	
	$('.close').live("click" , function(e) {		
		$('#confirmWrap, .confirmoverlay').fadeOut();
		$('#confirmWrap').remove();
		$('.overlay').remove();
	});
	
})(jQuery);

