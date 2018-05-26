<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="Pack1.*"%>
    <%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="explo.css">
    <style>
    </style>
</head>
<body>
<div class="navbar" id="myNavbar">
    <a href="index.jsp" style="margin-left: 10%">Acasa</a>
    <a href="exploreaza.jsp" class="active">Exploreaza</a>

</div>

<br>
<p id="text_start"><strong>Mai jos poti gasi toate petitile</strong></p>
<br>
<div class="tab">
    <button class="tablinks" onclick="openCity(event, 'Politica')" id="defaultOpen">Politica</button>
    <button class="tablinks" onclick="openCity(event, 'Sport')">Sport</button>
    <button class="tablinks" onclick="openCity(event, 'Educatie')">Societate</button>
</div>

<div id="Politica" class="tabcontent">

    <input type="text" id="myInputPolitica" onkeyup="myFunctionPolitica()" placeholder="Cauta petitii.." title="Type in a name">

    <ul id="myULPolitica">
    <%
    ArrayList<Petition> p=Database.getByCategory("Politica");
    if(p!=null)
    	for(int i=0;i<p.size();i++)
    	out.println("<li><a href=\"petitie.jsp?index="+p.get(i).id+"\">"+p.get(i).title+"</a></li>");
    %>
    </ul>

</div>

<div id="Sport" class="tabcontent">
    <input type="text" id="myInputSport" onkeyup="myFunctionSport()" placeholder="Cauta petitii.." title="Type in a name">

    <ul id="myULSport">
    <%
    ArrayList<Petition> petitiiSport=Database.getByCategory("Sport");
    if(petitiiSport!=null)
    	for(int i=0;i<petitiiSport.size();i++)
    	out.println("<li><a href=\"petitie.jsp?index="+petitiiSport.get(i).id+"\">"+petitiiSport.get(i).title+"</a></li>");
    %>
    </ul>
</div>

<div id="Educatie" class="tabcontent">
    <input type="text" id="myInputEducatie" onkeyup="myFunctionEducatie()" placeholder="Cauta petitii.." title="Type in a name">

    <ul id="myULEducatie">
    <%
    ArrayList<Petition> petitiiSocietate=Database.getByCategory("Societate");
    if(petitiiSocietate!=null)
    	for(int i=0;i<petitiiSocietate.size();i++)
    	out.println("<li><a href=\"petitie.jsp?index="+petitiiSocietate.get(i).id+"\">"+petitiiSocietate.get(i).title+"</a></li>");
    %>
    </ul>
</div>

<script>
    function myFunctionPolitica() {
        var input, filter, ul, li, a, i;
        input = document.getElementById("myInputPolitica");
        filter = input.value.toUpperCase();
        ul = document.getElementById("myULPolitica");
        li = ul.getElementsByTagName("li");
        for (i = 0; i < li.length; i++) {
            a = li[i].getElementsByTagName("a")[0];
            if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
                li[i].style.display = "";
            } else {
                li[i].style.display = "none";

            }
        }
    }

    function myFunctionSport() {
        var input, filter, ul, li, a, i;
        input = document.getElementById("myInputSport");
        filter = input.value.toUpperCase();
        ul = document.getElementById("myULSport");
        li = ul.getElementsByTagName("li");
        for (i = 0; i < li.length; i++) {
            a = li[i].getElementsByTagName("a")[0];
            if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
                li[i].style.display = "";
            } else {
                li[i].style.display = "none";

            }
        }
    }

    function myFunctionEducatie() {
        var input, filter, ul, li, a, i;
        input = document.getElementById("myInputEducatie");
        filter = input.value.toUpperCase();
        ul = document.getElementById("myULEducatie");
        li = ul.getElementsByTagName("li");
        for (i = 0; i < li.length; i++) {
            a = li[i].getElementsByTagName("a")[0];
            if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
                li[i].style.display = "";
            } else {
                li[i].style.display = "none";

            }
        }
    }

    function openCity(evt, cityName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(cityName).style.display = "block";
        evt.currentTarget.className += " active";
    }

    // Get the element with id="defaultOpen" and click on it
    document.getElementById("defaultOpen").click();
</script>

<div class="about_us">
    <hr>
    <h3 id="about_text">About us</h3>
    <p id="about_main">
    <p id="email_about"> Email: depunepetitie@gmail.com</p>
    <p id="autori">Autori:<br> Pantelimon Victor & Bocicu Samuel<br>Copyright 2018</p>


</div>


</body>
</html>
