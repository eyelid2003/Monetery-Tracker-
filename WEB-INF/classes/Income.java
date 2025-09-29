import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;
public class Income extends HttpServlet
{
    private static final long serialVersionUID= 1L;
    protected void doPost(HttpServletRequest req ,HttpServletResponse res) throws ServletException,IOException
    {
        PrintWriter p=res.getWriter();
        String name =req.getParameter("name");
        String amount =req.getParameter("amount");
        String cat =req.getParameter("cat");
        String date =req.getParameter("date");
        RequestDispatcher dis=null;
        HttpSession htps=req.getSession();
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/monetory_tracker","root","root");
            String query=" insert into income (name,amount,cat,Idate) values ('"+name+"','"+amount+"','"+cat+"','"+date+"') ";
            PreparedStatement ps=con.prepareStatement(query);
            int i=ps.executeUpdate();
            
            if(i==1)
            {
                htps.setAttribute("sucess","data incerted");
                res.sendRedirect("income.jsp");
                return;
            }
            else
            {
                htps.setAttribute("failed","something iss wrong");
                res.sendRedirect("income.jsp");
                return;
            }
        }
        catch(Exception e)
        {
            htps.setAttribute("error","sothing is wrong");
            res.sendRedirect("income.jsp");
            return;
        }
    }
}