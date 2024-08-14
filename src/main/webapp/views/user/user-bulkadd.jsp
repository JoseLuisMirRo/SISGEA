<%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 03/08/2024
  Time: 09:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<div class="modal fade" id="bulkRegisterModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="userRegisterTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h1 class="modal-title fs-5" id="userRegisterTitle">Registro masivo de usuarios</h1>
                <hr>
                <form id="usrBulkAdd" action="<%=request.getContextPath()%>/userBulkServlet" method="post" enctype="multipart/form-data">
                    <div CLASS="form-group mb-3 row">
                        <label for="file" class="col-form-label form-label">Archivo .XLSX:</label>
                        <div>
                            <input type="file" name="file" id="file" class="form-action"/>
                        </div>
                    </div>
                    <div class="col-12 text-end mt-4">
                    <button type="reset" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                    <button id="submitButtonBulk" type="button" class="btn btn-success">Enviar</button>
                </div>
                </form>
            </div>
        </div>
    </div>
</div>
</html>
<script>
    document.getElementById("submitButtonBulk").addEventListener("click",function () {
        document.getElementById("usrBulkAdd").submit();
    });
</script>