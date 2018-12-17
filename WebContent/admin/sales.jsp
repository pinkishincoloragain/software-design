<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2> 매출 보러가기 </h2>
	<br>
	
	
	<form action="sale_all.jsp?retailer_id=<%=request.getParameter("retailer_id")%>" method="post">
		<input type="submit" value="전체 매출"/>
	</form>
	
	<form action="sale_month.jsp?retailer_id=<%=request.getParameter("retailer_id")%>" method="post">
		<input type="submit" value="월별 매출"/>
	</form>
	
	<form action="sale_day.jsp?retailer_id=<%=request.getParameter("retailer_id")%>" method="post">
		<input type="submit" value="일별 매출"/>
	</form>
		

</body>
</html>