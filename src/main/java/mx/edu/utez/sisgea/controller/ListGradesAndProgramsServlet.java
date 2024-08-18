package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sisgea.dao.GradeDao;
import mx.edu.utez.sisgea.dao.ProgramDao;
import mx.edu.utez.sisgea.model.GradeBean;
import mx.edu.utez.sisgea.model.GroupBean;
import mx.edu.utez.sisgea.model.ProgramBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/data/gradesAndPrograms")
public class ListGradesAndProgramsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        GradeDao gradeDao = new GradeDao();
        ProgramDao programDao = new ProgramDao();

        List<ProgramBean> programsList = programDao.getAllPrograms();
        List<GradeBean> gradesList = gradeDao.getAllGrades();

        Map<String, Object> combinedLists = new HashMap<>();
        combinedLists.put("programs", programsList);
        combinedLists.put("grades", gradesList);

        Gson gson = new GsonBuilder().create();
        String jsonArray = gson.toJson(combinedLists);

        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();
    }
}
