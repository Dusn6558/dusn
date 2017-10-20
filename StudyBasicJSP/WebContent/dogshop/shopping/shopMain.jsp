<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../etc/color.jspf" %>
    <%@ page import="dogshop.shopping.CustomerDBBean"%>
    <%@ page import="dogshop.shopping.CustomerDataBean"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog Shopping Mall</title>
<!-- <link href="../etc/style.css" rel="stylesheet" type="text/css"> -->
<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../css/heroic-features.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/heroic-features.css" rel="stylesheet">

</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container">
        <a class="navbar-brand" href="#">멍멍숍</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
        <%
        String id = (String)session.getAttribute("id");
        CustomerDBBean member = CustomerDBBean.getInstance();
        CustomerDataBean members = member.getMember(id);
        String managerId = (String)session.getAttribute("managerId");
        try{
        	if(session.getAttribute("id")==null&&session.getAttribute("managerId")==null){%>
        	
        	<form method="post" action="../shopping/loginPro.jsp">
        		아이디 : <input type="text" name="id" size="15" maxlength="50"> &nbsp;&nbsp;&nbsp;
        		비밀번호 : <input type="password" name="passwd" size="15" maxlength="16">
        		<input type="submit" value="로그인">
        	</form>
        <%}else if(session.getAttribute("managerId")==null){ %>
          <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
              <a class="nav-link" href="shopMain.jsp">메인으로가기
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="cartList.jsp?goods_kind=all">장바구니</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="buyList.jsp">구매목록</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="../manager/managerMain.jsp">관리자메뉴가기</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <%}else{%> <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
              <a class="nav-link" href="shopMain.jsp">메인으로가기
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="cartList.jsp?goods_kind=all">장바구니</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="buyList.jsp">구매목록</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">마이페이지</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>	<%}
}catch(Exception e){
	e.printStackTrace();
}%>
<table>
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
		<td width="700" valign="top">
			<jsp:include page="introList.jsp" flush="false"/>
		</td>
	</tr>
	<tr>
		<td width="150" valign="top">
			<img src="../module/sunny.jpg"border="0"width="150"height="120">
		</td>
		<td width="700" valign="top" bgcolor="#BDBDBD">
			<jsp:include page="../module/bottom.jsp" flush="false"/>
		</td>
	</tr>
</table>

</body>
</html>