<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width" initial-scale="1">

<!-- 스타일시트 참조  -->

<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>게시판 웹사이트</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>

</head>

<body>

	<%
	//로그인시	userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int pageNumber = 1; //기본 첫페이지가 1이기 때문에 1로 해준다.
	if (request.getParameter("pageNumber") != null) { //parameter로 값이 넘어 왔으면 그 parameter 값을 넣어 줄 수 있도록 한다.
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>

<jsp:include page="header.jsp"/>


	<!-- 게시판 -->

	<div class="container">

		<div class="row">

			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">

				<thead>

					<tr>

						<th style="background-color: #eeeeee; text-align: center;">번호</th>

						<th style="background-color: #eeeeee; text-align: center;">제목</th>

						<th style="background-color: #eeeeee; text-align: center;">작성자</th>

					</tr>

				</thead>

				<tbody>
					<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for (int i = 0; i < list.size(); i++) {
					%>

					<tr>

						<td><%=list.get(i).getBbsID()%></td>
						<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
		.replaceAll("\n", "<br>")%></a></td>
						<td><%=list.get(i).getUserID()%></td>
						
					<%
					}
					%>

				</tbody>

			</table>
			<%
			if (pageNumber != 1) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arraw-left">이전페이지</a>
			<%
			}
			if (bbsDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arraw-left">다음페이지</a>
			<%
			}
			%>

			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>

		</div>

	</div>






<jsp:include page="footer.jsp"/>

</body>

</html>

