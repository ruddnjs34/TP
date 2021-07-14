<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<!-- userdao의 클래스 가져옴 -->
<%@ page import="bbs.Bbs"%>
<%@ page import="java.io.PrintWriter"%>
<!-- 자바 클래스 사용 -->
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>
</head>
<body>
	<%
	String userID = null;

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");

		script.println("alert('로그인을 하세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}

	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");

		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	if (!userID.equals(bbs.getUserID())) { //글을 쓴 사람 확인
		PrintWriter script = response.getWriter();
		script.println("<script>");

		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	} //글 수정 권한이 있는 사람이라면 수정이 가능 하다.

	else { //NULL값이거나 빈칸이 하나라도 있는 경우 입력이 안 된 사항이 있다고 경고창을 띄웁니다.

		if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null

		|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals(""))

		{ //update에 있던 bbsTitle과 bbsContent로 넘어온 매개변수값들을 분석  
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			BbsDAO bbsDAO = new BbsDAO(); //인스턴스생성
			int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));

			if (result == -1) { // 아이디가 기본키기. 중복되면 오류.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글수정에 실패하였습니다.')");
		script.println("history.back()");
		script.println("</script>");
			}
			//글쓰기성공
			else {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글쓰기가 정상적으로 처리되었습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
			}
		}

	}
	%>

</body>

</body>
</html>

