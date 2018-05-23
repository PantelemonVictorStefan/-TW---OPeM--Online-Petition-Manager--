package Pack1;

import java.io.IOException;

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
		response.getWriter().append("Served at: ").append(request.getContextPath());
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
			Petition p=new Petition(category,title,description,trg,0,tags,name,email,exp);
			//p.tags2=request.getParameterValues("taguri_petitie")[0];
			//p.getTags();
			//System.out.println(category+" "+p.category);
			Database.add(p);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	

}
