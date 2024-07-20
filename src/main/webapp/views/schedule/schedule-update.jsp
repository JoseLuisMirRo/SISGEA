<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 17/07/2024
  Time: 02:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="scheduleUpdateModal" tabindex="-1" aria-labelledby="schUpdateTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="schUpdateTitle">Actualizar horario</h1>
            </div>
            <div class="modal-body">
                <form id ="updateScheduleForm" action="<%=request.getContextPath()%>/scheduleServlet" method="post">
                    <input id="updateScheduleId" type="hidden" name="updateScheduleId" />
                    <label for="updateQuarter">Cuatrimestre:</label>
                    <select class="form-select" id="updateQuarter" name="updateQuarterId"></select>
                    <br>
                    <label for="updateClass">Clase:</label>
                    <select class="form-select" id="updateClass" name="updateClassId"></select>
                    <br>
                    <label for="updateRoom">Espacio:</label>
                    <select class="form-select" id="updateRoom" name="updateRoomId"></select>
                    <br>
                    <label for="updateDay">Día:</label>
                    <select class="form-select" id="updateDay" name="updateDayId">
                        <option value="1">Lunes</option>
                        <option value="2">Martes</option>
                        <option value="3">Miércoles</option>
                        <option value="4">Jueves</option>
                        <option value="5">Viernes</option>
                        <option value="6">Sábado</option>
                    </select>
                    <br>
                    <label for="updateStarttime">Hora de inicio:</label>
                    <input type="time" name="updateStarttime" id="updateStarttime" min="07:00" max="20:00"/>
                    <br><br>
                    <label for="updateEndtime">Hora de fin:</label>
                    <input type="time" name="updateEndtime" id="updateEndtime" min="08:00" max="21:00"/>
                    <input type="text" name="action" value="update" hidden/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonUpdate" type="button" class="btn btn-success">Registrar</button>
            </div>
        </div>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", ()=> {
        const updateScheduleModal = document.getElementById('scheduleUpdateModal');
        updateScheduleModal.addEventListener('shown.bs.modal', async ()=> {
            const [response1, response2, response3] = await Promise.all([
                fetch('http://localhost:8080/SISGEA_war_exploded/data/quarters'),
                fetch('http://localhost:8080/SISGEA_war_exploded/data/classes'),
                fetch('http://localhost:8080/SISGEA_war_exploded/data/rooms')
            ]);

            const quarters = await response1.json();
            const classes = await response2.json();
            const rooms = await response3.json();

            const quartersElement = document.getElementById("updateQuarter");
            const classesElement = document.getElementById("updateClass");
            const roomsElement = document.getElementById("updateRoom");

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

            const id = updateScheduleModal.getAttribute('data-id');
            const classId = updateScheduleModal.getAttribute('data-classId');
            const quarterId = updateScheduleModal.getAttribute('data-quarterId');
            const roomId = updateScheduleModal.getAttribute('data-roomid')
            const dayId = updateScheduleModal.getAttribute('data-day');
            const starttime = updateScheduleModal.getAttribute('data-startime');
            const endtime = updateScheduleModal.getAttribute('data-endtime');
            console.log(dayId)

            const starttime24 = hourTo24(starttime);
            const endtime24 = hourTo24(endtime);

            document.getElementById('updateScheduleId').value = id;
            classesElement.value = classId;
            quartersElement.value = quarterId;
            roomsElement.value = roomId;
            document.getElementById('updateDay').value = dayId;
            document.getElementById('updateStarttime').value = starttime24;
            document.getElementById('updateEndtime').value = endtime24;

        });
    });

    document.getElementById("submitButtonUpdate").addEventListener("click", () =>{
        const form = document.getElementById("updateScheduleForm");
        const {updateQuarter, updateClass, updateRoom, updateDay, updateStarttime, updateEndtime} = form.elements;

        if(updateStarttime.value.split(":").length === 2){
            updateStarttime.value += ":00";
        }

        if(updateEndtime.value.split(":").length === 2){
            updateEndtime.value += ":00";
        }

        //ENTRE SEMANA
        const initialStartTime = "07:00:00";
        const finalStartTime = "20:00:00";
        const initialEndTime = "08:00:00"
        const finalEndTime = "21:00:00";

        //FIN DE SEMANA
        const wfinalStartTime = "15:00:00";
        const wfinalEndTime = "16:00:00";

        if (updateQuarter.value && updateClass.value && updateRoom.value && updateDay.value && updateStarttime.value && updateEndtime.value) {
            if (updateDay.value !== 6) {
                if (updateStarttime.value >= initialStartTime && updateStarttime.value <= finalStartTime) {
                    if (updateEndtime.value >= initialEndTime && updateEndtime.value <= finalEndTime) {
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
                if (updateStarttime.value >= initialStartTime && updateStarttime.value <= wfinalStartTime) {
                    if (updateEndtime.value >= initialEndTime && updateEndtime.value <= wfinalEndTime) {
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

    const hourTo24 = (hour12) => {
        const parts = hour12.split(' '); //DIVIDIMOS POR ESPACIOS PARA SEPARAR AM Y PM
        const time = parts[0] //OBTENEMOS LA PARTE SOLO CON LA HORA
        const period = parts[1] //OBTENEMOS LA PARTE SOLO CON AM Y PM

        let [hour, minute, second] = time.split(':'); //DIVIDIMOS HORAS, MINUTOS Y SEGUNDOS
        hour = parseInt(hour,10);
        console.log(period);

        if(period === 'p. m.'){
            console.log('PM');
            hour +=12;
        }
        else if (period === 'a. m.' && hour === 12){
            console.log('AM');
            hour = 0;
        }
        console.log(hour);
        return `\${hour.toString().padStart(2, '0')}:\${minute}:\${second}`;

    }

</script>

