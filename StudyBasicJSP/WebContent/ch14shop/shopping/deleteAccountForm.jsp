<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../etc/color.jspf"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제계좌 삭제</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String buyer = (String)session.getAttribute("id");
String accountList = request.getParameter("accountList");
String account = request.getParameter("account");
if(buyer==null){
	response.sendRedirect("shopMain.jsp");        
}else{
%>
<h3><%=buyer %>님의 계좌삭제</h3>
<form action="deleteAccountPro.jsp" method="post">
<table align="center">
	<tr>
	<td width="450" align="center" height="50" colspan="2"><font size="+1"><%=accountList %></font> 
	<input type="hidden" name="accountList" value="<%=accountList %>">
	</td>
	</tr>
	<tr>
		<td width="150" align="center">비밀번호 확인</td>
		<td width="300" align="center"><input type="text" name="passwd">
	</tr>
	<tr>
	<td width="450" align="center" colspan="2">
	<input type="submit" value="확인">
	<input type="button" value="취소"
	onclick="javascript:window.location='buyForm.jsp'">
	</tr>

</table>
</form>
<%} %>
</body>
</html>