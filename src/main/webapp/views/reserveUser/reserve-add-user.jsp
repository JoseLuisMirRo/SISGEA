<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 20/07/2024
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="reserveRegisterModal" tabindex="-1" aria-labelledby="reserveRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="reserveRegisterTitle">Registrar nueva reserva</h1>
            </div>
            <div class="modal-body">
                <form id ="registerReserveForm" action="<%=request.getContextPath()%>/reserveServlet" method="post">
                    <label for="room">Espacio:</label>
                    <select class="form-select" id="room" name="roomId"></select>
                    <br>
                    <label for="description">Descripcion:</label>
                    <input type="text" class="form-control" name="description" id="description"/>
                    <br>
                    <label for="date">Fecha:</label>
                    <input type="date" class="form-control" name="date" id="date"/>
                    <br>
                    <label for="starttime">Hora de inicio:</label>
                    <input type="time" class="form-control" name="starttime" id="starttime" min="07:00" max="20:00"/>
                    <br>
                    <label for="endtime">Hora de fin:</label>
                    <input type="time" name="endtime" class="form-control" id="endtime" min="08:00" max="21:00"/>
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
        const reserveRegisterModal = document.getElementById('reserveRegisterModal');

        reserveRegisterModal.addEventListener('shown.bs.modal', async ()=> {
            const response = await fetch('http://localhost:8080/SISGEA_war_exploded/data/rooms');
            const data = await response.json();

            const roomsElement = document.getElementById("room");

            while(roomsElement.firstChild){
                roomsElement.removeChild(roomsElement.firstChild);
            }
            //ORDENAR OPCIONES
            data.sort((a, b) => {
                if (a.roomType.name > b.roomType.name) return 1;
                if (a.roomType.name < b.roomType.name) return -1;
                if (a.number > b.number) return 1;
                if (a.number < b.number) return -1;
                if (a.building.name > b.building.name) return 1;
                if (a.building.name < b.building.name) return -1;
                return 0;
            });

            data.forEach((room) => {
                const option = document.createElement("option");
                option.value = room.id;
                option.textContent = `\${room.roomType.name} \${room.number} - \${room.building.name}`;
                roomsElement.appendChild(option);
            });
        });
    });

    document.getElementById("submitButtonAdd").addEventListener("click", () => {
        const form = document.getElementById("registerReserveForm");
        const {roomId, description, date, starttime, endtime} = form.elements;

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

        //PASAR DATE A OBJETO DATE
        const dateobjetc = new Date(date.value);
        const day = dateobjetc.getDay();

        if (roomId.value && description.value && date.value && starttime.value && endtime.value) {
            if (day === 6) {
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
