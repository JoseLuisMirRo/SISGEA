<%--
  Created by IntelliJ IDEA.
  User: Jose Luis Miranda
  Date: 03/07/2024
  Time: 02:51 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<select id="usuarios">
</select>
</body>
<script>
    addEventListener("DOMContentLoaded", async () => {
        const response=await fetch('http://localhost:8080/SISGEA_war_exploded/data/users');
        const users=await response.json();

        let content= ``;
        users.forEach((user,index) => {
            content+= "<option value=\"" + user.ID +"\">" + user.firstName + "</option>"
        })

        document.getElementById("usuarios").innerHTML =content
    })
</script>
</html>
