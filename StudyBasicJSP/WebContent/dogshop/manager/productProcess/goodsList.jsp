<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dogshop.master.ShopdogDBBean" %>
<%@ page import="dogshop.master.ShopdogDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록된 상품목록</title>
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
	List<ShopdogDataBean> goodsList=null;
	int number = 0;
	String goods_kind="";
	
	goods_kind = request.getParameter("goods_kind");
	
	ShopdogDBBean goodsProcess = ShopdogDBBean.getInstance();
	int count = goodsProcess.getgoodsCount();
	
	if(count>0){
		goodsList = goodsProcess.getgoodss(goods_kind);
	}
	String goods_kindName="";
	if(goods_kind.equals("100")){
		goods_kindName="사료";
	}else if(goods_kind.equals("200")){
		goods_kindName="간식/영양제";
	}else if(goods_kind.equals("300")){
		goods_kindName="장난감";
	}else if(goods_kind.equals("400")){
		goods_kindName="샤워용품";
	}else if(goods_kind.equals("500")){
		goods_kindName="기타용품";
	}else if(goods_kind.equals("all")){
		goods_kindName="전체";
}
%>
<a href="../managerMain.jsp">관리자 메인으로</a>&nbsp;
<p><%=goods_kindName %> 분류의 목록:
<% if(goods_kind.equals("all")){ %>
<%=count %>개
<%}else{ %>
<%=goodsList.size() %>개
<%} %></p>
<table align="center">
	<tr>
		<td align="right" bgcolor="<%=value_c%>">
		<a href="goodsRegisterForm.jsp">상품 등록</a>
</td>
</tr>
</table>
<%if(count==0){
	%>
	<table align="center">
	<tr>
		<td align="center">등록된 책이 없습니다.</td>
	</table>
	<%}else{ %>
	<table align="center">
		<tr height="30" bgcolor="<%=value_c%>">
		<td align="center" width="50">번호</td>
		<td align="center" width="50">상품 분류</td>
		<td align="center" width="150">상품명</td>
		<td align="center" width="50">가격</td>
		<td align="center" width="50">수량</td>
		<td align="center" width="70">제조 회사</td>
		<td align="center" width="100">유통기한</td>
		<td align="center" width="100">원산지</td>
		<td align="center" width="50">상품이미지</td>
		<td align="center" width="30">할인율</td>
		<td align="center" width="100">등록일</td>
		<td align="center" width="50">수정</td>
		<td align="center" width="50">삭제</td>
		</tr>
		<%
		for(int i =0;i<goodsList.size(); i++){
		ShopdogDataBean goods = (ShopdogDataBean)goodsList.get(i);
		%>
		<tr height="30" >
		<td width="50" align="center"><%=++number %></td>
		<td width="50" align="center"><%=goods.getGoods_kind()%></td>
		<td width="150" align="center"><%=goods.getGoods_name()%></td>
		<td width="50" align="center"><%=goods.getGoods_price()%></td>
		<td width="50" align="center"><%if(goods.getGoods_count()==0){ %>
		<font color="red" align="center"> <%="일시품절" %></font>
		<%}else{ %>
		<%=goods.getGoods_count() %><%} %></td>
		<td width="70" align="center"><%=goods.getGoods_com()%></td>
		<td width="100" align="center"><%=goods.getGoods_date()%></td>
		<td width="100" align="center"><%=goods.getGoods_country()%></td>
		<td width="50" align="center"><%=goods.getGoods_image()%></td>
		<td width="50" align="center"><%=goods.getDiscount_rate()%></td>
		<td width="100" align="center"><%=sdf.format(goods.getReg_date())%></td>
		<td width="50" align="center">
		<a href="goodsUpdateForm.jsp?goods_id=<%=goods.getGoods_id()%>&goods_kind=<%=goods.getGoods_kind() %>">
		수정</a>
		</td>
		<td width="50" align="center">
		<a href="goodsDeleteForm.jsp?goods_id=<%=goods.getGoods_id()%>&goods_kind=<%=goods.getGoods_kind() %>">
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
ShopgoodsDBBean dbPro = ShopgoodsDBBean.getInstance();
count = dbPro.getgoodsCount();
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
	<a href="goodsList.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<% }
	
	for(int i=startPage; i<=endPage; i++){ %>
	<a href="goodsList.jsp?pageNum=<%=i >">[<%=i %>]</a>
	<%}
	if(endPage < pageCount){%>
	<a href="goodsList.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%}
}
%> --%>
<br>
</body>
</html>