package mx.edu.utez.sisgea.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.BuildingDao;
import mx.edu.utez.sisgea.dao.RoomDao;
import mx.edu.utez.sisgea.dao.RoomtypeDao;
import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.model.RoomBean;
import mx.edu.utez.sisgea.model.UserBean;

import java.io.IOException;

@WebServlet("/roomServlet")
public class RoomServlet extends HttpServlet {
    private int id;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        RoomBean roomBean = new RoomBean();
        RoomDao roomDao = new RoomDao();
        RoomtypeDao roomtypeDao = new RoomtypeDao();
        BuildingDao buildingDao = new BuildingDao();

        String action = req.getParameter("action");

        switch(action){
            case "add":
                try{
                    roomBean.setRoomType(roomtypeDao.getRoomtype(Integer.parseInt(req.getParameter("roomTypeId"))));
                    roomBean.setBuilding(buildingDao.getBuilding(Integer.parseInt(req.getParameter("buildingId"))));
                    roomBean.setNumber(Integer.parseInt(req.getParameter("number")));
                    roomBean.setStatus(true);
                    roomDao.insertRoom(roomBean);
                    resp.sendRedirect(req.getContextPath() + "/roomServlet?status=registerOk");

                }catch(Exception e){
                    e.printStackTrace();
                    resp.sendRedirect(req.getContextPath() + "/roomServlet?status=registerError");
                }
                break;

                case "update":
                    try{
                        roomBean.setId(Integer.parseInt(req.getParameter("updateRoomId")));
                        roomBean.setRoomType(roomtypeDao.getRoomtype(Integer.parseInt(req.getParameter("updateRoomTypeId"))));
                        roomBean.setBuilding(buildingDao.getBuilding(Integer.parseInt(req.getParameter("updateBuildingId"))));
                        roomBean.setNumber(Integer.parseInt(req.getParameter("updateNumber")));
                        roomDao.updateRoom(roomBean);
                        resp.sendRedirect(req.getContextPath() + "/roomServlet?status=updateOk");

                    }catch(Exception e){
                        e.printStackTrace();
                        resp.sendRedirect(req.getContextPath() + "/roomServlet?status=updateError");
                    }
                    break;

                    case "delete":
                        try{
                            id=(Integer.parseInt(req.getParameter("deleteRoomId")));
                            roomDao.deleteRoom(id);
                            resp.sendRedirect(req.getContextPath() + "/roomServlet?status=deleteOk");
                        }catch(Exception e){
                            e.printStackTrace();
                            resp.sendRedirect(req.getContextPath() + "/roomServlet?status=deleteError");
                        }
                        break;

            case "revertDelete":
                try{
                    id=(Integer.parseInt(req.getParameter("revertDeleteRoomId")));
                    roomDao.revertDeleteRoom(id);
                    resp.sendRedirect(req.getContextPath() + "/roomServlet?status=revertDeleteOk");
                }catch(Exception e){
                    e.printStackTrace();
                    resp.sendRedirect(req.getContextPath() + "/roomServlet?status=revertDeleteError");
                }
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession activeSession = req.getSession();
        LoginBean user = (LoginBean)activeSession.getAttribute("activeUser");
        RequestDispatcher rd;
        if(user!=null){
            if(user.getRole().getId()==1){
                rd = req.getRequestDispatcher("/views/room/roomMan.jsp");
            }else{
                rd = req.getRequestDispatcher("/views/layout/error403.jsp");
            }
        }else {
            rd = req.getRequestDispatcher("/views/login/login.jsp");
        }
        rd.forward(req,resp);
    }
}
