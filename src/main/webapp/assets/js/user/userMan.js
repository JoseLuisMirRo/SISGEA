let status = document.getElementById("status").value;
if (status === "registerError") {
    Swal.fire({
        icon: "error",
        title: "Error, no se registró el usuario",
        text: "Verifique si el usuario ya se encuentra registrado y vuelva a intentarlo",
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
        title: "Error, no se actualizó el usuario",
        text: "Vuelva a intentarlo",
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
else if (status==="updatePswdOk"){
    Swal.fire({
        icon: "success",
        title: "Contraseña actualizada con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    });
}
else if(status==="updatePswdError"){
    Swal.fire({
        icon: "error",
        title: "Error, no se actualizó la contraseña",
        text: "Vuelva a intentarlo",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}
else if (status === "deleteError"){
    Swal.fire({
        icon: "error",
        title: "Error, no se eliminó el usuario",
        text: "Vuelva a intentarlo",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}
else if (status === "deleteOk"){
    Swal.fire({
        icon: "success",
        title: "Usuario eliminado con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    });
}
else if (status === "revertDeleteError"){
    Swal.fire({
        icon: "error",
        title: "Error, no se reactivó el usuario",
        text: "Vuelva a intentarlo",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}
else if (status === "revertDeleteOk"){
    Swal.fire({
        icon: "success",
        title: "Usuario reactivado con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    });
}
else if (status === "bulkOk"){
    Swal.fire({
        icon: "success",
        title: "Usuarios agregados con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    });
}
else if (status === "bulkError"){
    Swal.fire({
        icon: "error",
        title: "Error, no se agregaron los usuarios",
        text: "Vuelva a intentarlo",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}