package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sisgea.dao.NonBusinessDayDao;
import mx.edu.utez.sisgea.model.NonBusinessDay;

import javax.swing.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/data/nbd")
public class ListNonBusinessDayServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        NonBusinessDayDao nbdDao = new NonBusinessDayDao();

        List<NonBusinessDay> nbdList = nbdDao.getNonBusinessDays();
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setPrettyPrinting().create();
        String jsonArray = gson.toJson(nbdList);

        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();
    }
}
