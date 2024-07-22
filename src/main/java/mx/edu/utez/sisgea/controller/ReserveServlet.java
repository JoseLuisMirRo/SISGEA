package mx.edu.utez.sisgea.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.*;
import mx.edu.utez.sisgea.model.*;

import mx.edu.utez.sisgea.controller.ResendAPI;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.sql.Time;
import java.time.DayOfWeek;
import java.util.List;
import java.time.LocalDate;

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

        switch (action) {
            case "add":
                try {
                    int userId = sessionUserId;
                    int roomId = Integer.parseInt(req.getParameter("roomId"));
                    String description = req.getParameter("description");
                    Date date = Date.valueOf(req.getParameter("date"));
                    Time startTime = Time.valueOf(req.getParameter("starttime"));
                    Time endTime = Time.valueOf(req.getParameter("endtime"));
                    Status status = Status.Active;

                    if (endTime.before(startTime)) {
                        throw new IllegalArgumentException("startAfterEnd");
                    }

                    reserveBean = new ReserveBean(userDao.getUser(userId), roomDao.getRoom(roomId), description, date, startTime, endTime, status);

                    ScheduleDao scheduleDao = new ScheduleDao();
                    List<ScheduleBean> schedules = scheduleDao.getAllRoomSchedules(roomId);
                    boolean isValid = validateOverlap(reserveBean, schedules);

                    if (!isValid) {
                        throw new IllegalArgumentException("overlaps");
                    }
                    reserveDao.insertReserve(reserveBean);
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=registerOk");

                } catch (Exception e) {
                    e.printStackTrace();
                    String errorMessage = e.getMessage();
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=registerError&errorMessage=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
                }
                break;

            case "update":
                try {
                    int updateReserveId = Integer.parseInt(req.getParameter("updateReserveId"));
                    int roomId = Integer.parseInt(req.getParameter("updateRoomId"));
                    String description = req.getParameter("updateDescription");
                    Date date = Date.valueOf(req.getParameter("updateDate"));
                    Time startTime = Time.valueOf(req.getParameter("updateStarttime"));
                    Time endTime = Time.valueOf(req.getParameter("updateEndtime"));
                    Status status = Status.Active;

                    if (endTime.before(startTime)) {
                        throw new IllegalArgumentException("startAfterEnd");
                    }

                    reserveBean = new ReserveBean(updateReserveId, roomDao.getRoom(roomId), description, date, startTime, endTime, status);

                    ScheduleDao scheduleDao = new ScheduleDao();
                    List<ScheduleBean> schedules = scheduleDao.getAllRoomSchedules(roomId);
                    boolean isValid = validateOverlap(reserveBean, schedules);

                    if (!isValid) {
                        throw new IllegalArgumentException("overlaps");
                    }

                    reserveDao.updateReserve(reserveBean);
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=updateOk");

                } catch (Exception e) {
                    e.printStackTrace();
                    String errorMessage = e.getMessage();
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=updateError&errorMessage=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
                }
                break;

            case "cancel":
                try {
                    int idC = Integer.parseInt(req.getParameter("cancelReserveId"));
                    Status status = Status.Canceled;
                    ReserveBean reserve = reserveDao.getReserve(idC);
                    if (reserve.getStatus() == Status.Active) { //Validación para que no se pueda cancelar una reserva que ya esté cancelada
                        if (user.getRole().getId() == 1) {
                            status = Status.Admin_Canceled;
                            if(reserve.getUser().getId() != user.getId()) {
                                ResendAPI emailSender = new ResendAPI();
                                String from = "Alertas SISGEA <sisgea@resend.dev>";
                                String to = reserve.getUser().getEmail();
                                String subject = "Tu reserva: '" + reserve.getDescription() + "' ha sido cancelada";
                                String html = "<h2>¡Hola! " + reserve.getUser().getFirstName()
                                        + "</h2><p>Tu reserva ha sido cancelada por un administrador.</p><p>Administrador: "
                                        + user.getFirstName() + " " + user.getLastNameP() + " " + user.getLastNameM()
                                        + "</p><p>Motivo: " + req.getParameter("cancelReason")
                                        + "</p><h3><b>Detalles de la reserva cancelada:</b></h3>" +
                                        "<p>Descripcion de la reserva: " + reserve.getDescription() + "</p><p>Espacio: "
                                        + reserve.getRoom().getRoomType().getAbbreviation() + reserve.getRoom().getNumber()
                                        + " - " + reserve.getRoom().getBuilding().getName()
                                        + "<p>Fecha: " + reserveDao.getReserve(idC).getDate()
                                        + "</p><p>Hora de inicio: " + reserveDao.getReserve(idC).getStartTime()
                                        + "</p><p>Hora de fin: " + reserveDao.getReserve(idC).getEndTime() + "</p>";

                                emailSender.sendEmail(from, to, subject, html);
                            }

                        } else if (user.getRole().getId() == 2) {
                            status = Status.Canceled;
                        }
                        reserveDao.updateStatus(Integer.parseInt(req.getParameter("cancelReserveId")), status);
                        resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=deleteOk");
                    } else if (reserveDao.getReserve(idC).getStatus() == (Status.Canceled)) {
                        throw new Exception("alreadyCanceled");
                    } else if (reserveDao.getReserve(idC).getStatus() == (Status.Admin_Canceled)) {
                        throw new Exception("adminCanceled");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    String errorMessage = e.getMessage();
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=deleteError&errorMessage=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
                }
                break;

            case "reactivate": //TODAS LAS VERIFICACIONES OK
                try {
                    int idA = Integer.parseInt(req.getParameter("reactivateReserveId"));
                    if (user.getRole().getId() == 1) {
                        reserveDao.updateStatus(idA, Status.Active);
                        resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=reactivateOk");
                    } else if (user.getRole().getId() == 2) {
                        if (reserveDao.getReserve(idA).getStatus() == Status.Canceled) {
                            reserveDao.updateStatus(idA, Status.Active);
                            resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=reactivateOk");
                        } else if (reserveDao.getReserve(idA).getStatus() == Status.Admin_Canceled) {
                            throw new Exception("adminCanceled");
                        } else {
                            throw new Exception("alreadyActive");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    String errorMessage = e.getMessage();
                    resp.sendRedirect(req.getContextPath() + "/reserveServlet?status=reactivateError&errorMessage=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
                }
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession activeSession = req.getSession();
        LoginBean user = (LoginBean) activeSession.getAttribute("activeUser");
        RequestDispatcher rd;

        if (user != null) {
            if (user.getRole().getId() == 1) {
                rd = req.getRequestDispatcher("/views/reserve/reserveManAdmin.jsp");
            } else if (user.getRole().getId() == 2) {
                rd = req.getRequestDispatcher("/views/reserve/reserveManUser.jsp");
            } else {
                rd = req.getRequestDispatcher("/views/layout/error403.jsp");
            }
        } else {
            rd = req.getRequestDispatcher("/views/login/login.jsp");
        }
        rd.forward(req, resp);
    }

    //MÉTODO PARA VALIDAR QUE NO SE SOLAPEN LAS RESERVAS
    private boolean validateOverlap(ReserveBean reserve, List<ScheduleBean> schedules) {
        LocalDate reserveDate = reserve.getDate().toLocalDate(); //Convertimos la fecha de la reserva a LocalDate
        DayOfWeek reserveDayOfWeek = reserveDate.getDayOfWeek(); //Obtenemos el día de la semana de la reserva
        int dayNumber = reserveDayOfWeek.getValue(); //Obtenemos el número del día de la semana

        Day reserveDay = Day.numbToDay(dayNumber); //Convertimos el número del día de la semana a un objeto de tipo Day - Esto quedó raro, podría haber usado el DayOfWeek al crear mi schedule en lugar de la clase Enum Day

        for (ScheduleBean schedule : schedules) {
            //Validamos que la fecha de la reserva esté dentro del rango de fechas de la cuatrimestre
            if (schedule.getQuarter().getStartDate().toLocalDate().isBefore(reserveDate) && schedule.getQuarter().getEndDate().toLocalDate().isAfter(reserveDate)) {
                //Validamos si el día de la reserva es igual al día del horario
                if (schedule.getDay().equals(reserveDay)) {
                    if (!reserve.getEndTime().before(schedule.getStartTime()) && !reserve.getStartTime().after(schedule.getEndTime())) {
                        return false;
                    }
                }
            }
        }
        return true;
    }
}
