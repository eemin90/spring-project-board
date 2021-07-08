<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/board" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>Insert title here</title>
</head>
<body>
<my:navbar />
<div class="container">

	<c:if test="${not empty param.error}">
		<div id="alert1" class="alert alert-primary" role="alert">
			회원 가입에 실패하였습니다.
		</div>
	</c:if>


	<h1>회원 가입</h1>
	<div class="row">
		<div class="col-12">
			<form action="${appRoot}/member/signup" method="post">
				<div class="form-group">
					<label for="signup-input1">아이디</label>
					<input type="text" id="signup-input1" name="userid" class="form-control" />
				</div>
				<div class="form-group">
					<label for="signup-input2">패스워드</label>
					<input type="password" id="signup-input2" name="userpw" class="form-control" />
				</div>
				<div class="form-group">
					<label for="signup-input3">이름</label>
					<input type="text" id="signup-input3" name="userName" class="form-control" />
				</div>
				<button type="submit" id="signup-btn1" class="btn btn-primary">회원 가입</button>
			</form>
		</div>
	</div>
</div>
</body>
</html>