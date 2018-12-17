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
	<h2> 재고 주문 성공! </h2>
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
 	out.println("<h4>" + " 재고 관리 "  +"</h4>");
	String retailer_id = request.getParameter("retailer_id");
	String query = "select name "
			+ " from retailer"
			+ " where retailer_id='" + request.getParameter("retailer_id") + "'";

	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	rs.next();
	String retailer_name = rs.getString(1);
	pstmt.close();
 %>
			
	<form action="manage.jsp?retailer_name=<%=retailer_name%>" method="post">
		<input type="submit" value="메인으로 가기"/>
	</form>

<% 
	query = "SELECT * "
		+ " from be_in_stock natural join item "
	+ " where retailer_id='" + retailer_id  + "'";
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	out.println("<form action = \"stock_add.jsp?retailer_id=" + retailer_id +"\" method=\"POST\">");
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	
	out.println("<th>"+ "  이름  " +"</th>");
	out.println("<th>"+ "  재고  " +"</th>");
	out.println("<th>"+ "  재고 증가량  " +"</th>");
	
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(5)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>");
		out.println("<td>" + "<input type=\"text\"" + "name=\"product_" + rs.getString(1) +  "\"" + "/>" + "</td>");
		out.println("</tr>");
	}
	
	out.println("</table>");
	out.println("<input type=\"submit\" value=\"주문\" />");
	out.println("</form>");
	pstmt.close();
	
%>


<%
	conn.close();
%>

</body>
</html>