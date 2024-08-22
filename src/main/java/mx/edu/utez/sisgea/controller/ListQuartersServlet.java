package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.QuarterDao;
import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.model.QuarterBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/data/quarters")
public class ListQuartersServlet extends HttpServlet {
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


        QuarterDao quarterDao = new QuarterDao();

        List<QuarterBean> quartersList = quarterDao.getAllQuarters();

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setPrettyPrinting().create();
        String jsonArray = gson.toJson(quartersList);

        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();
    }
}
