<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 23/06/2024
  Time: 02:11 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .modal-content {
        background-color: #fff; /* Fondo blanco para el modal */
        border-radius: 10px;
    }
    .modal-header {
        background-color: #004d99; /* Azul oscuro para el encabezado del modal */
        color: #fff; /* Texto blanco */
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
    }
    .modal-body {
        color: #333; /* Texto gris oscuro */
    }
    .modal-footer {
        background-color: #004d99; /* Azul oscuro para el pie de página del modal */
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;
    }
    .form-label {
        color: #004d99; /* Azul oscuro para etiquetas */
    }
    .form-control {
        border-color: #004d99; /* Borde azul oscuro para campos de entrada */
    }
</style>
<!-- Modal -->
<div class="modal fade" id="userRegisterModal" tabindex="-1" aria-labelledby="userRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="userRegisterTitle">Registrar nuevo usuario</h1>
            </div>
            <div class="modal-body">
                <form id="registerForm" action="<%=request.getContextPath()%>/userServlet" method="post">
                    <div class="mb-3 row">
                        <label for="name" class="col-sm-4 col-form-label form-label">Nombre:</label>
                        <div class="col-sm-8">
                            <input id="name" type="text" class="form-control" name="name" required />
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="lastNameP" class="col-sm-4 col-form-label form-label">Apellido Paterno:</label>
                        <div class="col-sm-8">
                            <input id="lastNameP" type="text" class="form-control" name="lastNameP" required />
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="lastNameM" class="col-sm-4 col-form-label form-label">Apellido Materno:</label>
                        <div class="col-sm-8">
                            <input id="lastNameM" type="text" class="form-control" name="lastNameM" required />
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="email" class="col-sm-4 col-form-label form-label">Correo Institucional:</label>
                        <div class="col-sm-8">
                            <input id="email" type="email" class="form-control" name="email" required />
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="password" class="col-sm-4 col-form-label form-label">Contraseña:</label>
                        <div class="col-sm-8">
                            <input id="password" type="password" class="form-control" name="password" required />
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="confirmPassword" class="col-sm-4 col-form-label form-label">Confirmar contraseña:</label>
                        <div class="col-sm-8">
                            <input id="confirmPassword" type="password" class="form-control" name="confirmPassword" required />
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="role" class="col-sm-4 col-form-label form-label">Tipo de usuario:</label>
                        <div class="col-sm-8">
                            <label>
                                <input type="checkbox" name="roles" value=1> Administrador
                            </label>
                            <br>
                            <label>
                                <input type="checkbox" name="roles" value=2> Docente
                            </label>
                            <br>
                            <label>
                                <input type="checkbox" name="roles" value=3> Estudiante
                            </label>
                            <br>
                        </div>
                    </div>
                    <input type="text" name="action" value="add" hidden /> <!--VALOR PARA INDICAR AL SERVLET QUE ES UN ACCION DE AÑADIR-->
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
    //LIMITAMOS SELECCION DE CHECKBOXES
    function limitCheckboxes(min, max) {
        const checkboxes = document.querySelectorAll('input[name="roles"]');
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                const checkedCheckboxes = Array.from(checkboxes).filter(cb => cb.checked);
                if (checkedCheckboxes.length > max) {
                    this.checked = false;
                } else if (checkedCheckboxes.length < min) {
                    checkboxes.forEach(cb => cb.disabled = false);
                }
            });
        });
    }

    window.onload = function() {
        limitCheckboxes(1, 2); // Permitir de 1 a 2 opciones
    }


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
<script>alert('Hola mundo!');</script>