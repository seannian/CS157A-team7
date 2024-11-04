import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateDescription")
public class UpdateDescriptionServlet extends HttpServlet {
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String description = request.getParameter("description");
        String userId = request.getParameter("userId");
		String databaseUser = "root";
		String databasePassword = System.getenv("DB_PASSWORD");
		try {
			java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/?autoReconnect=true&useSSL=false", databaseUser, databasePassword);
            String sql = "UPDATE myflorabase.user SET description = ? WHERE user_id = ?";
            try (PreparedStatement statement = con.prepareStatement(sql)) {
                statement.setString(1, description);
                statement.setInt(2, Integer.parseInt(userId)); 

                int rowsUpdated = statement.executeUpdate(); 
                response.getWriter().write(rowsUpdated + " row(s) updated."); 
            }
            con.close();
		} catch(SQLException e) {
            System.out.println("SQLException caught: " + e.getMessage());
        } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}