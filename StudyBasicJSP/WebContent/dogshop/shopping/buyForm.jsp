<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dogshop.shopping.CartDataBean" %>
<%@ page import = "dogshop.shopping.CartDBBean" %>
<%@ page import = "dogshop.shopping.CustomerDataBean" %>
<%@ page import = "dogshop.shopping.CustomerDBBean" %>
<%@ page import = "dogshop.shopping.bankDBBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.NumberFormat" %>

<%@ include file="../etc/color.jspf"%> 
<html>
<head>
<title>goods Shopping Mall</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
   String goods_kind = request.getParameter("goods_kind");
   String buyer = (String)session.getAttribute("id");
%>
<%
List<CartDataBean> cartLists = null;
List<String> accountLists = null;
CartDataBean cartList = null;
CustomerDataBean member= null;
int number = 0;
int total = 0;
if(session.getAttribute("id")==null){
	response.sendRedirect("shopMain.jsp");        
}else{
	CartDBBean goodsProcess = CartDBBean.getInstance();
    cartLists = goodsProcess.getCart(buyer);
    
    CustomerDBBean memberProcess = CustomerDBBean.getInstance();
    member = memberProcess.getMember(buyer);
    
    bankDBBean bankProcess = bankDBBean.getInstance();
    accountLists = bankProcess.getAccount(buyer);
%>
  <h3><b>구매 목록</b></h3>

  <form name="inform" method="post" action="updateCart.jsp">
  <table> 
    <tr> 
      <td width="50">번호</td> 
      <td width="300">책이름</td> 
      <td width="100">판매가격</td>
      <td width="150">수량</td> 
      <td width="150">금액</td>
    </tr>   
<%
  for(int i=0;i<cartLists.size();i++){
     cartList = cartLists.get(i);
%>
     
     <tr> 
       <td width="50"><%=++number %></td> 
       <td width="300" align="left">
         <img src="../../imageFile/<%=cartList.getGoods_image()%>" 
           border="0" width="30" height="50" align="middle">
           <%=cartList.getGoods_name()%>
       </td> 
       <td width="100"><%=NumberFormat.getInstance().format(cartList.getBuy_price())%></td>
       <td width="150"><%=cartList.getBuy_count()%></td> 
       <td width="150">
          <%total += cartList.getBuy_count()*cartList.getBuy_price();%>
          <%=NumberFormat.getInstance().format(cartList.getBuy_count()*cartList.getBuy_price()) %>
      </td>
    </tr>
<%
  }
%>
  <tr>
    <td colspan="5" align="right"><font size="+1" color="blue">
    <b>총 구매금액 : <%=NumberFormat.getInstance().format(total)%> 원 
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b></font></td>
  </tr>
</table>
</form>
<%} 
 %>
<br>
<script type="text/javascript">
	function selectAccount(name) {
		var accountList = document.getElementById("accountList").value;
		var url = name+"?accountList="+accountList
		javascript:window.location=url;
	}
	
</script>
<form method="post" action="buyPro.jsp" name="buyinput">
 <table>
   <tr> 
    <td  colspan="2"><font size="+1" ><b>주문자 정보</b></font></td>
   </tr>
   <tr> 
    <td  width="200" align="left">성명</td>
    <td  width="400" align="left"><%=member.getName()%></td>
   </tr>
   <tr> 
    <td  width="200" align="left">전화번호</td>
    <td  width="400" align="left"><%=member.getTel()%></td>
   </tr>
   <tr> 
    <td  width="200" align="left">주소</td>
    <td  width="400" align="left"><%=member.getAddress()%></td>
   </tr>
   <tr> 
     <td  width="200" align="left">결제계좌</td>
     <td  width="400" align="left">
       <select name="account" id = "accountList">
        <%
        String accountList="";
          for(int i=0;i<accountLists.size();i++){
           accountList = accountLists.get(i);
         %>
           <option value="<%=accountList %>"><%=accountList %></option>
        <%}%>
       </select>
    </td>
  </tr>
  <tr>
  	<td colspan="2" align="center" bgcolor="<%=value_c%>">
  		<input type="button" value="계좌등록" 
  		onclick="javascript:window.location='insertAccountForm.jsp'">&nbsp;
  		<input type="button" value="계좌수정"
  		onclick="selectAccount('updateAccountForm.jsp')">&nbsp;
  		<input type="button" value="계좌삭제"
  		onclick="selectAccount('deleteAccountForm.jsp')">&nbsp;
  	
  	</td>
  </tr>
  </table>
  <br>
   
<table>
  <tr> 
   <td  colspan="2" align="center"><font size="+1" ><b>배송지 정보</b></font></td>
  </tr>
  <tr> 
    <td  width="200" align="left">성명</td>
    <td  width="400" align="left">
      <input type="text" name="deliveryName" value="<%=member.getName()%>">
    </td>
  </tr>
  <tr> 
    <td  width="200" align="left">전화번호</td>
    <td  width="400" align="left">
      <input type="text" name="deliveryTel" value="<%=member.getTel()%>">
    </td>
  </tr>
  <tr> 
    <td  width="200" align="left">주소</td>
    <td  width="400" align="left">
      <input type="text" name="deliveryAddess" value="<%=member.getAddress()%>">
    </td>
  </tr>
   <tr> 
     <td colspan="2" align="center" bgcolor="<%=value_c%>">
       <input type="submit" value="확인" >
       <input type="button" value="취소" 
       onclick="javascript:window.location='shopMain.jsp'">      
     </td>
   </tr>
  </table>
  </form>
 
</body>
</html>