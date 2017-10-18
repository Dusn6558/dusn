<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "ch13.board.BoardDataBean" %>
<%@ page import = "ch13.board.BoardDBBean" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.img {
	margin-top : 50px;
	margin-right: 50px;
	}
 </style>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
<title>게시판</title>
</head>
<body>
<div>

<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

try{
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean article = dbPro.getArticle(num);
	int ref = article.getRef();
	int re_step = article.getRe_step();
	int re_level= article.getRe_level();
%>
<h2><img alt="로고" src="../images/sunny.jpg" width="40">반려견과 함께하는 여행</h2>
<p>글내용 보기</p>

<form bgcolor="#B2CCFF">
<table>
	<tr height="30">
		<td align="center" width="125" bgcolor="<%=value_c%>">글번호</td>
		<td align="center" width="125"><%=article.getNum() %></td>
		<td align="center" width="125" bgcolor="<%=value_c%>">조회수</td>
		<td align="center" width="125"><%=article.getReadcount() %></td>
	</tr>
	<tr height="30">
		<td align="center" width="125" bgcolor="<%=value_c%>">작성자</td>
		<td align="center" width="125"><%=article.getWriter() %></td>
		<td align="center" width="125"  bgcolor="<%=value_c%>">작성일</td>
		<td align="center" width="125"><%=sdf.format(article.getReg_date())%></td>
	</tr>
	<tr height="30">
		<td align="center" width="125"  bgcolor="<%=value_c%>">글제목</td>
		<td align="left" width="375" colspan="3"><%=article.getSubject() %></td>
	</tr>
	<tr>
		<td align="center" width="125"  bgcolor="<%=value_c%>">글내용</td>
		<td align="left" width="375" colspan="3"><pre width="300"><%=article.getContent()%></pre></td>
	</tr>
	<tr height="30">
		<td colspan="4" bgcolor="<%=value_c%>" align="right">
		<input type="button" value="글수정" 
		onclick="document.location.href='updateForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum%>'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="글삭제" 
		onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum%>'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="댓글쓰기" 
		onclick="document.location.href='writeForm.jsp?num=<%=num %>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="글목록" 
		onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
		</td>
		
	</tr>
</table>
<%
}catch(Exception e){}
%>
<img alt="쓰기" src="../images/illust3221.png" class="img" width="300" align="right">
</form>
</div>
</body>
</html>