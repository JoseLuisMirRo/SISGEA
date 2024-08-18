package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.RoomDao;
import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.model.RoomBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/data/rooms")
public class ListRoomsServlet extends HttpServlet {
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

        RoomDao roomDao = new RoomDao();

        List<RoomBean> roomsList = roomDao.getAllRooms();

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String jsonArray = gson.toJson(roomsList);

        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();
    }
}
