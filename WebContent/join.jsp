<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!--뷰포트-->

<meta name="viewport" content="width = device-width" , initial-scale="1">

<!-- 스타일시트-->

<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title></title>

</head>

<body>


	<%
	//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
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

	<!-- 로그인폼-->

	<div class="container">

		<div class="col-lg-4"></div>

		<div class="col-lg-4">

			<!-- 점보트론-->

			<div class="jumbotron" style="padding-top: 20px;">

				<!-- 로그인 정보 숨기고 전송-->

				<form method="post" action="joinAction.jsp">

					<h3 style="text-align: center;">회원가입 화면</h3>

					<div class="form-group">

						<input type="text" class="form-control" placeholder="아이디"
							name="userID" maxlength="20">

					</div>

					<div class="form-group">

						<input type="password" class="form-control" placeholder="비밀번호"
							name="userPassword" maxlength="20">

					</div>

					<div class="form-group">

						<input type="text" class="form-control" placeholder="이름"
							name="userName" maxlength="20">

					</div>

					

					<div class="form-group">

						<input type="text" class="form-control" placeholder="이메일"
							name="userEmail" maxlength="50">

					</div>



					<input type="submit" class="btn btn-primary form-control"
						value="회원가입">


				</form>

			</div>

		</div>

		<div class="col-lg-4"></div>

	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
		
	</script>

	<script src="js/bootstrap.js">
		
	</script>

</body>
</html>
