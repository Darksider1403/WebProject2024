<%@ page import="Model.Account" %>
<%@ page import="Model.Slider" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.ShoppingCart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/base.css">
    <!--    Font-->
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer">
</head>
<body>
<%
    Account account = (Account) session.getAttribute("account");
    List<Slider> sliders = (List<Slider>) request.getAttribute("slider");
    ShoppingCart gh = (ShoppingCart) session.getAttribute("cart");
    if (gh == null) gh = new ShoppingCart();
%>
<div id="header">
    <div class="container">
        <nav>
            <ul class="list-item">
                <li class="item"><a href="./home" class="linked-item">Trang chủ</a></li>
                <li class="item"><a href="./" class="linked-item">Sản phẩm</a></li>
            </ul>

            <div class="header-contain__search" style="display: none">
                <input class="header__search" name="search" placeholder="Tìm kiếm sản phẩm" type="text">
                <i class="fa-solid fa-magnifying-glass"></i>
                <div class="header-contain__display-product">
                    <ul class="list-products">
                        <li class="product-item">
                            <div class="product__infor">
                                <a href="">Đầu khóa thắt lưng Minh Tâm , kiểu khóa lăn trượt</a>
                                <span>139.000</span>
                            </div>
                            <a href="" class="product-img"><img src="./DK049(1).jpg" alt=""></a>
                        </li>
                        <li class="product-item">
                            <div class="product__infor">
                                <a href="">Đầu khóa thắt lưng Minh Tâm , kiểu khóa lăn trượt</a>
                                <span>139.000</span>
                            </div>
                            <a href="" class="product-img"><img src="./DK049(1).jpg" alt=""></a>
                        </li>
                        <li class="product-item">
                            <div class="product__infor">
                                <a href="">Đầu khóa thắt lưng Minh Tâm , kiểu khóa lăn trượt</a>
                                <span>139.000</span>
                            </div>
                            <a href="" class="product-img"><img src="./DK049(1).jpg" alt=""></a>
                        </li>
                        <li class="product-item">
                            <div class="product__infor">
                                <a href="">Đầu khóa thắt lưng Minh Tâm , kiểu khóa lăn trượt</a>
                                <span>139.000</span>
                            </div>
                            <a href="" class="product-img"><img src="./DK049(1).jpg" alt=""></a>
                        </li>
                        <li class="product-item">
                            <div class="product__infor">
                                <a href="">Đầu khóa thắt lưng Minh Tâm , kiểu khóa lăn trượt</a>
                                <span>139.000</span>
                            </div>
                            <a href="" class="product-img"><img src="./DK049(1).jpg" alt=""></a>
                        </li>
                        <li class="product-item">
                            <div class="product__infor">
                                <a href="">Đầu khóa thắt lưng Minh Tâm , kiểu khóa lăn trượt</a>
                                <span>139.000</span>
                            </div>
                            <a href="" class="product-img"><img src="./DK049(1).jpg" alt=""></a>
                        </li>
                        <li class="product-item">
                            <div class="product__infor">
                                <a href="">Đầu khóa thắt lưng Minh Tâm , kiểu khóa lăn trượt</a>
                                <span>139.000</span>
                            </div>
                            <a href="" class="product-img"><img src="./DK049(1).jpg" alt=""></a>
                        </li>

                    </ul>
                </div>
            </div>

            <div class="header-contain__method">
                <a href="./CartServlet" class="header_cart"><i class="fa fa-fw fa-cart-arrow-down mr-1"></i></a>
                <span class="position-absolute left-100 translate-middle badge bg-light text-dark" style="border-radius: 30rem !important;">
                    <%= gh.getSize() %>
                </span>
                <% if (session.getAttribute("account") == null) { %>
                <a class="nav-icon position-relative text-decoration-none header__login" href="./login">
                    <i class="fa fa-fw fa-user mr-3"></i>
                </a>
                <% } else { %>
                <a class="nav-icon position-relative text-decoration-none header__login" href="users-page.jsp">
                    <i class="fa fa-fw fa-user mr-3"></i>
                </a>
                <% } %>
            </div>
        </nav>
    </div>
</div>
</body>
</html>

