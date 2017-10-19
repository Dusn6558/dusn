<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dogshop.shopping.bankDataBean" %>
<%@ page import = "dogshop.shopping.bankDBBean" %>
    <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String buyer=(String)session.getAttribute("id");
String accountList = request.getParameter("accountList");
int index = accountList.indexOf(" ");
String account = accountList.substring(0,index);
String update_account = request.getParameter("update_account");
String update_bank=request.getParameter("update_bank");

bankDBBean bankProcess = bankDBBean.getInstance();
bankDataBean member = new bankDataBean();
member.setId(buyer);
member.setAccount(update_account);
member.setBank(update_bank);
member.setReg_date(new Timestamp(System.currentTimeMillis()));
bankProcess.updateAccount(member, account);

response.sendRedirect("buyForm.jsp");
%>

</body>
</html>