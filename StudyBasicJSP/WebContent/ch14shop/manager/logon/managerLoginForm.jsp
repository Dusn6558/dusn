<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
body{
	width: 500px;
	margin:0 auto;
}
form {
margin-top: 50px;
}
ul {
list-style-type: none;
}
ul lable{
width:200px;
text-align: right;
}
ul li{
margin-bottom:10px;
}
.botton{
text-align: right;
}
legend{
text-align: left;
}
</style>
</head>
<body>
<form action="managerLoginPro.jsp" method="post">
<fieldset><legend>로그인 폼</legend>
<ul>
<li>
<label>아 이 디 : </label>
<input type="text" name="id" maxlength="50">
</li>
<li>
<label>비밀번호 : </label>
<input type="password" name="passwd" maxlength="16">
</li>
<li class="button">
<input type="submit" value="로그인" >
</li>
</ul>
</fieldset>
</form>
</body>
</html>