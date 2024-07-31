package mx.edu.utez.sisgea.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sisgea.dao.BuildingDao;
import mx.edu.utez.sisgea.dao.RoomtypeDao;
import mx.edu.utez.sisgea.model.BuildingBean;
import mx.edu.utez.sisgea.model.RoomtypeBean;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/select/rooms")
public class DataRoomsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        RoomtypeDao roomType = new RoomtypeDao();
        BuildingDao building = new BuildingDao();

        List<RoomtypeBean> roomTypes = roomType.getAllRoomtypes();
        List<BuildingBean> buildings = building.getAllBuildings();

        // Crear un mapa para combinar las listas bajo claves distintas
        Map<String, Object> combinedLists = new HashMap<>();
        combinedLists.put("roomTypes", roomTypes);
        combinedLists.put("buildings", buildings);

        // Convertir el mapa a JSON
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String combinedJson = gson.toJson(combinedLists);

        PrintWriter out = resp.getWriter();
        out.print(combinedJson);
        out.flush();
    }

}
