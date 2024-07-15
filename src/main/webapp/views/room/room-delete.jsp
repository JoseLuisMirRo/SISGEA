<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 15/07/2024
  Time: 03:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="deleteRoomModal" aria-labelledby="deleteRoomTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="deleteRoomTitle">Eliminar espacio</h1>
            </div>
            <div class="modal-body">
                <h3>¿Desea eliminar espacio?</h3>
                <form id="deleteForm" action="<%=request.getContextPath()%>/roomServlet" method="post" style="display:none">
                    <input id="deleteRoomId" name="deleteRoomId" type="text"/>
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
<div class="modal fade" id="revertDeleteRoomModal" aria-labelledby="revertDeleteRoomTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="revertDeleteRoomTitle">Reactivar espacio</h1>
            </div>
            <div class="modal-body">
                <h3>¿Desea reactivar espacio?</h3>
                <form id="revertDeleteForm" action="<%=request.getContextPath()%>/roomServlet" method="post" style="display:none">
                    <input id="revertDeleteRoomId" name="revertDeleteRoomId" type="text"/>
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
