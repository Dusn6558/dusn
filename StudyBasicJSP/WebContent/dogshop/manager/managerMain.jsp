<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String managerId="";
try{
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")){
		response.sendRedirect("logon/managerLoginForm.jsp");
	}else{
		%>
		<form action="logon/managerLogout.jsp" method="post" border="1">
		<b>관리작업중..</b><input type="submit" value="로그아웃">
		</form>
		<table>
			<tr>
				<td align="center" bgcolor="<%=bar%>">상품관련 작업</td>
			</tr>
	
			<tr>
				<td><a href='productProcess/goodsRegisterForm.jsp'>상품등록</a></td>
			</tr>
			<tr>
				<td><a href='productProcess/goodsList.jsp?goods_kind=all'>상품수정/삭제</a></td>
			</tr>
		</table><br><br>
		<table>
			<tr>
				<td align="center" bgcolor="<%=bar%>">구매된 상품관련 작업</td>
			</tr>
			<tr>
				<td><a href='orderProduct/orderedList.jsp'>전체구매목록 확인</a></td>
			</tr>
		</table>
		
	<%
	}
}catch(Exception e){e.printStackTrace();}

%>

</body>
</html>