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
    <!--DataTables CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/datatables-2-1-3/datatables.min.css" rel="stylesheet">
    <!--Bootstrap CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap-icons.min.css" rel="stylesheet">
</head>
<jsp:include page="/views/layout/navbar.jsp"></jsp:include>

<body>
<jsp:include page="/views/nonbusinessday/data-table-nbd.jsp"></jsp:include>

<!--MODAL AGREGAR HORARIO-->
<jsp:include page="/views/nonbusinessday/nbd-add.jsp"></jsp:include>

<!--MODAL ACTUALIZAR HORARIO-->
<jsp:include page="/views/nonbusinessday/nbd-update.jsp"></jsp:include>

<!--MODAL ELIMINAR HORARIO-->
<jsp:include page="/views/nonbusinessday/nbd-delete.jsp"></jsp:include>

<!--STATUS DE LA PAGINA-->
<%
    HttpSession activeSession = request.getSession();
    String status = (String) activeSession.getAttribute("status");
    String errorMessage = (String) activeSession.getAttribute("errorMessage");
    activeSession.removeAttribute("status");
    activeSession.removeAttribute("errorMessage");
%>

<input type="hidden" id="status" value="<%=status%>">
<script src="${pageContext.request.contextPath}/assets/js/nonbusinessday/nbdMan.js"> </script>
</body>
</html>
