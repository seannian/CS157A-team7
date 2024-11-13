package header;

import com.example.*;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.*;

@WebServlet("/profile")
public class profileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public profileServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		// set profile outline color, and active tab status
		HttpSession curSession = request.getSession(false);
		if (curSession == null || curSession.getAttribute("user") == null) {
			request.setAttribute("errorTitle", "You were logged out!");
			request.setAttribute("errorMessage", "Please Sign In again.");
			request.getRequestDispatcher("login.jsp").forward(request, response);
			response.sendRedirect("login.jsp");
		} else {
			User user = (User) curSession.getAttribute("user");

			if (user.isAdmin()) {
				request.setAttribute("profileActive", "active");
				request.setAttribute("userType", "admin");
			} else {
				request.setAttribute("profileActive", "active");
				request.setAttribute("userType", "user");
			}

			RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
			dispatcher.forward(request, response);
			response.sendRedirect("profile.jsp");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
	}

	public void destroy() {
	}
}