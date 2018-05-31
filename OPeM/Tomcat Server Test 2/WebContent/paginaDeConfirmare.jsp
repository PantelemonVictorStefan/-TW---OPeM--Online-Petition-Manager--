<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="Pack1.*"%>
    <%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pagina de Confirmare</title>
<link rel="stylesheet" type="text/css" href="paginaDeConfirmare.css">
</head>
<body>
<div class="navbar" id="myNavbar">
    <a href="index.jsp" style="margin-left: 10%">Acasa</a>
    <a href="exploreaza.jsp">Exploreaza</a>

</div>

<br>
<br>
<br>
<br>
<br>
<form action="SubmitCode"  >
<p>Codul de confirmare:</p><input id="test" type="text" name="codConfirmare" ><br><br>
<input id=submit_button type="submit" value="Submit">
<input type="hidden" name="index" value="<%out.print(request.getParameter("index")); %>" />
<input type="hidden" id="email" name="email" value="<%out.print(request.getParameter("email")); %>" />
<input type="hidden" id="idpetitie" name="id_petitie" value="<%out.print(request.getParameter("id_petitie")); %>" />
    <br><br>
    <div id="mesaj">
<%
String mesaj=request.getParameter("mesaj");
if(mesaj.equals("0"))
	out.println("<p>Ai gresit codul, incearca din nou cu mai multa atentie.</p>");
%>
    
    </div>
</form>
<br>
<br>
<button id=submit_button onclick="submitForm()">Retrimite</button>
<script>

function submitForm() {
    var http = new XMLHttpRequest();
    http.open("POST", "SubmitCode", true);
    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    var params = "search=" + document.getElementById("email").value // probably use document.getElementById(...).value
    var params2="id=" + document.getElementById("idpetitie").value;
    http.send(params+"&"+params2);
    http.onload = function() {
        alert("Emailul a fost trimis la " + document.getElementById("email").value);
    }
}

</script>
</body>
</html>