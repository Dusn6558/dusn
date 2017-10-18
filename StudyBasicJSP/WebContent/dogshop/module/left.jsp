<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="#8BBDFF">

<p>책분류</p>
<br>
<a href="../shopping/list.jsp?book_kind=all">전체목록보기</a><br><br>
<a href="../shopping/list.jsp?book_kind=100">문학</a><br><br><br>
<a href="../shopping/list.jsp?book_kind=200">외국어</a><br><br><br>
<a href="../shopping/list.jsp?book_kind=300">컴퓨터</a><br><br><br>
<a href="../shopping/list.jsp?book_kind=400">취미레져</a><br><br><br>
<a href="../shopping/list.jsp?book_kind=500">여행</a><br><br><br>
<%
String buyer = (String)session.getAttribute("id");
if (buyer==null){}
else {
	%><a href="../../ch13/board/list.jsp">게시판 보기</a>
<% }
%>



</body>
</html>