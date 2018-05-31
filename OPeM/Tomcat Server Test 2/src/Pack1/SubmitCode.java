package Pack1;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SubmitCode
 */
@WebServlet("/SubmitCode")
public class SubmitCode extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitCode() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		//System.out.println(request.getParameterValues("index")[0]+" "+request.getParameterValues("codConfirmare")[0]);
		long id=Long.parseLong(request.getParameterValues("index")[0]);
		int code=Integer.parseInt(request.getParameterValues("codConfirmare")[0]);
		
		long pet_id=Database.submitCode(id, code);
		//System.out.println(id+" "+code+" "+pet_id);
		if(pet_id<1)
		{
			RequestDispatcher myDispatch = request.getRequestDispatcher("paginaDeConfirmare.jsp?index="+id+"&mesaj=0");
		    myDispatch.forward(request, response);
		}
		else
		{
			RequestDispatcher myDispatch = request.getRequestDispatcher("petitie.jsp?id_petitie="+request.getParameterValues("id_petitie")[0]+"&index="+pet_id+"&mesaj=congratz&email="+request.getParameterValues("email")[0]);
		    myDispatch.forward(request, response);
		}
		//System.out.println("GET");
			
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		//System.out.println(request.getParameter("search")+"\n"+request.getParameter("id"));
		Database.signPetition(Long.parseLong(request.getParameter("id")), request.getParameter("search"));
		
	}

}
