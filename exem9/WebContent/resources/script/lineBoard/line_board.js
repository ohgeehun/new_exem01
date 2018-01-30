function showMessage(msg) {
	alert(msg);
}

function goPage(page) {
	document.getElementById("nowPage").value = page;
	document.getElementById("pagingForm").submit();
}

function goDelete(boardNo) {
	if(confirm(boardNo + "번 글을 삭제하시겠습니까?")) {
		document.getElementById("deleteBoardNo").value = boardNo;
		document.getElementById("deleteForm").submit();
	}
}

function logout() {
	location.href = "logout";
}