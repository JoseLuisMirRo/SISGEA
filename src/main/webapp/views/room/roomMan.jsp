<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 13/07/2024
  Time: 04:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de espacios</title>
    <!--Bootstrap CSS-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!--DataTables CSS-->
    <link href="https://cdn.datatables.net/2.0.8/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<jsp:include page="/views/layout/banner.jsp"></jsp:include>

<body>
<jsp:include page="/views/room/data-table-room.jsp"></jsp:include>

<!--MODAL AGREGAR ESPACIO-->
<jsp:include page="/views/room/room-add.jsp"></jsp:include>

<!--MODAL ACTUALIZAR ESPACIO-->
<jsp:include page="/views/room/room-update.jsp"></jsp:include>

<!--MODAL ELIMINAR ESPACIO-->
<jsp:include page="/views/room/room-delete.jsp"></jsp:include>

<!--STATUS DE LA PAGINA-->
<%
    String status = request.getParameter("status");
%>
<input type="hidden" id="status" value="<%=status%>">
<script src="${pageContext.request.contextPath}/assets/js/room/roomMan.js"> </script>

</body>
</html>
