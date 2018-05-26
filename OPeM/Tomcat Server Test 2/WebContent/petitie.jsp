<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="Pack1.*"%>
    <%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Prezentare Petitie</title>
    <link rel="stylesheet" type="text/css" href="prezentarePetitie.css">
</head>
<body>
<div class="navbar" id="myNavbar">
    <a href="index.jsp" style="margin-left: 20%">Acasa</a>
    <a href="Exploreaza.html">Exploreaza</a>

</div>
<div id="main">
    <br>
	<%
	Petition p=Database.getPetitionById(Long.parseLong(request.getParameter("index")));
	%>
    <h2 id="titlu" name="titlu"><%out.print(p.title); %></h2>

    <h4 id="descriere" name="descriere"><%out.print(p.description); %></h4>

    <!--<h4 name="obiectiv">Obiectiv:</h4>-->
    <progress id="progres" name="progres" value="<%out.print(p.votes*100/p.target); %>" max="100" >
    </progress>
    <h4 id="termenLimita" >Termen Limita: &nbsp;<span name="termenLimita"><%out.print(p.expDate); %></span></h4>
    <h4 >Initiatorul petitiei: &nbsp;<span name="numeDetinator"> <%out.print(p.name); %></span></h4>
    <br>
    <hr>
    <form id="semnareButon" >
        Email:<br>
        <input style="height:25px;width:30%" type="email" id="email_petitie" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"
               required title="Sase sau mai multe caractere" maxlength="50">
        <br><br>

        <input id=Buton  type="submit" value="Semnez!">
        <!--onclick="window.location.href='/page2'"-->
    </form>
    <p style="text-align: center">~mesaj~</p>
</div>
</body>
</html>
