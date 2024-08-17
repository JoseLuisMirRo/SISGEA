<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 13/08/2024
  Time: 09:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Modal -->
<div class="modal fade" id="nbdRegisterModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="nbdRegTit" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="nbdRegTit">Registrar feriado</h1>
                <hr>
                <form id="registerNbdForm" action="<%=request.getContextPath()%>/NonBusinessDayServlet" method="POST" novalidate>
                    <div class="form-group mb-3 row">
                        <label for="name" class="col-4 col-form-label form-label">Nombre:</label>
                        <div class="col-8">
                            <input id="name" type="text" class="form-control" name="name" placeholder="Nombre del feriado" required pattern="^[A-ZÁÉÍÓÚÜÑ0-9][a-záéíóúüñA-ZÁÉÍÓÚÜÑ0-9]*(?:\s+[a-záéíóúüñA-ZÁÉÍÓÚÜÑ0-9]+)*$"/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un nombre válido</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                        <label for="date" class="col-4 col-form-label form-label">Fecha:</label>
                        <div class="col-8">
                            <input type="date" class="form-control" name="date" id="date" required/>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce una fecha válida</span>
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
    const today = new Date().toISOString().split('T')[0];
    document.getElementById("date").setAttribute('min', today);
    
    document.getElementById("submitButtonRegister").addEventListener("click",function (){
        const form= document.getElementById("registerNbdForm");
        form.classList.add('was-validated');
        const {name,date}=form.elements;

        if(name.value && date.value){
            if(form.checkValidity()) {
                form.submit();
            }
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
