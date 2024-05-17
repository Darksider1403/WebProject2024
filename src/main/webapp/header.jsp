<%@ page import="Model.Account" %>
<%@ page import="Model.Slider" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.ShoppingCart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
<%
    String content = request.getAttribute("content") == null ? "" : request.getAttribute("content").toString();
%>
<div id="header">
    <div class="container">
        <nav>
            <ul class="list-item">
                <li class="item">Trang chủ</li>
                <li class="item">Sản phẩm</li>
            </ul>

            <div class="header-contain__search">
                <input oninput="searchProduct(this)" value="<%=content%>" class="header__search" name = "search" placeholder="Tìm kiếm sản phẩm" type="text">
                <i class="fa-solid fa-magnifying-glass"></i>
                <div id="header-contain__display-product">
                    <ul id="header__list-products">

                    </ul>
                </div>
            </div>

            <div class="header-contain__method">
                <a href="" class="header_cart"><i class="fa fa-fw fa-cart-arrow-down text-dark mr-1"></i></a>
                <a href="" class="header__login"><i class="fa fa-fw fa-user text-dark mr-3"></i></a>
            </div>
        </nav>
    </div>
</div>
</body>

<script>
    function searchProduct(input) {
        let content = input.value;
        let displaySearch = document.getElementById("header-contain__display-product");
        if (content.isEmpty()) {
            console.log("1")
            displaySearch.style.display = "none"
        } else {
            displaySearch.style.display = "block"
        }
        $.ajax({
            url: "search",
            type: "POST",
            data: {
                content: content
            },
            success: function (data) {
                let listProduct = document.getElementById("header__list-products");
                listProduct.innerHTML = data;
            }
        })
    }
</script>
</html>

