<%--
  Created by IntelliJ IDEA.
  User: luisi
  Date: 01/08/2024
  Time: 10:38 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!-- Modal -->
<div class="modal fade" id="nbdUpdateModal" tabindex="-1" aria-labelledby="nbdUpdateTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="nbdRegisterTitle">Actualizar feriado</h1>
            </div>
            <div class="modal-body">
                <form action="<%= request.getContextPath() %>/NonBusinessDayServlet " id="updateNbdForm" method="POST" class="mb-4">
                    <div class="mb-3">
                        <input type="text" name="updateNbdId" id="updateNbdId" hidden/>
                        <label for="updateName" class="form-label">Nombre del feriado</label>
                        <input type="text" class="form-control" name="updateName" id="updateName" placeholder="Nombre del feriado" required>
                    </div>
                    <div class="mb-3">
                        <label for="updateDate" class="form-label">Fecha del feriado</label>
                        <input type="date" class="form-control" name="updateDate" id="updateDate" required>
                        <input type="text" name="action" value="update" hidden/>
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
    document.addEventListener("DOMContentLoaded" , () => {
        const nbdUpdateModal = document.getElementById('nbdUpdateModal');

        nbdUpdateModal.addEventListener('shown.bs.modal', ()=> {
            const id=nbdUpdateModal.getAttribute("data-id");
            const name=nbdUpdateModal.getAttribute("data-name");
            const date=nbdUpdateModal.getAttribute("data-date");

            const dateYMD = manageDate(date);

            document.getElementById('updateNbdId').value=id;
            document.getElementById('updateName').value=name;
            document.getElementById('updateDate').value=dateYMD;
        });
    });
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
    const manageDate = (dateD) => {
        const months = {
            'ene.': 0, 'feb.': 1, 'mar.': 2, 'abr.': 3,
            'may.': 4, 'jun.': 5, 'jul.': 6, 'ago.': 7,
            'sep.': 8, 'oct.': 9, 'nov.': 10, 'dic.': 11
        };

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