<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goods Shopping Mall</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String cart_id = request.getParameter("cart_id");
String buy_count = request.getParameter("buy_count");
String goods_kind = request.getParameter("goods_kind");

if(session.getAttribute("id")==null){
	response.sendRedirect("shopMain.jsp");
}else{
	%>
	<form action="updateCart.jsp" name="updateForm" method="post">
	변경할 수량 : <input type="text" name="buy_count" size="5" value="<%=buy_count%>">
	<input type="hidden" name="cart_id" value="<%=cart_id %>">
	<input type="hidden" name="goods_kind" value="<%=goods_kind %>">
	<input type="submit" value="변경">
	
	</form>

</body>
</html>
<%} %>