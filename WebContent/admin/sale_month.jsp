<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.util.Date" %>
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
 	out.println("<h4>" + " 월별 매출 "  +"</h4>");
 %>
			

<% 
	Calendar cal = Calendar.getInstance();
	cal.setTime(new Date());
	
	int first_day = cal.getActualMinimum(Calendar.DAY_OF_MONTH);
	int end_day = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	System.out.println(" " + first_day + " : " + end_day);
	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	cal.set(Calendar.DATE, first_day);
	String first_date = dateFormat.format(cal.getTime());
	
	cal.set(Calendar.DATE, end_day);
	String end_date = dateFormat.format(cal.getTime());
	
	System.out.println(first_date);
	System.out.println(end_date);
	
	String retailer_id = request.getParameter("retailer_id");
	String query = "select product_id, (num * price) as sale_one"
			+ " from item natural join (select product_id, sum(included_num) as num "
			+ "	from (included natural join order_history) natural join order_into "
			+ "	where retailer_id='" + retailer_id + "'"
			+ " and order_date between '" + first_date + "' and '" +  end_date + "' "
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

<h3>월별 전체 매출 : <%=total%></h3>

<%
	conn.close();
%>

</body>
</html>