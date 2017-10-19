<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ch14.bookshop.shopping.bankDataBean" %>
<%@ page import = "ch14.bookshop.shopping.bankDBBean" %>
<%@ page import = "ch14.bookshop.shopping.CustomerDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); 
String accountList = request.getParameter("accountList");
String buyer=(String)session.getAttribute("id");
String passwd = request.getParameter("passwd");
int index = accountList.indexOf(" ");
String account = accountList.substring(0,index);

CustomerDBBean memberProcess = CustomerDBBean.getInstance();
int x = memberProcess.userCheck(buyer, passwd);
if(x==1){
bankDBBean bankProcess = bankDBBean.getInstance();
bankProcess.deleteAccount(buyer, account);
%>
<script>
 alert("계좌를 삭제 하였습니다");
</script>
<%
response.sendRedirect("buyForm.jsp");
}else {
	%>
	<script>
	 alert("비밀번호가 틀렸습니다.");
	history.go(-1);
	</script>
	<%
}
%>

</body>
</html>