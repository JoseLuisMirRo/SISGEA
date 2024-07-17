let status = document.getElementById("status").value;
console.log(status);
if (status === "registerError") {
    const urlParams = new URLSearchParams(window.location.search);
    const errorMessage = urlParams.get("errorMessage");
    let textShow;
    if (errorMessage==="repeated"){
        textShow = "Existe un registro con los mismso datos"
    }else if (errorMessage==="conflict"){
        textShow = "Horario de clase traslapa con otra clase"
    }else if (errorMessage==="startAfterEnd"){
        textShow = "Hora de inicio no puede ir antes de hora final"
    }else {
        textShow = "Error del sistema, por favor contacte al administrador"
    }
    Swal.fire({
        icon: "error",
        title: "Error, no se registró el horario",
        text: textShow,
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/scheduleServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
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
            window.location.href = contextPath + "/scheduleServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "updateError"){
    Swal.fire({
        icon: "error",
        title: "Error, no se actualizó el horario",
        text: "Verifique si existe un registro con los mismos datos y vuelva a intentarlo",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/scheduleServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
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
            window.location.href = contextPath + "/scheduleServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "deleteError"){
    Swal.fire({
        icon: "error",
        title: "Error, no se eliminó el horario",
        text: "Vuelva a intentarlo",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/scheduleServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
else if (status === "deleteOk"){
    Swal.fire({
        icon: "success",
        title: "Horario eliminado con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    }).then((result) => {
        if (result.isConfirmed) {
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
            window.location.href = contextPath + "/scheduleServlet"; //Redireccionamos a la página principal. Previene que se muestre el SweetAlert si se recarga la página
        }
    });
}
