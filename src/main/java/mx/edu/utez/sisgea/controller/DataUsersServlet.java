package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sisgea.dao.UserDao;
import mx.edu.utez.sisgea.model.UserBean;

import java.io.IOException;
import java.io.PrintWriter;
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

        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        String jsonArray = gson.toJson(usersList);
        //System.out.println("Número de usuarios en la lista: " + usersList.size());

        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();

    }
}
