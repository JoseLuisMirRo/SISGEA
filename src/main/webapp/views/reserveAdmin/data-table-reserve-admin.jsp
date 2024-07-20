<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 18/07/2024
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de reservas</title>
    <link href="${pageContext.request.contextPath}/assets/css/styles-admin-profile.css" rel="stylesheet">
    <!--Bootstrap CSS-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!--DataTables CSS-->
    <link href="https://cdn.datatables.net/2.0.8/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>
<body>
<div class="container my-6"> <!--Contenedor de una tabla con margen de 6 unidades-->
    <div>
        <h2 style="color: black">Gestión de reservas</h2>
    </div>
    <div class="text-end">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#reserveRegisterModal" id="reserveRegisterButton">
            <i class="bi bi-plus-lg"></i> Agregar reserva </button>
    </div>
    <div class="row"> <!--Fila de la tabla-->
        <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12"> <!--Columna de la tabla que va a ser de 12 en todos los tamaños de pantallas-->
            <table id="datatable_reserves" class="table table-striped" style="width: 100%;">
                <thead> <!--Encabezado de la tabla-->
                <tr> <!--Fila de la tabla-->
                    <th>Usuario</th>
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
<!--Bootrastrap SCRIPT-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!--JQuery SCRIPT-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!--DataTable SCRIPT-->
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.min.js"></script>

<!--DataTable Bootstrap SCRIPT-->
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.bootstrap5.min.js"></script>

<!--JS Custom-->
<script src="${pageContext.request.contextPath}/assets/js/reserveAdmin/main-datatable-reserve-admin.js"></script>
</body>
</html>

