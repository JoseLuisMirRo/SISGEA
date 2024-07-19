package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sisgea.dao.ScheduleDao;
import mx.edu.utez.sisgea.model.ScheduleBean;
import mx.edu.utez.sisgea.model.ScheduleCalendarBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.jar.JarEntry;

@WebServlet("/data/scalendar")
public class ListScheduleCalendarServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        ScheduleCalendarGenerator generator = new ScheduleCalendarGenerator();
        ScheduleDao schDao = new ScheduleDao();
        List<ScheduleBean> schList = schDao.getAllSchedules();
        List<ScheduleCalendarBean> calendarList = generator.generateCalendar(schList);

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDate.class,new LocalDateAdapter())
                .setPrettyPrinting().create();

        String jsonArray = gson.toJson(calendarList);
        PrintWriter out = resp.getWriter();
        out.print(jsonArray);
        out.flush();
        out.close();




    }
}
