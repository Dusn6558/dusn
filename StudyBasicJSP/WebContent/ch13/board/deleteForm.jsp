<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../etc/script.js"></script>
<style type="text/css">

	
 </style>
</head>
<body>
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
%>
<h2><img alt="로고" src="../images/sunny.jpg" width="40">반려견 함께하는 여행 정보 커뮤니티</h2>
<p>글 삭제<img alt="고양이" src="../images/delete.png" width="60" class="img"></p>
<br>
<form action="deletePro.jsp?pageNum=<%=pageNum %>" method="post" name="deleteform" onsubmit="return deleteSave()">
<table>
	<tr height="30">
		<td align="center" bgcolor="<%=value_c %>">
		<b>비밀번호를 입력해 주세요.</b></td>
	</tr>
	<tr height="30">
		<td align="center">비밀번호 : 
		<input type="password" name="passwd" size="8" maxlength="12">
		<input type="hidden" name="num" value="<%=num %>">
		</td>
	</tr>
	<tr height="30">
		<td align="center" bgcolor="<%=value_c %>">
		<input type="submit" value="글삭제">
		<input type="button" value="취소" 
		onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
		</td>
	</tr>

</table>




</form>
</body>
</html>