<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "dogshop.master.ShopdogDataBean" %>
<%@ page import = "dogshop.master.ShopdogDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import= "java.text.NumberFormat" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goods Shopping Mall</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">

</head>
<body>
<%
	String goods_kind = request.getParameter("goods_kind");
	List<ShopdogDataBean> goodsLists = null;
	ShopdogDataBean  goodsList = null;
	String goods_kindName="";
	
	ShopdogDBBean goodsProcess = ShopdogDBBean.getInstance();
	goodsLists = goodsProcess.getgoodss(goods_kind);
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
<table>
		<tr>
			<td width="150" valign="top"><img src="../module/logo.png"
				border="0" width="150" height="120"></td>
			<td><jsp:include page="../module/top.jsp" flush="false" /></td>
		</tr>
		<tr>
			<td width="150" valign="top"><jsp:include
					page="../module/left.jsp" flush="false" /></td>
			<td width="700">
				<h3><b><%=goods_kindName%> 분류의 목록</b>
				</h3> <a href="shopMain.jsp">메인으로</a> <%
	for(int i=0; i<goodsLists.size();i++){
		goodsList = (ShopdogDataBean)goodsLists.get(i);
		%>
				<table>
					<tr height="30" bgcolor="<%=value_c %>">
						<td rowspan="4" width="100"><a
							href="goodsContent.jsp?goods_id=<%=goodsList.getGoods_id()%>&goods_kind=<%=goods_kind %>">
								<img src="../../imageFile/<%=goodsList.getGoods_image()%>"
								border="0" width="100" height="150">
						</a></td>
						<td width="350"><font size="+1"><b> <a
									href="goodsContent.jsp?goods_id=<%=goodsList.getGoods_id()%>&goods_kind=<%=goods_kind%>">
										<%=goodsList.getGoods_name() %></a></b></font></td>
						<td rowspan="4" width="100">
							<%if(goodsList.getGoods_count()==0){ %> <font color="red"><b>일시
									품절</b></font> <%}else{ %> <font><b>구매가능</b></font> <%} %>
						</td>
					</tr>
					<tr height="30" bgcolor="<%=value_c %>">
						<td width="350">제조회사 <%=goodsList.getGoods_com() %></td>
					</tr>
					<tr height="30" bgcolor="<%=value_c %>">
						<td width="350">원산지 <%=goodsList.getGoods_country() %></td>
					</tr>
					<tr height="30" bgcolor="<%=value_c %>">
						<td width="350">정가 : <%=NumberFormat.getInstance().format(goodsList.getGoods_price())%>원<br>
							판매가 : <b><font color="red" size="+1"> <%=NumberFormat.getInstance().format((int)(goodsList.getGoods_price()*((double)(100-
			goodsList.getDiscount_rate())/100))) %>
							</font> </b>원
						</td>
					</tr>
				</table> <br> <%		
	}	
	%>
			</td>
		</tr>
		<tr>
		<td width="150" valign="top">
			<img src="../module/logo.png"border="0"width="150"height="120">
		</td>
		<td width="700" valign="top" bgcolor="#BDBDBD" >
			<jsp:include page="../module/bottom.jsp" flush="false"/>
		</td>
	</tr>
	</table>

</body>
</html>