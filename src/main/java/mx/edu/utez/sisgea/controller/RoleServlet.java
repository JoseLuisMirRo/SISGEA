package mx.edu.utez.sisgea.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.RoleDao;
import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.model.RoleBean;

import javax.management.relation.Role;
import java.io.IOException;
import java.util.List;

@WebServlet("/roleController")
public class RoleServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int selectedRole=Integer.parseInt(req.getParameter("role"));
        HttpSession activeSession = req.getSession();
        LoginBean user = (LoginBean) req.getSession().getAttribute("user");
        RoleDao roleDao = new RoleDao();
        System.out.println(user.getFirstName());
        RoleBean role = roleDao.getRoleById(selectedRole);
        user.setRole(role);
        System.out.println(user.getRole().getName());
        activeSession.removeAttribute("user");
        System.out.println(user);
        activeSession.setAttribute("activeUser", user);

        //Rutas del sistema
        String[] routes = {"mainAdministrador", "mainDocente", "mainAlumno"};
        //Roles del sistema
        Integer[] roles = {1, 2, 3};

        for (int i = 0; i < roles.length; i++) {
            if (roles[i].equals(role.getId())) {
                req.getRequestDispatcher("/views/index.jsp").forward(req, resp);
            }
        }
    }


}
