package Pack1;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SignPetition
 */
@WebServlet("/SignPetition")
public class SignPetition extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignPetition() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String email=request.getParameterValues("email")[0];
		long id=Long.parseLong(request.getParameterValues("id_petitie")[0]);
		
		if(validateEmail(email))
		{
			doPost(request,response,Database.signPetition(id, email),id);
			
		}
		else
			response.getWriter().append("You email is not valid");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response,long next,long id) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		if(next<1)
		{
		RequestDispatcher myDispatch = request.getRequestDispatcher("petitie.jsp?index="+id+"&mesaj="+next);
	    myDispatch.forward(request, response);
		}
		else
			response.getWriter().append("ID cerere:"+next+"\nDe aici face Sami");
	}

	boolean validateEmail(String email)
	{
		if((!email.contains("@"))||(!email.contains(".")))
			return false;
		return true;
	}
}
