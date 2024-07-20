<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 19/07/2024
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="reserveCancelModal" aria-labelledby="cancelReserveTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="deleteReserveTitle">Cancelar reserva</h1>
            </div>
            <div class="modal-body">
                <h3>¿Desea cancelar reserva?</h3>
                <form id="cancelForm" action="<%=request.getContextPath()%>/reserveServlet" method="post" style="display:none">
                    <input id="cancelReserveId" name="cancelReserveId" type="text"/>
                    <input type="text" name="action" value="cancel"/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonCancel" type="button" class="btn btn-success">Eliminar</button>

            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("submitButtonCancel").addEventListener("click", function () {
        document.getElementById("cancelForm").submit();
    });
</script>

<%--REACTIVATE--%>
