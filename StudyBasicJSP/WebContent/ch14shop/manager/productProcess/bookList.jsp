<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import="ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록된 책목록</title>
<style type="text/css">
body {
text-align: center;
}
table{
	border: 1px solid black;
	border-collapse: collapse;
}</style>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String managerId="";
try{
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null||managerId.equals("")){
		response.sendRedirect("../logon/managerLoginForm.jsp");
	}else{
		%>
		<%!
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		%>
	<%
	List<ShopBookDataBean> bookList=null;
	int number = 0;
	String book_kind="";
	
	book_kind = request.getParameter("book_kind");
	
	ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
	int count = bookProcess.getBookCount();
	
	if(count>0){
		bookList = bookProcess.getBooks(book_kind);
	}
	String book_kindName="";
	if(book_kind.equals("100")){
		book_kindName="문학";
	}else if(book_kind.equals("200")){
		book_kindName="외국어";
	}else if(book_kind.equals("300")){
		book_kindName="컴퓨터";
	}else if(book_kind.equals("400")){
		book_kindName="취미레져";
	}else if(book_kind.equals("500")){
		book_kindName="여행";
	}else if(book_kind.equals("all")){
		book_kindName="전체";
}
%>
<a href="../managerMain.jsp">관리자 메인으로</a>&nbsp;
<p><%=book_kindName %> 분류의 목록:
<% if(book_kind.equals("all")){ %>
<%=count %>개
<%}else{ %>
<%=bookList.size() %>개
<%} %></p>
<table align="center">
	<tr>
		<td align="right" bgcolor="<%=value_c%>">
		<a href="bookRegisterForm.jsp">책등록</a>
</td>
</tr>
</table>
<%if(count==0){
	%>
	<table ealign="center">
	<tr>
		<td align="center">등록된 책이 없습니다.</td>
	</table>
	<%}else{ %>
	<table align="center">
		<tr height="30" bgcolor="<%=value_c%>">
		<td align="center" width="50">번호</td>
		<td align="center" width="50">책분류</td>
		<td align="center" width="150">제목</td>
		<td align="center" width="50">가격</td>
		<td align="center" width="50">수량</td>
		<td align="center" width="70">저자</td>
		<td align="center" width="100">출판사</td>
		<td align="center" width="100">출판일</td>
		<td align="center" width="50">책이미지</td>
		<td align="center" width="30">할인율</td>
		<td align="center" width="100">등록일</td>
		<td align="center" width="50">수정</td>
		<td align="center" width="50">삭제</td>
		</tr>
		<%
		for(int i =0;i<bookList.size(); i++){
		ShopBookDataBean book = (ShopBookDataBean)bookList.get(i);
		%>
		<tr height="30" >
		<td width="50" align="center"><%=++number %></td>
		<td width="50" align="center"><%=book.getBook_kind()%></td>
		<td width="150" align="center"><%=book.getBook_title()%></td>
		<td width="50" align="center"><%=book.getBook_price()%></td>
		<td width="50" align="center"><%if(book.getBook_count()==0){ %>
		<font color="red" align="center"> <%="일시품절" %></font>
		<%}else{ %>
		<%=book.getBook_count() %><%} %></td>
		<td width="70" align="center"><%=book.getAuthor()%></td>
		<td width="100" align="center"><%=book.getPublishing_com()%></td>
		<td width="100" align="center"><%=book.getPublishing_date()%></td>
		<td width="50" align="center"><%=book.getBook_image()%></td>
		<td width="50" align="center"><%=book.getDiscount_rate()%></td>
		<td width="100" align="center"><%=sdf.format(book.getReg_date())%></td>
		<td width="50" align="center">
		<a href="bookUpdateForm.jsp?book_id=<%=book.getBook_id()%>&book_kind=<%=book.getBook_kind() %>">
		수정</a>
		</td>
		<td width="50" align="center">
		<a href="bookDeleteForm.jsp?book_id=<%=book.getBook_id()%>&book_kind=<%=book.getBook_kind() %>">
		삭제</a>
		</td>
		</tr>
		<%} %>
		</table>
		<%} %>
		<br>
		<a href="../managerMain.jsp">관리자 메인으로</a>
	
	
	<%
	}
}catch(Exception e){
		e.printStackTrace();
	}
	%>
<%-- <%
String pageNum = request.getParameter("pageNum");
if(pageNum == null){
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum);
int count=0;
int pageSize = 10;
ShopBookDBBean dbPro = ShopBookDBBean.getInstance();
count = dbPro.getBookCount();
if(count>0){
	int pageCount = count/pageSize+(count % pageSize ==0?0:1);
	int startPage=1;
	
	if(currentPage % 10 !=0)
		startPage=(int)(currentPage/10)*10+1;
	else
		startPage = ((int)(currentPage/10)-1)*10+1;
	
	int pageBlock = 10;
	int endPage = startPage + pageBlock-1;
	if(endPage > pageCount) endPage=pageCount;
	
	if(startPage>10) {%>
	<a href="bookList.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<% }
	
	for(int i=startPage; i<=endPage; i++){ %>
	<a href="bookList.jsp?pageNum=<%=i >">[<%=i %>]</a>
	<%}
	if(endPage < pageCount){%>
	<a href="bookList.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%}
}
%> --%>
<br>
</body>
</html>