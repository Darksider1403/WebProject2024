<%@ page import="Model.Log" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Log Manager</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/2.0.6/js/dataTables.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.6/css/dataTables.dataTables.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
<div class="container-fluid">
    <h1 class="text-center">Log Manager</h1>
    <a href="userManager.jsp">
        <button class="btn btn-primary">User manager</button>
    </a>
    <table id="log-table" class="display">
        <thead>
        <tr>
            <td>Id</td>
            <td>Level</td>
            <td>Address</td>
            <td>Ip address</td>
            <td>Before Value</td>
            <td>After Value</td>
            <td>Date time</td>
        </tr>
        </thead>
        <tbody>
        <%
            List<Log> logs = (List<Model.Log>) request.getAttribute("logs");
            if (logs != null) {
                for (Model.Log log : logs) {
        %>
        <tr>
            <td><%= log.getId() %></td>
            <td><span class="<%= log.getLevel() %>"><%= log.getLevel() %></span></td>
            <td><%= log.getAddress() %></td>
            <td><%= log.getIp() %></td>
            <td><%= log.getPreValue() %></td>
            <td><%= log.getValue() %></td>
            <td><%= log.getCreateAt() %></td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
</body>
<script>
    $(document).ready(function() {
        $('#log-table').DataTable();
    });
</script>
<style>
    .INFO {
        background-color: lightskyblue;
        padding: 10px 20px;
    }

    .ALERT {
        background-color: darkorange;
        padding: 10px 20px;
    }

    .DANGER {
        background-color: orangered;
        padding: 10px 20px;
    }

    .WARNING {
        background-color: peachpuff;
        padding: 10px 20px;
    }
</style>
</html>
