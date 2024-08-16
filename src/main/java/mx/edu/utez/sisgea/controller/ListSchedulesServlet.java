package mx.edu.utez.sisgea.controller;

import com.google.gson.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sisgea.dao.ScheduleDao;
import mx.edu.utez.sisgea.model.Day;
import mx.edu.utez.sisgea.model.ScheduleBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.text.DateFormat;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/data/schedules")
public class ListSchedulesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        ScheduleDao schDao = new ScheduleDao();
        List<ScheduleBean> schList = schDao.getAllSchedules();
        //Serializacion del JSON
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").registerTypeAdapter(Day.class, new JsonSerializer<Day>() {
                    @Override
                    public JsonElement serialize(Day day, Type type, JsonSerializationContext jsonSerializationContext) {
                        JsonObject jsonDay = new JsonObject();
                        jsonDay.addProperty("id", day.getDayNumber()); // Obtener el número del día
                        jsonDay.addProperty("name", day.name()); // Obtener el nombre del día
                        return jsonDay;
                    }
                })
                .create();

        String jsonArray = gson.toJson(schList);

        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();
    }
}
