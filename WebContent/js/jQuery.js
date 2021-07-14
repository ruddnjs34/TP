 // 댓글 입력
	    $("#reply_btn").click(function(){
	    	if($("#reply_content").val().trim() === ""){
	    		alert("댓글을 입력하세요.");
	    		$("#reply_content").val("").focus();
	    	}else{
	    		$.ajax({
	    			url: "/expro/ReplyWriteAction.do",
	                type: "POST",
	                data: {
	                    no : $("#no").val(),
	                    id : $("#id").val(),
	                    reply_content : $("#reply_content").val()
	                },
	                success: function () {
	                	alert("댓글 등록 완료");
	                	$("#reply_content").val("");
	                	getReply();
	                },
	    		})
	    	}
	    })