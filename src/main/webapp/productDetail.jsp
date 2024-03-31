<%@ page import="DAO.ProductDAO" %>
<%@ page import="Model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="Service.ProductService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <title>Document</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/base.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<%
    List<Product> productListNam = request.getAttribute("listProduct") == null
            ? new ArrayList<>()
            : (List<Product>) request.getAttribute("listProduct");

    ProductService ps = request.getAttribute("ps") == null ? ProductService.getInstance() : (ProductService) request.getAttribute("ps");
    // Assuming you have a method to fetch a single product by ID:
    Product selectedProduct = ps.findById(request.getParameter("id"));  // Use request.getParameter
%>
<div class="container">
    <% if (selectedProduct != null) { %>
    <h1>Trang chủ / Xem chi tiết <%= selectedProduct.getId() %>
    </h1>
    <% } else { %>
    <p>Product not found!</p>
    <% } %>
</div>


</body>
</html>
