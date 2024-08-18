<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 17/07/2024
  Time: 02:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="scheduleUpdateModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="schUpdateTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="schUpdateTitle">Actualizar horario</h1>
                <hr>
                <form id ="updateScheduleForm" action="<%=request.getContextPath()%>/scheduleServlet" method="post" novalidate>
                    <input id="updateScheduleId" type="hidden" name="updateScheduleId" />
                    <div class="form-group mb-3 row">
                    <label for="updateQuarter" class="col-4 col-form-label form-label">Cuatrimestre:</label>
                        <div class="col-8">
                            <select class="form-select" id="updateQuarter" name="updateQuarterId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un cuatrimestre</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="updateClass" class="col-4 col-form-label form-label">Clase:</label>
                        <div class="col-8">
                            <select class="form-select" id="updateClass" name="updateClassId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona una clase</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                        <label for="updateGroup" class="col-4 col-form-label form-label">Grupo:</label>
                        <div class="col-8">
                            <select class="form-select" id="updateGroup" name="updateGroupId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un grupo</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="updateRoom" class="col-4 col-form-label form-label">Espacio:</label>
                        <div class="col-8">
                            <select class="form-select" id="updateRoom" name="updateRoomId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un espacio</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="updateDay" class="col-4 col-form-label form-label">Día:</label>
                        <div class="col-8">
                            <select class="form-select" id="updateDay" name="updateDayId" required>
                                <option value="1">Lunes</option>
                                <option value="2">Martes</option>
                                <option value="3">Miércoles</option>
                                <option value="4">Jueves</option>
                                <option value="5">Viernes</option>
                                <option value="6">Sábado</option>
                            </select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un día</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="updateStarttime" class="col-4 col-form-label form-label">Hora de inicio:</label>
                        <div class="col-8">
                            <input class="form-control" type="time" name="updateStarttime" id="updateStarttime" min="07:00" max="20:00" required/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Ingresa una hora válida</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="updateEndtime" class="col-4 col-form-label form-label">Hora de fin:</label>
                        <div class="col-8">
                            <input class="form-control" type="time" name="updateEndtime" id="updateEndtime" min="08:00" max="21:00" required/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Ingresa una hora válida</span>
                        </div>
                    </div>
                    <div class="col-12 text-end mt-4">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                        <button id="submitButtonUpdate" type="button" class="btn btn-success">Registrar</button>
                    </div>
                    <input type="text" name="action" value="update" hidden/>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", ()=> {
        const updateScheduleModal = document.getElementById('scheduleUpdateModal');
        updateScheduleModal.addEventListener('shown.bs.modal', async ()=> {
            const [response1, response2, response3] = await Promise.all([
                fetch(`\${cleanBasePath}data/quarters`),
                fetch(`\${cleanBasePath}data/classes`),
                fetch(`\${cleanBasePath}data/rooms`)
            ]);

            const quarters = await response1.json();
            const classesandgroups = await response2.json();
            const classes = classesandgroups.classes;
            const groups = classesandgroups.groups;
            const rooms = await response3.json();

            const quartersElement = document.getElementById("updateQuarter");
            const classesElement = document.getElementById("updateClass");
            const roomsElement = document.getElementById("updateRoom");
            const groupsElement = document.getElementById("updateGroup");

            while(quartersElement.firstChild){
                quartersElement.removeChild(quartersElement.firstChild);
            }
            while(classesElement.firstChild){
                classesElement.removeChild(classesElement.firstChild);
            }
            while(roomsElement.firstChild){
                roomsElement.removeChild(roomsElement.firstChild);
            }
            while(groupsElement.firstChild){
                groupsElement.removeChild(groupsElement.firstChild);
            }

            quarters
                .sort((a, b) => {
                    if (a.name > b.name) return 1;
                    if (a.name < b.name) return -1;
                    return 0;
                })
                .forEach((quarter) => {
                const option = document.createElement("option");
                option.value = quarter.id;
                option.textContent = quarter.name;
                quartersElement.appendChild(option);
            });

            classes
                .filter((classe) => classe.status === true)
                .forEach((classe) => {
                const option = document.createElement("option");
                option.value = classe.id;
                option.textContent = classe.name;
                classesElement.appendChild(option);
            });

            rooms
                .filter((room) => room.status === true)
                .sort((a, b) => {
                    if (a.roomType.name > b.roomType.name) return 1;
                    if (a.roomType.name < b.roomType.name) return -1;
                    if (a.number > b.number) return 1;
                    if (a.number < b.number) return -1;
                    if (a.building.name > b.building.name) return 1;
                    if (a.building.name < b.building.name) return -1;
                    return 0;
                })
                .forEach((room) => {
                const option = document.createElement("option");
                option.value = room.id;
                option.textContent = `\${room.roomType.name} \${room.number} - \${room.building.name}`;
                roomsElement.appendChild(option);
            });

            groups
                .forEach((group) => {
                const option = document.createElement("option");
                option.value = group.id;
                option.textContent = group.name;
                groupsElement.appendChild(option);
            });

            const id = updateScheduleModal.getAttribute('data-id');
            const classId = updateScheduleModal.getAttribute('data-classId');
            const quarterId = updateScheduleModal.getAttribute('data-quarterId');
            const groupId = updateScheduleModal.getAttribute('data-groupId');
            const roomId = updateScheduleModal.getAttribute('data-roomid')
            const dayId = updateScheduleModal.getAttribute('data-day');
            const starttime = updateScheduleModal.getAttribute('data-startime');
            const endtime = updateScheduleModal.getAttribute('data-endtime');

            const starttime24 = hourTo24(starttime);
            const endtime24 = hourTo24(endtime);

            document.getElementById('updateScheduleId').value = id;
            classesElement.value = classId;
            quartersElement.value = quarterId;
            groupsElement.value = groupId;
            roomsElement.value = roomId;
            document.getElementById('updateDay').value = dayId;
            document.getElementById('updateStarttime').value = starttime24;
            document.getElementById('updateEndtime').value = endtime24;

        });
    });

    document.getElementById("submitButtonUpdate").addEventListener("click", () =>{
        const form = document.getElementById("updateScheduleForm");
        form.classList.add('was-validated');
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

        if (updateQuarter.value && updateClass.value && updateRoom.value && updateDay.value && updateStarttime.value && updateEndtime.value && updateGroup.value) {
            if (updateDay.value !== 6) {
                if (updateStarttime.value >= initialStartTime && updateStarttime.value <= finalStartTime) {
                    if (updateEndtime.value >= initialEndTime && updateEndtime.value <= finalEndTime) {
                        if(form.checkValidity()) {
                            form.submit();
                        }
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
                        if(form.checkValidity()) {
                            form.submit();
                        }
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

        if(period === 'p. m.'){
            hour +=12;
        }
        else if (period === 'a. m.' && hour === 12){
            hour = 0;
        }
        return `\${hour.toString().padStart(2, '0')}:\${minute}:\${second}`;

    }

</script>

