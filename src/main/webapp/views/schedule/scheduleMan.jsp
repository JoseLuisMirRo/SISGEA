<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 16/07/2024
  Time: 12:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de horarios</title>
    <!--DataTables CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/datatables-2-1-3/datatables.min.css" rel="stylesheet">
    <!--Bootstrap CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap-icons.min.css" rel="stylesheet">
</head>
<jsp:include page="/views/layout/navbar.jsp"></jsp:include>

<body>
<jsp:include page="/views/schedule/data-table-schedule.jsp"></jsp:include>

<!--MODAL AGREGAR HORARIO-->
<jsp:include page="/views/schedule/schedule-add.jsp"></jsp:include>

<!--MODAL ACTUALIZAR HORARIO-->
<jsp:include page="/views/schedule/schedule-update.jsp"></jsp:include>

<!--MODAL ELIMINAR HORARIO-->
<jsp:include page="/views/schedule/schedule-delete.jsp"></jsp:include>

<!--STATUS DE LA PAGINA-->
<%
    HttpSession activeSession = request.getSession();
    String status = (String) activeSession.getAttribute("status");
    String errorMessage = (String) activeSession.getAttribute("errorMessage");
    activeSession.removeAttribute("status");
    activeSession.removeAttribute("errorMessage");
%>

<input type="hidden" id="status" value="<%=status%>">
<input type="hidden" id="errorMessage" value="<%=errorMessage%>">
<script src="${pageContext.request.contextPath}/assets/js/schedule/scheduleMan.js"> </script>
</body>
</html>