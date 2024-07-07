package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sisgea.dao.RoleDao;
import mx.edu.utez.sisgea.dao.UserDao;
import mx.edu.utez.sisgea.dao.UserroleDao;
import mx.edu.utez.sisgea.model.RoleBean;
import mx.edu.utez.sisgea.model.UserBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/data/users")
public class DataUsersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        //Borre usuario bean
        UserDao userDao = new UserDao();

        List<UserBean> usersList = userDao.readAllUsers();

        for (UserBean userBean : usersList) {
            int id = userBean.getId(); //Pido ID del usuario
            UserroleDao userroleDao = new UserroleDao(); //Creo nuevo usserrole DAO que guarda id usuario y id role
            List<Integer> rolIds = userroleDao.getUserRoles(id); //Obtengo lista de roles de usuario a partir del id.
            System.out.println(userroleDao.getUserRoles(id));
            List<RoleBean> roles = new ArrayList<>(); // Creo una lista de roles vacía

            for (Integer roleId : rolIds) {
            RoleDao roleDao = new RoleDao(); // Creo un nuevo RoleDao
            RoleBean role = roleDao.getRoleById(roleId); // Obtengo el objeto RoleBean a partir del id
            roles.add(role); // Agrego el objeto RoleBean a la lista de roles
            }
            userBean.setRoles(roles); // Agrego la lista de roles al objeto UserBean
        }

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String jsonArray = gson.toJson(usersList);
        //System.out.println("Número de usuarios en la lista: " + usersList.size());

        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();

    }
}
