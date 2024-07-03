<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 23/06/2024
  Time: 02:11 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="userRegisterModal" tabindex="-1" aria-labelledby="userRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="userRegisterTitle">Registrar nuevo usuario</h1>
            </div>
            <div class="modal-body">
                <form id="registerForm" action="<%=request.getContextPath()%>/userServlet" method="post">
                    <label for="name">Nombre:</label>
                    <input id="name" type="text" name="name" required/>
                    <br><br>
                    <label for="lastNameP">Apellido Paterno:</label>
                    <input id="lastNameP" type="text" name="lastNameP" required/>
                    <br><br>
                    <label for="lastNameM">Apellido Materno:</label>
                    <input id="lastNameM" type="text" name="lastNameM" required/>
                    <br><br>
                    <label for="email">Correo Institucional:</label>
                    <input id="email" type="email" name="email" required/>
                    <br><br>
                    <label for="password">Contraseña:</label>
                    <input id="password" type="password" name="password" required/>
                    <br><br>
                    <label for="confirmPassword">Confirmar contraseña:</label>
                    <input id="confirmPassword" type="password" name="confirmPassword" required/>
                    <br><br>
                    <label for="role">Tipo de usuario:</label>
                    <select id="role" name="role">
                        <option value="Administrador">Administrador</option>
                        <option value="Docente">Docente</option>
                        <option value="Estudiante">Estudiante</option>
                    </select>
                    <input type="text" name="action" value="add" hidden/> <!--VALOR PARA INDICAR AL SERVLET QUE ES UN ACCION DE AÑADIR-->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonAdd" type="button" class="btn btn-primary">Registrar</button>

            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("submitButtonAdd").addEventListener("click",function () {
        const form= document.getElementById("registerForm");
        const {name,lastNameP,lastNameM,email,password,confirmPassword,role}=form.elements;

        if(name.value && lastNameP.value && lastNameM.value && email.value && password.value && confirmPassword.value && role.value) {
            if (email.value.substring(email.value.lastIndexOf("@") + 1) === "utez.edu.mx") {
                if (password.value === confirmPassword.value) {
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