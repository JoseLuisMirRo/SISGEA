<%@ page import="mx.edu.utez.sisgea.model.LoginBean" %><%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 15/06/2024
  Time: 10:44 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession activeSession = request.getSession();
    LoginBean user = (LoginBean)activeSession.getAttribute("activeUser");
    %>

<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles-banner.css" />
</head>
<body>
<header>
    <nav class="navbar navbar-expand">
        <div class="container-fluid">
            <a class="navbar-brand">SISGEA</a>
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li>
                    <img src="${pageContext.request.contextPath}/assets/img/userprofile.png" alt="usuario" height="60" width="auto" class="rounded-circle">
                </li>

                <li style="margin-left: 15px;">
                    <div class="row">
                        <div class="col">
                            <label id="nombreUsuario"><%=(user.getFirstName())%> <%=(user.getLastNameP())%> <%=(user.getLastNameM())%></label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label id="rolUsuario"><%=(user.getRole().getName())%></label>
                        </div>
                    </div>
                </li>

            </ul>
            <ul class="navbar-nav" style="align-content: center">
                <% int userRole = user.getRole().getId(); %>
                <% if(1==userRole || 2==userRole){ %> <!--Si el role es 1 (Admin) se muestran todas las opciones del nav)-->
                <li class="nav-item dropdown">
                    <button class="btn btn-secondary btn-lg dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="height: 90% !important">
                        <i class="bi bi-list"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton1">
                        <% if(1==userRole){ %>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/userServlet">Gestionar usuarios</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/roomServlet">Gestionar espacios</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/scheduleServlet">Gestionar horarios</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/reserveServlet">Gestionar reservas</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/NonBusinessDayServlet">Gestionar feriados</a></li>
                        <% } else if (2==userRole) {%>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/reserveServlet">Gestionar reservas</a></li>
                        <% } %>
                    </ul>
                </li>
                <% } %>
                <li> <!--Pendiente cambiar importacion de iconos a version CDN--> <!--PROBLEMA: ME ESTÁ TOMANDO ESTILOS BOOTSTRAP EN LUGAR DE MIS PROPIOS ESTILOS, SOLUCIONAR CON REFACTOR DEL CÓDIGO-->
                    <form id="logoutButtonForm" action="${pageContext.request.contextPath}/LogoutServlet" method="POST">
                        <button type="button" class="btn btn-danger btn-lg" style="margin-left: 15px !important; margin-right: 15px!important; height: 90% !important;" onclick="logoutAlert()">
                            <i class="bi bi-box-arrow-right"></i>
                        </button>
                    </form>
                </li>
            </ul>
        </div>
    </nav>
</header>
    <script>
        function logoutAlert(){
            Swal.fire({
                icon: "warning",
                title: "¿Desea cerrar sesión?",
                showCancelButton: true,
                confirmButtonText: "Sí, cerrar sesión",
                cancelButtonText: "Cancelar",
                confirmButtonColor: "#208c7d",
                cancelButtonColor: "#dc3545"
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById("logoutButtonForm").submit();
                }
            });
        }
    </script>
    <script src="${pageContext.request.contextPath}/assets/js/sweetalert2-11-12-4/sweetalert2.all.min.js"></script>
</body>

</html>
