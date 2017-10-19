<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "dogshop.master.ShopdogDataBean" %>
<%@ page import = "dogshop.master.ShopdogDBBean" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goods Shopping Mall</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<h3>신간소개</h3>
<%
ShopdogDataBean [] goodsLists = null;
int number = 0;
String goods_kindName="";
try{
ShopdogDBBean goodsProcess = ShopdogDBBean.getInstance();
for(int i=1; i<=5;i++){
	goodsLists = goodsProcess.getgoodss(i+"00",3);
	if( goodsLists[0].getGoods_kind().equals("100")){
		goods_kindName="사료";
	}else if( goodsLists[0].getGoods_kind().equals("200")){
		goods_kindName="간식/영양제";
	}else if( goodsLists[0].getGoods_kind().equals("300")){
		goods_kindName="장난감";
	}else if( goodsLists[0].getGoods_kind().equals("400")){
		goods_kindName="샤워용품";
	}else if( goodsLists[0].getGoods_kind().equals("500")){
		goods_kindName="기타용품";
	}
	%>
	<br>
	<font size="+1"><b><%=goods_kindName %>분류의 최신목록: 
	<a href="list.jsp?goods_kind=<%=goodsLists[0].getGoods_kind() %>">더보기</a>
	</b><br></font>
	<%
	for(int j=0; j<goodsLists.length;j++){
		%>
		<table>
			<tr height="30" bgcolor="<%=value_c %>">
			<td rowspan="4" width="100">
			<a href = "goodsContent.jsp?goods_id=<%=goodsLists[j].getGoods_id()%>&goods_kind=<%=goodsLists[0].getGoods_kind() %>">
			<img src = "../../imageFile/<%=goodsLists[j].getGoods_image()%>" 
			border="0" width="100" height="150"></a></td>
			<td width="350"><font size="+1"><b>
			<a href = "goodsContent.jsp?goods_id=<%=goodsLists[j].getGoods_id()%>&goods_kind=<%=goodsLists[0].getGoods_kind()%>">
			<%=goodsLists[j].getGoods_name() %></a></b></font></td>
			<td rowspan="4" width="100">
			<%if(goodsLists[j].getGoods_count()==0){ %>
			<font color="red"><b>일시 품절</b></font>
			<%}else{ %>
			<font><b>구매가능</b></font>
			<%} %>
			</td>
			</tr>
			<tr height="30"  bgcolor="<%=value_c %>">
				<td width="350">제조회사 :  <%=goodsLists[j].getGoods_com() %></td>
			</tr>
			<tr height="30"  bgcolor="<%=value_c %>">
				<td width="350">원산지 : <%=goodsLists[j].getGoods_country() %></td>
			</tr>
			<tr height="30"  bgcolor="<%=value_c %>">
				<td width="350">정가 : 
				<%=NumberFormat.getInstance().format(goodsLists[j].getGoods_price())%>원<br>
				판매가 : <b><font color="red" size="+1">
		<%=NumberFormat.getInstance().format((int)(goodsLists[j].getGoods_price()*((double)(100-
			goodsLists[j].getDiscount_rate())/100))) %>
			</font>
			</b>원
			</td>
			</tr>
		</table>
		<br>
		<br>
		<%
	}
	
}
}catch(Exception e){
	e.printStackTrace();
}
%>


</body>
</html>