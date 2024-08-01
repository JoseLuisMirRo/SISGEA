<%--
  Created by IntelliJ IDEA.
  User: luisi
  Date: 31/07/2024
  Time: 08:49 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de feriados</title>
    <!--Bootstrap CSS-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!--DataTables CSS-->
    <link href="https://cdn.datatables.net/2.0.8/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<jsp:include page="/views/layout/banner.jsp"></jsp:include>

<body>
<jsp:include page="/views/nonbusinessday/data-table-nbd.jsp"></jsp:include>

<!--MODAL AGREGAR HORARIO-->
<jsp:include page="/views/nonbusinessday/nbd-add.jsp"></jsp:include>

<!--MODAL ACTUALIZAR HORARIO-->
<jsp:include page="/views/nonbusinessday/nbd-update.jsp"></jsp:include>

<!--MODAL ELIMINAR HORARIO-->

<!--STATUS DE LA PAGINA-->
<%
    String status = request.getParameter("status");
%>

<input type="hidden" id="status" value="<%=status%>">
<script src="${pageContext.request.contextPath}/assets/js/nonbusinessday/nbdMan.js"> </script>
</body>
</html>
