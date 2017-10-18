<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#8BBDFF">
<%
try{
	if(session.getAttribute("id")==null){%>
	<a href = "../shopping/list.jsp?book_kind=all">전체목록보기</a>
	<br><br>
	<form method="post" action="../shopping/loginPro.jsp">
		아이디 : <input type="text" name="id" size="15" maxlength="50">
		비밀번호 : <input type="password" name="passwd" size="15" maxlength="16">
		<input type="submit" value="로그인">
	</form>
	<font color="red">반드시 로그인을 하셔야 서비스를 이용하실 수 있습니다.</font>
	<br><br>
	<%}else{ %>
		<a href = "../shopping/list.jsp?book_kind=all">전체목록보기</a>
		<a href = "../shopping/cartList.jsp?book_kind=all">장바구니보기</a>
		<a href = "../shopping/buyList.jsp">구매목록보기</a>
		
		<br>
		<br>
		<b><%=session.getAttribute("id") %></b>님, i-book 에 오신것을 환영합니다^^*
		<input type="button" value="로그아웃" 
		onclick="javascript:window.location='../shopping/logout.jsp'">
		<%}
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>