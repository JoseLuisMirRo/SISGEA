<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 30/07/2024
  Time: 08:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<div class="modal fade" id="classeUpdateModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="clUpadteTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="clUpdateTitle">Actualizar clase</h1>
                <hr>
                <form class="needsValidation" id ="updateClasseForm" action="<%=request.getContextPath()%>/classServlet" method="post" novalidate>
                    <input id="updateClasseId" name="updateClasseId" type="text" hidden/>
                    <div class="form-group mb-3 row">
                    <label for="updateName" class="col-4 col-form-label form-label">Nombre:</label>
                        <div class="col-8">
                            <input class="form-control" type="text" id="updateName" name="updateName" required pattern="^[A-ZÁÉÍÓÚÜÑ0-9][a-záéíóúüñA-ZÁÉÍÓÚÜÑ0-9]*(?:\s+[a-záéíóúüñA-ZÁÉÍÓÚÜÑ0-9]+)*$"/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un nombre válido</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="updateProgram" class="col-4 col-form-label form-label">Programa:</label>
                        <div class="col-8">
                            <select class="form-select" id="updateProgram" name="updateProgramId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un programa</span>
                        </div>
                    </div>
                    <input type="text" name="action" value="update" hidden/>
                    <div class="col-12 text-end mt-4">
                        <button type="reset" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                        <button id="submitButtonUpdate" type="button" class="btn btn-success">Registrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</html>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const classeUpdateModal = document.getElementById('classeUpdateModal');

        classeUpdateModal.addEventListener('shown.bs.modal', async ()=> {
            const response = await fetch(`\${cleanBasePath}data/classes`);
            const data = await response.json();

            const programSelect = document.getElementById('updateProgram');

            while(programSelect.firstChild){
                programSelect.removeChild(programSelect.firstChild);
            }

            data.programs.forEach(program => {
                const option = document.createElement('option');
                option.value = program.id;
                option.textContent = program.name;
                programSelect.appendChild(option);
            });

            const id = classeUpdateModal.getAttribute('data-id');
            const name = classeUpdateModal.getAttribute('data-name');
            const programId = classeUpdateModal.getAttribute('data-programid');

            document.getElementById('updateClasseId').value = id;
            document.getElementById('updateName').value = name;
            programSelect.value = programId;
        });
    });

    document.getElementById('submitButtonUpdate').addEventListener("click", () => {
        const form = document.getElementById('updateClasseForm');
        form.classList.add('was-validated');
        const {updateName, updateProgram} = form.elements;

        if(updateName.value && updateProgram.value) {
            if(form.checkValidity()) {
                form.submit();
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
    })
</script>
