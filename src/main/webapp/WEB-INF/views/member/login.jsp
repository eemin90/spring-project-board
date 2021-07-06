<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/board"%>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>Insert title here</title>
</head>
<body>
<my:navbar />
<div class="container mt-5">
	<div class="row justify-content-center">
		<div class="col-md-12 col-6">
			<h1>로그인</h1>
			<hr>
			<form action="${appRoot}/login" method="post">
				<div class="form-group">
					<label for="input1">이름</label>
					<input id="input1" name="username" class="form-group" />
				</div>
				<div class="form-group">
					<label for="input2">패스워드</label>
					<input id="input2" type="password" name="password" class="form-group" />
				</div>
				<input type="submit" value="로그인" class="btn btn-primary" />
			</form>
		</div>
	</div>
</div>
</body>
</html>