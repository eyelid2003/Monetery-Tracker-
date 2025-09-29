import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;
public class Asking extends HttpServlet
{
    private static final long serialVersionUID= 1L;
    protected void doPost(HttpServletRequest req ,HttpServletResponse res) throws ServletException,IOException
    {
        PrintWriter p=res.getWriter();
        String name =req.getParameter("name");
        String email =req.getParameter("email");
        String msg =req.getParameter("msg");
        RequestDispatcher dis=null;
        HttpSession htps=req.getSession();
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/monetory_tracker","root","root");
            String query=" insert into asking (name,email,msg) values ('"+name+"','"+email+"','"+msg+"') ";
            PreparedStatement ps=con.prepareStatement(query);
            int i=ps.executeUpdate();
            
            if(i==1)
            {
                htps.setAttribute("sucess","Review Send to the Admin");
                res.sendRedirect("index.jsp");
                return;
            }
            else
            {
                htps.setAttribute("failed","something iss wrong");
                res.sendRedirect("index.jsp");
                return;
            }
        }
        catch(Exception e)
        {
            htps.setAttribute("error","sothing is wrong");
            res.sendRedirect("index.jsp");
            return;
        }
    }
}