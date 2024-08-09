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
    <!--DataTables CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/datatables-2-1-3/datatables.min.css" rel="stylesheet">
    <!--Bootstrap CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap-icons.min.css" rel="stylesheet">
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
