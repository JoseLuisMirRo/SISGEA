package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sisgea.dao.GradeDao;
import mx.edu.utez.sisgea.dao.GroupDao;
import mx.edu.utez.sisgea.model.GradeBean;
import mx.edu.utez.sisgea.model.GroupBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/data/gradesAndGroups")
public class ListGradesAndGroups extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        GroupDao groupDao = new GroupDao();
        GradeDao gradeDao = new GradeDao();

        List<GroupBean> groupsList = groupDao.getAllGroups();
        List<GradeBean> gradesList = gradeDao.getAllGrades();

        Map<String, Object> combinedLists = new HashMap<>();
        combinedLists.put("groups", groupsList);
        combinedLists.put("grades", gradesList);

        Gson gson = new GsonBuilder().create();
        String jsonArray = gson.toJson(combinedLists);

        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();
    }
}
