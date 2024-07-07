<%@ page import="mx.edu.utez.sisgea.model.RoleBean" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: JLuis
  Date: 07/07/2024
  Time: 01:15 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Multiuser Menu</title>
</head>
<body>
<h1>Multiuser Menu (Despues le pongo $5 de diseño)</h1>

<h2>Se han encontrado multiples roles para este usuario</h2>

<form action="<%=request.getContextPath()%>/loginForm" method="post">
    <label for="roles">Selecciona un rol: </label>
    <select id="roles" name="role">
    <%
        List<RoleBean> userRoles = (List<RoleBean>) request.getAttribute("userRoles");
        for(RoleBean role : userRoles){
            %>
        <option value="<%= role.getId() %>"><%= role.getName() %></option>
        <% } %>
    </select>
    <br><br>
    <input type="submit" value="Seleccionar">
</form>

</body>
</html>
