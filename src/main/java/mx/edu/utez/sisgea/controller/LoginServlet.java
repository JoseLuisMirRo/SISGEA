package mx.edu.utez.sisgea.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.LoginDao;
import mx.edu.utez.sisgea.model.LoginBean;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/loginForm")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();

        //Roles y rutas del sistema
        String[] roles = {"Administrador", "Docente", "Alumno"};
        String[] routes = {"mainAdministrador", "mainDocente", "mainAlumno"};

        String email = req.getParameter("inputEmail");
        String password = req.getParameter("inputPassword");

        LoginBean logBean = new LoginBean(email, password);
        LoginDao logDao = new LoginDao();

        if (email == null || email.isEmpty()) {
            req.setAttribute("status", "invalidEmail");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
        if (password == null || password.isEmpty()) {
            req.setAttribute("status", "invalidPassword");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }

        try {
            LoginBean user = logDao.loginValidate(logBean);
            if (user != null) {
                //Verificacion de rol
                for (int i = 0; i < roles.length; i++) {
                    if (roles[i].equals(user.getRole())) {
                        HttpSession activeSession = req.getSession();
                        activeSession.setAttribute("activeUser", user);
                        req.getRequestDispatcher("/views/" + routes[i] + ".jsp").forward(req, resp);
                    }
                }
            } else {
                req.setAttribute("status", "failed");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            if (e.getMessage().equals("deshabilitado")) {
                req.setAttribute("status", "unauthorized");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            } else {
                System.out.println("Error al iniciar sesion" + e);
                req.setAttribute("status", "serverError");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                e.printStackTrace();
            }
        }
    }
}

