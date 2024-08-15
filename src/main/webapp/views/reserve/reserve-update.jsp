<%@ page import="mx.edu.utez.sisgea.model.LoginBean" %><%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 19/07/2024
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession activeSession = request.getSession();
    LoginBean user = (LoginBean)activeSession.getAttribute("activeUser");
    int activeUserId = user.getId();
%>

<div class="modal fade" id="reserveUpdateModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="reserveUpdateTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="reserveUpdateTitle">Actualizar reserva</h1>
                <hr>
                <form id ="updateReserveForm" action="<%=request.getContextPath()%>/reserveServlet" method="post" novalidate>
                    <input id="updateReserveId" type="hidden" name="updateReserveId" />
                    <div class="form-group mb-3 row">
                    <label for="updateRoom" class="col-4 col-form-label form-label">Espacio:</label>
                        <div class="col-8">
                            <select class="form-select" id="updateRoom" name="updateRoomId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un espacio</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="updateDescription" class="col-4 col-form-label form-label">Descripcion:</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="updateDescription" id="updateDescription"/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce una descripción válida</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="updateDate" class="col-4 col-form-label form-label">Fecha:</label>
                        <div class="col-8">
                            <input type="date" class="form-control" name="updateDate" id="updateDate" required/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce una fecha válida</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="updateStarttime" class="col-4 col-form-label form-label">Hora de inicio:</label>
                        <div class="col-8">
                            <input type="time" class="form-control" name="updateStarttime" id="updateStarttime" min="07:00" max="20:00" required/>
                            <span class="valid-feedback">La hora tiene un formato válido</span>
                            <span class="invalid-feedback">Introduce una hora de inicio válida</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="updateEndtime" class="col-4 col-form-label form-label">Hora de fin:</label>
                        <div class="col-8">
                            <input type="time" name="updateEndtime" class="form-control" id="updateEndtime" min="08:00" max="21:00" required/>
                            <span class="valid-feedback">La hora tiene un formato válido</span>
                            <span class="invalid-feedback">Introduce una hora de fin válida</span>
                        </div>
                    </div>
                    <%if(user.getRole().getId()==1){%>
                    <div id="adminReasonContainer" style="display: none;">
                        <label for="updateReason" class="form-label">Motivo de la actualización:</label>
                        <textarea class="form-control" name="updateReason" id="updateReason" required></textarea>
                        <span class="valid-feedback">El texto es válido</span>
                        <span class="invalid-feedback">Introduce un motivo con formato válido</span>
                    </div>
                    <%}%>
                    <input type="text" name="action" value="update" hidden/>
                    <div class="col-12 text-end mt-4">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                        <button id="submitButtonUpdate" type="button" class="btn btn-success">Registrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("updateDate").setAttribute('min', minDate);

    document.addEventListener("DOMContentLoaded", () => {
        const reserveUpdateModal = document.getElementById('reserveUpdateModal');

        reserveUpdateModal.addEventListener('shown.bs.modal', async ()=> {
            const response = await fetch(`\${cleanBasePath}data/rooms`);
            const data = await response.json();

            const roomsElement = document.getElementById("updateRoom");

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

            data
                .filter((room) => room.status === true)
                .forEach((room) => {
                const option = document.createElement("option");
                option.value = room.id;
                option.textContent = `\${room.roomType.name} \${room.number} - \${room.building.name}`;
                roomsElement.appendChild(option);
            });

            const sessionUserId = parseInt(<%=activeUserId%>);

            const id = reserveUpdateModal.getAttribute('data-id');
            const roomId = reserveUpdateModal.getAttribute('data-roomid');
            const userId = parseInt(reserveUpdateModal.getAttribute('data-userid'));
            const description = reserveUpdateModal.getAttribute('data-description');
            const date = reserveUpdateModal.getAttribute('data-date');
            const starttime = reserveUpdateModal.getAttribute('data-starttime');
            const endtime = reserveUpdateModal.getAttribute('data-endtime');

            const starttime24 = hourTo24(starttime);
            const endtime24 = hourTo24(endtime);

            document.getElementById('updateReserveId').value = id;
            roomsElement.value = roomId;
            document.getElementById('updateDescription').value = description;
            document.getElementById('updateDate').value = date;
            document.getElementById('updateStarttime').value = starttime24;
            document.getElementById('updateEndtime').value = endtime24;

            if(sessionUserId !== userId){
                document.getElementById('adminReasonContainer').style.display = 'block';
                document.getElementById('updateReason').required = true;
            }else{
                document.getElementById('adminReasonContainer').style.display = 'none';
                document.getElementById('updateReason').required = false;
            }

        });
    });

    document.getElementById("submitButtonUpdate").addEventListener("click", () => {
        const form = document.getElementById("updateReserveForm");
        form.classList.add('was-validated');
        const {updateRoomId, updateDescription, updateDate, updateStarttime, updateEndtime} = form.elements;

        if(updateStarttime.value.split(":").length === 2){
            updateStarttime.value += ":00";
        }

        if(updateEndtime.value.split(":").length === 2){
            updateEndtime.value += ":00";
        }

        const initialStartTime = "07:00:00";
        const finalStartTime = "20:00:00";
        const initialEndTime = "08:00:00"
        const finalEndTime = "21:00:00";

        const wfinalStartTime = "15:00:00";
        const wfinalEndTime = "16:00:00";

        const currentDateTime = new Date();
        const inputDateTime = new Date(`\${updateDate.value}T\${updateStarttime.value}`);

        const dateobjetc = new Date(updateDate.value);
        const day = dateobjetc.getDay();

        if(updateRoomId.value && updateDescription.value && updateDate.value && updateStarttime.value && updateEndtime.value) {
            if (updateStarttime.value < updateEndtime.value) {
                if (inputDateTime > currentDateTime) {
                    if (day !== 6) {
                        if (updateStarttime.value >= initialStartTime && updateStarttime.value <= finalStartTime) {
                            if (updateEndtime.value >= initialEndTime && updateEndtime.value <= finalEndTime) {
                                if (form.checkValidity()) {
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
                                if (form.checkValidity()) {
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
                        text: "Ingresa una fecha y hora de reserva posterior a la fecha y hora actuales",
                        confirmButtonText: "Revisar",
                        confirmButtonColor: "#dc3545",
                    });
                }
            } else {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: "Hora fin no puede ser anterior a hora de inicio",
                    confirmButtonText: "Revisar",
                    confirmButtonColor: "#dc3545",
                });
            }
        }else{
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
        hour = parseInt(hour, 10);

        if (period === 'p. m.' && hour!==12) {
            hour += 12;
        } else if (period === 'a. m.' && hour === 12) {
            hour = 0;
        }
        return `\${hour.toString().padStart(2, '0')}:\${minute}:\${second}`;
    }

</script>
