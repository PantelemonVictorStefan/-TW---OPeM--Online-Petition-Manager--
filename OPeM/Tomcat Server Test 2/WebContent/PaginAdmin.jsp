<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="Pack1.*"%>
    <%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<%
//System.out.println(request.getCookies()[0].getValue());
try{
if(!request.getCookies()[0].getValue().equals(Database.SID))
response.sendRedirect("index.jsp");
}
catch(NullPointerException e)
{
	response.sendRedirect("index.jsp");
}
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pagina Admin</title>
    <link rel="stylesheet" type="text/css" href="paginaAdmin.css">
</head>
<body>
<div class="navbar" id="myNavbar">
<a >Pagina Admin</a>


</div>
<br><br>
<br><br>
<form action="generatedHtml.jsp">

    <p>Generare raport HTML: <input id=raport_html type="submit" value="Raport HTML"></p>
</form>
<br><br>
<form action="generatePdf">
    <p>Generare raport PDF: <input id=raport_pdf type="submit" value="Raport PDF"></p>
</form>

</body>
</html>