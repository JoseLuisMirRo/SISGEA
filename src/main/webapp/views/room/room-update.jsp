<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 15/07/2024
  Time: 11:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Modal -->
<div class="modal fade" id="updateRoomModal" tabindex="-1" aria-labelledby="updateRoomTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="updateRoomTitle">Actualizar usuario</h1>
            </div>
            <div class="modal-body">
                <form id="updateRoomForm" action="<%=request.getContextPath()%>/roomServlet" method="post">
                    <input id="updateRoomId" type="hidden" name="updateRoomId" class="form-control" />
                    <label for="updateBuilding">Edificio:</label>
                    <select class="form-select" id="updateBuilding" name="updateBuildingId"></select>
                    <br>
                    <label for="updateRoomType">Tipo de espacio:</label>
                    <select class="form-select" id="updateRoomType" name="updateRoomTypeId"></select>
                    <br>
                    <label for="updateNumber">Número:</label>
                    <input class="form-control" type="number" name="updateNumber" min="1" id="updateNumber" placeholder="Numero de espacio"/>
                    <input type="text" name="action" value="update" hidden/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonUpdate" type="button" class="btn btn-success">Actualizar</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const updateRoomModal = document.getElementById('updateRoomModal');

        updateRoomModal.addEventListener('shown.bs.modal', async ()=> {
            const response = await fetch(`\${cleanBasePath}select/rooms`);
            const data = await response.json();

            const roomTypesElement = document.getElementById("updateRoomType");
            const buildingsElement = document.getElementById("updateBuilding");

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

            const id = updateRoomModal.getAttribute('data-id');
            const roomTypeId = updateRoomModal.getAttribute('data-roomtypeid');
            const buildingId = updateRoomModal.getAttribute('data-buildingid');
            const number = updateRoomModal.getAttribute('data-number');

            document.getElementById('updateRoomId').value = id;
            roomTypesElement.value = roomTypeId;
            buildingsElement.value = buildingId;
            document.getElementById('updateNumber').value = number;

        });
    });

    document.getElementById("submitButtonUpdate").addEventListener("click", () => {
        const form= document.getElementById("updateRoomForm");
        const {updateRoomId,updateRoomTypeId,updateBuildingId,updateNumber}=form.elements;

        if(updateRoomId.value && updateRoomTypeId.value && updateBuildingId.value && updateNumber.value) {
            if(updateNumber.value>0 && !updateNumber.value.includes('.')){
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
