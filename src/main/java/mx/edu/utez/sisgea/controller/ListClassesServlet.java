package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sisgea.dao.ClassDao;
import mx.edu.utez.sisgea.model.ClassBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/data/classes")
public class ListClassesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        ClassDao classDao = new ClassDao();

        List<ClassBean> classesList = classDao.getAllClasses();

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String jsonArray = gson.toJson(classesList);

        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();
    }
}
