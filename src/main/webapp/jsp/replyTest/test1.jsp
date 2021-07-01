<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>
</head>
<body>
<div class="container">
	<script>
	$(function() {
		$("#btn1").click(function() {
			$.post({
				url: "${appRoot}/replies/new",
				data: JSON.stringify({ // JavaScript 값이나 객체를 JSON 문자열로 변환. JSON.parse()는 JSON 문자열을 JavaScript 값이나 객체로 변환.
					bno: 136,
					reply: "새로운 댓글",
					replyer: "user00"
				}),
				contentType: "application/json",
				success: function(data) {
					console.log(data);
				},
				error: function() {
					console.log("등록 실패");
				}
			});
		});
		
		$("#btn2").click(function() {
			$.post({
				url: "${appRoot}/replies/new",
				data: JSON.stringify({ // JavaScript 값이나 객체를 JSON 문자열로 변환. JSON.parse()는 JSON 문자열을 JavaScript 값이나 객체로 변환.
					bno: 136136136,
					reply: "새로운 댓글",
					replyer: "user00"
				}),
				contentType: "application/json",
				success: function(data) {
					console.log(data);
				},
				error: function() {
					console.log("등록 실패");
				}
			});
		});
	});
	</script>
	<h5>입력 테스트</h5>
	<button id="btn1">TEST CREATE - success</button>
	<button id="btn2">TEST CREATE - fail</button>
	
	<hr>
	
	<script>
	$(function() {
		$("#btn3").click(function() {
			const bno = 136;
			
			$.get({
				url: "${appRoot}/replies/pages/" + bno,
				success: function(data) {
					console.log(data);
				}
			});
		});
	});
	</script>
	<h5>목록 테스트</h5>
	<button id="btn3">TEST LIST</button>
	
	<hr>
	
	<script>
	$(function() {
		$("#btn4").click(function() {
			const rno = 5;
			
			$.get({
				url: "${appRoot}/replies/" + rno,
				success: function(data)	{
					console.log(data);
				}
			});
		});
	});
	</script>
	<h5>댓글 하나</h5>
	<button id="btn4">TEST GET</button>
	
	<hr>
	
	<script>
	$(function() {
		$("#btn5").click(function() {
			const rno = 5;
			
			$.ajax({
				type: "delete",
				url: "${appRoot}/replies/" + rno,
				success: function() {
					console.log("delete success");
				},
				error: function() {
					console.log("delete fail");
				}
			});
		});
	});
	</script>
	<h5>댓글 삭제</h5>
	<button id="btn5">TEST DELETE</button>
	
	<hr>
	
	<script>
	$(function() {
		$("#btn6").click(function() {
			const rno = 3;
			const data = {
					rno: rno,
					bno: 136,
					reply: "수정된 댓글!",
					replyer: "user"
			};
			
			$.ajax({
				type: "put",
				url: "${appRoot}/replies/" + rno,
				data: JSON.stringify(data),
				contentType: "application/json",
				success: function() {
					console.log("update success");
				},
				error: function() {
					console.log("update fail");
				}
			});
		});
	});
	</script>
	<h5>댓글 수정</h5>
	<button id="btn6">TEST UPDATE</button>
	
	<hr>
	
	<script>
	$(function() {
		$("#btn7").click(function() {
			const rno = $("#input1").val();
			const bno = $("#input2").val();
			const reply = $("#input3").val();
			const replyer = $("#input4").val();
			
			const data = {
					rno: rno,
					bno: bno,
					reply: reply,
					replyer: replyer
			};
			
			$.ajax({
				type: "put",
				url: "${appRoot}/replies/" + rno,
				data: JSON.stringify(data),
				contentType: "application/json",
				success: function() {
					console.log("update success");
				},
				error: function() {
					console.log("update fail");
				}
			});
		});
	});
	</script>
	<h5>댓글 수정 form</h5>
	<input id="input1" name="rno" value="3" readonly />
	<input id="input2" name="bno" value="136" readonly />
	<input id="input3" name="reply" placeholder="댓글 입력" />
	<input id="input4" name="replyer" placeholder="작성자 입력" />
	<button id="btn7">TEST UPDATE form</button>
</div>
</body>
</html>