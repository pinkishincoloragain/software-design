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
	<h2>  </h2>
	<br>
<%
	String serverIP = "localhost";
	String portNum = "3306";
	String dbName = "comp322";
	String url = "jdbc:mysql://" +serverIP + ":" +portNum + "/"+ dbName;
	String user = "root";
	String pass = "1234qwer";
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, pass);
%>
 
 <%
 	out.println("<h4>" + request.getParameter("retailer_name") + " 매장 관리 "  +"</h4>");
 %>
	
<%
	System.out.println(request.getParameter("retailer_name"));
%>

<%
	String query = "select * "
		+ " from retailer"
		+ " where name='" + request.getParameter("retailer_name") + "'";

	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	rs.next();
	String retailer_id = rs.getString(3);
	pstmt.close();
	
%>

<form action="stock.jsp?retailer_id=<%=retailer_id%>" method="post">
	<input type="submit" value="재고관리하러가기"/>
</form>

<form action="sales.jsp?retailer_id=<%=retailer_id%>" method="post">
	<input type="submit" value="매출 보기"/>
</form>
		

<%
	conn.close();
%>

</body>
</html>