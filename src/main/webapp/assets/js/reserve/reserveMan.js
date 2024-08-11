const status = document.getElementById("status").value;
if (status === "registerError") {
    const errorMessage = document.getElementById("errorMessage").value;
    let textShow;
    if (errorMessage==="repeated"){
        textShow = "Existe un registro con los mismso datos"
    }else if (errorMessage==="conflict"){
        textShow = "Horario de reserva traslapa con otra reserva"
    }else if (errorMessage==="startAfterEnd") {
        textShow = "Hora de inicio no puede ir antes de hora final"
    }else if (errorMessage==="overlaps") {
        textShow = "Horario de reserva traslapa con una clase"
    }else if (errorMessage==="overlapsnbd"){
        textShow = "No se puede reservar en dias feriados"
    }else {
        textShow = "Error del sistema, por favor contacte al administrador"
    }
    Swal.fire({
        icon: "error",
        title: "Error, no se registró la reserva",
        text: textShow,
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
    const errorMessage = document.getElementById("errorMessage").value;
    let textShow;
    if (errorMessage==="repeated"){
        textShow = "Existe un registro con los mismso datos"
    }else if (errorMessage==="conflict"){
        textShow = "Horario de reserva traslapa con otra reserva"
    }else if (errorMessage==="startAfterEnd"){
        textShow = "Hora de inicio no puede ir antes de hora final"
    }else if (errorMessage==="overlaps") {
        textShow = "Horario de reserva traslapa con una clase"
    }else if (errorMessage==="overlapsNbd"){
        textShow = "No se puede reservar en dias feriados"
    }else {
        textShow = "Error del sistema, por favor contacte al administrador"
    }
    Swal.fire({
        icon: "error",
        title: "Error, no se actualizó la reserva",
        text: textShow,
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

else if (status === "deleteOk"){
    Swal.fire({
        icon: "success",
        title: "Reserva cancelada con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    });
}

else if(status === "deleteError"){
    const errorMessage = document.getElementById("errorMessage").value;
    let textShow;
    if (errorMessage==="adminCanceled"){
        textShow = "Reserva cancelada por un administrador"
    } else if (errorMessage==="alreadyCanceled"){
        textShow = "La reserva ya está cancelada"
    }else {
        textShow = "Error del sistema, por favor contacte al administrador"
    }
        Swal.fire({
            icon: "error",
            title: "Error al cancelar la reserva",
            text: textShow,
            confirmButtonText: "Reintentar",
            confirmButtonColor: "#dc3545",
        });
}

else if (status === "reactivateOk"){
    Swal.fire({
        icon: "success",
        title: "Reserva reactivada con éxito",
        confirmButtonText: "Ok",
        confirmButtonColor: "#208c7d",
    });
}

else if (status === "reactivateError"){
    const errorMessage = document.getElementById("errorMessage").value;
    let textShow;
    if (errorMessage==="alreadyActive"){
        textShow = "La reserva ya está activa"
    }else if(errorMessage==="adminCanceled"){
        textShow = "Reserva cancelada por un administrador"
    }else{
        textShow = "Error del sistema, por favor contacte al administrador"
    }
    Swal.fire({
        icon: "error",
        title: "Error al reactivar la reserva",
        text: textShow,
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}

