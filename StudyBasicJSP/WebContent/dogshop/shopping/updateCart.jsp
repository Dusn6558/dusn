<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "dogshop.shopping.CartDBBean" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String cart_id = request.getParameter("cart_id");
String buy_count = request.getParameter("buy_count");
String goods_kind = request.getParameter("goods_kind");

if(session.getAttribute("id")==null){
	response.sendRedirect("shopMain.jsp");
}else{
	CartDBBean goodsProcess = CartDBBean.getInstance();
	goodsProcess.updateCount(Integer.parseInt(cart_id),Byte.parseByte(buy_count));
	response.sendRedirect("cartList.jsp?goods_kind="+goods_kind);
	
}
%>
</body>
</html>