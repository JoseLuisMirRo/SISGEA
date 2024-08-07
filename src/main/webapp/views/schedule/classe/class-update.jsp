<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 30/07/2024
  Time: 08:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<div class="modal fade" id="classeUpdateModal" tabindex="-1" aria-labelledby="clUpadteTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="clUpdateTitle">Actualizar clase</h1>
            </div>
            <div class="modal-body">
                <form id ="updateClasseForm" action="<%=request.getContextPath()%>/classServlet" method="post">
                    <input id="updateClasseId" name="updateClasseId" type="text" hidden/>
                    <label for="updateName">Nombre:</label>
                    <input class="form-control" type="text" id="updateName" name="updateName">
                    <br>
                    <label for="updateProgram">Programa:</label>
                    <select class="form-select" id="updateProgram" name="updateProgramId"></select>
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
        const {updateName, updateProgram} = form.elements;

        if(updateName.value && updateProgram.value) {
            form.submit();
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
