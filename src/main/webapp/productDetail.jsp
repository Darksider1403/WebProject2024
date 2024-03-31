<%@ page import="DAO.ProductDAO" %>
<%@ page import="Model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="Service.ProductService" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <title>Document</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/productDetail.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<%
    ProductService ps = request.getAttribute("ps") == null ? ProductService.getInstance() : (ProductService) request.getAttribute("ps");
//    Product selectedProduct = ps.findById(request.getParameter("id"));  // Use request.getParameter

    Map<String, String> listImageThumbnail = ps.selectImageThumbnail();
    List<Product> listProduct = request.getAttribute("listProduct") == null
            ? new ArrayList<>() : (List<Product>) request.getAttribute("listProduct");

    Product selectedProduct = (Product) request.getAttribute("selectedProduct");
    NumberFormat nf = NumberFormat.getInstance();
%>

<%--    <% if (selectedProduct != null) { %>--%>
<%--    <ol class="page-breadcrumb breadcrumb__list">--%>
<%--        <li><a href="./home" class="breadcrumb__item">Trang chủ</a></li>--%>
<%--        <li><a href="#" class="breadcrumb__item"><%= selectedProduct.getId() %>--%>
<%--        </a></li>--%>
<%--    </ol>--%>
<%--    <% } else { %>--%>
<%--    <p>Product not found!</p>--%>
<%--    <% } %>--%>

<%--<div class="container p-3">--%>
<%--    <div class="row">--%>
<%--        <div class="col-md-6 text-center p-5 border bg-white">--%>
<%--            <img alt="" src="./assets/images/product_img/<%=%>">--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<% if (selectedProduct != null) { %>

<ol class="page-breadcrumb breadcrumb__list">
    <li><a href="./home" class="breadcrumb__item">Trang chủ</a></li>
    <li><a href="#" class="breadcrumb__item"><%= selectedProduct.getId() %></a></li>
</ol>

<div class="container p-3">
    <div class="row">
        <div class="col-md-6 text-center p-5 border bg-white">
            <% for (Product product : listProduct) { %>
            <div class="product-item">
                <div class="product">
                    <a href="./productDetail.jsp"><img class="product-img"
                                                       src="<%=listImageThumbnail.get(product.getId())%>"
                                                       alt="<%= selectedProduct.getName() %>"></a>
                    <div class="product-container__tittle">
                        <p class="product-title"><%=product.getName()%>
                        </p>
                    </div>

                    <p class="product-price">Giá: <%=nf.format(product.getPrice())%>đ
                    </p>
                    <%--                            TODO : quan : Xem chi tiet san pham--%>
                    <a href="productDetail?id=<%= product.getId() %>" class="product-order">Xem chi tiết</a>
                </div>
            </div>
            <%}%>
        </div>
        <div class="col-md-6">
            <h2><%= selectedProduct.getName() %></h2>
            <p class="text-justify"><%= selectedProduct.getId_category() %></p>
            <p class="price">Giá: <%= selectedProduct.getPrice() %>đ</p>
        </div>
    </div>
</div>

<% } else { %>
<p>Product not found!</p>
<% } %>

</body>
</html>
