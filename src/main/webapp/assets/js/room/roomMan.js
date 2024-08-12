let status = document.getElementById("status").value;
if (status === "registerError") {
    Swal.fire({
        icon: "error",
        title: "Error, no se registró el espacio",
        text: "Verifique si el espacio ya se encuentra registrado",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}
else if (status === "registerOk") {
    Swal.fire({
        icon: "success",
        title: "Registro realizado con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    });
}
else if (status === "updateError"){
    Swal.fire({
        icon: "error",
        title: "Error, no se actualizó el espacio",
        text: "Verifique si los nuevos datos no corresponden a otro registro y vuelva a intentarlo",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}
else if (status === "updateOk"){
    Swal.fire({
        icon: "success",
        title: "Actualización realizada con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    });
}
else if (status === "deleteError"){
    Swal.fire({
        icon: "error",
        title: "Error, no se eliminó el espacio",
        text: "Vuelva a intentarlo",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}
else if (status === "deleteOk"){
    Swal.fire({
        icon: "success",
        title: "Espacio eliminado con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    });
}
else if (status === "revertDeleteError"){
    Swal.fire({
        icon: "error",
        title: "Error, no se reactivó el espacio",
        text: "Vuelva a intentarlo",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}
else if (status === "revertDeleteOk"){
    Swal.fire({
        icon: "success",
        title: "Espacio reactivado con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    });
}