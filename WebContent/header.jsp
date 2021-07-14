<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/header.css?ver=1">
</head>
<body>

	<header>
		

		<div class="serviceArea">
			<ul>
				<li><a href="#">장바구니</a></li>
				
				<li><a href="login.jsp">로그인</a></li>
			
				<li><a href="bbs.jsp">고객센터</a></li>
				
				<li><a href="join.jsp">회원가입</a></li>
			</ul>
		</div>

		<div class="logo" onclick="location.href='index.jsp'">
			<img src="image/logo.jpg" alt="로고">
		</div>

		<nav class="gnb">
			<ul>
				<li><a href="#">전체 카테고리</a>
					<ul>
						<li><a href="#">한식</a></li>
						<li><a href="#">양식</a></li>
						<li><a href="#">중식</a></li>
						<li><a href="#">일식</a></li>
					</ul></li>
				<li><a href="#">신상품</a></li>
				<li><a href="#">베스트</a></li>
				<li><a href="#">특가</a></li>
				<li><a href="#">레시피</a></li>
			</ul>

			<span class="searchArea"> 
				<input type="search" placeholder="Search"> 
				<input type="button" value="검색">
			</span>
		</nav>

	</header>

</body>
</html>