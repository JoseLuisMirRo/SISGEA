<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 23/06/2024
  Time: 02:15 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="updateUserModal" tabindex="-1" aria-labelledby="updateUserTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="updateUserTitle">Actualizar usuario</h1>
            </div>
            <div class="modal-body">
                <form id="updateForm" action="<%=request.getContextPath()%>/userServlet" method="post">
                    <label for="updateUserId">ID:</label>
                    <input id="updateUserId" type="text" name="updateUserId" readonly/>
                    <br><br>
                    <label for="updateName">Nombre:</label>
                    <input id="updateName" type="text" name="name" required/>
                    <br><br>
                    <label for="updateLastNameP">Apellido Paterno:</label>
                    <input id="updateLastNameP" type="text" name="lastNameP" required/>
                    <br><br>
                    <label for="updateLastNameM">Apellido Materno:</label>
                    <input id="updateLastNameM" type="text" name="lastNameM" required/>
                    <br><br>
                    <label for="updateEmail">Correo Institucional:</label>
                    <input id="updateEmail" type="email" name="email" required/>
                    <br><br>
                    <label for="updatePassword">Contraseña:</label>
                    <input id="updatePassword" type="password" name="password" required/>
                    <br><br>
                    <label for="updateConfirmPassword">Confirmar contraseña:</label>
                    <input id="updateConfirmPassword" type="password" name="confirmPassword" required/>
                    <br><br>
                    <label for="updateRole">Tipo de usuario:</label>
                    <select id="updateRole" name="role">
                        <option value="Administrador">Administrador</option>
                        <option value="Docente">Docente</option>
                        <option value="Estudiante">Estudiante</option>
                    </select>
                    <input type="text" name="action" value="update" hidden/> <!--VALOR PARA INDICAR AL SERVLET QUE ES UN ACCION DE UPDATE-->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonUpdate" type="button" class="btn btn-primary">Actualizar</button>

            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("submitButtonUpdate").addEventListener("click",function () {
        const form= document.getElementById("updateForm");
        const {updateName,updateLastNameP,updateLastNameM,updateEmail,updatePassword,updateConfirmPassword,updateRole}=form.elements;

        if(updateName.value && updateLastNameP.value && updateLastNameM.value && updateEmail.value && updatePassword.value && updateConfirmPassword.value && updateRole.value) {
            if (updateEmail.value.substring(updateEmail.value.lastIndexOf("@") + 1) === "utez.edu.mx") {
                if (updatePassword.value === updateConfirmPassword.value) {
                    form.submit();
                }
                else {
                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: "Las contraseñas no coinciden",
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
</script>