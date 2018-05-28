package Pack1;

import java.io.IOException;
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
	

}
