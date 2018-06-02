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
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = 'https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script>

<div class="navbar" id="myNavbar">
    <a href="index.jsp" style="margin-left: 20%">Acasa</a>
    <a href="exploreaza.jsp">Exploreaza</a>

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
    <form id="semnareButon" action="SignPetition" >
        Email:<br>
        <input style="height:25px;width:30%" type="email" id="email_petitie" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"
               required title="Sase sau mai multe caractere" maxlength="50">
        <%out.print("<input type=\"hidden\" name=\"id_petitie\" value="+p.id+">"); %>
        <br><br>

        <input id=Buton  type="submit" value="Semnez!">
        <!--onclick="window.location.href='/page2'"-->
    </form>
    <% 
    String mesaj=request.getParameter("mesaj");
    if(mesaj.equals("-1"))
    {
    	mesaj="Petitia nu mai este valabila";
    	out.print("<p style=\"text-align: center\">"+mesaj+"</p>");
    }
    else
    	if(mesaj.equals("0"))
    	{
    		mesaj="Ai semnat deja";
    		out.print("<p style=\"text-align: center\">"+mesaj+"</p>");
    	}
    	else
    		if(mesaj.equals("congratz"))
        	{
        		mesaj="Iti multumim pentru ca te-ai alaturat cauzei noastre!";
        		out.print("<p style=\"text-align: center\">"+mesaj+"</p>");
        	}
    
    %>
</div>
<div class="fb-share-button" data-href="http://localhost:8081/Tomcat_Server_Test_2/petitie.jsp?index=<%out.print(p.id);%>&amp;mesaj=null" data-layout="button" data-size="large" data-mobile-iframe="true"><a target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Flocalhost%3A8081%2FTomcat_Server_Test_2%2Fpetitie.jsp%3Findex%3D7%26mesaj%3Dnull&amp;src=sdkpreparse" class="fb-xfbml-parse-ignore">Share</a></div>

</body>
</html>
