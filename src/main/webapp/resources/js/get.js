/**
 * 
 */
$(function() {
	function showModifyModal(rno) {
		$.ajax({
			type: "get",
			url: appRoot + "/replies/" + rno,	
			success: function(reply) {
				$("#reply-rno-input2").val(reply.rno);
				$("#reply-replyer-input2").val(reply.replyer);
				$("#reply-reply-textarea2").text(reply.reply);
				$("#reply-modify-modal").modal("show");
			},
			error: function() {
				console.log("댓글 가져오기 실패");
			}
		});
	}
	
	function showReplyList(list) {
		var container = $("#reply-list-container").empty();
		
		for (var reply of list) {
			var replyHTML = `
				<li class="media" id="reply${reply.rno}" data-rno="${reply.rno}">
					<div class="media-body">
						<div class="d-flex justify-content-between">
							<strong class="flex-grow-1 bd-highlight">${reply.replyer}</strong>
							<small class="bd-highlight text-muted">${new Date(reply.replyDate).toISOString().split("T")[0]}</small><br>
						</div>
						<small>${reply.reply}</small><hr>
					</div>
				</li>
			`;
			
			var replyComponent = $(replyHTML).click(function() {
				showModifyModal($(this).attr("data-rno"));
			});
			
			container.append(replyComponent);
		}
		
		/* 위의 for문으로 대체함(backtick ver)
		for (var reply of list) {
			var newItem = $("<li>").addClass("media")
									.attr("id", "reply" + reply.rno)
									.attr("data-rno", reply.rno);
			var mediaBody = $("<div>").addClass("media-body");
			
			newItem.click(function() {
				showModifyModal($(this).attr("data-rno"));
			});
			
			newItem.append(mediaBody);
			mediaBody.append('<strong class="my-4">' + reply.replyer + "</strong>")
					 .append('<small class="text-muted">' + new Date(reply.replyDate).toISOString().split("T")[0] + "</small><br>")
					 .append("<small>" + reply.reply + "</small><hr>");
			container.append(newItem);
		}
		*/
	}
	
	/* 댓글 목록 가져오기 */
	function getReplyList() {
		$.ajax({
			type: "get",
			url: appRoot + "/replies/pages/" + boardBno,
			success: function(list) {
				console.log(list);
				showReplyList(list);
			},
			error: function() {
				console.log("댓글 가져오는중 에러.");
			}
		});
	}
	
	/* 페이지 로딩 후 댓글 목록 가져오는 함수 실행 */
	getReplyList();
	
	/* 댓글 입력 버튼 */
	$("#reply-insert-btn1").click(function() {
		var bno = $("#reply-bno-input1").val();
		var replyer = $("#reply-replyer-input1").val();
		var reply = $("#reply-reply-textarea1").val();
		
		var data = {
			bno: bno,
			replyer: replyer,
			reply: reply
		};
		
		$.ajax({
			type: "post",
			url: appRoot + "/replies/new",
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function() {
				console.log("입력 성공");
				// 모달창 닫고
				$("#reply-insert-modal").modal("hide");
				// 댓글 리스트 가져오고
				getReplyList();
				// 안내 메세지 보여주기
				$("#alert1").text("새 댓글을 입력하였습니다.").addClass("show");
			},
			error: function() {
				console.log("입력 실패");
			}
		});
	});
	
	/* 댓글 수정 버튼 */
	$("#reply-modify-btn1").click(function() {
		var rno = $("#reply-rno-input2").val();
		var bno = $("#reply-bno-input2").val();
		var replyer = $("#reply-replyer-input2").val();
		var reply = $("#reply-reply-textarea2").val();
		
		var data = {
			rno: rno,
			bno: bno,
			replyer: replyer,
			reply: reply
		};
		
		$.ajax({
			type: "put",
			url: appRoot + "/replies/" + rno,
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function() {
				console.log("수정 성공");
				// 모달창 닫고
				$("#reply-modify-modal").modal("hide");
				// 댓글 리스트 가져오고
				getReplyList();
				// 안내 메세지 보여주기
				$("#alert1").text("댓글을 수정하였습니다.").addClass("show");
			},
			error: function() {
				console.log("수정 실패");
			}
		});
	});
	
	/* 댓글 삭제 버튼 */
	$("#reply-delete-btn1").click(function() {
		var check = confirm("삭제 하시겠습니까?");
		
		if (check) {
			var rno = $("#reply-rno-input2").val();
			
			$.ajax({
				type: "delete",
				url: appRoot + "/replies/" + rno,
				success: function() {
					console.log("삭제 성공");
					// 모달창 닫고
					$("#reply-modify-modal").modal("hide");
					// 댓글 리스트 가져오고
					getReplyList();
					// 안내 메세지 보여주기
					$("#alert1").text("댓글을 삭제하였습니다.").addClass("show");
				},
				error: function() {
					console.log("삭제 실패");
				}
			});
		}
	});
});