<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/board" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>
</head>
<body>
<my:navbar />
<div class="container mt-5">
	<h1>글쓰기</h1>
	<hr>
	<div class="row">
		<div class="col-12">
			<form action="${appRoot}/board/register" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="input1">제목</label>
					<input id="input1" name="title" class="form-control" />
				</div>
				<div class="form-group">
					<label for="textarea1">내용</label>
					<textarea id="textarea1" name="content" class="form-control" rows="5"></textarea>
				</div>
				<div class="form-group">
					<label for="input3">파일</label>
					<input type="file" id="input3" name="file" class="form-control" accept="image/*" />
				</div>
				<div class="form-group">
					<label for="input2">작성자</label>
					<input id="input2" name="writer" class="form-control" value="${pinfo.member.userid}" hidden readonly />
					<input class="form-control" value="${pinfo.member.userName}" readonly />
				</div>
				<input class="btn btn-primary" type="submit" value="작성" />
			</form>
		</div>
	</div>
</div>
</body>
</html>