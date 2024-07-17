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
            case "add": //FALTAN MAS VALIDADCIONES EN TIME, COMO QUE LA HORA FINAL NO SEA ANTES DE LA HORA INICIO. 
                try{
                    scheduleBean.setClasse(classDao.getClass(Integer.parseInt(req.getParameter("classId"))));
                    scheduleBean.setQuarter(quarterDao.getQuarter(Integer.parseInt(req.getParameter("quarterId"))));
                    scheduleBean.setRoom(roomDao.getRoom(Integer.parseInt(req.getParameter("roomId"))));
                    scheduleBean.setDay(Day.numbToDay(Integer.parseInt(req.getParameter("dayId"))));
                    scheduleBean.setStartTime(Time.valueOf(req.getParameter("starttime")));
                    scheduleBean.setEndTime(Time.valueOf(req.getParameter("endtime")));
                    scheduleDao.insertSchedule(scheduleBean);
                    resp.sendRedirect(req.getContextPath() + "/scheduleServlet?status=registerOk");

                }catch (Exception e){
                    e.printStackTrace();
                    resp.sendRedirect(req.getContextPath() + "/scheduleServlet?status=registerError");
                    System.out.println(scheduleBean.getRoom().getId());
                }
                break;

                case "update":
                    try{
                        scheduleBean.setId(Integer.parseInt(req.getParameter("updateScheduleId")));
                        scheduleBean.setClasse(classDao.getClass(Integer.parseInt(req.getParameter("classId"))));
                        scheduleBean.setQuarter(quarterDao.getQuarter(Integer.parseInt(req.getParameter("quarterId"))));
                        scheduleBean.setRoom(roomDao.getRoom(Integer.parseInt(req.getParameter("roomId"))));
                        scheduleBean.setDay(Day.numbToDay(Integer.parseInt(req.getParameter("dayId"))));
                        scheduleBean.setStartTime(Time.valueOf(req.getParameter("starttime")));
                        scheduleBean.setEndTime(Time.valueOf(req.getParameter("endtime")));
                        scheduleDao.updateSchedule(scheduleBean);
                        resp.sendRedirect(req.getContextPath() + "/scheduleServlet?status=updateOk");

                    }catch (Exception e){
                        e.printStackTrace();
                        resp.sendRedirect(req.getContextPath() + "/scheduleServlet?status=updateError");
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
