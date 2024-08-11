const status = document.getElementById("status").value;
if (status === "registerError") {
    const urlParams = new URLSearchParams(window.location.search);
    const errorMessage = urlParams.get("errorMessage");
    let textShow;
    if (errorMessage === "repeated") {
        textShow = "Existe un registro con los mismos datos para el programa seleccionado";
    } else {
        textShow = "Error del sistema, por favor contacte al administrador"
    }
    Swal.fire({
        icon: "error",
        title: "Error, no se registró la clase",
        text: textShow,
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
            window.location.href = contextPath + "/classServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
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
            window.location.href = contextPath + "/classServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "updateError") {
    const urlParams = new URLSearchParams(window.location.search);
    const errorMessage = urlParams.get("errorMessage");
    let textShow;
    if (errorMessage === "repeated") {
        textShow = "Existe un registro con los mismos datos para el programa seleccionado"
    } else {
        textShow = "Error del sistema, por favor contacte al administrador"
    }
    Swal.fire({
        icon: "error",
        title: "Error, no se actualizó la clase",
        text: textShow,
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
            window.location.href = contextPath + "/classServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "updateOk") {
    Swal.fire({
        icon: "success",
        title: "Actualización realizada con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/classServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "deleteOk") {
    Swal.fire({
        icon: "success",
        title: "Eliminación realizada con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/classServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "deleteError") {
    Swal.fire({
        icon: "error",
        title: "Error, no se eliminó la clase",
        text: "Error del sistema, por favor contacte al administrador",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
            window.location.href = contextPath + "/classServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "revertDeleteOk") {
    Swal.fire({
        icon: "success",
        title: "Clase reactivada con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
            window.location.href = contextPath + "/classServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "revertDeleteError") {
    Swal.fire({
        icon: "error",
        title: "Error, no se reactivó la clase",
        text: "Error del sistema, por favor contacte al administrador",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
            window.location.href = contextPath + "/classServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}