<%@ page import="mx.edu.utez.sisgea.model.NonBusinessDay" %><%--
  Created by IntelliJ IDEA.
  User: luisi
  Date: 01/08/2024
  Time: 09:43 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!-- Modal -->
<div class="modal fade" id="nbdRegisterModal" tabindex="-1" aria-labelledby="nbdRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="nbdRegisterTitle">Registrar nuevo feriado</h1>
            </div>
            <div class="modal-body">
                <form action="<%= request.getContextPath() %>/NonBusinessDayServlet " id="registerNbdForm" method="POST" class="mb-4">
                    <div class="mb-3">
                        <label for="name" class="form-label">Nombre del feriado</label>
                        <input type="text" class="form-control" name="name" id="name" placeholder="Nombre del feriado" required>
                    </div>
                    <div class="mb-3">
                        <label for="date" class="form-label">Fecha del feriado</label>
                        <input type="date" class="form-control" name="date" id="date" required>
                        <input type="text" name="action" value="add" hidden/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonAdd" type="button" class="btn btn-success">Registrar</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById("submitButtonAdd").addEventListener("click",function (){
        const form= document.getElementById("registerNbdForm");
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