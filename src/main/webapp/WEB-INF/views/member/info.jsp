<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/board" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<script>
$(function() {
	$("#member-info-remove-btn1").click(function() {
		var ans = confirm("탈퇴 하시겠습니까?");
		
		if (ans) {
			$("#member-info-form1")
			.attr("action", "${appRoot}/member/remove")
			.submit();
		}
	});
});
</script>

<title>Insert title here</title>
</head>
<body>
<my:navbar />
<div class="container mt-5">

	<c:if test="${param.status == 'success'}">
		<div id="alert1" class="alert alert-primary" role="alert">
			회원 정보를 수정하였습니다.
		</div>
	</c:if>
	<c:if test="${param.status == 'error'}">
		<div id="alert1" class="alert alert-danger" role="alert">
			회원 정보 수정에 실패하였습니다.
		</div>
	</c:if>

	<h1>회원 정보</h1>
	<div class="row">
		<div class="col-12">
			<form id="member-info-form1" action="${appRoot}/member/modify" method="post">
				<div class="form-group">
					<label for="member-info-input1">아이디</label>
					<input type="text" id="member-info-input1" name="userid" class="form-control" value="${member.userid}" readonly />
				</div>
				<div class="form-group">
					<label for="member-info-input2">패스워드</label>
					<input type="password" id="member-info-input2" name="userpw" class="form-control" />
				</div>
				<div class="form-group">
					<label for="member-info-input3">이름</label>
					<input type="text" id="member-info-input3" name="userName" class="form-control" value="${member.userName}" />
				</div>
				<button type="submit" id="member-info-modify-btn1" class="btn btn-secondary">정보 수정</button>
				<button type="button" id="member-info-remove-btn1" class="btn btn-danger">회원 탈퇴</button>
			</form>
		</div>
	</div>
</div>
</body>
</html>