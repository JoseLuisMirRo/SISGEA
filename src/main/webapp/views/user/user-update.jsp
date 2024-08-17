<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 23/06/2024
  Time: 02:15 a.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Modal -->
<div class="modal fade" id="updateUserModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="updateUserTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="updateUserTitle">Actualizar usuario</h1>
                <hr>
                <form id="updateForm" action="<%=request.getContextPath()%>/userServlet" method="post" novalidate>
                    <input id="updateUserId" type="hidden" name="updateUserId" class="form-control" />
                    <div class="form-group mb-3 row">
                        <label for="updateName" class="col-4 col-form-label form-label">Nombre:</label>
                        <div class="col-8">
                            <input id="updateName" type="text" name="name" class="form-control" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$"/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un nombre válido</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                        <label for="updateLastNameP" class="col-4 col-form-label form-label">Apellido Paterno:</label>
                        <div class="col-8">
                            <input id="updateLastNameP" type="text" name="lastNameP" class="form-control" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$"/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un apellido válido</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                        <label for="updateLastNameM" class="col-4 col-form-label form-label">Apellido Materno:</label>
                        <div class="col-8">
                            <input id="updateLastNameM" type="text" name="lastNameM" class="form-control" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$"/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un apellido válido</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                        <label for="updateEmail" class="col-4 col-form-label form-label">Correo Electrónico:</label>
                        <div class="col-8">
                            <input id="updateEmail" type="email" name="email" class="form-control" required pattern="^([a-z0-9._%+-]+@utez\.edu\.mx)*$"/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un correo institucional válido</span>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-sm-4 col-form-label form-label">Tipo de usuario:</label>
                        <div class="btn-group" role="group">
                            <input type="checkbox" class="btn-check" id="btnUpdate1" value="1" autocomplete="off" name="updateRoles[]">
                            <label class="btn btn-outline-primary" for="btnUpdate1">Administrador</label>

                            <input type="checkbox" class="btn-check" id="btnUpdate2" value="2" autocomplete="off" name="updateRoles[]">
                            <label class="btn btn-outline-primary" for="btnUpdate2">Docente</label>

                            <input type="checkbox" class="btn-check" id="btnUpdate3" value="3" autocomplete="off" name="updateRoles[]">
                            <label class="btn btn-outline-primary" for="btnUpdate3">Estudiante</label>
                        </div>
                    </div>
                    <input type="text" name="action" value="update" hidden/> <!--VALOR PARA INDICAR AL SERVLET QUE ES UN ACCION DE UPDATE-->
                    <div class="col-12 text-end mt-4">
                        <button type="reset" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                        <button id="updatePswdBtn" type="button" class="btn btn-warning">Regenerar contraseña</button>
                        <button id="submitButtonUpdate" type="button" class="btn btn-success">Actualizar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const updateAdminCheckbox = document.getElementById('btnUpdate1');
        const updateTeacherCheckbox = document.getElementById('btnUpdate2');
        const updateStudentCheckbox = document.getElementById('btnUpdate3');

        function handleCheckboxChange(event) {
            const target = event.target;

            if (target === updateAdminCheckbox || target === updateTeacherCheckbox) {
                if (updateStudentCheckbox.checked) {
                    updateStudentCheckbox.checked = false;
                }
            }

            if (target === updateStudentCheckbox) {
                if (updateAdminCheckbox.checked || updateTeacherCheckbox.checked) {
                    updateAdminCheckbox.checked = false;
                    updateTeacherCheckbox.checked = false;
                }
            }
        }

        updateAdminCheckbox.addEventListener('change', handleCheckboxChange);
        updateTeacherCheckbox.addEventListener('change', handleCheckboxChange);
        updateStudentCheckbox.addEventListener('change', handleCheckboxChange);
    });

    document.getElementById("submitButtonUpdate").addEventListener("click",function () {
        document.getElementById("updateForm").classList.add('was-validated');
        const form= document.getElementById("updateForm");
        const {updateName,updateLastNameP,updateLastNameM,updateEmail}=form.elements;
        const roles = form.querySelectorAll('input[name="updateRoles[]"]');
        let rolesSelected = false;
        for (let role of roles){
            if (role.checked){
                rolesSelected=true;
                break;
            }
        }

        if(updateName.value && updateLastNameP.value && updateLastNameM.value && updateEmail.value) {
            if (updateEmail.value.substring(updateEmail.value.lastIndexOf("@") + 1) === "utez.edu.mx") {
                    if(rolesSelected){
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
            }
            else {
                Swal.fire({
                    icon: "error",
                    title: "Error, ",
                    text: "Correo registrado debe ser del dominio: '@utez.edu.mx'",
                    confirmButtonText: "Revisar",
                    confirmButtonColor: "#dc3545",
                });
            }
        }
        else {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: "Completa todos los campos",
                confirmButtonText: "Revisar",
                confirmButtonColor: "#dc3545",
            });
        }
    });
    document.getElementById("updatePswdBtn").addEventListener("click",function() {
       const form = document.createElement("form");
       form.id = "updatePswdForm";
       form.action = "<%=request.getContextPath()%>/userServlet";
       form.method = "post";

       const actionField = document.createElement("input");
       actionField.type = "hidden";
       actionField.name = "action";
       actionField.value = "updatePswd";

       const userIdField = document.createElement("input");
         userIdField.type = "hidden";
         userIdField.name = "updatePswdUserId";
         userIdField.value = document.getElementById("updateUserId").value;

        form.appendChild(actionField);
        form.appendChild(userIdField);

        document.body.appendChild(form);

        form.submit();

    });
</script>