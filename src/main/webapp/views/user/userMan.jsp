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
    <!--Bootstrap CSS-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!--DataTables CSS-->
    <link href="https://cdn.datatables.net/2.0.8/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <!--Bootstrap ICONS-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>
<jsp:include page="/views/layout/banner.jsp"></jsp:include>

<body>
<jsp:include page="/views/user/data-table-user.jsp"></jsp:include>

<!--MODAL AGREGAR USUARIO-->
<jsp:include page="/views/user/user-add.jsp"></jsp:include>

<!--MODAL USER UPDATE-->
<jsp:include page="/views/user/user-update.jsp"></jsp:include>

<!--MODAL USER DELETE-->
<jsp:include page="/views/user/user-delete.jsp"></jsp:include>

<!--STATUS DE LA PAGINA-->
<%
    String status = request.getParameter("status");
%>
<input type="hidden" id="status" value="<%=status%>">
<script>
    let status = document.getElementById("status").value;
    console.log(status);
    if (status === "registerError") {
        Swal.fire({
            icon: "error",
            title: "Error, no se registró el usuario",
            text: "Verifique si el usuario ya se encuentra registrado y vuelva a intentarlo",
            confirmButtonText: "Reintentar",
            confirmButtonColor: "#dc3545",
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "userMan.jsp"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
            }
        });
    }
    else if (status === "registerOk") {
        Swal.fire({
            icon: "success",
            title: "Registro realizado con éxito",
            confirmButtonText: "Ok",
            confirmButtonColor: "#208c7d",
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "userMan.jsp"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
            }
        });
    }
    else if (status === "updateError"){
        Swal.fire({
            icon: "error",
            title: "Error, no se actualizó el usuario",
            text: "Vuelva a intentarlo",
            confirmButtonText: "Reintentar",
            confirmButtonColor: "#dc3545",
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "userMan.jsp"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
            }
        });
    }
    else if (status === "updateOk"){
        Swal.fire({
            icon: "success",
            title: "Actualización realizada con éxito",
            confirmButtonText: "Ok",
            confirmButtonColor: "#208c7d",
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "userMan.jsp"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
            }
        });
    }
    else if (status === "deleteError"){
        Swal.fire({
            icon: "error",
            title: "Error, no se eliminó el usuario",
            text: "Vuelva a intentarlo",
            confirmButtonText: "Reintentar",
            confirmButtonColor: "#dc3545",
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "userMan.jsp"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
            }
        });
    }
    else if (status === "deleteOk"){
        Swal.fire({
            icon: "success",
            title: "Usuario eliminado con éxito",
            confirmButtonText: "Ok",
            confirmButtonColor: "#208c7d",
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "userMan.jsp"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
            }
        });
    }
    else if (status === "revertDeleteError"){
        Swal.fire({
            icon: "error",
            title: "Error, no se reactivó el usuario",
            text: "Vuelva a intentarlo",
            confirmButtonText: "Reintentar",
            confirmButtonColor: "#dc3545",
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "userMan.jsp"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
            }
        });
    }
    else if (status === "revertDeleteOk"){
        Swal.fire({
            icon: "success",
            title: "Usuario reactivado con éxito",
            confirmButtonText: "Ok",
            confirmButtonColor: "#208c7d",
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "userMan.jsp"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
            }
        });
    }
</script>
</body>
</html>