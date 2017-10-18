<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="ch13.board.BoardDataBean" %>
    <%@page import = "ch13.board.BoardDBBean" %>
    <%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 수정</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../etc/script.js"></script>
</head>
<body>
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
try{
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean article = dbPro.updateGetArticle(num);
	%>
	<h2><img alt="로고" src="../images/sunny.jpg" width="40">반려견 함께하는 여행 정보 커뮤니티</h2>
	<p>글수정<img alt="update" src="../images/update.png" width="60"></p>
	<br>
	<form method="post" action="updatePro.jsp?pageNum=<%=pageNum %>" name="writeform"
		onsubmit="return writeSave()">
		<table>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">이름</td>
				<td width="330" align="left"><input type="text" size="10"
					maxlength="10" name="writer"  value="<%=article.getWriter()%>">
					<input type="hidden" name="num" value="<%=article.getNum()%>">
					</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">제목</td>
				<td width="330" align="left">
				 <input type="text" size="40" maxlength="50" name="subject"
					value="<%=article.getSubject()%>">
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">email</td>
				<td width="330" align="left"><input type="text" size="40"
					maxlength="30" name="email" value="<%=article.getEmail()%>"></td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">내 용</td>
				<td width="330" align="left"><textarea rows="13" cols="40"
						name="content" ><%=article.getContent() %></textarea></td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
				<td width="330" align="left"><input type="password" size="8"
					maxlength="12" name="passwd" ></td>
			</tr>
			<tr>
				<td bgcolor="<%=value_c%>" align="center" colspan="2">
				<input type="submit" value="글수정">
				<input type="reset" value="다시 작성">
				<input type="button" value="목록보기"
					onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
				</td>
			</tr>

		</table>
		</form>
		<%}catch(Exception e){} %>

</body>
</html>