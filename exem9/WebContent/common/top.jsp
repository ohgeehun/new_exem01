<%@ page language="java" contentType="text/html;charset=UTF-8"	errorPage="/common/error.jsp" %>
<%@ include file="/common/taglibs.jsp" %>

<!--//header-->
<center>
<table border="0" cellspacing="0" cellpadding="0" class="head" width="100%">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0"  class="navi">
				<tr>
					<td style="text-align: left; padding-left: 40px;" >
						<table border="0" cellspacing="0" cellpadding="0" style="top:15px; padding-left:30px;">
							<tr>
								<td><a href="#"><img src="resources/images/logo.gif"alt="아주대학교설문시스템" ></a></td>
								<td width="60px;">&nbsp;</td>
								<c:choose>
									<c:when test="${menuId == '02'}">
										<td><a href="getPatientRecordList"><img src="resources/images/menu2_on.gif" alt="환자 사정 정보" class="p_l20"></a></td>
									</c:when>
									<c:otherwise>
										<td><a href="getPatientRecordList"><img src="resources/images/menu2.gif" alt="환자 사정 정보" class="p_l20"></a></td>
									</c:otherwise>
								</c:choose>
												
								<c:choose>
									<c:when test="${menuId == '03'}">
										<td><a href="getPatientStatistics"><img src="resources/images/menu3_on.gif" alt="환자 통계" class="p_l20"></a></td>
									</c:when>
									<c:otherwise>
										<td><a href="getPatientStatistics"><img src="resources/images/menu3.gif" alt="환자 통계" class="p_l20"></a></td>
									</c:otherwise>
								</c:choose>
												
								<c:choose>
									<c:when test="${menuId == '04'}">
										<td><a href="getSurvStatistics"><img src="resources/images/menu4_on.gif" alt="환자 사정 통계" class="p_l20"></a></td>
									</c:when>
									<c:otherwise>
										<td><a href="getSurvStatistics"><img src="resources/images/menu4.gif" alt="환자 사정 통계" class="p_l20"></a></td>
									</c:otherwise>
								</c:choose>
								
								<c:choose>
									<c:when test="${menuId == '05'}">
										<td><a href="Survey"><img src="resources/images/menu5_on.gif" alt="설문 통계" class="p_l20"></a></td>
									</c:when>
									<c:otherwise>
										<td><a href="Survey"><img src="resources/images/menu5.gif" alt="설문 통계" class="p_l20"></a></td>
									</c:otherwise>
								</c:choose>
												
								<c:choose>
									<c:when test="${menuId == '06'}">
										<td><a href="SurveyPatientList"><img src="resources/images/menu6_on.gif" alt="환자 설문 정보" class="p_l20"></a></td>
									</c:when>
									<c:otherwise>
										<td><a href="SurveyPatientList"><img src="resources/images/menu6.gif" alt="환자 설문 정보" class="p_l20"></a></td>
									</c:otherwise>
								</c:choose>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td> 
	</tr>
</table>
</center>
<!--header//-->
