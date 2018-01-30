<%@ page language="java" contentType="text/html;charset=UTF-8"	errorPage="/common/error.jsp" %>
<%@ include file="/common/taglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function() {
		$("a[name='pager']").bind("click", function () {
			var tmp = $(this).attr("id").split("_");
			
			$("#pageCount").val(tmp[1]);
			$("#searchForm").submit();
		});
	});
</script>
			<table width="800" border="0" cellspacing="0" cellpadding="0" class="number" id="paging" >
				<tr>
					<td>&nbsp;</td>
					<td>
						<c:choose>
							<c:when test="${1 ==  pageCount}">
								<img src="resources/images/btn_left2.gif"alt="첫페이지로">
							</c:when>
							<c:otherwise>
								<a href="#" id="pCount_1" name="pager" title="첫페이지로"><img src="resources/images/btn_left2.gif"alt="첫페이지로"></a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${1 >=  pageCount}">
								<img src="resources/images/btn_left.gif"alt="이전페이지로">
							</c:when>
							<c:otherwise>
								<a href="#" id="pCount_${pageCount - 1}" name="pager" title="이전페이지로"><img src="resources/images/btn_left.gif"alt="이전페이지로"></a>
							</c:otherwise>
						</c:choose>
						<c:forEach var="i" begin="${startPcount}" end="${endPcount}" step="1">
							<c:choose>
								<c:when test="${i == pageCount}">
									<b>${i}</b>&nbsp;
								</c:when>
								<c:otherwise>
									<a href="#" id="pCount_${i}" name="pager" title="${i}">${i}</a>&nbsp;
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${maxPcount <=  pageCount}">
								<img src="resources/images/btn_right.gif"alt="다음페이지로">
							</c:when>
							<c:otherwise>
								<a href="#" id="pCount_${pageCount + 1}" name="pager" title="다음페이지로"><img src="resources/images/btn_right.gif"alt="다음페이지로"></a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${maxPcount ==  pageCount}">
								<img src="resources/images/btn_right2.gif"alt="마지막페이지로">
							</c:when>
							<c:otherwise>
								<a href="#" id="pCount_${maxPcount}" name="pager" title="마지막페이지로"><img src="resources/images/btn_right2.gif"alt="마지막페이지로"></a>
							</c:otherwise>
						</c:choose>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
