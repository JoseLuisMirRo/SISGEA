<%@ page import="mx.edu.utez.sisgea.model.LoginBean" %><%--
<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 11/08/2024
  Time: 11:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession activeSession = request.getSession();
    LoginBean user = (LoginBean)activeSession.getAttribute("activeUser");
%>

<html>
<head>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/img/favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar-styles.css" />
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand me-auto" href="#">
                <img src="${pageContext.request.contextPath}/assets/img/LogoSisgea.png" alt="logoSisgea" width=auto height="70">
            </a>
            <div
                    class="offcanvas offcanvas-end"
                    tabindex="-1"
                    id="offcanvasNavbar"
                    aria-labelledby="offcanvasNavbarLabel"
            >
                <div class="offcanvas-header">
                    <img class="offcanvas-title" src="${pageContext.request.contextPath}/assets/img/LogoSisgea.png" alt="logoSisgea" width=auto height="70">
                    <button
                            type="button"
                            class="btn-close btn-close-white"
                            data-bs-dismiss="offcanvas"
                            aria-label="Close"
                    ></button>
                </div>
                <div class="offcanvas-body">
                    <% int userRole = user.getRole().getId(); %>
                    <% if(1==userRole || 2==userRole){ %>
                    <ul class="navbar-nav justify-content-center flex-grow-1 pe-3">
                        <li class="nav-item">
                            <a class="nav-link mx-lg-2" aria-current="page" href="${pageContext.request.contextPath}/calendar">Inicio</a>
                        </li>
                        <% if(1==userRole){ %>
                        <li class="nav-item">
                            <a class="nav-link mx-lg-2" href="${pageContext.request.contextPath}/reserveServlet">Reservas</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link mx-lg-2" href="${pageContext.request.contextPath}/scheduleServlet">Horarios</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link mx-lg-2" href="${pageContext.request.contextPath}/roomServlet">Espacios</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link mx-lg-2" href="${pageContext.request.contextPath}/NonBusinessDayServlet">Feriados</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link mx-lg-2" href="${pageContext.request.contextPath}/userServlet">Usuarios</a>
                        </li>
                        <% } else if (2==userRole) { %>
                        <li class="nav-item">
                            <a class="nav-link mx-lg-2" href="${pageContext.request.contextPath}/reserveServlet">Reservas</a>
                        <% } %>
                    </ul>
                    <% } %>
                </div>
            </div>
            <div class="dropdown">
                <a class="nav-link dropdown-toggle" role="button" id="userDropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="bi bi-person-circle" style="font-size: 2rem";></i>
                </a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown" style="width: 250px;">
                    <li><a class="dropdown-item-text text-end"><%=user.getFirstName()%> <%=user.getLastNameP()%> <%=user.getLastNameM()%></a></li>
                    <li><a class="dropdown-item-text text-end"><%=user.getRole().getName()%></a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                    <form id="logoutButtonForm" action="${pageContext.request.contextPath}/LogoutServlet" method="POST">
                        <button type="button" class="dropdown-item text-danger" onclick="logoutAlert()">Cerrar sesión</button>
                    </form>
                    </li>
                </ul>
            </div>
            <button
                    class="navbar-toggler pe-0"
                    type="button"
                    data-bs-toggle="offcanvas"
                    data-bs-target="#offcanvasNavbar"
                    aria-controls="offcanvasNavbar"
                    aria-label="Toggle navigation">
                <i class="bi bi-list" style="color:#e6e6ff; font-size: 2rem;"></i>
            </button>
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
    document.addEventListener('DOMContentLoaded', function() {
        let currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll('.nav-link');
        if(currentPath === "${pageContext.request.contextPath}/classServlet"){
            currentPath = "${pageContext.request.contextPath}/scheduleServlet";
        }

        navLinks.forEach(link => {
            if (link.getAttribute('href') === currentPath) {
                link.classList.add('active');
            }
        });
    });
</script>
<script src="${pageContext.request.contextPath}/assets/js/sweetalert2-11-12-4/sweetalert2.all.min.js"></script>
</body>

</html>
