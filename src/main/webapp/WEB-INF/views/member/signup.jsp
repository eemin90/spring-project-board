<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/board" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>Insert title here</title>

<script>
$(function() {
	// 아이디 중복 확인, 패스워드 확인 기록 저장
	var canUseId = false;
	var passwordConfirm = false;
	
	// 아이디 중복 확인
	$("#id-dup-btn").click(function() {
		var idVal = $("#signup-input1").val();
		var messageElem = $("#id-message");
		messageElem.addClass("text-danger");
		
		canUseId = false;
		
		if (idVal == "") {
			// 아이디가 입력되지 않았을 때
			messageElem.text("아이디를 입력해주세요.");
			
			// submit 버튼 enable/disable 토글
			toggleEnableSubmit();
		} else {
			// 아이디가 입력되어 있을 때
			var data = {id: idVal};
			$.ajax({
				type: "get",
				url: "${appRoot}/member/dup",
				data: data,
				success: function(data) {
					if (data == "success") {
						canUseId = true;
						messageElem.removeClass("text-danger").addClass("text-primary");
						console.log("사용 가능한 아이디");
						messageElem.text("사용 가능한 아이디 입니다.");
					} else if (data == "exist") {
						messageElem.addClass("text-danger");
						console.log("사용 불가능한 아이디");
						messageElem.text("이미 존재하는 아이디 입니다.");
					}
					
					// submit 버튼 enable/disable 토글
					toggleEnableSubmit();
				},
				error: function() {
					console.log("아이디 중복 체크 실패");
				}
			});
		}
	});
	
	// 패스워드 확인
	$("#signup-input2, #signup-input4").keyup(function() {
		var pw1 = $("#signup-input2").val();
		var pw2 = $("#signup-input4").val();
		
		passwordConfirm = false;
		
		if (pw1 != pw2) {
			$("#password-message").text("패스워드가 일치하지 않습니다.");
		} else {
			if (pw1 == "") {
				$("#password-message").text("패스워드를 입력해주세요.");
			} else {
				passwordConfirm = true;
				$("#password-message").empty();
			}
		}
		
		// submit 버튼 enable/disable 토글
		toggleEnableSubmit();
	});
	
	// 아이디 중복 확인, 패스워드 확인 기록이 둘 다 true이면 signup-btn1 활성화
	function toggleEnableSubmit() {
		if (canUseId && passwordConfirm) {
			$("#signup-btn1").removeAttr("disabled");
		} else {
			$("#signup-btn1").attr("disabled", "disabled");
		}
	}
});
</script>

</head>
<body>
<my:navbar />
<div class="container mt-5">

	<c:if test="${not empty param.error}">
		<div id="alert1" class="alert alert-danger" role="alert">
			회원 가입에 실패하였습니다.
		</div>
	</c:if>

	<h1>회원 가입</h1>
	<div class="row">
		<div class="col-12">
			<form action="${appRoot}/member/signup" method="post">
				<div class="form-group">
					<label for="signup-input1">아이디</label>
					<div class="input-group">
						<input type="text" id="signup-input1" name="userid" class="form-control" required />
						<div class="input-group-append">
							<button type="button" id="id-dup-btn" class="btn btn-outline-secondary">아이디 중복 체크</button>
						</div>
					</div>
					<small id="id-message" class="form-text"></small>
				</div>
				<div class="form-group">
					<label for="signup-input2">패스워드</label>
					<input type="password" id="signup-input2" name="userpw" class="form-control" required />
				</div>
				<div class="form-group">
					<label for="signup-input4">패스워드 확인</label>
					<input type="password" id="signup-input4" class="form-control" required />
					<small id="password-message" class="form-text text-danger"></small>
				</div>
				<div class="form-group">
					<label for="signup-input3">이름</label>
					<input type="text" id="signup-input3" name="userName" class="form-control" required />
				</div>
				<button type="submit" id="signup-btn1" class="btn btn-primary" disabled>회원 가입</button>
			</form>
		</div>
	</div>
</div>
</body>
</html>