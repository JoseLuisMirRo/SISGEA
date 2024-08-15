<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 19/07/2024
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .animated-icon {
        font-size: 6rem;
        color: #fa4040;
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
                <form id="cancelForm" action="<%=request.getContextPath()%>/reserveServlet" method="post" style="display:none">
                    <input id="cancelReserveId" name="cancelReserveId" type="text"/>
                    <input type="text" name="action" value="cancel"/>
                </form>
                <div class="col-12 text-center mt-4">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                    <button id="submitButtonCancel" type="button" class="btn btn-success">Sí, cancelar</button>
                </div>
            </div>
        </div>
    </div>
</div>
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
                <form id="reactivateForm" action="<%=request.getContextPath()%>/reserveServlet" method="post" style="display:none">
                    <input id="reactivateReserveId" name="reactivateReserveId" type="text"/>
                    <input type="text" name="action" value="reactivate"/>
                </form>
                <div class="col-12 text-center mt-4">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                    <button id="submitButtonReactivate" type="button" class="btn btn-success">Reactivar</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("submitButtonCancel").addEventListener("click", function () {
        document.getElementById("cancelForm").submit();
    });
    document.getElementById("submitButtonReactivate").addEventListener("click", function () {
        document.getElementById("reactivateForm").submit();
    });
</script>
