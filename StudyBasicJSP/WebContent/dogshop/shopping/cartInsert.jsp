<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@page import = "dogshop.shopping.CartDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<%
String goods_kind = request.getParameter("goods_kind");
String buy_count = request.getParameter("buy_count");
String goods_id = request.getParameter("goods_id");
String goods_name = request.getParameter("goods_name");
String goods_image = request.getParameter("goods_image");
String buy_price = request.getParameter("buy_price");
String buyer = (String)session.getAttribute("id");

%>
<jsp:useBean id="cart" scope="page" class="dogshop.shopping.CartDataBean">
</jsp:useBean>
<%
cart.setGoods_id(Integer.parseInt(goods_id));
cart.setGoods_image(goods_image);
cart.setGoods_name(goods_name);
cart.setBuy_count(Byte.parseByte(buy_count));
cart.setBuy_price(Integer.parseInt(buy_price));
cart.setBuyer(buyer);

CartDBBean goodsProcess = CartDBBean.getInstance();
goodsProcess.insertCart(cart);
response.sendRedirect("cartList.jsp?goods_kind="+goods_kind);


%>


</body>
</html>