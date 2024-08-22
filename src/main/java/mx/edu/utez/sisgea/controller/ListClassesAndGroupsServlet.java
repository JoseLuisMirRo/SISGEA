package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.ClassDao;
import mx.edu.utez.sisgea.dao.GroupDao;
import mx.edu.utez.sisgea.model.ClassBean;
import mx.edu.utez.sisgea.model.GroupBean;
import mx.edu.utez.sisgea.model.LoginBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/data/classes")
public class ListClassesAndGroupsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        HttpSession activeSession = req.getSession();
        LoginBean user = (LoginBean) activeSession.getAttribute("activeUser");

        if(user==null || user.getRole()==null){
            req.getRequestDispatcher("/views/layout/error403.jsp").forward(req, resp);
            return;
        }
        if(user.getRole().getId()!=1){
            req.getRequestDispatcher("/views/layout/error403.jsp").forward(req, resp);
            return;
        }

        ClassDao classDao = new ClassDao();
        GroupDao groupDao = new GroupDao();

        List<ClassBean> classesList = classDao.getAllClasses();
        List<GroupBean> groupsList = groupDao.getAllGroups();

        Map<String, Object> combinedLists = new HashMap<>();
        combinedLists.put("classes", classesList);
        combinedLists.put("groups", groupsList);

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String jsonArray = gson.toJson(combinedLists);

        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();
    }
}
