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
<div class="modal fade" id="classeRegisterModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="clRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="clRegisterTitle">Registrar clase</h1>
                <hr>
                <form class="needs-validation" id ="registerClasseForm" action="<%=request.getContextPath()%>/classServlet" method="post" novalidate>
                    <div class="form-group mb-3 row">
                    <label for="name" class="col-4 col-form-label form-label">Nombre:</label>
                        <div class="col-8">
                            <input class="form-control" type="text" id="name" name="name" required pattern="^[A-ZÁÉÍÓÚÜÑ0-9][a-záéíóúüñA-ZÁÉÍÓÚÜÑ0-9]*(?:\s+[a-záéíóúüñA-ZÁÉÍÓÚÜÑ0-9]+)*$"/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un nombre válido</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                        <label for="grade" class="col-4 col-form-label form-label">Grado:</label>
                        <div class="col-8">
                            <select class="form-select" id="grade" name="gradeId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un grado</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                    <label for="program" class="col-4 col-form-label form-label">Programa:</label>
                        <div class="col-8">
                            <select class="form-select" id="program" name="programId" required></select>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Selecciona un programa</span>
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
        const classeRegisterModal = document.getElementById('classeRegisterModal');

        classeRegisterModal.addEventListener('shown.bs.modal', async ()=> {
            const response = await fetch(`\${cleanBasePath}data/gradesAndPrograms`);
            const data = await response.json();

            const programSelect = document.getElementById('program');
            const gradeSelect = document.getElementById('grade');

            while(programSelect.firstChild){
                programSelect.removeChild(programSelect.firstChild);
            }
            while(gradeSelect.firstChild){
                gradeSelect.removeChild(gradeSelect.firstChild);
            }

            data.programs.forEach(program => {
                const option = document.createElement('option');
                option.value = program.id;
                option.textContent = program.name;
                programSelect.appendChild(option);
            });

            data.grades.forEach(grade => {
                const option = document.createElement('option');
                option.value = grade.id;
                option.textContent = grade.number;
                gradeSelect.appendChild(option);
            });
        });
    });

    document.getElementById("submitButtonAdd").addEventListener("click", async () => {
        const form = document.getElementById("registerClasseForm");
        form.classList.add('was-validated');
        const {name, program, grade} = form.elements;

        if(name.value && program.value && grade.value) {
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
    });
</script>