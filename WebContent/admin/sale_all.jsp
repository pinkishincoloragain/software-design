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
 	out.println("<h4>" + " 전체매출 "  +"</h4>");
 %>
			

<% 
	String retailer_id = request.getParameter("retailer_id");
	String query = "select product_id, (num * price) as sale_one"
			+ " from item natural join (select product_id, sum(included_num) as num "
			+ "	from (included natural join order_history) natural join order_into "
			+ "	where retailer_id='" + retailer_id + "'"
			+ "	group by product_id) c "
			+ "	order by sale_one desc";
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	
	out.println("<th>"+ "  이름  " +"</th>");
	out.println("<th>"+ "  매출  " +"</th>");
	
	int total = 0;
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("</tr>");
		
		total += (int)Integer.parseInt(rs.getString(2));
	}
	
	out.println("</table>");
	
	pstmt.close();
%>

<h3>전체매출 : <%=total%></h3>

<%
	conn.close();
%>

</body>
</html>