<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dogshop.master.ShopdogDataBean" %>
<%@ page import="dogshop.master.ShopdogDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import ="com.oreilly.servlet.MultipartRequest" %>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<%
String realFolder ="";
String filename="";
MultipartRequest imageUp=null;

String saveFolder = "/imageFile";
String encType = "utf-8";
int maxSize = 2*1024*1024;
ServletContext context = getServletContext();
realFolder = context.getRealPath(saveFolder);

try{
	imageUp = new MultipartRequest(
			request,realFolder,maxSize,encType, new DefaultFileRenamePolicy());
	Enumeration<?> files = imageUp.getFileNames();
	while(files.hasMoreElements()){
		String name = (String)files.nextElement();
		filename = imageUp.getFilesystemName(name);
	}
}catch(IOException ioe){
	ioe.printStackTrace();
}catch(Exception e){
	e.printStackTrace();
}

%>
<jsp:useBean id="goods" scope="page" 
class="dogshop.master.ShopdogDataBean">
</jsp:useBean>
<%
int goods_id = Integer.parseInt(imageUp.getParameter("goods_id"));
String goods_kind = imageUp.getParameter("goods_kind");
String goods_name = imageUp.getParameter("goods_name");
String goods_price = imageUp.getParameter("goods_price");
String goods_count = imageUp.getParameter("goods_count");
String goods_com = imageUp.getParameter("goods_com");
String goods_date = imageUp.getParameter("goods_date");
String goods_country = imageUp.getParameter("goods_country");
String goods_content = imageUp.getParameter("goods_content");
String discount_rate = imageUp.getParameter("discount_rate");


goods.setGoods_kind(goods_kind);
goods.setGoods_name(goods_name);
goods.setGoods_price(Integer.parseInt(goods_price));
goods.setGoods_count(Short.parseShort(goods_count));
goods.setGoods_com(goods_com);
goods.setGoods_date(goods_date);
goods.setGoods_country(goods_country);
goods.setGoods_image(filename);
goods.setGoods_content(goods_content);
goods.setDiscount_rate(Byte.parseByte(discount_rate));
goods.setReg_date(new Timestamp(System.currentTimeMillis()));


ShopdogDBBean bookProcess = ShopdogDBBean.getInstance();
bookProcess.updategoods(goods, goods_id);

response.sendRedirect("goodsList.jsp?goods_kind=all");

%>


</body>
</html>