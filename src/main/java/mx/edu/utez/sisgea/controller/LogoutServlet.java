package mx.edu.utez.sisgea.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.LoginDao;

import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        req.setCharacterEncoding("UTF-8");

        LoginDao close = new LoginDao();

        try{
            close.closeConnection();
            HttpSession activeSession = req.getSession();
            activeSession.removeAttribute("activeUser");
            req.getRequestDispatcher("/views/login/login.jsp").forward(req, resp);
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
