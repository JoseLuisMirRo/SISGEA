<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 23/06/2024
  Time: 02:11 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Modal -->
<div class="modal fade" id="userRegisterModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="userRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="userRegisterTitle">Registrar nuevo usuario</h1>
                <hr>
                <form id="registerForm" action="<%=request.getContextPath()%>/userServlet" method="post" novalidate>
                    <div class="mb-3 row">
                        <label for="name" class="col-sm-4 col-form-label form-label">Nombre:</label>
                        <div class="col-sm-8">
                            <input id="name" type="text" class="form-control" name="name" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$" />
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un nombre válido</span>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="lastNameP" class="col-sm-4 col-form-label form-label">Apellido Paterno:</label>
                        <div class="col-sm-8">
                            <input id="lastNameP" type="text" class="form-control" name="lastNameP" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$" />
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un apellido válido</span>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="lastNameM" class="col-sm-4 col-form-label form-label">Apellido Materno:</label>
                        <div class="col-sm-8">
                            <input id="lastNameM" type="text" class="form-control" name="lastNameM" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$" />
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un apellido válido</span>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="email" class="col-4 col-form-label form-label">Correo Electrónico:</label>
                        <div class="col-8">
                            <input id="email" type="email" class="form-control" name="email" required pattern="^([a-z0-9._%+-]+@utez\.edu\.mx)*$" />
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un correo institucional válido</span>
                        </div>
                    </div>
                    <div>
                        <label>La contraseña se envía por correo al usuario registrado</label>
                    </div>
                    <br>
                    <div class="mb-3 row">
                        <label class="col-sm-4 col-form-label form-label">Tipo de usuario:</label>
                        <div class="btn-group" role="group">
                            <input type="checkbox" class="btn-check" id="btncheck1" value="1" autocomplete="off" name="roles[]">
                            <label class="btn btn-outline-primary" for="btncheck1">Administrador</label>

                            <input type="checkbox" class="btn-check" id="btncheck2" value="2" autocomplete="off" name="roles[]">
                            <label class="btn btn-outline-primary" for="btncheck2">Docente</label>

                            <input type="checkbox" class="btn-check" id="btncheck3" value="3" autocomplete="off" name="roles[]">
                            <label class="btn btn-outline-primary" for="btncheck3">Estudiante</label>
                        </div>
                    </div>
                    <input type="text" name="action" value="add" hidden />
                    <!--VALOR PARA INDICAR AL SERVLET QUE ES UN ACCION DE AÑADIR-->
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
    document.addEventListener('DOMContentLoaded', function () {
        const adminCheckbox = document.getElementById('btncheck1');
        const teacherCheckbox = document.getElementById('btncheck2');
        const studentCheckbox = document.getElementById('btncheck3');

        function handleCheckboxChange(event) {
            const target = event.target;

            if (target === adminCheckbox || target === teacherCheckbox) {
                if (studentCheckbox.checked) {
                    studentCheckbox.checked = false;
                }
            }

            if (target === studentCheckbox) {
                if (adminCheckbox.checked || teacherCheckbox.checked) {
                    adminCheckbox.checked = false;
                    teacherCheckbox.checked = false;
                }
            }
        }

        adminCheckbox.addEventListener('change', handleCheckboxChange);
        teacherCheckbox.addEventListener('change', handleCheckboxChange);
        studentCheckbox.addEventListener('change', handleCheckboxChange);
    });
    document.getElementById("submitButtonAdd").addEventListener("click",function () {
        document.getElementById("registerForm").classList.add('was-validated');
        const form= document.getElementById("registerForm");
        const {name,lastNameP,lastNameM,email}=form.elements;
        const roles = form.querySelectorAll('input[name="roles[]"]');
        let rolesSelected = false;
        for (let role of roles){
            if (role.checked){
                rolesSelected=true;
                break;
            }
        }
        if (name.value && lastNameP.value && lastNameM.value && email.value) {
            if (email.value.substring(email.value.lastIndexOf("@") + 1) === "utez.edu.mx") {
                if(rolesSelected) {
                    if(form.checkValidity()) {
                        form.submit();
                    }
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: "Debes seleccionar al menos un rol",
                        confirmButtonText: "Revisar",
                        confirmButtonColor: "#dc3545",
                    });
                }
            } else {
                Swal.fire({
                    icon: "error",
                    title: "Error, ",
                    text: "Correo registrado debe ser del dominio: '@utez.edu.mx'",
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