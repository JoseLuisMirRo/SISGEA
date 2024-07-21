package mx.edu.utez.sisgea.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.model.LoginBean;

import java.io.IOException;

@WebServlet("/calendar")
public class CalendarServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession activeSession = req.getSession();
        LoginBean user = (LoginBean) activeSession.getAttribute("activeUser");
        RequestDispatcher rd;

        if(user!=null){
            rd = req.getRequestDispatcher("/views/index.jsp");
        }else{
            rd = req.getRequestDispatcher("/views/login/login.jsp");
    }
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession activeSession = req.getSession();
        LoginBean user = (LoginBean) activeSession.getAttribute("activeUser");
        RequestDispatcher rd;

        if(user!=null){
            rd = req.getRequestDispatcher("/views/index.jsp");
        }else{
            rd = req.getRequestDispatcher("/views/login/login.jsp");
        }
        rd.forward(req, resp);
    }
}
