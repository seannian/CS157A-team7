
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;

import java.sql.Blob;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String databaseUser = "root";
		String databasePassword = "root";
		PrintWriter out = response.getWriter();
		// Connect to database and compare user's input
		try {
			java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/?autoReconnect=true&useSSL=false", databaseUser, databasePassword);
            String uname = request.getParameter("uname");
    		String password = request.getParameter("password");
    		String sql = "SELECT username FROM myflorabase.user WHERE username = ? AND password=?";
           		
    		try (PreparedStatement statement = con.prepareStatement(sql)) {
            	statement.setString(1, uname);
            	statement.setString(2, password);
            	ResultSet result = statement.executeQuery();
            	if(result.next()) {
            		RequestDispatcher rd = request.getRequestDispatcher("sighting.jsp");
            		rd.forward(request, response);
            	}
            	else {

            		// TODO: Pop up an error box before redirect to login page
            		out.println("<font color=red size=20>Login Failed!!!<br>");
            		out.println("<a href=login.jsp>Try AGAIN!! </a>");
//            		RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
//            		rd.forward(request, response);
            	}
            }
            
            con.close();
		} catch(SQLException e) {
            System.out.println("SQLException caught: " + e.getMessage());
        } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
	}

}
