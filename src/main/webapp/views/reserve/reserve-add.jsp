<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 18/07/2024
  Time: 21:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="reserveRegisterModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="reserveRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="reserveRegisterTitle">Registrar nueva reserva</h1>
                <hr>
                <form class="needs-validation" id ="registerReserveForm" action="<%=request.getContextPath()%>/reserveServlet" method="post" novalidate>
                    <div class="form-group mb-3 row">
                    <label for="room" class="col-4 col-form-label form-label">Espacio:</label>
                        <div class="col-8">
                            <select class="form-select" id="room" name="roomId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un espacio</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="description" class="col-4 col-form-label form-label">Descripcion:</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="description" id="description" required pattern="^[A-ZÁÉÍÓÚÜÑ0-9][a-záéíóúüñA-ZÁÉÍÓÚÜÑ0-9]*(?:\s+[a-záéíóúüñA-ZÁÉÍÓÚÜÑ0-9]+)*$" />
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce una descripción válida</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="date" class="col-4 col-form-label form-label">Fecha:</label>
                        <div class="col-8">
                            <input type="date" class="form-control" name="date" id="date" required/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce una fecha válida</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="starttime" class="col-4 col-form-label form-label">Hora de inicio:</label>
                        <div class="col-8">
                            <input type="time" class="form-control" name="starttime" id="starttime" min="07:00" max="20:00" required/>
                            <span class="valid-feedback">La hora tiene un formato válido</span>
                            <span class="invalid-feedback">Introduce una hora de inicio válida</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="endtime" class="col-4 col-form-label form-label">Hora de fin:</label>
                        <div class="col-8">
                            <input type="time" name="endtime" class="form-control" id="endtime" min="08:00" max="21:00" required/>
                            <span class="valid-feedback">La hora tiene un formato válido</span>
                            <span class="invalid-feedback">Introduce una hora de fin válida</span>
                        </div>
                    </div>
                    <input type="text" name="action" value="add" hidden/>
                    <div class="col-12 text-end mt-4">
                        <button type="reset" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                        <button id="submitButtonAdd" type="button" class="btn btn-success">Registrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    const today = new Date();
    today.setDate(today.getDate() - 1);
    const minDate = today.toISOString().split('T')[0];
    document.getElementById("date").setAttribute('min', minDate);

    document.addEventListener("DOMContentLoaded", () => {
        const reserveRegisterModal = document.getElementById('reserveRegisterModal');

        reserveRegisterModal.addEventListener('shown.bs.modal', async ()=> {
            const response = await fetch(`\${cleanBasePath}data/rooms`);
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

            data
                .filter((room) => room.status === true)
                .forEach((room) => {
                const option = document.createElement("option");
                option.value = room.id;
                option.textContent = `\${room.roomType.name} \${room.number} - \${room.building.name}`;
                roomsElement.appendChild(option);
            });
        });
    });

    document.getElementById("submitButtonAdd").addEventListener("click", () => {
        const form = document.getElementById("registerReserveForm");
        form.classList.add('was-validated');
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

        const currentDateTime = new Date();
        const inputDateTime = new Date(`\${date.value}T\${starttime.value}`);

        //PASAR DATE A OBJETO DATE
        const dateobjetc = new Date(date.value);
        const day = dateobjetc.getDay();

        if (roomId.value && description.value && date.value && starttime.value && endtime.value) {
            if(starttime.value<endtime.value) {
                if (inputDateTime > currentDateTime) {
                    if (day !== 6) {
                        if (starttime.value >= initialStartTime && starttime.value <= finalStartTime) {
                            if (endtime.value >= initialEndTime && endtime.value <= finalEndTime) {
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
                        text: "Ingresa una fecha y hora de reserva posterior a la fecha y hora actuales",
                        confirmButtonText: "Revisar",
                        confirmButtonColor: "#dc3545",
                    });
                }
            }else{
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: "Hora fin no puede ser anterior a hora de inicio",
                    confirmButtonText: "Revisar",
                    confirmButtonColor: "#dc3545",
                });
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


