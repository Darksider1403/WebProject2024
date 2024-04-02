<%@ page import="DAO.ProductDAO" %>
<%@ page import="Model.Product" %>
<%@ page import="Service.ProductService" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <title>Document</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css"
          integrity="sha512-17EgCFERpgZKcm0j0fEq1YCJuyAWdz9KUtv1EjVuaOz8pDnh/0nZxmU6BBXwaaxqoi9PQXnRWqlcDB027hgv9A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css"
          integrity="sha512-yHknP1/AwR+yx26cB1y0cjvQUMvEa2PFzt1c9LlS4pRQ5NOTZFWbhBig+X9G9eYW/8m0/4OXNx8pxJ6z57x0dw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/productDetail.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<%
    //    String productId = (String) request.getAttribute("id");
    ProductService productService = request.getAttribute("ps") == null ? ProductService.getInstance() : (ProductService) request.getAttribute("ps");

    Product selectedProduct = (Product) request.getAttribute("selectedProduct");
    Map<String, String> imageMap = productService.selectImageProductDetail(selectedProduct.getId());
%>
<% if (selectedProduct != null) { %>
<ol class="page-breadcrumb breadcrumb__list">
    <li><a href="./home" class="breadcrumb__item">Trang chủ</a></li>
    <li><a href="" class="breadcrumb__item"><%= selectedProduct.getId() %>
    </a></li>
</ol>

<div class="container p-3">
    <div class="row">
        <div class="col-md-6 p-5 border bg-white">
            <%
                if (imageMap != null) {
                    for (Map.Entry<String, String> entry : imageMap.entrySet()) {
            %>
            <img src="<%= entry.getValue() %>" alt="Product Image"> <%
            }
        } else {
        %>
            <p>No images found for this product.</p>
            <%
                }
            %>
            <%--                    <p class="product-title">--%>
            <%--                        <%= product.getName().length() > 20 ? product.getName().substring(0, 20) + "..." : product.getName() %>--%>
            <%--                    </p>--%>
        </div>
        <div class="col-md-6 p-5 border bg-white">
            <h2><%= selectedProduct.getName() %>
            </h2>
            <p class="text-justify"><%= selectedProduct.getQuantity() %>
            </p>
            <p class="price">Giá: <%= selectedProduct.getPrice() %>đ</p>

            <div class="order">
                <form action="AddToCartServlet" method="post">
                    <a class="btn btn-success" href="AddToCartServlet?masanpham=<%=selectedProduct.getId()%>">
                        <i class="fa-solid fa-cart-shopping"></i>Add to cart
                    </a>
                </form>
            </div>

        </div>
    </div>
</div>

<% } else { %>
<p>Product not found!</p>
<% } %>

</body>
<script src="https://use.fontawesome.com/releases/v6.4.2/js/all.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"
        integrity="sha512-HGOnQO9+SP1V92SrtZfjqxxtLmVzqZpjFFekvzZVWoiASSQgSr4cw9Kqd2+l8Llp4Gm0G8GIFJ4ddwZilcdb8A=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</html>
