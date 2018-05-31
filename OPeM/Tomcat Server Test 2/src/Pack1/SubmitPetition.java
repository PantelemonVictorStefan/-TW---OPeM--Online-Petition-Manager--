package Pack1;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SubmitPetition
 */
@WebServlet("/SubmitPetition")
public class SubmitPetition extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitPetition() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String category=request.getParameterValues("type_of_petition")[0];
		String title=request.getParameterValues("textarea")[0];
		String description=request.getParameterValues("textarea")[1];
		String target=request.getParameterValues("target")[0];
		String tags=request.getParameterValues("taguri_petitie")[0];
		String name=request.getParameterValues("firstname")[0];
		String email=request.getParameterValues("email")[0];
		String exp=request.getParameterValues("termenLimita")[0];
		
			//System.out.println(category+" "+title+" "+description+" "+target+" "+tags+" "+name+" "+email+" "+exp);
			long trg=Long.parseLong(target);
			
			
			/*int c=0;
			switch (category)
			{
			case "Politica": c=1; break;
			case "Sport": c=2; break;
			case "Societate": c=3; break;
			case "Other": c=4; break;
			}*/
			//p.tags2=request.getParameterValues("taguri_petitie")[0];
			//p.getTags();
			//System.out.println(category+" "+p.category);
			if(validateData(category,title,description,trg,email,exp))
			{
				Petition p=new Petition(category,title,description,trg,0,tags,name,email,exp);
				long id=Database.add(p);
				//System.out.println(request.getServletContext().getRealPath("/"));
				updateXML(request.getServletContext().getRealPath("/")+"flux.xml");
				doPost(request,response,id);
			}
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response,long id) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		//System.out.println("In the post"+id);
		RequestDispatcher myDispatch = request.getRequestDispatcher("petitie.jsp?index="+id+"&mesaj=null");
	    myDispatch.forward(request, response);
	    //response.sendRedirect("https://www.google.ro/?gws_rd=ssl");
		
	}
	
	boolean validateData(String cat,String titl,String desc, long trg,String eml,String expiration)
	{
		if((!cat.equals((String)"Politica"))&&(!cat.equals((String)"Societate"))&&(!cat.equals((String)"Sport"))&&(!cat.equals((String)"Other")))
			return false;
		if(titl.length()<6)
			return false;
		if(desc.length()<15)
			return false;
		if((trg!=100)&&(trg!=1000)&&(trg!=10000)&&(trg!=100000)&&(trg!=1000000))
			return false;
		if((!eml.contains("@"))||(!eml.contains(".")))
			return false;
		Calendar.getInstance();
		if(Integer.parseInt(expiration.substring(0,4))<Calendar.YEAR)
			return false;
		else
			if(Integer.parseInt(expiration.substring(0,4))==Calendar.YEAR)
				if(Integer.parseInt(expiration.substring(5,7))<Calendar.MONTH)
					return false;
				else
					if(Integer.parseInt(expiration.substring(5,7))==Calendar.MONTH)
							if(Integer.parseInt(expiration.substring(8,10))<Calendar.DAY_OF_MONTH)	
								return false;
		return true;
	}
	
	void updateXML(String path)
	{
		try {
			ArrayList<Petition> petitions=Database.get();
			PrintWriter out= new PrintWriter(path);
			out.println("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>");
			out.println("<feed xmlns=\"http://www.w3.org/2005/Atom\">");
			out.println("<id>http://79.112.42.126:8081/Tomcat_Server_Test_2/flux.xml</id>"); //UPDATE
			out.println("<title>Flux Atom</title>");
			out.println("<updated>"+Calendar.getInstance().get(Calendar.YEAR)+"-"+Calendar.MONTH+"-"+Calendar.DAY_OF_MONTH+"T"+Calendar.HOUR+":"+Calendar.MINUTE+":"+Calendar.SECOND+"Z</updated>");
			//2007-02-25T13:37:36Z
			out.println(" <link rel=\"self\" type=\"application/atom+xml\" href=\"http://79.112.42.126:8081/Tomcat_Server_Test_2/flux.xml\" />"); //UPDATE
			out.println("<author>\n<name>depunepetitie</name>\n</author>");
			for(int i=0;i<petitions.size();i++)
			{
				out.println("<entry>");
				out.println("<title>"+petitions.get(i).title +"</title>");
				out.println("<link href=\""+"http://79.112.42.126:8081/Tomcat_Server_Test_2/petitie.jsp?index="+petitions.get(i).id+"\"/>"); //UPDATE
				out.println("<id>"+"http://79.112.42.126:8081/Tomcat_Server_Test_2/petitie.jsp?index="+petitions.get(i).id +"</id>");
				out.println("<updated>"+petitions.get(i).creDate.substring(0,10)+"T"+petitions.get(i).creDate.substring(11,19)+"Z</updated>");
				out.println("<summary>"+petitions.get(i).description +"</summary>");
				out.println("</entry>\n\n");
				 
			}
			//System.out.println("Fac treaba asta");
			//System.out.println("Working Directory = " +             System.getProperty("user.dir"));
			out.println("</feed>");
			out.flush();
			out.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	

}
