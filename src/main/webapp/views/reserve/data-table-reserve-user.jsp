<%@ page import="mx.edu.utez.sisgea.model.LoginBean" %><%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 20/07/2024
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de reservas</title>
    <!--Bootstrap CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap.min.css" rel="stylesheet">
    <!--DataTables CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/datatables-2-1-3/datatables.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap-icons.min.css" rel="stylesheet">

</head>
<body>
<!--Obtenemos el id de usuario de la sesion par la solicitud de fetch posterior-->
<%  HttpSession activeSession = request.getSession();
    LoginBean user = (LoginBean)activeSession.getAttribute("activeUser");
    int userId = user.getId();
%>
<script>
    const userId = <%=userId%>
</script>

<div class="main-container-table"> <!--Contenedor de una tabla con margen de 6 unidades-->
    <div>
        <h2 style="color: black">Mis reservas</h2>
    </div>
    <div class="text-end">
        <button id="historyBtn" class="btn btn-primary">Ver historial completo</button>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#reserveRegisterModal" id="reserveRegisterButton">
            <i class="bi bi-plus-lg"></i> Agregar reserva </button>
    </div>
    <div class="row"> <!--Fila de la tabla-->
        <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12"> <!--Columna de la tabla que va a ser de 12 en todos los tamaños de pantallas-->
            <table id="datatable_reserves" class="table table-striped" style="width: 100%;">
                <thead> <!--Encabezado de la tabla-->
                <tr> <!--Fila de la tabla-->
                    <th>Descripción</th>
                    <th>Espacio</th>
                    <th>Fecha</th>
                    <th>Hora de inicio</th>
                    <th>Hora de fin</th>
                    <th>Estado</th>
                    <th>Opciones</th>
                </tr>
                </thead>
                <tbody id="tableBody_reserves"></tbody> <!--Cuerpo de la tabla-->
            </table>
        </div>
    </div>
</div>
<!--Bootstrap SCRIPT-->
<script src="${pageContext.request.contextPath}/assets/js/bootstrap-5-5-3/bootstrap.bundle.min.js"></script>
<!--DataTable SCRIPT-->
<script src="${pageContext.request.contextPath}/assets/js/datatables-2-1-3/datatables.min.js"></script>
<!--JS Custom-->
<script src="${pageContext.request.contextPath}/assets/js/reserve/main-datatable-reserve-user.js"></script>
</body>
</html>

