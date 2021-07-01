<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/board" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>
<script>
var appRoot = "${appRoot}";
var boardBno = "${board.bno}";
</script>
<script type="text/javascript" src="${appRoot}/resources/js/get.js"></script>

</head>
<body>
<my:navbar />
<div class="container">

<div id="alert1" class="alert alert-primary fade" role="alert"></div>
	<h1>글 보기</h1>
	<hr>
	<div class="row">
		<div class="col-12">
			<form>
				<div class="form-group">
					<label for="input1">제목</label>
					<input id="input1" class="form-control" name="title" value="${board.title}" readonly>
				</div>
				<div class="form-group">
					<label for="textarea1">내용</label>
					<textarea id="textarea1" class="form-control" name="content" rows="5" readonly><c:out value="${board.content}" /></textarea>
				</div>
				<div class="form-group">
					<label for="input2">작성자</label>
					<input id="input2" class="form-control" name="writer" value="${board.writer}" readonly>
				</div>
				
				<c:url value="/board/modify" var="modifyUrl">
					<c:param name="bno" value="${board.bno}" />
					<c:param name="pageNum" value="${cri.pageNum}" />
					<c:param name="amount" value="${cri.amount}" />
					<c:param name="type" value="${cri.type}" />
					<c:param name="keyword" value="${cri.keyword}" />
				</c:url>
				
				<hr>
				<a class="btn btn-secondary" href="${modifyUrl}">수정/삭제</a>
			</form>
		</div>
	</div>
</div>

<!-- 댓글 목록 -->
<div class="container mt-5">
	<div class="row">
		<div class="col-12">
			<h4>댓글</h4>
			<hr>
			<ul class="list-unstyled" id="reply-list-container">
				
			</ul>
		</div>
	</div>
</div>

<!-- 댓글 입력 -->
<div class="container">
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#reply-insert-modal">댓글 작성</button>
	
	<div class="modal fade" id="reply-insert-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">새 댓글</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<input type="text" value="${board.bno}" id="reply-bno-input1" readonly hidden />
						<div class="form-group">
							<label for="reply-replyer-input1" class="col-form-label">작성자</label>
							<input type="text" class="form-control" id="reply-replyer-input1" />
						</div>
						<div class="form-group">
							<label for="reply-reply-textarea1" class="col-form-label">댓글</label>
							<textarea class="form-control" id="reply-reply-textarea1"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button id="reply-insert-btn1" type="button" class="btn btn-primary">댓글 입력</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 댓글 수정, 삭제 -->
<div class="modal fade" id="reply-modify-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">댓글 수정/삭제</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<input type="text" value="" id="reply-rno-input2" readonly hidden />
					<input type="text" value="${board.bno}" id="reply-bno-input2" readonly hidden />
					<div class="form-group">
						<label for="reply-replyer-input1" class="col-form-label">작성자</label>
						<input type="text" class="form-control" id="reply-replyer-input2" />
					</div>
					<div class="form-group">
						<label for="reply-reply-textarea1" class="col-form-label">댓글</label>
						<textarea class="form-control" id="reply-reply-textarea2"></textarea>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button id="reply-modify-btn1" type="button" class="btn btn-primary">댓글 수정</button>
				<button id="reply-delete-btn1" type="button" class="btn btn-danger">댓글 삭제</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

</body>
</html>