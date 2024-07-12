package mx.edu.utez.sisgea.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.LoginDao;
import mx.edu.utez.sisgea.dao.RoleDao;
import mx.edu.utez.sisgea.dao.UserroleDao;
import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.model.RoleBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/loginForm")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();
        //Roles del sistema
        Integer[] roles = {1, 2, 3};

        String email = req.getParameter("inputEmail");
        String password = req.getParameter("inputPassword");

        LoginBean logBean = new LoginBean(email, password);
        LoginDao logDao = new LoginDao();

        if (email == null || email.isEmpty()) {
            req.setAttribute("status", "invalidEmail");
            req.getRequestDispatcher("/views/login/login.jsp").forward(req, resp);
        }
        if (password == null || password.isEmpty()) {
            req.setAttribute("status", "invalidPassword");
            req.getRequestDispatcher("/views/login/login.jsp").forward(req, resp);
        }

        try {
            LoginBean user = logDao.loginValidate(logBean);
            if (user != null) {
                int userId=user.getId();
                UserroleDao userRoleDao = new UserroleDao();
                List<Integer> userRoles = userRoleDao.getUserRoles(userId); //RECIBO LOS ID DE ROLES DISPONIBLES PARA EL USUARIO
                System.out.println(userRoles.size());
                List<RoleBean> roleBeansList = new ArrayList<>(); // Creo una lista de rolebeans vacía
                for (Integer roleId : userRoles) {
                    RoleDao roleDao = new RoleDao(); // Creo un nuevo RoleDao
                    RoleBean role = roleDao.getRoleById(roleId); // Obtengo el objeto RoleBean a partir del id
                    roleBeansList.add(role); // Agrego el objeto RoleBean a la lista de roles
                }

                if(userRoles.size()>1){ //Si un usuario tiene mas de un rol
                    req.setAttribute("userRoles",roleBeansList); //ENVIO CON LA PETICION LA LISTA DE roleBeans para el usuario
                    HttpSession activeSession = req.getSession();
                    activeSession.setAttribute("activeUser",user); //ENVIO EL USUARIO
                    req.getRequestDispatcher("/views/login/login-multirole.jsp").forward(req,resp);
                    Integer result = (Integer) req.getAttribute("result");
                }
                else { //Si solo tiene un rol
                    for (int j = 0; j < roles.length; j++) {
                        if (roles[j].equals(userRoles.get(0))) {
                            user.setRole(roleBeansList.get(0)); //LE PASO EL UNICO ROL EN LA POSICION CERO
                            HttpSession activeSession = req.getSession();
                            activeSession.setAttribute("activeUser", user);
                            req.getRequestDispatcher("/views/index.jsp").forward(req, resp);
                        }
                    }
                }
            } else {
                req.setAttribute("status", "failed");
                req.getRequestDispatcher("/views/login/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            if (e.getMessage().equals("deshabilitado")) {
                req.setAttribute("status", "unauthorized");
                req.getRequestDispatcher("/views/login/login.jsp").forward(req, resp);
            } else {
                System.out.println("Error al iniciar sesion" + e);
                req.setAttribute("status", "serverError");
                req.getRequestDispatcher("/views/login/login.jsp").forward(req, resp);
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("/views/login/login.jsp");
        rd.forward(req, resp);
    }
}

