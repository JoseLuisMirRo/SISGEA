<%@ page import="mx.edu.utez.sisgea.model.RoleBean" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sisgea.model.LoginBean" %><%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 07/07/2024
  Time: 01:15 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession activeSession = request.getSession();
    LoginBean user = (LoginBean)activeSession.getAttribute("activeUser");
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Menú Multi-Rol</title>
    <!--BOOTSTRAP CSS-->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-5-3-3/bootstrap.min.css" rel="stylesheet">
</head>

<body class="text-center">
    <div class="container" style="background-color: rgb(5, 35, 73); text-align: center; margin-top: 100px; padding: 50px; width: 800px; border-radius: 10px;">
        <h3 style="color: white; text-align: center; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><b>Hola, ${activeUser.firstName} ${activeUser.lastNameP} ${activeUser.lastNameM}</b></h3>
        <br>
        <h4 style="text-align: center; color: white">Se han encontrado multiples roles para tu usuario</h4>
        <br>
        <form action="<%=request.getContextPath()%>/roleController" method="post" id="multirolForm">
            <select id="roles" name="role" style="width: 205px; margin: 0 auto;" class="form-select" aria-label="Select roles">
            <option value="" disabled selected>Seleccionar Rol</option>
            <%
                List<RoleBean> userRoles = (List<RoleBean>) request.getAttribute("userRoles");
                for(RoleBean role : userRoles){
            %>
            <option value="<%= role.getId() %>"><%= role.getName() %></option>
            <% } %>
            </select>
            <br>
            <button style="font-size: 20px;" type="submit" class="btn btn-outline-success">Seleccionar</button>
            </form>
    </div>
</body>
<!--Script de Bootstrap-->
<script src="${pageContext.request.contextPath}/assets/js/bootstrap-5-5-3/bootstrap.bundle.min.js"></script>
<!--SweetAlerts Script-->
<script src="${pageContext.request.contextPath}/assets/js/sweetalert2-11-12-4/sweetalert2.all.min.js"></script>

<script>
    document.getElementById("multirolForm").addEventListener("submit", function(event){
        let role = document.getElementById("roles").value;
        if(role === ""){
            event.preventDefault();
            Swal.fire({
                icon: "error",
                title: "Error",
                text: "Selecciona un rol para continuar",
                confirmButtonText: "Revisar",
                confirmButtonColor: "#dc3545",
            });
        }
    });
</script>
</html>
