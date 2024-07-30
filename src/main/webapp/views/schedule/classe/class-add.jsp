<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 29/07/2024
  Time: 09:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!-- Modal -->
<div class="modal fade" id="classeRegisterModal" tabindex="-1" aria-labelledby="clRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="clRegisterTitle">Registrar nueva clase</h1>
            </div>
            <div class="modal-body">
                <form id ="registerClasseForm" action="<%=request.getContextPath()%>/classServlet" method="post">
                    <label for="name">Nombre:</label>
                    <input class="form-control" type="text" id="name" name="name">
                    <br>
                    <label for="program">Programa:</label>
                    <select class="form-select" id="program" name="programId"></select>
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
        const classeRegisterModal = document.getElementById('classeRegisterModal');

        classeRegisterModal.addEventListener('shown.bs.modal', async ()=> {
            const response = await fetch('http://localhost:8080/SISGEA_war_exploded/data/classes');
            const data = await response.json();

            const programSelect = document.getElementById('program');

            data.programs.forEach(program => {
                const option = document.createElement('option');
                option.value = program.id;
                option.textContent = program.name;
                programSelect.appendChild(option);
            });
        });
    });

    document.getElementById("submitButtonAdd").addEventListener("click", async () => {
        const form = document.getElementById("registerClasseForm");
        const {name, program} = form.elements;

        if(name.value && program.value) {
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
    });
</script>