<%@ page language="java" contentType="text/html;charset=UTF-8"	errorPage="/common/error.jsp" %>
<%@ include file="/common/taglibs.jsp" %>
<!--//left-->
<div class="left">
	<table border="0" cellspacing="0" cellpadding="0" > 
		<tr>
			<td><img src="resources/images/logo.bmp"></td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td class="left_admin" >
				<table border="0" cellspacing="0" cellpadding="0" style="margin:25px;">
					<tr>
						<td><span class="color_b">${sUserName}</span>님<br>즐거운하루되세요</td> 
					</tr>
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>
							<a href="UserInfo">정보변경 </a>ㅣ
							<a href="Logout">로그아웃</a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<c:if test="${sAccType eq '00'}">
		<tr>
			<td>
				<table border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<td><img src="resources/images/left_top.gif" ></td> 
					</tr>
					<tr>
						<td>
							<table border="0" cellspacing="0" cellpadding="0" class="left_menu">
								<tr>
									<td>
										<table border="0" cellspacing="0" cellpadding="0" style="margin-left:20px; ">
											<tr>
												<c:choose>
													<c:when test="${menuId eq 'patientList'}">
														<td class="menu_icon"><a href="PatientList" title="환자정보"><b>환자정보</b></a></td>
													</c:when>
													<c:otherwise>
														<td class="menu_icon"><a href="PatientList" title="환자정보">환자정보</a></td>
													</c:otherwise>
												</c:choose>
											</tr>
											<tr>
												<c:choose>
													<c:when test="${menuId eq 'userList'}">
														<td class="menu_icon"><a href="UserList" title="사용자정보"><b>사용자정보</b></a></td>
													</c:when>
													<c:otherwise>
														<td class="menu_icon"><a href="UserList" title="사용자정보">사용자정보</a></td>
													</c:otherwise>
												</c:choose>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td> 
					</tr>
					<tr>
						<td><img src="resources/images/left_bottom.gif" style="margin-top:-1px;"></td> 
					</tr>
				</table>
			</td>
		</tr>
		</c:if>
	</table>
</div>
<!--left//-->
