package mx.edu.utez.sisgea.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sisgea.dao.NonBusinessDayDao;
import mx.edu.utez.sisgea.model.NonBusinessDay;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/NonBusinessDayServlet")
public class NonBusinessDayServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NonBusinessDayDao dao = new NonBusinessDayDao();
        List<NonBusinessDay> nonBusinessDays = dao.getNonBusinessDays();

        req.setAttribute("nonBusinessDays", nonBusinessDays);
        req.getRequestDispatcher("views/nonBusinessDay.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        NonBusinessDayDao dao = new NonBusinessDayDao();

        if ("delete".equals(action)) {
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
        }
    }
}
