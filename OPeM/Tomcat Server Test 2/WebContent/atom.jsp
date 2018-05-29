<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="Pack1.*"%>
    <%@ page import="java.util.ArrayList"%>
	<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://localhost:8081/Tomcat_Server_Test_2/atom.jsp">
<%
ArrayList<Petition> p=Database.get();
if(p!=null)
for(int i=0;i<p.size();i++)
{
	out.println("<petition>");
	out.println("<category>"+p.get(i).category +"</category>");
	out.println("<votes>"+p.get(i).votes+"</votes>");
	out.println("<target>"+p.get(i).target+ "</target>");
	out.println("<id>"+p.get(i).id+"</id>");
	out.println("<title>"+p.get(i).title +"</title>");
	out.println("<description>"+p.get(i).description +"</description>");
	out.println("<expiration_date>"+p.get(i).expDate+"</expiration_date>");
	out.println("</petition>");
	
	
}

%>
</feed>
