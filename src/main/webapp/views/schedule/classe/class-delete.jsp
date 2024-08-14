<%--
  Created by IntelliJ IDEA.
  User: Jose Luis Miranda
  Date: 31/07/2024
  Time: 04:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %><style>
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

<div class="modal fade" id="deleteClasseModal" data-bs-backdrop="static" aria-labelledby="deleteClasseTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
                <div class="text-center">
                    <div class="mb-3">
                        <i class="bi bi-question-circle animated-icon"></i>
                    </div>
                    <h3>¿Desea eliminar clase?</h3>
                </div>
                <form id="deleteForm" action="<%=request.getContextPath()%>/classServlet" method="post" style="display:none">
                    <input id="deleteClassId" name="deleteClassId" type="text"/>
                    <input type="text" name="action" value="delete"/>
                </form>
                <div class="col-12 text-center mt-4">
                    <button id="submitButtonDelete" type="button" class="btn btn-success">Eliminar</button>
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%--REVERIR DELETE--%>
<div class="modal fade" id="revertDeleteClasseModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="revertDeleteClasseTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
                <div class="text-center">
                    <div class="mb-3">
                        <i class="bi bi-arrow-repeat animated-icon-reactivate"></i>
                    </div>
                    <h3>¿Desea reactivar la clase?</h3>
                </div>
                <form id="revertDeleteForm" action="<%=request.getContextPath()%>/classServlet" method="post" style="display:none">
                    <input id="revertDeleteClassId" name="revertDeleteClassId" type="text"/>
                    <input type="text" name="action" value="revertDelete"/>
                </form>
                <div class="col-12 text-center mt-4">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                    <button id="submitButtonRevertDelete" type="button" class="btn btn-success">Reactivar</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("submitButtonRevertDelete").addEventListener("click", function () {
        document.getElementById("revertDeleteForm").submit();
    });
    document.getElementById("submitButtonDelete").addEventListener("click", function () {
        document.getElementById("deleteForm").submit();
    });
</script>
