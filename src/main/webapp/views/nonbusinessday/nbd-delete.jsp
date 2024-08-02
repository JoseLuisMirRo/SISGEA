<%--
  Created by IntelliJ IDEA.
  User: luisi
  Date: 02/08/2024
  Time: 11:24 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="deleteNbdModal" aria-labelledby="deleteNbdTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="deleteNbdTitle">Eliminar feriado</h1>
            </div>
            <div class="modal-body">
                <h3>¿Desea eliminar horario?</h3>
                <h4>¡Cuidado! Esta acción no se puede revertir</h4>
                <form id="deleteForm" action="<%=request.getContextPath()%>/NonBusinessDayServlet" method="post" style="display:none">
                    <input id="deleteNbdId" name="deleteNbdId" type="text"/>
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
