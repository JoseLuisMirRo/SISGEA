<%@ page import="mx.edu.utez.sisgea.model.LoginBean" %><%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 22/07/2024
  Time: 12:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession activeSession = request.getSession();
    LoginBean user = (LoginBean)activeSession.getAttribute("activeUser");
    int activeUserId = user.getId();
%>
<style>
    .animated-icon {
        font-size: 6rem;
        color: #f8bb86;
        animation: fadeInDown 1s, bounceIn 1s 0.5s;
    }
    .animated-icon-reactivate {
        font-size: 6rem;
        color: #28a745;
        animation: fadeInDown 1s, bounceIn 1s 0.5s;
    }

    @keyframes fadeInDown {
        0% {
            opacity: 0;
            transform: translateY(-50px);
        }
        100% {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @keyframes bounceIn {
        0%, 20%, 40%, 60%, 80%, 100% {
            transition-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
        }

        0% {
            opacity: 0;
            transform: scale3d(.3, .3, .3);
        }

        20% {
            transform: scale3d(1.1, 1.1, 1.1);
        }

        40% {
            transform: scale3d(.9, .9, .9);
        }

        60% {
            opacity: 1;
            transform: scale3d(1.03, 1.03, 1.03);
        }

        80% {
            transform: scale3d(.97, .97, .97);
        }

        100% {
            opacity: 1;
            transform: scale3d(1, 1, 1);
        }
    }
</style>

<div class="modal fade" id="reserveCancelModal" data-bs-backdrop="static" aria-labelledby="cancelReserveTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
                <div class="text-center">
                    <div class="mb-3">
                        <i class="bi bi-question-circle animated-icon"></i>
                    </div>
                    <h3>¿Desea cancelar reserva?</h3>
                </div>
                <form id="cancelForm" action="<%=request.getContextPath()%>/reserveServlet" method="post" novalidate>
                    <input id="cancelReserveId" name="cancelReserveId" type="text" hidden/>
                    <input id="cancelUserId" name="cancelUserId" type="text" hidden/>
                    <div class="form-group" id="cancelReasonContainer" style="display: none;">
                        <label for="cancelReason">Motivo de cancelación: </label>
                        <textarea class="form-control" name="cancelReason" id="cancelReason" type="text" required></textarea>
                        <span class="valid-feedback">Información con formato correcto</span>
                        <span class="invalid-feedback">Ingrese razón de cancelación</span>
                    </div>
                    <input type="text" name="action" value="cancel" hidden/>
                    <div class="col-12 text-center mt-4">
                        <button type="reset" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                        <button id="submitButtonCancel" type="button" class="btn btn-success">Sí, cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("submitButtonCancel").addEventListener("click", function () {
        const cancelForm = document.getElementById("cancelForm")
        cancelForm.classList.add('was-validated');
        if (cancelForm.checkValidity()) {
            cancelForm.submit();
        }
    });
</script>

<%--REACTIVATE--%>
<div class="modal fade" id="reactivateReserveModal" data-bs-backdrop="static" aria-labelledby="reactivateReserveTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
                <div class="text-center">
                    <div class="mb-3">
                        <i class="bi bi-arrow-repeat animated-icon-reactivate"></i>
                    </div>
                    <h3>¿Desea reactivar reserva?</h3>
                </div>
                <form id="reactivateForm" action="<%=request.getContextPath()%>/reserveServlet" method="post" novalidate>
                    <input id="reactivateReserveId" name="reactivateReserveId" type="text" hidden/>
                    <input id="reactivateUserId" name="reactivateUserId" type="text" hidden/>
                    <div class="form-group" id="reactivateReasonContainer" style="display: none;">
                        <label for="cancelReason">Motivo de reactivación: </label>
                        <textarea class="form-control" name="reactivateReason" id="reactivateReason" type="text" required></textarea>
                        <span class="valid-feedback">Información con formato correcto</span>
                        <span class="invalid-feedback">Ingrese razón de cancelación</span>
                    </div>
                    <input type="text" name="action" value="reactivate"hidden/>
                    <div class="col-12 text-center mt-4">
                        <button type="reset" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                        <button id="submitButtonReactivate" type="button" class="btn btn-success">Reactivar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("submitButtonReactivate").addEventListener("click", function () {
        const reactForm = document.getElementById("reactivateForm");
        reactForm.classList.add('was-validated');
        if (reactForm.checkValidity()) {
            reactForm.submit();
        }
    });
    document.addEventListener("DOMContentLoaded", ()=>{
        document.getElementById('reserveCancelModal').addEventListener('shown.bs.modal', async ()=> {
            const sessionUserId = parseInt(<%=activeUserId%>);
            const userId = parseInt(document.getElementById('cancelUserId').value);
            if(sessionUserId !== userId){
                document.getElementById('cancelReasonContainer').style.display = 'block';
                document.getElementById('cancelReason').required = true;
            }else{
                document.getElementById('cancelReasonContainer').style.display = 'none';
                document.getElementById('cancelReason').required = false;
            }
        });
        document.getElementById('reactivateReserveModal').addEventListener('shown.bs.modal', async ()=> {
            const sessionUserIdR = parseInt(<%=activeUserId%>);
            const userIdR = parseInt(document.getElementById('reactivateUserId').value);
            console.log(sessionUserIdR, userIdR);
            if (sessionUserIdR !== userIdR) {
                document.getElementById('reactivateReasonContainer').style.display = 'block';
                document.getElementById('reactivateReason').required = true;
            } else {
                document.getElementById('reactivateReasonContainer').style.display = 'none';
                document.getElementById('reactivateReason').required = false;
            }
        });
    });
</script>