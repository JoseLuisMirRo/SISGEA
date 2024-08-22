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
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/img/favicon.png" type="image/x-icon">
    <!--Bootstrap CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap.min.css" rel="stylesheet">
    <!--CSS Custom Login-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles-login.css">
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
<script src="${pageContext.request.contextPath}/assets/js/bootstrap-5-5-3/bootstrap.bundle.min.js"></script>
<!--SweetAlerts Script-->
<script src="${pageContext.request.contextPath}/assets/js/sweetalert2-11-12-4/sweetalert2.all.min.js"></script>
<!--Script Alerts-->
<script src="${pageContext.request.contextPath}/assets/js/login/login.js"></script>
</body>
</html>
