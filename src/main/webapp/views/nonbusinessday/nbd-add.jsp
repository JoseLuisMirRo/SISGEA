<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 13/08/2024
  Time: 09:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Modal -->
<html>
<div class="modal fade" id="nbdRegisterModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="nbdRegTit" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="nbdRegTit">Registrar feriado</h1>
                <hr>
                <form action="<%= request.getContextPath() %>/NonBusinessDayServlet " id="registerNbdForm" method="POST" novalidate>
                    <div class="form-group mb-3 row">
                        <label for="name" class="col-4 col-form-label form-label">Nombre:</label>
                        <div class="col-8">
                            <input type="text" class="form-control" name="name" id="name" placeholder="Nombre del feriado" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$">
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un nombre válido</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                        <label for="date" class="col-4 col-form-label form-label">Fecha:</label>
                        <div class="col-8">
                            <input type="date" class="form-control" name="date" id="date" required>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un nombre válido</span>
                        </div>
                    </div>
                    <input type="text" name="action" value="add" hidden/>
                    <div class="col-12 text-end mt-4">
                        <button type="reset" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                        <button id="submitButtonRegister" type="button" class="btn btn-success">Registrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById("submitButtonRegister").addEventListener("click",function (){
        const form= document.getElementById("RegisterNbdForm");
        form.classList.add('was-validated');
        const {name,date}=form.elements;

        if(name.value && date.value){
            form.submit();
        } else {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: "Completa todos los campos",
                confirmButtonText: "Revisar",
                confirmButtonColor: "#dc3545",
            });
        }
    });
</script>
</html>
