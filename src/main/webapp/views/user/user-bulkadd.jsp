<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 03/08/2024
  Time: 09:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<div class="modal fade" id="bulkRegisterModal" tabindex="-1" aria-labelledby="userRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="userRegisterTitle">Registro masivo de usuarios</h1>
            </div>
            <div class="modal-body">
                <form id="usrBulkAdd" action="<%=request.getContextPath()%>//bulkUserServlet" method="post" enctype="multipart/form-data">
                    <input type="file" name="file" id="file" class="form-action"/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                <button id="submitButtonAdd" type="button" class="btn btn-success">Enviar</button>
            </div>
        </div>
    </div>
</div>
</html>
<script>
    document.getElementById("submitButtonAdd").addEventListener("click",function () {
        document.getElementById("usrBulkAdd").submit();
    });
</script>