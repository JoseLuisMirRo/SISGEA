<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 17/07/2024
  Time: 22:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="deleteScheduleModal" aria-labelledby="deleteScheduleTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="deleteScheduleTitle">Eliminar horario</h1>
            </div>
            <div class="modal-body">
                <h3>¿Desea eliminar horario?</h3>
                <h4>¡Cuidado! Esta acción no se puede revertir</h4>
                <form id="deleteForm" action="<%=request.getContextPath()%>/scheduleServlet" method="post" style="display:none">
                    <input id="deleteScheduleId" name="deleteScheduleId" type="text"/>
                    <input type="text" name="action" value="delete"/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonDelete" type="button" class="btn btn-success">Eliminar</button>

            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("submitButtonDelete").addEventListener("click", function () {
        document.getElementById("deleteForm").submit();
    });
</script>

