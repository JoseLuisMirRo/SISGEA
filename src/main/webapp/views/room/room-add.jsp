<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 14/07/2024
  Time: 04:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Modal -->
<div class="modal fade" id="roomRegisterModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="roomRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="roomRegisterTitle">Registrar nuevo espacio</h1>
                <hr>
                    <form class="needs-validation" id ="registerRoomForm" action="<%=request.getContextPath()%>/roomServlet" method="post" novalidate>
                        <div class="form-group mb-3 row">
                            <label for="building" class="col-4 col-form-label form-label">Edificio:</label>
                            <div class="col-8">
                                <select class="form-select" id="building" name="buildingId" required></select>
                                <span class="valid-feedback">El dato es correcto</span>
                                <span class="invalid-feedback">Realiza una selección</span>
                            </div>
                        </div>
                        <div class="form-group mb-3 row">
                            <label for="roomType" class="col-4 col-form-label form-label">Tipo de espacio:</label>
                            <div class="col-8">
                                <select class="form-select" id="roomType" name="roomTypeId" required></select>
                                <span class="valid-feedback">El dato es correcto</span>
                                <span class="invalid-feedback">Realiza una selección</span>
                            </div>
                        </div>
                        <div class="form-group mb-3 row">
                            <label for="number" class="col-4 col-form-label form-label">Número:</label>
                            <div class="col-8">
                                <input type="number" class="form-control" name="number" min="1" max="19" id="number" placeholder="Numero de espacio" required>
                                <span class="valid-feedback">El dato es correcto</span>
                                <span class="invalid-feedback">Introduce un número válido</span>
                            </div>
                        </div>
                        <input type="text" name="action" value="add" hidden/>
                        <div class="col-12 text-end mt-4">
                            <button type="reset" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                            <button id="submitButtonAdd" type="button" class="btn btn-success">Registrar</button>
                        </div>
                    </form>
                </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const roomRegisterModal = document.getElementById('roomRegisterModal');

        roomRegisterModal.addEventListener('shown.bs.modal', async ()=> {
            const response = await fetch(`\${cleanBasePath}select/rooms`);
            const data = await response.json();

            const roomTypesElement = document.getElementById("roomType");
            const buildingsElement = document.getElementById("building");

            while(roomTypesElement.firstChild){
                roomTypesElement.removeChild(roomTypesElement.firstChild);
            }
            while(buildingsElement.firstChild){
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
        const form= document.getElementById('registerRoomForm');
        form.classList.add('was-validated');
        const {building, roomType, number}=form.elements;

        if(building.value && roomType.value && number.value) {
            if(number.value>0 && !number.value.includes('.')){
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

