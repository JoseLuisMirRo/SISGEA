package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.ReserveDao;
import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.model.ReserveBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet ("/data/reserves")
public class ListReservesServlet extends HttpServlet {
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

        ReserveDao reserveDao = new ReserveDao();
        List<ReserveBean> reservesList = reserveDao.getAllReserves();

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setPrettyPrinting().create();
        String jsonArray = gson.toJson(reservesList);

        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();
        out.close();

    }
}
