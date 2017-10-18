<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 계좌 등록</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String buyer = (String)session.getAttribute("id");
if(buyer==null){
	response.sendRedirect("shopMain.jsp");
}else{
%>
<h3><%=buyer %>님의 계좌 등록</h3>
<form action="insertAccountPro.jsp" method="post">
<table align="center">
	<tr>
		<td width="50" align="center">결제계좌</td>
		<td width="300">
			<input type="text" name="account">
		</td>
	</tr>
	<tr>
		<td width="100" align="center">결제은행</td>
		<td width="300">
			<input type="text" name="bank">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="확인" >&nbsp;
			<input type="button" value="취소" 
			onclick="javascript:window.location='buyForm.jsp'">
		</td>
	</tr>

</table>
</form>
<%} %>
</body>
</html>