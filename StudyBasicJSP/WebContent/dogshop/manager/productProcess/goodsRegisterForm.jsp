<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.Timestamp" %>
    <%@include file="../../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../etc/script.js"></script>
</head>
<body >
<%
String managerId="";
try{
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null||managerId.equals("")){
		response.sendRedirect("../logon/managerLoginForm.jsp");
	}else{
		%>
		<p>상품 등록</p><br>
		<form action="goodsRegisterPro.jsp" enctype="multipart/form-data"
		method="post" name=writeform>
		<table align="center">
			<tr>
				<td align="right" colspan="2" bgcolor="<%=value_c %>">
				<a href="../managerMain.jsp">관리자 메인으로</a></td>
			</tr>
			<tr>
				<td width="100" bgcolor="<%=value_c %>">분류 선택</td>
				<td width="400" align="left">
					<select name="goods_kind">
						<option value="100">사료</option>	
						<option value="200">간식/영양제</option>
						<option value="300">장난감</option>
						<option value="400">샤워용품</option>
						<option value="500">기타용품</option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="100" bgcolor="<%=value_c %>">상품명</td>
				<td width="400" align="left">
				<input type="text" size="50" maxlength="50" name="goods_name"></td>
			</tr>
			<tr>
				<td width="100" bgcolor="<%=value_c %>">가격</td>
				<td width="400" align="left">
				<input type="text" size="10" maxlength="9" name="goods_price">원</td>
			</tr>
			<tr>
				<td width="100" bgcolor="<%=value_c %>">수량</td>
				<td width="400" align="left">
				<input type="text" size="10" maxlength="5" name="goods_count">개</td>
			</tr>
			<tr>
				<td width="100" bgcolor="<%=value_c %>">제조 회사</td>
				<td width="400" align="left">
				<input type="text" size="20" maxlength="30" name="goods_com"></td>
			</tr>
			<tr>
				<td width="100" bgcolor="<%=value_c %>">유통기한</td>
				<td width="400" align="left">
				<input type="text" size="20" maxlength="30" name="goods_date"></td>
			</tr>
			<tr>
				<td width="100" bgcolor="<%=value_c %>">원산지</td>
				<td width="400" align="left">
				<input type="text" size="20" maxlength="30" name="goods_country"></td>
			</tr>	
			<tr>	
				<td width="100" bgcolor="<%=value_c %>">이미지</td>
				<td width="400" align="left">
				<input type="file"name="goods_image"></td>
			</tr>
			<tr>
				<td width="100" bgcolor="<%=value_c %>">내용</td>
				<td width="400" align="left"><textarea name="goods_content" rows="13" cols="40"></textarea></td>
			</tr>
			<tr>
				<td width="100" bgcolor="<%=value_c %>">할인률</td>
				<td width="400" align="left">
				<input type="text" size="5" maxlength="2" name="discount_rate"></td>
			</tr>
			<tr>
				<td align="right" colspan="2" bgcolor="<%=value_c %>">
				<input type="submit" value="상품 등록">
				<input type="reset" value="다시 작성">
				</td>
			</tr>
			</table>
			</form>
			<%
			}
			}catch(Exception e){
			e.printStackTrace();
			}
			%>
			</body>
			</html>