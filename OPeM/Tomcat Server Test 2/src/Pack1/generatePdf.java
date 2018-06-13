package Pack1;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

/**
 * Servlet implementation class generatePdf
 */
@WebServlet("/generatePdf")
public class generatePdf extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public generatePdf() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try{
			if(!request.getCookies()[0].getValue().equals(Database.SID))
			response.sendRedirect("index.jsp");
			}
			catch(NullPointerException e)
			{
				response.sendRedirect("index.jsp");
			}
		
		try {
			createPdf(request.getServletContext().getRealPath("/")+"raport.pdf");
			response.sendRedirect("raport.pdf");
			//response.getWriter().append("Served at: ").append(request.getContextPath());
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
	}
	
	public static void createPdf(String path) throws IOException, DocumentException {
        Document document = new Document();
        PdfWriter.getInstance(document, new FileOutputStream(path));
        document.open();
        PdfPTable table = new PdfPTable(6);
        table.addCell("Titlu");
        table.addCell("Autor");
        table.addCell("Voturi");
        table.addCell("Target Voturi");
        table.addCell("Tip petitie");
        table.addCell("Data expirarii");
        ArrayList<Petition> petitions=Database.getAll();
        for(int i=0;i<petitions.size();i++)
        {
        	table.addCell(petitions.get(i).title);
        	table.addCell(petitions.get(i).name);
        	table.addCell(""+petitions.get(i).votes);
        	table.addCell(""+petitions.get(i).target);
        	table.addCell(petitions.get(i).category);
        	table.addCell(petitions.get(i).expDate);
        }
        document.add(table);
        document.close();
    }

}
