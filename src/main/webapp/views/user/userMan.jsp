<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 15/06/2024
  Time: 10:19 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de usuarios</title>
    <link href="${pageContext.request.contextPath}/assets/css/styles-admin-profile.css" rel="stylesheet">
    <!--DataTables CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/datatables-2-1-3/datatables.min.css" rel="stylesheet">
    <!--Bootstrap CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap-icons.min.css" rel="stylesheet">

</head>
<jsp:include page="/views/layout/banner.jsp"></jsp:include>

<body>
<jsp:include page="/views/user/data-table-user.jsp"></jsp:include>

<!--MODAL USER BULK ADD-->
<jsp:include page="/views/user/user-bulkadd.jsp"></jsp:include>

<!--MODAL AGREGAR USUARIO-->
<jsp:include page="/views/user/user-add.jsp"></jsp:include>

<!--MODAL USER UPDATE-->
<jsp:include page="/views/user/user-update.jsp"></jsp:include>

<!--MODAL USER DELETE-->
<jsp:include page="/views/user/user-delete.jsp"></jsp:include>

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
<script src="${pageContext.request.contextPath}/assets/js/user/userMan.js"> </script>
</body>
</html>