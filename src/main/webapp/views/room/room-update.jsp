<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 15/07/2024
  Time: 11:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Modal -->
<div class="modal fade" id="updateRoomModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="updateRoomTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="updateRoomTitle">Actualizar espacio</h1>
                <hr>
                <form class="needs-validation" id="updateRoomForm" action="<%=request.getContextPath()%>/roomServlet" method="post" novalidate>
                    <input id="updateRoomId" type="hidden" name="updateRoomId" class="form-control" />
                    <div class="form-group mb-3 row">
                    <label for="updateBuilding" class="col-sm-4 col-form-label form-label">Edificio:</label>
                        <div class="col-sm-8">
                            <select class="form-select" id="updateBuilding" name="updateBuildingId"></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Realiza una selección</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="updateRoomType" class="col-sm-4 col-form-label form-label">Tipo de espacio:</label>
                        <div class="col-sm-8">
                            <select class="form-select" id="updateRoomType" name="updateRoomTypeId"></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Realiza una selección</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label class="col-sm-4 col-form-label col-label" for="updateNumber">Número:</label>
                        <div class="col-sm-8">
                            <input class="form-control" type="number" name="updateNumber" min="1" max="19" id="updateNumber" placeholder="Numero de espacio" required/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un número válido</span>
                        </div>
                    </div>
                    <input type="text" name="action" value="update" hidden/>
                    <div class="col-12 text-end mt-4">
                        <button type="reset" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                        <button id="submitButtonUpdate" type="button" class="btn btn-success">Actualizar</button>
                    </div>
                </form>
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
    document.getElementById('submitButtonUpdate').addEventListener("click", () => {
        document.getElementById('updateRoomForm').classList.add('was-validated');
    })

    document.getElementById("submitButtonUpdate").addEventListener("click", () => {
        const form= document.getElementById("updateRoomForm");
        const {updateRoomId,updateRoomTypeId,updateBuildingId,updateNumber}=form.elements;

        if(updateRoomId.value && updateRoomTypeId.value && updateBuildingId.value && updateNumber.value) {
            if(updateNumber.value>0 && !updateNumber.value.includes('.')){
                if(form.checkValidity()) {
                    form.submit();
                }
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
