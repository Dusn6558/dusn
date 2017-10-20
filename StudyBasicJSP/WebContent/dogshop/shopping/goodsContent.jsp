<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dogshop.master.ShopdogDataBean" %>
<%@ page import = "dogshop.master.ShopdogDBBean" %>
<%@ page import= "java.text.NumberFormat" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goods Shopping Mall</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
<style>
pre{
white-space: pre-wrap;
}
</style>
</head>
<body>
<%
String goods_kind = request.getParameter("goods_kind");
String goods_id = request.getParameter("goods_id");
String id="";
int buy_price=0;
try{
if(session.getAttribute("id")==null)
	id="not";
else
	id=(String)session.getAttribute("id");
}catch(Exception e){
	e.printStackTrace();
}

ShopdogDataBean goodsList = null;
String goods_kindName="";
ShopdogDBBean goodsProcess = ShopdogDBBean.getInstance();
goodsList = goodsProcess.getgoods(Integer.parseInt(goods_id));

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
<table width="800">
	<tr>
		<td width="150" valign="top">
		<img src="../module/sunny.jpg"border="0"width="150"height="120">
		</td>
		<td>
			<jsp:include page="../module/top.jsp" flush="false"/>
		</td>
	</tr>
	<tr>
		<td width="150" valign="top">
			<jsp:include page="../module/left.jsp" flush="false"/>
		</td>
		<td>
		<form action="cartInsert.jsp" method="post"name="inform" >
	<table width="650" bgcolor="#B2CCFF">
	<tr height="30">
	<td rowspan="6" width="150">
		<img src="../../imageFile/<%=goodsList.getGoods_image()%>"				
		border="0" width="150" height="200"></td>
	<td width="500"><font size="+1">
	<b><%=goodsList.getGoods_name() %></b></font></td></tr>
	<tr><td width="500">제조사 : <%=goodsList.getGoods_com() %></td></tr>
	<tr><td width="500">유통기한 : <%=goodsList.getGoods_date() %></td></tr>
	<tr><td width="500">원산지 : <%=goodsList.getGoods_country() %></td></tr>
	<tr><td width="500">정가 : <%=NumberFormat.getInstance().format(goodsList.getGoods_price())%>원<br>
	판매가 : <b><font color="red" size="+1"> 
	<% buy_price = (int)(goodsList.getGoods_price()*((double)(100-goodsList.getDiscount_rate())/100)); %>
	<%=NumberFormat.getInstance().format((int)(buy_price))%>원</font> </b></td></tr>
	<tr><td width="500">수량 : <input type="text" size="5"name="buy_count" value="1"> 개
	<%
	if(id.equals("not")){
		if(goodsList.getGoods_count()==0){
			%><b>일시품절</b>
			<%
		}else{
			%><font color="red">로그인을 하셔야 구매가 가능합니다.</font><%
		}
	}else{
		if(goodsList.getGoods_count()==0){
			%><b>일시품절</b>
	<%
		}else{%>
		<input type="hidden" name="goods_id" value="<%=goods_id%>">
		<input type="hidden" name="goods_image" value="<%=goodsList.getGoods_image()%>">
		<input type="hidden" name="goods_name" value="<%=goodsList.getGoods_name()%>">
		<input type="hidden" name="buy_price" value="<%=buy_price%>">
		<input type="hidden" name="goods_kind" value="<%=goods_kind%>">
		<input type="submit" value="장바구니에 담기">
	<%}
	}%>
	<input type="button" value="목록으로"
	onclick="javascript:window.location='list.jsp?goods_kind=<%=goods_kind%>'">
	<input type="button" value="메인으로"
	onclick="javascript:window.location='shopMain.jsp'">
	</td>
	</tr>
	<tr>
	<td colspan="2"align="left"><br><pre><%=goodsList.getGoods_content() %></pre></td>
	</tr>
	</table>
</form>
	</td>
	</tr>
	<tr>
		<td width="150" valign="top">
			<img src="../module/sunny.jpg"border="0"width="150"height="120">
		</td>
		<td width="700" valign="top" bgcolor="#BDBDBD" >
			<jsp:include page="../module/bottom.jsp" flush="false"/>
		</td>
	</tr>
</table>


</body>
</html>