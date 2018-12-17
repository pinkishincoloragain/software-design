<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="java.util.*" %>
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
 	out.println("<h4>" + request.getParameter("retailer_id") + " 매장 관리 "  +"</h4>");
 %>
	
<%
	System.out.println(request.getParameter("retailer_id"));
%>		


<% 
	
	HashMap<String, String> product_list = new HashMap<String,String>();
	
	Enumeration<String> enumer = request.getParameterNames();
	while(enumer.hasMoreElements()){
		String key = enumer.nextElement();
		
		/*	주문할 아이템에 관련된 attribute이면		*/
		if(key.contains("product_")){
			String product_id = key.substring(key.indexOf("product_") + "product_".length());
			String product_num = request.getParameter(key);
			product_list.put(product_id, product_num);
			
			System.out.println(product_id + " : " + product_num);
		}
	}
	
	try{
		for(Iterator<String> iter=product_list.keySet().iterator(); iter.hasNext();){
			String product_id = iter.next();
			
			if(product_list.get(product_id) != null && product_list.get(product_id).length() > 0){
				System.out.println(product_list.get(product_id));
				
				String query = "update be_in_stock set stock=stock + " + product_list.get(product_id)
				+ " where product_id='" + product_id + "' and retailer_id='" + request.getParameter("retailer_id") + "'";
				
				System.out.println(query);
				
				pstmt = conn.prepareStatement(query);
				pstmt.executeUpdate();
				
				pstmt.close();
			}
		}
		
		response.sendRedirect("stock_success.jsp?retailer_id=" + request.getParameter("retailer_id"));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>


<%
	conn.close();
%>

</body>
</html>