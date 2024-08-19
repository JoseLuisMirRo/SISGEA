<%--
  Created by IntelliJ IDEA.
  User: luisi
  Date: 31/07/2024
  Time: 08:21 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de feriados</title>
    <!--Bootstrap CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap.min.css" rel="stylesheet">
    <!--DataTables CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/datatables-2-1-3/datatables.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        @media (max-width: 768px) {
            .btn-responsive {
                width: 50%;
                max-width: 50%;
                margin-bottom: 10px;
            }
        }
    </style>

</head>
<body>
<div class="main-container-table"> <!--Contenedor de una tabla con margen de 6 unidades-->
    <div id="loading-animation" style="display: none; text-align: center;">
        <img src="${pageContext.request.contextPath}/assets/img/preloader.gif" alt="Cargando..." />
    </div>
    <div id="nbd-table">
    <div>
        <h2 style="color: black">Gestión de feriados</h2>
    </div>
    <div class="d-flex flex-column flex-md-row justify-content-md-end align-items-center gap-2 mb-4">
        <button type="button" class="btn btn-primary btn-responsive" data-bs-toggle="modal" data-bs-target="#nbdRegisterModal" id="nbdRegisterButton">
            <i class="bi bi-plus-lg"></i> Agregar feriado </button>
    </div>
    <div class="row"> <!--Fila de la tabla-->
        <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12"> <!--Columna de la tabla que va a ser de 12 en todos los tamaños de pantallas-->
            <table id="datatable_nbd" class="table table-striped" style="width: 100%;">
                <thead> <!--Encabezado de la tabla-->
                <tr> <!--Fila de la tabla-->
                    <th>Nombre</th>
                    <th>Fecha</th>
                    <th>Opciones</th>
                </tr>
                </thead>
                <tbody id="tableBody_nbd"></tbody> <!--Cuerpo de la tabla-->
            </table>
        </div>
    </div>
    </div>
</div>
<!--Bootstrap SCRIPT-->
<script src="${pageContext.request.contextPath}/assets/js/bootstrap-5-5-3/bootstrap.bundle.min.js"></script>
<!--DataTable SCRIPT-->
<script src="${pageContext.request.contextPath}/assets/js/datatables-2-1-3/datatables.min.js"></script>
<!--JS Custom-->
<script src="${pageContext.request.contextPath}/assets/js/nonbusinessday/data-table-nbd.js"></script>
</body>
</html>


