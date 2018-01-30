<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" />   

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>


<title>Insert title here</title>
<script type="text/javascript">

</script>
<head>
<title>CSS Website Layout</title>
<meta charset="utf-8">

<style>

</style>
</head>
<body>

<c:import url="/main_upview"></c:import>

<div class="row">
  <div class="column side">	
     <h2>Side</h2>    
     <a href="#">Link</a></br>
     <a href="#">Link</a></br>
     <a href="#">Link</a></br> 
  </div>
  <div class="column middle">
  	<!-- 	<div class="mv-event-container" id="mvEventContainer2"><div class="month-row" style="top:0%;height:21%"><table cellpadding="0" cellspacing="0" class="st-bg-table"><tbody><tr><td class="st-bg st-bg-fc">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td></tr></tbody></table><table cellpadding="0" cellspacing="0" class="st-grid"><tbody><tr><td class="st-dtitle st-dtitle-fr st-dtitle-fc"><span class="ca-cdp24385">10월 1일</span></td><td class="st-dtitle st-dtitle-fr"><span class="ca-cdp24386">2</span></td><td class="st-dtitle st-dtitle-fr"><span class="ca-cdp24387">3</span></td><td class="st-dtitle st-dtitle-fr"><span class="ca-cdp24388">4</span></td><td class="st-dtitle st-dtitle-fr"><span class="ca-cdp24389">5</span></td><td class="st-dtitle st-dtitle-fr"><span class="ca-cdp24390">6</span></td><td class="st-dtitle st-dtitle-fr"><span class="ca-cdp24391">7</span></td></tr><tr><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td></tr></tbody></table></div><div class="month-row" style="top:20%;height:21%"><table cellpadding="0" cellspacing="0" class="st-bg-table"><tbody><tr><td class="st-bg st-bg-fc">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td></tr></tbody></table><table cellpadding="0" cellspacing="0" class="st-grid"><tbody><tr><td class="st-dtitle st-dtitle-fc"><span class="ca-cdp24392">8</span></td><td class="st-dtitle"><span class="ca-cdp24393">9</span></td><td class="st-dtitle"><span class="ca-cdp24394">10</span></td><td class="st-dtitle"><span class="ca-cdp24395">11</span></td><td class="st-dtitle"><span class="ca-cdp24396">12</span></td><td class="st-dtitle"><span class="ca-cdp24397">13</span></td><td class="st-dtitle"><span class="ca-cdp24398">14</span></td></tr><tr><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td></tr></tbody></table></div><div class="month-row" style="top:40%;height:21%"><table cellpadding="0" cellspacing="0" class="st-bg-table"><tbody><tr><td class="st-bg st-bg-fc">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg st-bg-today">&nbsp;</td><td class="st-bg st-bg-next">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td></tr></tbody></table><table cellpadding="0" cellspacing="0" class="st-grid"><tbody><tr><td class="st-dtitle st-dtitle-fc"><span class="ca-cdp24399">15</span></td><td class="st-dtitle"><span class="ca-cdp24400">16</span></td><td class="st-dtitle"><span class="ca-cdp24401">17</span></td><td class="st-dtitle st-dtitle-today"><span class="ca-cdp24402">18</span></td><td class="st-dtitle st-dtitle-next"><span class="ca-cdp24403">19</span></td><td class="st-dtitle"><span class="ca-cdp24404">20</span></td><td class="st-dtitle"><span class="ca-cdp24405">21</span></td></tr><tr><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td></tr></tbody></table></div><div class="month-row" style="top:60%;height:21%"><table cellpadding="0" cellspacing="0" class="st-bg-table"><tbody><tr><td class="st-bg st-bg-fc">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td></tr></tbody></table><table cellpadding="0" cellspacing="0" class="st-grid"><tbody><tr><td class="st-dtitle st-dtitle-fc"><span class="ca-cdp24406">22</span></td><td class="st-dtitle"><span class="ca-cdp24407">23</span></td><td class="st-dtitle"><span class="ca-cdp24408">24</span></td><td class="st-dtitle st-dtitle-down"><span class="ca-cdp24409">25</span></td><td class="st-dtitle"><span class="ca-cdp24410">26</span></td><td class="st-dtitle"><span class="ca-cdp24411">27</span></td><td class="st-dtitle"><span class="ca-cdp24412">28</span></td></tr><tr><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td></tr></tbody></table></div><div class="month-row" style="top:80%;bottom:0"><table cellpadding="0" cellspacing="0" class="st-bg-table"><tbody><tr><td class="st-bg st-bg-fc">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td><td class="st-bg">&nbsp;</td></tr></tbody></table><table cellpadding="0" cellspacing="0" class="st-grid"><tbody><tr><td class="st-dtitle st-dtitle-fc"><span class="ca-cdp24413">29</span></td><td class="st-dtitle"><span class="ca-cdp24414">30</span></td><td class="st-dtitle"><span class="ca-cdp24415">31</span></td><td class="st-dtitle st-dtitle-nonmonth"><span class="ca-cdp24417">11월 1일</span></td><td class="st-dtitle st-dtitle-nonmonth"><span class="ca-cdp24418">2</span></td><td class="st-dtitle st-dtitle-nonmonth"><span class="ca-cdp24419">3</span></td><td class="st-dtitle st-dtitle-nonmonth"><span class="ca-cdp24420">4</span></td></tr><tr><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td><td class="st-c st-s">&nbsp;</td></tr></tbody></table></div></div> -->
  </div>
</div>

<c:import url="/main_botview"></c:import>

</body>
</html>













