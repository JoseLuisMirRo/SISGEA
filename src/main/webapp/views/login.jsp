<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 15/06/2024
  Time: 09:35 p. m.
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<html lang="es">
<head>
    <!--CSS de Bootstrap-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!--CSS Custom Login-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles-login.css" />
    <title>Login</title>
</head>

<body>
<!--Etiqueta para leer status-->
<input type="hidden" id="status" value="<%=request.getAttribute("status")%>">

<div class = "container-fluid">
    <form class="mx-auto" action="<%=request.getContextPath()%>/loginForm" method="post">
        <h2 id="titulo-login">Inicio de sesión</h2>
        <div class="mb-3">
            <label for="inputEmail" class="form-label" >Correo electrónico</label>
            <input type="email" class="form-control" name="inputEmail" placeholder="usuario@utez.edu.mx">
        </div>
        <br>
        <div class="mb-3">
            <label for="inputPassword" class="form-label">Contraseña</label>
            <input type="password" class="form-control" name="inputPassword">
        </div>
        <br>

        <div class="container">
            <div class="row align-items-center">
                <div class="col-auto">
                    <img src="<%=request.getContextPath()%>/assets/img/LOGO%20UTEZ%20BLANCO.png" class="rounded float-start" alt="Logo UTEZ" id="logo-utez">
                </div>
                <div class="col-auto justify-content-end">
                    <button type="submit" class="btn btn-primary btn-lg">Iniciar</button>
                </div>
            </div>
        </div>

    </form>
</div>
<!--Script de Bootstrap-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<!--SweetAlerts Script-->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="sweetalert2.all.min.js"></script>
<!--Script Alerts-->
<script type="text/javascript">
    let status = document.getElementById("status").value;
    if (status === "failed"){
        Swal.fire({
            icon: "error",
            title: "Error",
            text: "Usuario o contraseña incorrectos",
            confirmButtonText: "Reintentar",
            confirmButtonColor: "#dc3545",
        });
    }
    else if (status === "invalidEmail"){
        Swal.fire({
            icon: "error",
            title: "Error",
            text: "Por favor ingrese nombre de usuario",
            confirmButtonText: "Reintentar",
            confirmButtonColor: "#dc3545",
        });
    }
    else if (status === "invalidPassword"){
        Swal.fire({
            icon: "error",
            title: "Error",
            text: "Por favor ingrese contraseña",
            confirmButtonText: "Reintentar",
            confirmButtonColor: "#dc3545",
        });
    }
    else if (status === "serverError"){
        Swal.fire({
            icon: "warning",
            title: "Error",
            text: "Error del sistema, por favor contacte al administrador",
            confirmButtonText: "OK",
            confirmButtonColor: "#dc3545",
        });
    }
    else if (status === "unauthorized"){
        Swal.fire({
            icon: "warning",
            title: "Error",
            text: "Usuario deshabilitado, si cree que se trata de un error por favor contacte al administrador",
            confirmButtonText: "OK",
            confirmButtonColor: "#dc3545",
        });
    }
</script>
</body>
</html>
