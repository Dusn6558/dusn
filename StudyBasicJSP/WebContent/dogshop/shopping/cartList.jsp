<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dogshop.shopping.CartDataBean" %>
<%@ page import = "dogshop.shopping.CartDBBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.NumberFormat" %>

<%@ include file="../etc/color.jspf"%>

<%
 String goods_kind = request.getParameter("goods_kind");
 String buyer = (String)session.getAttribute("id");
%>

<html>
<head>
<title>goods Shopping Mall</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<%
List<CartDataBean> cartLists = null;
CartDataBean cartList = null;
int count = 0;
int number = 0;
int total = 0;

if(session.getAttribute("id")==null){
   response.sendRedirect("shopMain.jsp");        
}else{
   CartDBBean goodsProcess = CartDBBean.getInstance();
   count = goodsProcess.getListCount(buyer);

   if(count == 0){
%>
   <h3><b>장바구니</b></h3>
   <table> 
     <tr><td >장바구니에 담긴 물품이 없습니다.</td> </tr>
   </table>
     <input type="button" value="쇼핑계속" 
     onclick="javascript:window.location='shopMain.jsp'">
<%
   }else{
     cartLists = goodsProcess.getCart(buyer);
 %>
   <h3><b>장바구니</b></h3>
   
   <table> 
     <tr> 
       <td width="50"><b>번호</b></td> 
       <td width="300"><b>상품 이름</b></td> 
       <td width="100"><b>판매가격</b></td>
       <td width="150"><b>수량</b></td> 
       <td width="150"><b>금액</b></td>
     </tr>
      
<%
   for(int i=0;i<cartLists.size();i++){
     cartList = (CartDataBean)cartLists.get(i);
%>
     
     <tr> 
       <td width="50"><%=++number %></td> 
       <td  width="300" align="left">
         <img src="../../imageFile/<%=cartList.getGoods_image()%>" 
             border="0" width="30" height="50" align="middle">&nbsp;&nbsp;
             <%=cartList.getGoods_name()%>
       </td> 
       <td width="100"><%=NumberFormat.getInstance().format(cartList.getBuy_price())%></td>
       <td width="150">
        <form method="post" action="updateCart.jsp" >
        
          <input type="text" name="buy_count" size="5" value="<%=cartList.getBuy_count()%>">
          <input type="hidden" name="cart_id" value="<%=cartList.getCart_id() %>">
          <input type="hidden" name="goods_kind" value="<%=goods_kind %>">
          <input type="submit" value="수정">
          
            </form>
       </td> 
       <td align="center"  width="150">
          <%total += cartList.getBuy_count()*cartList.getBuy_price();%>
            <%=NumberFormat.getInstance().format(cartList.getBuy_count()*cartList.getBuy_price()) %>
          <input type="button" value="삭제" 
            onclick="javascript:window.location=
            'cartListDel.jsp?list=<%=cartList.getCart_id()%>&goods_kind=<%=goods_kind%>'">
       </td>
     </tr>
<%}%>
     <tr border="1">
       <td colspan="5" align="right" >
       <font size="+1" color="blue"><b>총 금액 :  <%=NumberFormat.getInstance().format(total)%> 원
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></td>

     </tr>
     <tr>
       <td colspan="5">
         <input type="button" value="구매하기" 
            onclick="javascript:window.location='buyForm.jsp'">
         <input type="button" value="쇼핑계속" 
            onclick="javascript:window.location='list.jsp?goods_kind=<%=goods_kind%>'">
         <input type="button" value="장바구니비우기" 
            onclick="javascript:window.location='cartListDel.jsp?list=all&goods_kind=<%=goods_kind%>'">
       
       </td>
     </tr>
   </table>

<%
  } 
}
%>
</body>
</html>