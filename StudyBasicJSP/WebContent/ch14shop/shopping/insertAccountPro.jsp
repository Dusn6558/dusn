<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="ch14.bookshop.shopping.bankDBBean" %>
<%@ page import = "ch14.bookshop.shopping.bankDataBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제계좌 등록처리</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8");
String buyer = (String)session.getAttribute("id");
String account = request.getParameter("account");
String bank = request.getParameter("bank");


bankDBBean bankprosess = bankDBBean.getInstance();
bankDataBean member = new bankDataBean();
member.setId(buyer);
member.setAccount(account);
member.setBank(bank);
member.setReg_date(new Timestamp(System.currentTimeMillis()));
bankprosess.insertAccount(member);

response.sendRedirect("buyForm.jsp");
%>

</body>
</html>