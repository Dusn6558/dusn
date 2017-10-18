<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import = "dogshop.master.ShopdogDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<%
String id=request.getParameter("id");
String passwd = request.getParameter("passwd");
ShopdogDBBean manager = ShopdogDBBean.getInstance();
int check = manager.managerCheck(id, passwd);

if(check == 1){
	session.setAttribute("managerId",id);
	response.sendRedirect("../managerMain.jsp");
}else if(check==0){%>
	<script>
alert("비밀번호가 맞지 않습니다.");
history.go(-1);
</script>
	<%}else{ %>
	<script>
alert("아이디가 맞지 않습니다.");
history.go(-1);
</script>
	<%} %>

</body>
</html>