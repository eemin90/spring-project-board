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
	// 수정 혹은 탈퇴 버튼 구분
	whichButton = "";
	
	// modal의 확인 버튼 클릭 시
	$("#old-password-modal-btn").click(function() {
		switch (whichButton) {
			case "modify-button" :
				$("#member-info-form1")
				.attr("action", "${appRoot}/member/modify")
				.submit();
			break;
			
			case "remove-button" :
				$("#member-info-form1")
				.attr("action", "${appRoot}/member/remove")
				.submit();
			break;
		}
	});
	
	// 수정 버튼
	$("#member-info-modify-btn1").click(function(e) {
		e.preventDefault();
		whichButton = "modify-button";
		$("#old-password-modal").modal("show");
	});
	
	// 탈퇴 버튼
	$("#member-info-remove-btn1").click(function() {
		var ans = confirm("탈퇴 하시겠습니까?");
		whichButton = "remove-button";
		
		if (ans) {
			$("#old-password-modal").modal("show");
			
			/*
			$("#member-info-form1")
			.attr("action", "${appRoot}/member/remove")
			.submit();
			*/
		}
	});
	
	// 패스워드 확인
	$("#member-info-input2, #member-info-input4").keyup(function() {
		var pw1 = $("#member-info-input2").val();
		var pw2 = $("#member-info-input4").val();
		var modifyBtn = $("#member-info-modify-btn1");
		
		if (pw1 != pw2) {
			modifyBtn.attr("disabled", "disabled");
			$("#member-info-password-message").text("패스워드가 일치하지 않습니다.");
		} else {
			if (pw1 == "") {
				modifyBtn.attr("disabled", "disabled");
				$("#member-info-password-message").text("패스워드를 입력해주세요.");
			} else {
				modifyBtn.removeAttr("disabled");
				$("#member-info-password-message").empty();
			}
		}
	});
	
	// 패스워드 보이기, 감추기 토글
	$("#toggle-password-btn").click(function() {
		var inputElem = $("#member-info-input2")
		
		if (inputElem.attr("type") == "password") {
			inputElem.attr("type", "text");
			$("#toggle-password-icon").removeClass("fa-eye").addClass("fa-eye-slash");
		} else {
			inputElem.attr("type", "password");
			$("#toggle-password-icon").removeClass("fa-eye-slash").addClass("fa-eye");
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
					<label for="member-info-input2">새 패스워드</label>
					<div class="input-group">
						<input type="password" id="member-info-input2" name="userpw" class="form-control" required />
						<div class="input-group-append">
							<button type="button" id="toggle-password-btn" class="btn btn-outline-secondary">
								<i id="toggle-password-icon" class="far fa-eye"></i>
							</button>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="member-info-input4">새 패스워드 확인</label>
					<input type="password" id="member-info-input4" class="form-control" required />
					<small id="member-info-password-message" class="form-text text-danger"></small>
				</div>
				<div class="form-group">
					<label for="member-info-input3">이름</label>
					<input type="text" id="member-info-input3" name="userName" class="form-control" value="${member.userName}" required />
				</div>
				<button type="submit" id="member-info-modify-btn1" class="btn btn-secondary" disabled>정보 수정</button>
				<button type="button" id="member-info-remove-btn1" class="btn btn-danger">회원 탈퇴</button>
			</form>
		</div>
	</div>
</div>

<%-- 회원 탈퇴 시 기존 패스워드 입력 modal --%>
<div class="modal fade" id="old-password-modal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">기존 패스워드 입력</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="old-password-input">기존 패스워드</label>
					<input form="member-info-form1" type="password" id="old-password-input" name="oldPassword" class="form-control" required />
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="old-password-modal-btn" class="btn btn-danger">확인</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

</body>
</html>