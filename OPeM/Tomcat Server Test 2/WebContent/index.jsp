<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List" %>
    <%@ page import="Pack1.*"%>
    <%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="mycss.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>

<div class="header">
    <img id="img_citat" src="poza_citat3.jpg" alt="Citat motivational.">
</div>


<div class="navbar" id="myNavbar">
    <a href="index.jsp" class="active">Acasa</a>
    <a href="Exploreaza.html">Exploreaza</a>
    <a onclick="myFunctionStiri()" >Noutati</a>
    <a onclick="myFunctionContact()" >Contact</a>
    <a id="Library" onclick="myFunctionSearch()"></a>
    <a href="javascript:void(0);" style="font-size:23px;" class="icon" onclick="myFunction()">&#9776;</a>
</div>


<script>
    function myFunction() {
        var x = document.getElementById("myNavbar");
        if (x.className === "navbar") {
            x.className += " responsive";
        } else {
            x.className = "navbar";
        }
    }

    function myFunctionSearch() {
        var elmnt = document.getElementById("search_form");
        elmnt.scrollIntoView();
    }

    function myFunctionStiri() {
        var elmnt = document.getElementById("stiri");
        elmnt.scrollIntoView();
    }

    function myFunctionContact() {
        var elmnt = document.getElementById("about_text");
        elmnt.scrollIntoView();
    }

    // window.onscroll = function () {
    //     myFunction2()
    //
    // };
    //
    // var navbar = document.getElementById("myNavbar");
    // var sticky = navbar.offsetTop;
    // function myFunction2() {
    //     if (window.pageYOffset >= sticky) {
    //         navbar.classList.add("sticky")
    //     } else {
    //         navbar.classList.remove("sticky");
    //     }
    // }
</script>


<div class="main">
    <div class="header_text">

        <h2>&emsp;Creaza petitii gratuit!</h2>
        <p>&emsp;Schimbarea incepe cu <strong>tine</strong>, indrazneste chiar acum sa te alaturi cauzelor lor si sa le
            sustii cu semnatura ta!
            Pe aceasta pagina poti atat sa creezi o petitie, sa cauti o petitie cat si sa vezi petitiile ce sunt in
            tranding .
            Dorinta aceste pagini este de a unii fiecare perosana cu cei din comunitatea noastra, ce doresc sa lupte
            pentru cauze nobile din societatea noastra</p>
        <p><strong>Stiai ca:</strong> 9/10 dintre petitiile noastre au adunat semnaturile si au invins impreuna?</p>
        <!--<p>Pe aceasta pagina poti atat sa creezi o petitie, sa cauti o petitie cat si sa vezi petitiile ce sunt in tranding .</p>-->


        <form id="search_form">
            <br><br><br>
            <input type="text" id="search" name="search"/>

        </form>
        <br><br>


        <p>&emsp;&emsp;<strong>Mai jos vei gasii topul petitiilor de pe pagina noastra, trage o privire peste ele si
            alaturate lor, si de ce nu fii tu initiatorul unei noi petitii</strong></p>
        <br>

    </div>
    <div id="stiri">

        <br><br>
        <h3 style="margin-left: 2%; ">Noutati</h3>
        <%
        ArrayList<Petition> p=Database.get();
        if(p!=null)
        for(int i=0;i<p.size();i++)
        {
        	out.println("<div>");
        	out.println("<div class=\"wrapper\">");
        	out.println("<header class=\"header\">"+p.get(i).category +"</header>");
        	out.println("<aside class=\"sidebar\">"+p.get(i).votes+"/"+p.get(i).target+ "voturi</aside>");
        	out.println("<article class=\"content\">");
        	//out.println("<h1>"+p.get(i).title +"</h1>");
        	out.println("<a href=\"petitie.jsp?index="+p.get(i).id+"\">"+p.get(i).title +"</a>");
        	out.println("<p>"+p.get(i).description +"</p>");
        	out.println("</article>");
        	out.println("<footer class=\"footer\">Termen limita: "+p.get(i).expDate+"</footer>");
        	out.println("</div>\n</div>\n<br>");
        	//out.println("<a href=\"petitie.jsp\">"+p.get(i).title +"</a>");
        	
        	
        }
        else
        	System.out.println("Should be empty");
        
        %>
        <br><br>
    </div>

<div>
    <a class="petition-button" href="Petitie.html"><p>START A PETITION NOW <img class="img-start-pet"
                                                                             src="laDreaptapng.png" alt=" "> </p></a>

</div>
</div>
<br>
<hr>
<div class="about_us">
    <h3 id="about_text">About us</h3>
    <p id="about_main">
    <p id="email_about"> Email: depunepetitie@yahoo.com</p>
    <p id="autori">Autori:<br> Pantelimon Victor & Bocicu Samuel<br>Copyright 2018</p>


    <button class="admin" onclick="document.getElementById('id01').style.display='block'" style="width:auto;">Admin</button>

    <div id="id01" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
                <img src="seg.jpg" alt="Avatar" class="avatar">
            </div>

            <div class="container">
                <label for="uname"><b>Username</b></label>
                <input type="text" placeholder="Enter Username" name="uname" required>

                <label for="psw"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="psw" required>

                <button type="submit">Login</button>
                <label>
                    <input type="checkbox" checked="checked" name="remember"> Remember me
                </label>
            </div>

            <div class="container" style="background-color:#f1f1f1">
                <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
                <span class="psw">Forgot <a href="#">password?</a></span>
            </div>
        </form>
    </div>

    <script>
        // Get the modal
        var modal = document.getElementById('id01');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</div>

</body>
</html>