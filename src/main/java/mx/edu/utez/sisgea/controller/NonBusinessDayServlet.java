package mx.edu.utez.sisgea.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.NonBusinessDayDao;
import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.model.NonBusinessDay;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.util.List;

@WebServlet("/NonBusinessDayServlet")
public class NonBusinessDayServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NonBusinessDayDao nbdDao = new NonBusinessDayDao();
        NonBusinessDay nbdBean = new NonBusinessDay();

        String action = req.getParameter("action");
        HttpSession activeSession = req.getSession();

        switch (action){
            case "add":
                try{
                    nbdBean.setName(req.getParameter("name"));
                    nbdBean.setDate(Date.valueOf(req.getParameter("date")));
                    nbdDao.insertNonBusinessDay(nbdBean);
                    activeSession.setAttribute("status", "registerOk");
                    resp.sendRedirect(req.getContextPath() + "/NonBusinessDayServlet");
                }catch(Exception e){
                    e.printStackTrace();
                    String errorMsg = e.getMessage();
                    if(errorMsg.contains("Duplicate entry")){
                        errorMsg="duplicate";
                    }
                    activeSession.setAttribute("status", "registerError");
                    activeSession.setAttribute("errorMessage", errorMsg);
                    resp.sendRedirect(req.getContextPath() + "/NonBusinessDayServlet");
                }
                break;
            case "update":
                try{
                    nbdBean.setId(Integer.parseInt(req.getParameter("updateNbdId")));
                    nbdBean.setName(req.getParameter("updateName"));
                    nbdBean.setDate(Date.valueOf(req.getParameter("updateDate")));
                    nbdDao.updateNonBusinessDay(nbdBean);
                    activeSession.setAttribute("status", "updateOk");
                    resp.sendRedirect(req.getContextPath() + "/NonBusinessDayServlet");

                }catch (Exception e){
                    e.printStackTrace();
                    String errorMsg = e.getMessage();
                    if(errorMsg.contains("Duplicate entry")){
                        errorMsg="duplicate";
                    }
                    activeSession.setAttribute("status", "updateError");
                    activeSession.setAttribute("errorMessage", errorMsg);
                    resp.sendRedirect(req.getContextPath() + "/NonBusinessDayServlet");
                }
                break;
            case "delete":
                try{
                    int id = Integer.parseInt(req.getParameter("deleteNbdId"));
                    nbdDao.deleteNonBusinessDay(id);
                    activeSession.setAttribute("status", "deleteOk");
                    resp.sendRedirect(req.getContextPath() + "/NonBusinessDayServlet");
                } catch (Exception e){
                    e.printStackTrace();
                    activeSession.setAttribute("status", "deleteError");
                    resp.sendRedirect(req.getContextPath() + "/NonBusinessDayServlet");
                }
        }



        /*if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            boolean result = dao.deleteNonBusinessDay(id);
            if (result) {
                resp.sendRedirect(req.getContextPath() + "/NonBusinessDayServlet");
            } else {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al eliminar el día no laborable.");
            }
        } else {
            String name = req.getParameter("name");
            String dateStr = req.getParameter("date");

            if (name == null || name.isEmpty() || dateStr == null || dateStr.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Nombre y fecha son requeridos.");
                return;
            }

            Date date;
            try {
                date = Date.valueOf(dateStr);
            } catch (IllegalArgumentException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Fecha inválida.");
                return;
            }

            NonBusinessDay nonBusinessDay = new NonBusinessDay();
            nonBusinessDay.setName(name);
            nonBusinessDay.setDate(date);

            boolean result = dao.insertNonBusinessDay(nonBusinessDay);
            if (result) {
                resp.sendRedirect(req.getContextPath() + "/NonBusinessDayServlet");
            } else {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al insertar el día no laborable.");
            }
        }*/
    }
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession activeSession = req.getSession();
        LoginBean user = (LoginBean) activeSession.getAttribute("activeUser");
        RequestDispatcher rd;

        if(user!=null){
            if(user.getRole().getId()==1){
                rd = req.getRequestDispatcher("/views/nonbusinessday/nbdMan.jsp");
            }else{
                rd = req.getRequestDispatcher("/views/layout/error403.jsp");
            }
        }else{
            rd = req.getRequestDispatcher("/views/login/login.jsp");
        }
        rd.forward(req, resp);
    }
}
