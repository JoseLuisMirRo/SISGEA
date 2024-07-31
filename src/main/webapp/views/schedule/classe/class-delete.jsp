<%--
  Created by IntelliJ IDEA.
  User: Jose Luis Miranda
  Date: 31/07/2024
  Time: 04:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="deleteClasseModal" aria-labelledby="deleteClasseTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="deleteClasseTitle">Eliminar clase</h1>
            </div>
            <div class="modal-body">
                <h3>¿Desea eliminar clase?</h3>
                <form id="deleteForm" action="<%=request.getContextPath()%>/classServlet" method="post" style="display:none">
                    <input id="deleteClassId" name="deleteClassId" type="text"/>
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

<%--REVERIR DELETE--%>
<div class="modal fade" id="revertDeleteClasseModal" aria-labelledby="revertDeleteClasseTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="revertDeleteClasseTitle">Reactivar espacio</h1>
            </div>
            <div class="modal-body">
                <h3>¿Desea reactivar la clase?</h3>
                <form id="revertDeleteForm" action="<%=request.getContextPath()%>/roomServlet" method="post" style="display:none">
                    <input id="revertDeleteClasseId" name="revertDeleteClasseId" type="text"/>
                    <input type="text" name="action" value="revertDelete"/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonRevertDelete" type="button" class="btn btn-success">Reactivar</button>

            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("submitButtonRevertDelete").addEventListener("click", function () {
        document.getElementById("revertDeleteForm").submit();
    });
</script>
