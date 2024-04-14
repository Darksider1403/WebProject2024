<%@ page import="DAO.ProductDAO" %>
<%@ page import="Model.Product" %>
<%@ page import="Service.ProductService" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="Model.Account" %>
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <link rel="stylesheet" href="css/productDetail.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<%
    //    String productId = (String) request.getAttribute("id");
    Account account = (Account) session.getAttribute("account");
    Double productRating = (Double) request.getAttribute("productRating");
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
        <div class="col-md-6 p-5 border">
            <% if (imageMap != null) { %>
            <div class="image-carousel">
                <ul class="image-list">
                    <% for (Map.Entry<String, String> entry : imageMap.entrySet()) { %>
                    <li>
                        <img src="<%= entry.getValue() %>" alt="" data-zoom-image="<%= entry.getValue() %>">
                    </li>
                    <% } %>
                </ul>
                <div class="image-display">
                    <%
                        String firstImageUrl = "";
                        if (!imageMap.isEmpty()) {
                            Map.Entry<String, String> firstEntry = imageMap.entrySet().iterator().next();

                            firstImageUrl = firstEntry.getValue();
                        }
                    %>
                    <img src="<%=firstImageUrl%>" id="main-image" alt="Main Image">

                </div>
            </div>
            <% } else { %>
            <p>No images found for this product.</p>
            <% } %>
        </div>

        <div class="col-md-6 p-5 border bg-white">
            <h2><%= selectedProduct.getName() %>
            </h2>
            <div class="d-flex flex-row my-3">
                <div class="text-warning mb-1 me-2">
                    <div class="rating-container">
    <span class="rating-stars">
        <% for (int i = 1; i <= Math.floor(productRating); i++) { %>
            <i class="fa fa-star text-primary"></i>
        <% } %>
        <% if (productRating % 1 > 0) { %>
            <i class="fas fa-star-half-alt text-primary"></i>
        <% } %>
        <% for (int i = (int) (Math.ceil(productRating) + 1); i <= 5; i++) { %>
            <i class="fa-regular fa-star"></i>
        <% } %>
    </span>
                        <span class="rating-value ms-1">
        <%= productRating %>
    </span>
                    </div>
                </div>
            </div>
            <p class="text-justify">Số lượng hàng: <%= selectedProduct.getQuantity() %>
            </p>
            <p class="price">Giá: <%= selectedProduct.getPrice() %>đ</p>
            <div class="product--size">
                <span>s</span>
                <span class="active">m</span>
                <span>l</span>
                <span>xl</span>
            </div>

            <div class="order">
                <form action="AddToCartServlet" method="post">
                    <a class="btn btn-primary btn-lg" href="AddToCartServlet?masanpham=<%=selectedProduct.getId()%>">
                        <i class="fas fa-cart-plus"></i>Thêm sản phẩm
                    </a>
                </form>
            </div>
        </div>

        <form id="feedbackForm" action="./submitFeedback" method="post">
            <div class="mb-3">
                <label for="feedbackText" class="form-label">Đánh giá sản phẩm:</label>
                <textarea class="form-control" id="feedbackText" rows="3" name="content"></textarea>
            </div>
            <input type="hidden" id="productId" name="productId" value="<%= selectedProduct.getId() %>">
            <input type="hidden" id="isLoggedIn" value="<%=(account != null) ? "true" : "false"%>">

            <button type="submit" class="btn btn-primary btn-lg" id="submitButton">Gửi phản hồi</button>

            <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="loginModalLabel">Vui lòng Đăng nhập</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>Bạn cần phải đăng nhập để gửi phản hồi.</p>
                        </div>
                        <div class="modal-footer">
                            <button id='closeModal' type="button" class="btn btn-danger" data-bs-dismiss="modal">Close
                            </button>
                            <a href="./login" class="btn btn-primary">Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
        <% } %>

</body>
<script src="https://use.fontawesome.com/releases/v6.4.2/js/all.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"
        integrity="sha512-HGOnQO9+SP1V92SrtZfjqxxtLmVzqZpjFFekvzZVWoiASSQgSr4cw9Kqd2+l8Llp4Gm0G8GIFJ4ddwZilcdb8A=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!--    Slider-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>

<script type="text/javascript">
    const sizes = jQuery(".product--size").find("span");
    sizes.click(function () {
        sizes.removeClass("active");
        $(this).addClass("active");
    });

    $(document).ready(function () {
        const imageCarousel = $('.image-carousel');
        const mainImage = $('#main-image');
        const imageDisplay = $('.image-display');

        imageCarousel.on('click', '.image-list li img', function (event) {
            const zoomImage = $(this).data('zoomImage');
            mainImage.attr('src', zoomImage);
            imageDisplay.addClass('active');
        });

        imageDisplay.on('click', function () {
            imageDisplay.removeClass('active');
            mainImage.attr('src', '');
        });
    });

    $(document).ready(function () {
        const thumbnails = $('.image-list li img');
        const mainImage = $('#main-image');
        const imageDisplay = $('.image-display');

        thumbnails.on('click', function (event) {
            const zoomImage = $(this).data('zoomImage');
            mainImage.attr('src', zoomImage);
            imageDisplay.addClass('active');
        });

        thumbnails.on('click', function (event) {
            const zoomImage = $(this).data('zoomImage');
            mainImage.attr('src', zoomImage);
            imageDisplay.addClass('active');

            // Add/remove active class for image indicators
            thumbnails.removeClass('active');
            $(this).addClass('active');
        });

        // Add click event listener to the main image to close the zoom
        imageDisplay.on('click', function () {
            imageDisplay.removeClass('active');
        });

        $(document).ready(function () {
            $('#submitButton').click(function (event) {
                const isLoggedIn = $('#isLoggedIn').val() === "true";
                if (!isLoggedIn) {
                    // Prevent form submission and show login modal
                    event.preventDefault();
                    $('#loginModal').modal('show');
                }
            });
        });
    });
</script>
</html>
