import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;

public class Logout extends HttpServlet
{
    private static final long serialVersionUID= 1L;
    protected void doGet(HttpServletRequest req ,HttpServletResponse res) throws ServletException,IOException
    {
        HttpSession htps=req.getSession();
        try
        {
            htps.removeAttribute("username");
            htps.removeAttribute("email");
            htps.setAttribute("sucess","Logout done");
            res.sendRedirect("index.jsp");
            return;
        }
        catch(Exception e)
        {
            htps.setAttribute("error","sothing is wrong");
            res.sendRedirect("admin/Dashboard.jsp");
            return;
        }
    }
}