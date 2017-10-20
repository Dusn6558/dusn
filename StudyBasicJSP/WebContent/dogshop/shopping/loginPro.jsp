<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dogshop.shopping.CustomerDBBean"%>
<%@ page import ="dogshop.master.ShopdogDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

<%
    String id = request.getParameter("id");
	String passwd  = request.getParameter("passwd");
	
	CustomerDBBean user = CustomerDBBean.getInstance();
    int check= user.userCheck(id,passwd);
    ShopdogDBBean manager = ShopdogDBBean.getInstance();
    int managercheck = manager.managerCheck(id, passwd);

	if(check==1){
		session.setAttribute("id",id);
		response.sendRedirect("shopMain.jsp");
	}else if(check==1){%>
    <script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<%}else{ 
if(managercheck==1){
	session.setAttribute("managerId",id);
	response.sendRedirect("shopMain.jsp");
}else if(check==1){%>
<script> 
  alert("비밀번호가 맞지 않습니다.");
  history.go(-1);
</script>
<%}else{ %>
<script>
  alert("아이디가 맞지 않습니다..");
  history.go(-1);
</script>
<%}
}%>