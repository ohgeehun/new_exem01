(function() 
{
	/**
	 * @description : 로딩바를 출력한다.
	 * @param : msg - alt 메시지 
	 * @return : None
	 * @example :
	 * 로딩 바를 출력할 부분에  
	 * $.loadingBar('메시지');
	 * 작성 후 완료 시점에 
	 * $.loadingBar.fadeOut();
	 */
	jQuery.loadingBar = function(msg){
		
		if($('#loadingWrap').length){
			// A confirm is already shown on the page:
			return false;
		}
		
		var resourceHtml = [
		            		'<div class="loadingWrap" id="loadingWrap">',
		            		'	<div class="loadingBg"></div>',
		            		'	<div id="loading">',
		            		'	<img src="/Analytics/resources/images/front/common/loader.gif" alt="',msg,'" />',
		            		'	</div>',
		            		'</div>',
		].join('');
		
		$('body').append(resourceHtml);	
	};
	
	jQuery.loadingBar.fadeOut = function(){
		$('#loadingWrap').fadeOut(function(){
			$(this).remove();
		});
	};
	
})(jQuery);

