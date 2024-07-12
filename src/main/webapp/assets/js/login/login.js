let status = document.getElementById("status").value;
if (status === "failed"){
    Swal.fire({
        icon: "error",
        title: "Error",
        text: "Usuario o contraseña incorrectos",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}
else if (status === "invalidEmail"){
    Swal.fire({
        icon: "error",
        title: "Error",
        text: "Por favor ingrese nombre de usuario",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}
else if (status === "invalidPassword"){
    Swal.fire({
        icon: "error",
        title: "Error",
        text: "Por favor ingrese contraseña",
        confirmButtonText: "Reintentar",
        confirmButtonColor: "#dc3545",
    });
}
else if (status === "serverError"){
    Swal.fire({
        icon: "warning",
        title: "Error",
        text: "Error del sistema, por favor contacte al administrador",
        confirmButtonText: "OK",
        confirmButtonColor: "#dc3545",
    });
}
else if (status === "unauthorized"){
    Swal.fire({
        icon: "warning",
        title: "Error",
        text: "Usuario deshabilitado, si cree que se trata de un error por favor contacte al administrador",
        confirmButtonText: "OK",
        confirmButtonColor: "#dc3545",
    });
}
