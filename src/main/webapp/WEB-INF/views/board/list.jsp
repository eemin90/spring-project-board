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

<script>
	$(document).ready(function() {
		if (history.state == null) {
			$('#modal1').modal('show');
			history.replaceState({}, null);
		}
		
		$("#list-pagenation1 a").click(function(e) {
			// hyperlink 역할 중지
			e.preventDefault();
			
			var actionForm = $("#actionForm");
			
			// form의 input 태그의 pageNum값을 a 요소의 href 값으로 변경
			actionForm.find("[name=pageNum]").val($(this).attr("href"));
			
			actionForm.submit();
		});
	});
</script>

</head>
<body>
<my:navbar />

<!-- List -->
<div class="container mt-5">
	<h1>글 목록</h1>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일시</th>
				<th>수정일시</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="board">
				<tr>
					<td>${board.bno}</td>
					
					<!-- ${getUrl}을 쓰면 ${appRoot}/board/get?bno=${board.bno}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}... 이라고 보면 됨 -->
					<c:url value="/board/get" var="getUrl">
						<c:param name="bno" value="${board.bno}" />
						<c:param name="pageNum" value="${pageMaker.cri.pageNum}" />
						<c:param name="amount" value="${pageMaker.cri.amount}" />
						<c:param name="type" value="${pageMaker.cri.type}" />
						<c:param name="keyword" value="${pageMaker.cri.keyword}" />
					</c:url>

					<!-- 제목의 길이가 30 이상이면 30자 까지만 출력하고 뒤에 '...'을 붙인다 -->
					<c:choose>
						<c:when test="${fn:length(board.title) >= 30}">
							<td>
								<!-- getUrl 사용 -->
								<a href="${getUrl}">
									${fn:substring(board.title, 0, 30)}...
									<c:if test="${board.replyCnt > 0}">
										<small>[${board.replyCnt}]</small>
									</c:if>
								</a>
							</td>
						</c:when>
						<c:when test="${fn:length(board.title) < 30}">
							<td>
								<!-- getUrl 사용 -->
								<a href="${getUrl}">
									${board.title}
									<c:if test="${board.replyCnt > 0}">
										<small>[${board.replyCnt}]</small>
									</c:if>
								</a>
							</td>
						</c:when>
					</c:choose>

					<!-- 작성자의 길이가 10 이상이면 10자 까지만 출력하고 뒤에 '...'을 붙인다 -->
					<c:choose>
						<c:when test="${fn:length(board.writer) >= 10}">
							<td>${fn:substring(board.writer, 0, 10)}...</td>
						</c:when>
						<c:when test="${fn:length(board.writer) < 10}">
							<td>${board.writer}</td>
						</c:when>
					</c:choose>
					
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.updateDate}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<!-- Pagenation -->
<nav aria-label="Page navigation">
	<ul id="list-pagenation1" class="pagination justify-content-center">
		<c:if test="${pageMaker.prev}">
			<li class="page-item"><a class="page-link" href="${pageMaker.startPage - 1}">Previous</a></li>
		</c:if>
		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
			<!-- href value
			<li class="page-item"><a class="page-link" href="${appRoot}/board/list?pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}">${num}</a></li>
			-->
			<li class="page-item ${num == cri.pageNum ? 'active' : ''}"><a class="page-link" href="${num}">${num}</a></li>
		</c:forEach>
		<c:if test="${pageMaker.next}">
			<li class="page-item"><a class="page-link" href="${pageMaker.endPage + 1}">Next</a></li>
		</c:if>
	</ul>
</nav>

<!-- Pagenation Form -->
<div style="display: none;">
	<form id="actionForm" action="${appRoot}/board/list" method="get">
		<input name="pageNum" value="${cri.pageNum}" />
		<input name="amount" value="${cri.amount}" />
		<input name="type" value="${cri.type}" />
		<input name="keyword" value="${cri.keyword}" />
	</form>
</div>

<!-- Modal -->
<c:choose>
	<c:when test="${not empty result}">
		<div class="modal fade" id="modal1" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="modal1Label" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal1Label">알림</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">${result}번 글이 등록되었습니다.</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</c:when>
	<c:when test="${not empty modify}">
		<div class="modal fade" id="modal1" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="modal1Label" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal1Label">알림</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">${modify}번 글이 수정되었습니다.</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
		</c:when>
	<c:when test="${not empty remove}">
		<div class="modal fade" id="modal1" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="modal1Label" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal1Label">알림</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">${remove.bno}번 글이 삭제되었습니다.</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</c:when>
</c:choose>

</body>
</html>