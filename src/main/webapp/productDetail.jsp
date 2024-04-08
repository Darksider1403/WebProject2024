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

    <link rel="stylesheet" href="css/productDetail.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<%
    //    String productId = (String) request.getAttribute("id");
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
                        <span class="image-indicator"></span>
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
                    <% for (int i = 1; i <= Math.floor(productRating); i++) { %>
                    <i class="fa fa-star"></i>
                    <% } %>
                    <% if (productRating % 1 > 0) { %>
                    <i class="fas fa-star-half-alt"></i>
                    <% } %>
                    <% for (int i = (int) (Math.ceil(productRating) + 1); i <= 5; i++) { %> <i class="fa-regular fa-star"></i>
                    <% } %>
                    <span class="ms-1">
            <%= productRating %>
        </span>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col-md-4 col-6">
                    <label class="mb-2">Size</label>
                    <label>
                        <select class="form-select border border-secondary" style="height: 35px;">
                            <option>Small</option>
                            <option>Medium</option>
                            <option>Large</option>
                        </select>
                    </label>
                </div>

                <div class="col-md-4 col-6 mb-3">
                    <label class="mb-2 d-block">Quantity</label>
                    <div class="input-group mb-3" style="width: 170px;">
                        <button class="btn btn-white border border-secondary px-3" type="button" id="button-addon1"
                                data-mdb-ripple-color="dark">
                            <i class="fas fa-minus"></i>
                        </button>
                        <input type="text" class="form-control text-center border border-secondary" placeholder="14"
                               aria-label="Example text with button addon" aria-describedby="button-addon1"/>
                        <button class="btn btn-white border border-secondary px-3" type="button" id="button-addon2"
                                data-mdb-ripple-color="dark">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>
                </div>
            </div>
            <a href="#" class="btn btn-warning shadow-0"> Buy now </a>
            <div class="order">
                <form action="AddToCartServlet" method="post">
                    <a class="btn btn-primary shadow-0"
                       href="AddToCartServlet?masanpham=<%=selectedProduct.getId()%>">
                        <i class="me-1 fa fa-shopping-basket"></i>Add to cart
                    </a>
                </form>
            </div>
            <a href="#" class="btn btn-light border border-secondary py-2 icon-hover px-3"> <i
                    class="me-1 fa fa-heart fa-lg"></i> Save </a>

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
    });
</script>
</html>
