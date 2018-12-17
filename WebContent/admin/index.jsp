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
	<h2> 슈퍼 관리자 페이지 </h2>
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
 
	<h4> 매장별 재고 관리 </h4>
<%
	String query = "SELECT * "
		+ "from retailer";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	out.println("<form action=\"manage.jsp\" method=\"POST\">");
	out.println("매장 : <select name=\"retailer_name\">");
	
	while(rs.next()){
		out.print("<option value=\"");
		out.println(rs.getString(1)+"\">");
		out.println(rs.getString(1));
		out.println("</option>");
	}
	
	out.println("<input type=\"submit\" />");
	out.println("</form>");
	
	pstmt.close();
%>
		<input type="button" onclick="location.href='../LogOut.jsp'" value = "Log out"/>


<%
	conn.close();
%>

</body>
</html>