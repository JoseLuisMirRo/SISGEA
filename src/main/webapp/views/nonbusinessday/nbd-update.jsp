<%--
  Created by IntelliJ IDEA.
  User: luisi
  Date: 01/08/2024
  Time: 10:38 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Modal -->
<div class="modal fade" id="nbdUpdateModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="nbdUpdateTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="nbdRegisterTitle">Actualizar feriado</h1>
                <hr>
                <form action="<%= request.getContextPath() %>/NonBusinessDayServlet " id="updateNbdForm" method="POST" novalidate>
                    <input type="text" name="updateNbdId" id="updateNbdId" hidden/>
                    <div class="form-group mb-3 row">
                        <label for="updateName" class="col-4 col-form-label form-label">Nombre:</label>
                        <div class="col-8">
                        <input type="text" class="form-control" name="updateName" id="updateName" placeholder="Nombre del feriado" required pattern="^[A-ZÁÉÍÓÚÜÑ0-9][a-záéíóúüñA-ZÁÉÍÓÚÜÑ0-9]*(?:\s+[a-záéíóúüñA-ZÁÉÍÓÚÜÑ0-9]+)*$">
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un nombre válido</span>
                        </div>
                    </div>
                    <div class="form-group mb-3 row">
                        <label for="updateDate" class="col-4 col-form-label form-label">Fecha:</label>
                        <div class="col-8">
                            <input type="date" class="form-control" name="updateDate" id="updateDate" required>
                            <span class="valid-feedback">El dato es correcto</span>
                            <span class="invalid-feedback">Introduce un nombre válido</span>
                        </div>
                    </div>
                    <input type="text" name="action" value="update" hidden/>
                    <div class="col-12 text-end mt-4">
                        <button type="reset" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                        <button id="submitButtonUpdate" type="button" class="btn btn-success">Registrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById("updateDate").setAttribute('min', today);

    document.addEventListener("DOMContentLoaded" , () => {
        const nbdUpdateModal = document.getElementById('nbdUpdateModal');

        nbdUpdateModal.addEventListener('shown.bs.modal', ()=> {
            const id=nbdUpdateModal.getAttribute("data-id");
            const name=nbdUpdateModal.getAttribute("data-name");
            const date=nbdUpdateModal.getAttribute("data-date");

            document.getElementById('updateNbdId').value=id;
            document.getElementById('updateName').value=name;
            document.getElementById('updateDate').value=date;
        });
    });
    document.getElementById("submitButtonUpdate").addEventListener("click",function (){
        const form= document.getElementById("updateNbdForm");
        form.classList.add('was-validated');
        const {updateName,updateDate}=form.elements;

        if(updateName.value && updateDate.value){
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
    const manageDate = (dateD) => {
        const months = {
            'ene': 0, 'feb': 1, 'mar': 2, 'abr': 3,
            'may': 4, 'jun': 5, 'jul': 6, 'ago': 7,
            'sept': 8, 'oct': 9, 'nov': 10, 'dic': 11
        };
        dateD = dateD.replace('.', '');
        const parts = dateD.split(' ');
        const month = months[parts[0]];
        const day = parseInt(parts[1].replace(',', ''), 10);
        const year = parseInt(parts[2], 10);
        const date = new Date(year, month, day);
        const yearStr = date.getFullYear().toString();
        const monthStr = (date.getMonth() + 1).toString().padStart(2, '0');
        const dayStr = date.getDate().toString().padStart(2, '0');
        return `\${yearStr}-\${monthStr}-\${dayStr}`;
    }

</script>