<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 23/06/2024
  Time: 02:15 a.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Modal -->
<div class="modal fade" id="updateUserModal" tabindex="-1" aria-labelledby="updateUserTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="updateUserTitle">Actualizar usuario</h1>
            </div>
            <div class="modal-body">
                <form id="updateForm" action="<%=request.getContextPath()%>/userServlet" method="post">
                    <div class="form-group">
                        <input id="updateUserId" type="hidden" name="updateUserId" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label for="updateName" class="form-label">Nombre:</label>
                        <input id="updateName" type="text" name="name" class="form-control" required/>
                    </div>
                    <div class="form-group">
                        <label for="updateLastNameP" class="form-label">Apellido Paterno:</label>
                        <input id="updateLastNameP" type="text" name="lastNameP" class="form-control" required/>
                    </div>
                    <div class="form-group">
                        <label for="updateLastNameM" class="form-label">Apellido Materno:</label>
                        <input id="updateLastNameM" type="text" name="lastNameM" class="form-control" required/>
                    </div>
                    <div class="form-group">
                        <label for="updateEmail" class="form-label">Correo Institucional:</label>
                        <input id="updateEmail" type="email" name="email" class="form-control" required/>
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
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="updatePswdBtn" type="button" class="btn btn-warning">Regenerar contraseña</button>
                <button id="submitButtonUpdate" type="button" class="btn btn-success">Actualizar</button>
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
                        form.submit();
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