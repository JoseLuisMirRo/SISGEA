<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 16/07/2024
  Time: 01:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!-- Modal -->
<div class="modal fade" id="scheduleRegisterModal" tabindex="-1" aria-labelledby="schRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="schRegisterTitle">Registrar nuevo horario</h1>
            </div>
            <div class="modal-body">
                <form id ="registerScheduleForm" action="<%=request.getContextPath()%>/scheduleServlet" method="post">
                    <label for="quarter">Cuatrimestre:</label>
                    <select class="form-select" id="quarter" name="quarterId"></select>
                    <br>
                    <label for="classe">Clase:</label>
                    <select class="form-select" id="classe" name="classId"></select>
                    <br>
                    <label for="room">Espacio:</label>
                    <select class="form-select" id="room" name="roomId"></select>
                    <br>
                    <label for="day">Día:</label>
                    <select class="form-select" id="day" name="dayId">
                        <option value="1">Lunes</option>
                        <option value="2">Martes</option>
                        <option value="3">Miércoles</option>
                        <option value="4">Jueves</option>
                        <option value="5">Viernes</option>
                        <option value="6">Sábado</option>
                    </select>
                    <br>
                    <label for="starttime">Hora de inicio:</label>
                    <input type="time" name="starttime" id="starttime" min="07:00" max="20:00"/>
                    <br><br>
                    <label for="endtime">Hora de fin:</label>
                    <input type="time" name="endtime" id="endtime" min="08:00" max="21:00"/>
                    <input type="text" name="action" value="add" hidden/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonAdd" type="button" class="btn btn-success">Registrar</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const scheduleRegisterModal = document.getElementById('scheduleRegisterModal');

        scheduleRegisterModal.addEventListener('shown.bs.modal', async ()=> {
            const [response1, response2, response3] = await Promise.all([
                fetch('http://localhost:8080/SISGEA_war_exploded/data/quarters'),
                fetch('http://localhost:8080/SISGEA_war_exploded/data/classes'),
                fetch('http://localhost:8080/SISGEA_war_exploded/data/rooms')
            ]);

            const quarters = await response1.json();
            const classes = await response2.json();
            const rooms = await response3.json();

            const quartersElement = document.getElementById("quarter");
            const classesElement = document.getElementById("classe");
            const roomsElement = document.getElementById("room");

            while(quartersElement.firstChild){
                quartersElement.removeChild(quartersElement.firstChild);
            }
            while(classesElement.firstChild){
                classesElement.removeChild(classesElement.firstChild);
            }
            while(roomsElement.firstChild){
                roomsElement.removeChild(roomsElement.firstChild);
            }

            quarters.forEach((quarter) => {
                const option = document.createElement("option");
                option.value = quarter.id;
                option.textContent = quarter.name;
                quartersElement.appendChild(option);
            });

            classes.forEach((classe) => {
                const option = document.createElement("option");
                option.value = classe.id;
                option.textContent = classe.name;
                classesElement.appendChild(option);
            });

            rooms.forEach((room) => {
                const option = document.createElement("option");
                option.value = room.id;
                option.textContent = `\${room.roomType.name} \${room.number} - \${room.building.name}`;
                roomsElement.appendChild(option);
            });
        });
    });

    document.getElementById("submitButtonAdd").addEventListener("click", () => {
        const form = document.getElementById("registerScheduleForm");
        const {quarter, classe, room, day, starttime, endtime} = form.elements;

        if(starttime.value.split(":").length === 2){
            starttime.value += ":00";
        }

        if(endtime.value.split(":").length === 2){
            endtime.value += ":00";
        }



        //ENTRE SEMANA
        const initialStartTime = "07:00:00";
        const finalStartTime = "20:00:00";
        const initialEndTime = "08:00:00"
        const finalEndTime = "21:00:00";

        //FIN DE SEMANA
        const wfinalStartTime = "15:00:00";
        const wfinalEndTime = "16:00:00";

        if (quarter.value && classe.value && room.value && day.value && starttime.value && endtime.value) {
            if (day.value != 6) {
                if (starttime.value >= initialStartTime && starttime.value <= finalStartTime) {
                    if (endtime.value >= initialEndTime && endtime.value <= finalEndTime) {
                        form.submit();
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "Error",
                            text: "Ingresa un tiempo final válido \n(Entre las 08:00 y 21:00 hrs según el horario de la UTEZ)",
                            confirmButtonText: "Revisar",
                            confirmButtonColor: "#dc3545",
                        });
                    }
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: "Ingresa un tiempo inicial válido \n(Entre las 07:00 y 20:00 hrs según el horario de la UTEZ)",
                        confirmButtonText: "Revisar",
                        confirmButtonColor: "#dc3545",
                    });
                }
            } else {
                if (starttime.value >= initialStartTime && starttime.value <= wfinalStartTime) {
                    if (endtime.value >= initialEndTime && endtime.value <= wfinalEndTime) {
                        form.submit();
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "Error",
                            text: "Ingresa un tiempo final válido \n(Entre las 08:00 y 16:00 hrs según el horario de la UTEZ)",
                            confirmButtonText: "Revisar",
                            confirmButtonColor: "#dc3545",
                        });
                    }
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: "Ingresa un tiempo inicial válido \n(Entre las 07:00 y 15:00 hrs según el horario de la UTEZ)",
                        confirmButtonText: "Revisar",
                        confirmButtonColor: "#dc3545",
                    });
                }
            }
        } else {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: "Completa todos los campos",
                confirmButtonText: "Revisar",
                confirmButtonColor: "#dc3545",
            });
        }
    });

</script>
</html>
