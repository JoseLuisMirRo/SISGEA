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
<div class="modal fade" id="scheduleRegisterModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="schRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="schRegisterTitle">Registrar nuevo horario</h1>
                <hr>
                <form class="needs-validation" id ="registerScheduleForm" action="<%=request.getContextPath()%>/scheduleServlet" method="post" novalidate>
                    <div class="form-group mb-3 row">
                    <label for="quarter" class="col-4 col-form-label form-label">Cuatrimestre:</label>
                        <div class="col-8">
                            <select class="form-select" id="quarter" name="quarterId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un cuatrimestre</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="classe" class="col-4 col-form-label form-label">Clase:</label>
                        <div class="col-8">
                            <select class="form-select" id="classe" name="classId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona una clase</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                        <label for="group" class="col-4 col-form-label form-label">Grupo:</label>
                        <div class="col-8">
                            <select class="form-select" id="group" name="groupId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un grupo</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                        <label for="room" class="col-4 col-form-label form-label">Espacio:</label>
                        <div class="col-8">
                            <select class="form-select" id="room" name="roomId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un espacio</span>

                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="day" class="col-4 col-form-label form-label">Día:</label>
                        <div class="col-8">
                            <select class="form-select" id="day" name="dayId" required>
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
                    <label for="starttime" class="col-4 col-form-label form-label">Hora de inicio:</label>
                        <div class="col-8">
                            <input class="form-control" type="time" name="starttime" id="starttime" min="07:00" max="20:00" required/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Ingresa una hora válida</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="endtime" class="col-4 col-form-label form-label">Hora de fin:</label>
                        <div class="col-8">
                            <input class="form-control" type="time" name="endtime" id="endtime" min="08:00" max="21:00" required/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Ingresa una hora válida</span>
                        </div>
                    </div>
                    <div class="col-12 text-end mt-4">
                        <button type="reset" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                        <button id="submitButtonAdd" type="button" class="btn btn-success">Registrar</button>
                    </div>
                    <input type="text" name="action" value="add" hidden/>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const scheduleRegisterModal = document.getElementById('scheduleRegisterModal');

        scheduleRegisterModal.addEventListener('shown.bs.modal', async ()=> {
            const [response1, response2, response3] = await Promise.all([
                fetch(`\${cleanBasePath}data/quarters`),
                fetch(`\${cleanBasePath}data/classes`),
                fetch(`\${cleanBasePath}data/rooms`),
            ]);

            const quarters = await response1.json();
            const classesandgroups = await response2.json();
            const classes = classesandgroups.classes;
            const groups = classesandgroups.groups;
            const rooms = await response3.json();

            const quartersElement = document.getElementById("quarter");
            const classesElement = document.getElementById("classe");
            const roomsElement = document.getElementById("room");
            const groupsElement = document.getElementById("group");


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
                .sort((a, b) => {
                    if (a.name > b.name) return 1;
                    if (a.name < b.name) return -1;
                    return 0;
                })
                .forEach((classe) => {
                const option = document.createElement("option");
                option.value = classe.id;
                option.textContent = `\${classe.name} - \${classe.program.name}`;
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
        });
    });

    document.getElementById("submitButtonAdd").addEventListener("click", () => {
        const form = document.getElementById("registerScheduleForm");
        form.classList.add('was-validated');
        const {quarter, classe, group, room, day, starttime, endtime} = form.elements;

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

        if (quarter.value && classe.value && room.value && day.value && starttime.value && endtime.value && group.value) {
            if (day.value != 6) {
                if (starttime.value >= initialStartTime && starttime.value <= finalStartTime) {
                    if (endtime.value >= initialEndTime && endtime.value <= finalEndTime) {
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
                if (starttime.value >= initialStartTime && starttime.value <= wfinalStartTime) {
                    if (endtime.value >= initialEndTime && endtime.value <= wfinalEndTime) {
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

</script>
</html>
