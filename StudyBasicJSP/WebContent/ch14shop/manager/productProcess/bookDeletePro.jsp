<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import = "dogshop.master.ShopdogDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>
<%
int goods_id=Integer.parseInt(request.getParameter("goods_id"));
String goods_kind = request.getParameter("goods_kind");

ShopdogDBBean goodsProcess = ShopdogDBBean.getInstance();
goodsProcess.deletegoods(goods_id);

response.sendRedirect("goodsList.jsp?goods_kind=all");%>
</body>
</html>