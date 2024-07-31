package mx.edu.utez.sisgea.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.ClassDao;
import mx.edu.utez.sisgea.dao.QuarterDao;
import mx.edu.utez.sisgea.dao.RoomDao;
import mx.edu.utez.sisgea.dao.ScheduleDao;
import mx.edu.utez.sisgea.model.Day;
import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.model.ScheduleBean;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.sql.Time;

@WebServlet("/scheduleServlet")
public class ScheduleServlet extends HttpServlet {
    private int id;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ScheduleBean scheduleBean = new ScheduleBean();
        ScheduleDao scheduleDao = new ScheduleDao();
        ClassDao classDao = new ClassDao();
        QuarterDao quarterDao = new QuarterDao();
        RoomDao roomDao = new RoomDao();



        String action = req.getParameter("action");

        switch(action){
            case "add": //VALIDACIONES DE TRASLAPES Y REPETICIONES EN PROCEDIMIENTO ALMACENADO
                try{
                    int classId = Integer.parseInt(req.getParameter("classId"));
                    int quarterId = Integer.parseInt(req.getParameter("quarterId"));
                    int roomId = Integer.parseInt(req.getParameter("roomId"));
                    int dayId = Integer.parseInt(req.getParameter("dayId"));
                    Time startTime = Time.valueOf(req.getParameter("starttime"));
                    Time endTime = Time.valueOf(req.getParameter("endtime"));

                    //VALIDAMOS HORA FINAL>HORA INICIO - EN SERVLET POR QUE TAMBIEN IRÁ CLIENT-SIDE Y SI VA CLIENT SIDE
                    //NO ES NECESARIO VALIDAR EN PROCEDIMIENTO ALMACENADO
                    if (endTime.before(startTime)){
                        throw new IllegalArgumentException("startAfterEnd");
                    }

                    scheduleBean.setClasse(classDao.getClass(classId));
                    scheduleBean.setQuarter(quarterDao.getQuarter(quarterId));
                    scheduleBean.setRoom(roomDao.getRoom(roomId));
                    scheduleBean.setDay(Day.numbToDay(dayId));
                    scheduleBean.setStartTime(startTime);
                    scheduleBean.setEndTime(endTime);
                    scheduleDao.insertSchedule(scheduleBean);
                    resp.sendRedirect(req.getContextPath() + "/scheduleServlet?status=registerOk");
                }catch (Exception e){
                    e.printStackTrace();
                    String errorMessage = e.getMessage();
                    resp.sendRedirect(req.getContextPath() + "/scheduleServlet?status=registerError&errorMessage=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
                }
                break;

                case "update":
                    try{
                        int updateScheduleId = Integer.parseInt(req.getParameter("updateScheduleId"));
                        int classId = Integer.parseInt(req.getParameter("updateClassId"));
                        int quarterId = Integer.parseInt(req.getParameter("updateQuarterId"));
                        int roomId = Integer.parseInt(req.getParameter("updateRoomId"));
                        int dayId = Integer.parseInt(req.getParameter("updateDayId"));
                        Time startTime = Time.valueOf(req.getParameter("updateStarttime"));
                        Time endTime = Time.valueOf(req.getParameter("updateEndtime"));

                        //VALIDAMOS HORA FINAL>HORA INICIO - EN SERVLET POR QUE TAMBIEN IRÁ CLIENT-SIDE Y SI VA CLIENT SIDE
                        //NO ES NECESARIO VALIDAR EN PROCEDIMIENTO ALMACENADO
                        if (endTime.before(startTime)){
                            throw new IllegalArgumentException("startAfterEnd");
                        }

                        scheduleBean.setId(updateScheduleId);
                        scheduleBean.setClasse(classDao.getClass(classId));
                        scheduleBean.setQuarter(quarterDao.getQuarter(quarterId));
                        scheduleBean.setRoom(roomDao.getRoom(roomId));
                        scheduleBean.setDay(Day.numbToDay(dayId));
                        scheduleBean.setStartTime(startTime);
                        scheduleBean.setEndTime(endTime);
                        scheduleDao.updateSchedule(scheduleBean);
                        resp.sendRedirect(req.getContextPath() + "/scheduleServlet?status=updateOk");

                    }catch (Exception e){
                        e.printStackTrace();
                        String errorMessage = e.getMessage();
                        resp.sendRedirect(req.getContextPath() + "/scheduleServlet?status=updateError&errorMessage=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
                    }
                    break;

                    case "delete":
                        try{
                            id= Integer.parseInt(req.getParameter("deleteScheduleId"));
                            scheduleDao.deleteSchedule(id);
                            resp.sendRedirect(req.getContextPath() + "/scheduleServlet?status=deleteOk");
                        }catch (Exception e){
                            e.printStackTrace();
                            resp.sendRedirect(req.getContextPath() + "/scheduleServlet?status=deleteError");
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
                rd = req.getRequestDispatcher("/views/schedule/scheduleMan.jsp");
            }else{
                rd = req.getRequestDispatcher("/views/layout/error403.jsp");
            }
        }else{
            rd = req.getRequestDispatcher("/views/login/login.jsp");
        }
        rd.forward(req, resp);
    }
}
