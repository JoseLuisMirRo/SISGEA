const status = document.getElementById("status").value;
if (status === "registerError") {
    const urlParams = new URLSearchParams(window.location.search);
    const errorMessage = urlParams.get("errorMessage");
    let textShow;
    if (errorMessage==="duplicate"){
        textShow = "Existe un feriado registrado en esta fecha"
    }else {
        textShow = "Error del sistema, por favor contacte al administrador"
    }
    Swal.fire({
        icon: "error",
        title: "Error, no se registró el feriado",
        text: textShow,
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/NonBusinessDayServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
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
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/NonBusinessDayServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "updateError"){
    const urlParams = new URLSearchParams(window.location.search);
    const errorMessage = urlParams.get("errorMessage");
    let textShow;
    if (errorMessage==="duplicate"){
        textShow = "Existe un feriado registrado en esta fecha"
    }else {
        textShow = "Error del sistema, por favor contacte al administrador"
    }
    Swal.fire({
        icon: "error",
        title: "Error, no se actualizó el feriado",
        text: textShow,
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/NonBusinessDayServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
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
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/NonBusinessDayServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "deleteError"){
    Swal.fire({
        icon: "error",
        title: "Error, no se eliminó el feriado",
        text: "Vuelva a intentarlo",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/NonBusinessDayServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "deleteOk"){
    Swal.fire({
        icon: "success",
        title: "Feriado eliminado con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/NonBusinessDayServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
