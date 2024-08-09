<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 29/07/2024
  Time: 08:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de clases</title>
    <!--DataTables CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/datatables-2-1-3/datatables.min.css" rel="stylesheet">
    <!--Bootstrap CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap-icons.min.css" rel="stylesheet">
</head>
<jsp:include page="/views/layout/banner.jsp"></jsp:include>

<body>
<jsp:include page="/views/schedule/classe/data-table-classe.jsp"></jsp:include>

<!--MODAL AGREGAR CLASE-->
<jsp:include page="/views/schedule/classe/class-add.jsp"></jsp:include>

<!--MODAL ACTUALIZAR CLASE-->
<jsp:include page="/views/schedule/classe/class-update.jsp"></jsp:include>

<!--MODAL ELIMINAR HORARIO-->
<jsp:include page="/views/schedule/classe/class-delete.jsp"></jsp:include>

<!--STATUS DE LA PAGINA-->
<%
    String status = request.getParameter("status");
%>

<input type="hidden" id="status" value="<%=status%>">
<script src="${pageContext.request.contextPath}/assets/js/schedule/classe/classeMan.js"> </script>
</body>
</html>
