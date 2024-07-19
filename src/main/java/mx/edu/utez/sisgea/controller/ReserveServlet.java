package mx.edu.utez.sisgea.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.ReserveDao;
import mx.edu.utez.sisgea.dao.RoomDao;
import mx.edu.utez.sisgea.dao.UserDao;
import mx.edu.utez.sisgea.model.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/reserveServlet")
public class ReserveServlet extends HttpServlet {
    private int id;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ReserveBean reserveBean = new ReserveBean();
        ReserveDao reserveDao = new ReserveDao();
        UserDao userDao = new UserDao();
        RoomDao roomDao = new RoomDao();

        String action = req.getParameter("action");
        HttpSession activeSession = req.getSession();
        LoginBean user = (LoginBean) activeSession.getAttribute("activeUser");
        int sessionUserId = user.getId();

        switch(action){
            case "add":
                try{
                    int userId = sessionUserId;
                    int roomId = Integer.parseInt(req.getParameter("roomId"));
                    String description = req.getParameter("description");
                    Date date = Date.valueOf(req.getParameter("date"));
                    Time startTime = Time.valueOf(req.getParameter("starttime"));
                    Time endTime = Time.valueOf(req.getParameter("endtime"));
                    Status status = Status.Active;

                    if(endTime.before(startTime)){
                        throw new IllegalArgumentException("startAfterEnd");
                    }

                    reserveBean = new ReserveBean(userDao.getUser(userId),roomDao.getRoom(roomId),description,date,startTime,endTime,status);
                    reserveDao.insertReserve(reserveBean);
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=registerOk");

                }catch (Exception e){
                    e.printStackTrace();
                    String errorMessage = e.getMessage();
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=registerError&errorMessage="+ URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
                }
                break;

            case "update":
                try{
                    int updateReserveId = Integer.parseInt(req.getParameter("updateReserveId"));
                    int userId = sessionUserId;
                    int roomId = Integer.parseInt(req.getParameter("roomId"));
                    String description = req.getParameter("description");
                    Date date = Date.valueOf(req.getParameter("date"));
                    Time startTime = Time.valueOf(req.getParameter("starttime"));
                    Time endTime = Time.valueOf(req.getParameter("endtime"));
                    Status status = Status.Active;

                    if(endTime.before(startTime)){
                        throw new IllegalArgumentException("startAfterEnd");
                    }

                    reserveBean = new ReserveBean(updateReserveId,userDao.getUser(userId),roomDao.getRoom(roomId),description,date,startTime,endTime,status);
                    reserveDao.updateReserve(reserveBean);
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=updateOk");

                }catch (Exception e){
                    e.printStackTrace();
                    String errorMessage = e.getMessage();
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=updateError&errorMessage=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
                }
                break;

            case "cancel":
                try{
                    reserveDao.updateStatus(Integer.parseInt(req.getParameter("cancelReserveId")),Status.Admin_Canceled);
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=deleteOk");
                }catch (Exception e){
                    e.printStackTrace();
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=deleteError");
                }
                break;

            case "reactivate":
                try{
                    reserveDao.updateStatus(Integer.parseInt(req.getParameter("reactivateReserveId")),Status.Active);
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=reactivateOk");
                }catch (Exception e){
                    e.printStackTrace();
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=reactivateError");
                }
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession activeSession = req.getSession();
        LoginBean user = (LoginBean) activeSession.getAttribute("activeUser");
        RequestDispatcher rd;

        if(user!=null){
            if(user.getRole().getId()==1){
                rd = req.getRequestDispatcher("/views/reserve/reserveMan.jsp");
            }else{
                rd = req.getRequestDispatcher("/views/layout/error403.jsp");
            }
        }else{
            rd = req.getRequestDispatcher("/views/login/login.jsp");
        }
        rd.forward(req, resp);
    }
}
