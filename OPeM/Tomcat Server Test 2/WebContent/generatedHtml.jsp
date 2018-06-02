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
<html>
<head>
    <title>Form Reports</title>
    <meta name="robots" content="noindex, nofollow">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="raport.css" type="text/css" media="print, projection, screen">
   

   
<style type="text/css"></style>
</head>
<body>
	<h2 >Raport</h2>
    <table id="data-table" class="tablesorter tablesorter-blue hasStickyHeaders" border="1" cellpadding="8" cellspacing="0" role="grid">
<thead>

<tr class="tablesorter-headerRow" role="row">

<th><div class="tablesorter-header-inner">Titlu</div></th><th><div class="tablesorter-header-inner">Autor</div></th><th><div class="tablesorter-header-inner">Voturi</div></th><th><div class="tablesorter-header-inner">Target Voturi</div></th><th><div class="tablesorter-header-inner">Tip petitie</div></th><th><div class="tablesorter-header-inner">Data expirarii</div></th><th><div class="tablesorter-header-inner">Petitii similare</div></th>

</thead>

<tbody aria-live="polite" aria-relevant="all">
<% 
ArrayList<Petition> p=Database.getAll();
if(p!=null)
	for(int i=0;i<p.size();i++)
	{
		out.print("<tr class=\"odd\"><td>"+p.get(i).title+"</td><td>"+p.get(i).name+"</td><td>"+p.get(i).votes+"</td><td>"+p.get(i).target+"</td><td>"+p.get(i).category+"</td><td>"+p.get(i).expDate+"</td><td>");
		for(int j=0;j<p.size();j++)
		{
			if(i!=j)
				for(int k=0;k<p.get(i).tags.size();k++)
				{
					for(int l=0;l<p.get(j).tags.size();l++)
						if(p.get(i).tags.get(k).equals(p.get(j).tags.get(l)))
						{
							out.print("<p>"+p.get(j).title+"</p>");
							l=p.get(j).tags.size();
							k=p.get(i).tags.size();
							
						}
				}
		}
		out.print("</td></tr>");
		//System.out.println(p.get(i).tags.get(0));
	}
//<tr class="odd"><td>Titlu Petitie</td><td>Autor petitie</td><td>75</td><td>100</td><td>Sport</td><td>15.09.2018</td><td><p>Petitie vecin1</p><p>Petite vecin2</p><p>Petite vecin 3</p></td></tr>

%>

  </tbody></table>
	<!--   <table id="data-table-sticky" class="tablesorter tablesorter-blue containsStickyHeaders tablesorter-sticky-hidden" border="1" cellpadding="8" cellspacing="0" role="grid" style="position: fixed; margin: 0px; top: 0px; left: 0px; visibility: hidden; z-index: 2; height: 0px; width: 1893px; padding: 0px; border: 0px;">
	</table> -->

</body>
</html>


