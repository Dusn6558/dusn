<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String managerId="";
try{
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null||managerId.equals("")){
		response.sendRedirect("../logon/managerLoginForm.jsp");
	}else{
		int goods_id=Integer.parseInt(request.getParameter("goods_id"));
		String goods_kind = request.getParameter("goods_kind");
		%>
		<p>책삭제</p>
		<br>
		<form action="goodsDeletePro.jsp?goods_id=<%=goods_id%>&goods_kind=<%=goods_kind %>"
		method="post" name="delForm" onsubmit="return deleteSave()">
		<table>
			<tr>
				<td align="right" bgcolor="<%=value_c %>">
				<a href="../managerMain.jsp">관리자 메인으로</a>
				<a href="goodsList.jsp?goods_kind=<%=goods_kind%>">목록으로</a>
				</td>
			</tr>
			<tr height="30">
				<td align="center" bgcolor="<%=value_c %>">
				<input type="submit" value="삭제">
				</td>
			</tr>
		</table>
		</form>
	<%
	}
}catch(Exception e){
	e.printStackTrace();
}
%>

</body>
</html>