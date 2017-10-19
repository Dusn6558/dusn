<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="dogshop.master.ShopdogDBBean" %>
<%@ page import="dogshop.master.ShopdogDataBean" %>
<%@ include file="../../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../etc/script.js"></script>
<style type="text/css">

table{
	border: 1px solid black;
	border-collapse: collapse;
}</style>
</head>
<body>
<%
String managerId="";
try{
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null||managerId.equals("")){
		response.sendRedirect("../logon/managerLoginForm.jsp");
	}else{
	int goods_id = Integer.parseInt(request.getParameter("goods_id"));
	String goods_kind = request.getParameter("goods_kind");
	try{
		ShopdogDBBean GoodsProcess = ShopdogDBBean.getInstance();
		ShopdogDataBean Goods = GoodsProcess.getgoods(goods_id);
		%>
		<p>상품 수정</p>
		<br>
		<form method="post" action="goodsUpdatePro.jsp" 
		name="writeform" enctype="multipart/form-data">
		<table align="center">
		<tr>
			<td align="right" colspan="2" bgcolor="<%=value_c %>">
			<a href="../managerMain.jsp">관리자 메인으로</a>&nbsp;
			<a href="goodsList.jsp?goods_kind=all">목록으로</a>
			</td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c %>"> 분류 선택</td>
			<td width="400" align="left">
			<select name="goods_kind">
				<option value="100"
				<%if(Goods.getGoods_kind().equals("100")){ %>selected<%} %>
				>사료</option>	
				<option value="200"
				<%if(Goods.getGoods_kind().equals("200")){ %>selected<%} %>
				>간식/영양제</option>
				<option value="300"
				<%if(Goods.getGoods_kind().equals("300")){ %>selected<%} %>
				>장난감</option>
				<option value="400"
				<%if(Goods.getGoods_kind().equals("400")){ %>selected<%} %>
				>샤워용품</option>
				<option value="500"
				<%if(Goods.getGoods_kind().equals("500")){ %>selected<%} %>
				>기타용품</option>
				</select>
			</td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c %>">제목</td>
			<td width="400" align="left">
			<input type="text" size="50" maxlength="50" name="goods_name"
			value="<%=Goods.getGoods_name() %>">
			<input type="hidden" name="goods_id" value="<%=goods_id %>"></td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c %>">가격</td>
			<td width="400" align="left">
			<input type="text" size="10" maxlength="5" name="goods_price"
			value="<%=Goods.getGoods_price()%>">원</td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c %>">수량</td>
			<td width="400" align="left">
			<input type="text" size="10" maxlength="5" name="goods_count"
			value="<%=Goods.getGoods_count()%>">개</td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c %>">제조회사</td>
			<td width="400" align="left">
			<input type="text" size="10" maxlength="5" name="goods_com"
			value="<%=Goods.getGoods_com()%>"></td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c %>">유통기한</td>
			<td width="400" align="left">
			<input type="text" size="20" maxlength="30" name="goods_date"
			value="<%=Goods.getGoods_date()%>"></td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c %>">원산지</td>
			<td width="400" align="left">
			<input type="text" size="20" maxlength="30" name="goods_country"
			value="<%=Goods.getGoods_country()%>">
			</td>		
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c %>">이미지</td>
			<td width="400" align="left">
			<input type="file" name="goods_image">
			<%=Goods.getGoods_image()%>
			</td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c %>">내용</td>
			<td width="400" align="left"><textarea rows="13" name="goods_content" cols="40"><%=Goods.getGoods_content() %></textarea>
			</td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c %>">할인율</td>
			<td width="400" align="left">
			<input type="text" size="5" maxlength="2" name="discount_rate"
			value="<%=Goods.getDiscount_rate()%>"></td>
		</tr>
		<tr>
			<td align="center" colspan="2" bgcolor="<%=value_c %>">
			<input type="submit" value="상품 수정">
			<input type="reset" value="다시 작성">
			</td>
		</tr>
		</table>
		
		</form>
	<%
		} catch (Exception e) {
					e.printStackTrace();
				}
	%>
	<%
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

</body>
</html>