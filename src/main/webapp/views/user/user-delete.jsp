<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 24/06/2024
  Time: 08:22 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="deleteUserModal" tabindex="-1" aria-labelledby="deleteUserTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="deleteUserTitle">Actualizar usuario</h1>
            </div>
            <div class="modal-body">
                <h3>¿Desea eliminar usuario?</h3>
                <form id="deleteForm" action="<%=request.getContextPath()%>/userServlet" method="post" style="display:none">
                    <input id="deleteUserId" name="deleteUserId" type="text"/>
                    <input type="text" name="action" value="delete"/> <!--VALOR PARA INDICAR AL SERVLET QUE ES UN ACCION DE UPDATE-->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonDelete" type="button" class="btn btn-primary">Eliminar</button>

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
<div class="modal fade" id="revertDeleteUserModal" tabindex="-1" aria-labelledby="revertDeleteUserTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="revertDeleteUserTitle">Actualizar usuario</h1>
            </div>
            <div class="modal-body">
                <h3>¿Desea reactivar usuario?</h3>
                <form id="revertDeleteForm" action="<%=request.getContextPath()%>/userServlet" method="post" style="display:none">
                    <input id="revertDeleteUserId" name="revertDeleteUserId" type="text"/>
                    <input type="text" name="action" value="revertDelete"/> <!--VALOR PARA INDICAR AL SERVLET QUE ES UN ACCION DE UPDATE-->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonRevertDelete" type="button" class="btn btn-primary">Reactivar</button>

            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("submitButtonRevertDelete").addEventListener("click", function () {
        document.getElementById("revertDeleteForm").submit();
    });
</script>
