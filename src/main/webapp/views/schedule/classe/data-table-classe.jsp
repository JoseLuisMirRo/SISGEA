<%--
  Created by IntelliJ IDEA.
  User: jlmr
  Date: 7/29/24
  Time: 3:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de clases</title>
    <!--Bootstrap CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap.min.css" rel="stylesheet">
    <!--DataTables CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/datatables-2-1-3/datatables.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap-icons.min.css" rel="stylesheet">

</head>
<body>
<div class="container my-6"> <!--Contenedor de una tabla con margen de 6 unidades-->
    <div>
        <h2 style="color: black">Gestión de clases</h2>
    </div>
    <div class="text-end">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#classeRegisterModal" id="classeRegisterButton">
            <i class="bi bi-plus-lg"></i> Agregar clase </button>
    </div>
    <div class="row"> <!--Fila de la tabla-->
        <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12"> <!--Columna de la tabla que va a ser de 12 en todos los tamaños de pantallas-->
            <table id="datatable_classes" class="table table-striped" style="width: 100%;">
                <thead> <!--Encabezado de la tabla-->
                <tr> <!--Fila de la tabla-->
                    <th>Nombre</th>
                    <th>Programa</th>
                    <th>Estado</th>
                    <th>Opciones</th>
                </tr>
                </thead>
                <tbody id="tableBody_classes"></tbody> <!--Cuerpo de la tabla-->
            </table>
        </div>
    </div>
</div>
<!--Bootstrap SCRIPT-->
<script src="${pageContext.request.contextPath}/assets/js/bootstrap-5-5-3/bootstrap.bundle.min.js"></script>
<!--DataTable SCRIPT-->
<script src="${pageContext.request.contextPath}/assets/js/datatables-2-1-3/datatables.min.js"></script>
<!--JS Custom-->
<script src="${pageContext.request.contextPath}/assets/js/schedule/classe/main-datatable-classe.js"></script>
</body>
</html>

