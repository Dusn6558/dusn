<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	
 </style>
<title>게시판</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../etc/script.js"></script>
</head>

<body>
<div>
<%
int num = 0, ref = 1, re_step = 0, re_level = 0;
String strV="";
try{
	if(request.getParameter("num")!=null){
		num=Integer.parseInt(request.getParameter("num"));
		ref=Integer.parseInt(request.getParameter("ref"));
		re_step=Integer.parseInt(request.getParameter("re_step"));
		re_level=Integer.parseInt(request.getParameter("re_level"));
	}
	%>
	<h2><img alt="로고" src="../images/sunny.jpg" width="40">반려견 함께하는 여행 정보 커뮤니티</h2>
	<p>글쓰기<img alt="쓰기" src="../images/wirte.png" class="img" width="50"></p>
	<form method="post" action="writePro.jsp" name="writeform"
		onsubmit="return writeSave()">
		<input type="hidden" name="num" value="<%=num %>"> 
		<input type="hidden" name="ref" value="<%=ref %>">
		<input type="hidden" name="re_step" value="<%=re_step %>"> 
		<input type="hidden" name="re_level" value="<%=re_level %>">

		<table>
			<tr>
				<td align="right" colspan="2" bgcolor="<%=value_c%>"><a
					href="list.jsp">글목록</a></td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">이름</td>
				<td width="330" align="left"><input type="text" size="10"
					maxlength="10" name="writer" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">제목</td>
				<td width="330" align="left">
					<%
			if(request.getParameter("num")==null)
				strV="";
			else
				strV="[답변]";
			%> <input type="text" size="40" maxlength="50" name="subject"
					value="<%=strV %>" style="ime-mode:active;">
				</td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">email</td>
				<td width="330" align="left"><input type="text" size="40"
					maxlength="30" name="email" style="ime-mode:inactive;"></td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">내용</td>
				<td width="330" align="left"><textarea rows="13" cols="40"
						name="content" style="ime-mode:active;"></textarea></td>
			</tr>
			<tr>
				<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
				<td width="330" align="left"><input type="password" size="8"
					maxlength="12" name="passwd" style="ime-mode:inactive;"></td>
			</tr>
			<tr>
				<td bgcolor="<%=value_c%>" align="center" colspan="2">
				<input type="submit" value="글쓰기">
				<input type="reset" value="다시 작성">
				<input type="button" value="목록보기"
					OnClick="window.location='list.jsp'">
				</td>
			</tr>

		</table>
		<%
		}catch(Exception e){}
%>

	</form>

</div>
</body>
</html>