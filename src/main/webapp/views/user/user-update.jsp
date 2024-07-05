<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 23/06/2024
  Time: 02:15 a.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    @keyframes modalFadeIn {
        from {
            opacity: 0;
            transform: translateY(-50px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    .modal-content {
        background-color: #fff; /* Fondo blanco para el modal */
        border-radius: 10px;
        animation: modalFadeIn 0.5s;
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
    .form-group {
        display: flex;
        align-items: center;
        margin-bottom: 1rem;
    }
    .form-group label {
        flex: 1;
        margin-bottom: 0; /* Remove default margin of the label */
    }
    .form-group input,
    .form-group select {
        flex: 2;
    }
</style>
</head>
<body>
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
                    <div class="form-group">
                        <label for="updatePassword" class="form-label">Contraseña:</label>
                        <input id="updatePassword" type="password" name="password" class="form-control" required/>
                    </div>
                    <div class="form-group">
                        <label for="updateConfirmPassword" class="form-label">Confirmar contraseña:</label>
                        <input id="updateConfirmPassword" type="password" name="confirmPassword" class="form-control" required/>
                    </div>
                    <div class="form-group">
                        <label for="updateRole" class="form-label">Tipo de usuario:</label>
                        <select id="updateRole" name="role" class="form-select">
                            <option value="Administrador">Administrador</option>
                            <option value="Docente">Docente</option>
                            <option value="Estudiante">Estudiante</option>
                        </select>
                    </div>
                    <input type="text" name="action" value="update" hidden/> <!--VALOR PARA INDICAR AL SERVLET QUE ES UN ACCION DE UPDATE-->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonUpdate" type="button" class="btn btn-success">Actualizar</button>
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