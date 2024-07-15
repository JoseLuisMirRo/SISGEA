<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 14/07/2024
  Time: 04:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!-- Modal -->
<div class="modal fade" id="roomRegisterModal" tabindex="-1" aria-labelledby="roomRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="roomRegisterTitle">Registrar nuevo espacio</h1>
            </div>
            <div class="modal-body">
                <form id ="registerRoomForm" action="<%=request.getContextPath()%>/roomServlet" method="post">
                    <label for="building">Edificio:</label>
                    <select id="building" name="buildingId"></select>
                    <br><br>
                    <label for="roomType">Tipo de espacio:</label>
                    <select id="roomType" name="roomTypeId"></select>
                    <br><br>
                    <label for="number">Número:</label>
                    <input type="number" name="number" min="0" id="number" placeholder="Numero de espacio"/>
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
        const roomRegisterModal = document.getElementById('roomRegisterModal');

        roomRegisterModal.addEventListener('shown.bs.modal', async ()=> {
            const response = await fetch('http://localhost:8080/SISGEA_war_exploded/select/rooms');
            const data = await response.json();

            const roomTypesElement = document.getElementById("roomType");
            const buildingsElement = document.getElementById("building");

            while (roomTypesElement.firstChild) {
                roomTypesElement.removeChild(roomTypesElement.firstChild);
            }
            while (buildingsElement.firstChild) {
                buildingsElement.removeChild(buildingsElement.firstChild);
            }

            data.roomTypes.forEach((roomType) => {
                const option = document.createElement("option");
                option.value = roomType.id;
                option.textContent = roomType.name;
                roomTypesElement.appendChild(option);
            });

            data.buildings.forEach((building) => {
                const option = document.createElement("option");
                option.value = building.id;
                option.textContent = building.name;
                buildingsElement.appendChild(option);
            });
        });
    });

    document.getElementById("submitButtonAdd").addEventListener("click", () => {
        const form=document.getElementById("registerRoomForm");
        const {building, roomType, number}=form.elements;

        if(building.value && roomType.value && number.value) {
            if(number.value>0 && !number.value.includes('.')){
                form.submit();
            }else{
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: "Ingresa un número de salón válido (No decimal ni negativo)",
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
</script>
</html>
