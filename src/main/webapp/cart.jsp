<%@ page import="Model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="Model.ShoppingCart" %>
<%@ page import="Model.CartItems" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="Service.ProductService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="css/cart.css">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        .error-message {
            color: red;
            font-weight: bold;
            margin: 20px 0;
            padding: 10px;
            border: 1px solid red;
            background-color: #fdd;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="container">
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="error-message">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>
    <% if (request.getAttribute("message") != null) { %>
    <div class="error-message">
        <%= request.getAttribute("message") %>
    </div>
    <% } %>

    <div class="small-container cart-page">
        <table class="cart-table">
            <thead>
            <tr>
                <th scope="col"></th>
                <th scope="col">Stt</th>
                <th scope="col">Sản phẩm</th>
                <th scope="col"></th>
                <th scope="col">Mã sản phẩm</th>
                <th scope="col">Giá</th>
                <th scope="col">Số lượng</th>
                <th scope="col">Thành tiền</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <%
                NumberFormat nf = NumberFormat.getInstance();
                List<CartItems> sanPhams = (List<CartItems>) session.getAttribute("list-sp");
                double tongGiaTri = 0;
                Map<String, String> listImagesThumbnail = ProductService.getInstance().selectImageThumbnail();
                int stt = 1;
                for (CartItems sp : sanPhams) {
                    tongGiaTri += sp.getTotalPrice();
            %>
            <tr>
                <td><%= stt++ %></td>
                <td>
                    <div>
                        <p>
                            <%
                                String productName = sp.getProduct().getName();
                                if (productName.length() > 30) {
                                    String firstLine = productName.substring(0, 30);
                                    String remainingText = productName.substring(30);
                            %>
                            <%= firstLine %><br>
                            <%= remainingText %>
                            <%
                            } else {
                            %>
                            <%= productName %>
                            <%
                                }
                            %>
                        </p>
                    </div>
                </td>
                <td>
                    <div class="cart-info">
                        <%
                            String productId = sp.getProduct().getId();
                            String imageSource = listImagesThumbnail.get(productId);
                        %>
                        <img src="<%= imageSource %>" alt="">
                    </div>
                </td>
                <td><%= sp.getProduct().getId() %></td>
                <td><%= nf.format(sp.getProduct().getPrice()) %>đ</td>
                <td>
                    <a href="javascript:void(0)" onclick="updateCart('tang', '<%= sp.getProduct().getId() %>')" class="cart-btn-plus">+</a>
                    <input type="number" value="<%= sp.getQuantity() %>" name="quantity" disabled>
                    <a href="javascript:void(0)" onclick="updateCart('giam', '<%= sp.getProduct().getId() %>')" class="cart-btn-minus">-</a>
                </td>
                <td><%= nf.format(sp.getTotalPrice()) %>đ</td>
                <td><a href="javascript:void(0)" onclick="deleteFromCart('<%= sp.getProduct().getId() %>')">Xóa</a></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <div class="total-price">
        <table>
            <tr>
                <td>Tổng số tiền</td>
                <td id="grandTotal"><%= nf.format(tongGiaTri) %>đ</td>
            </tr>
        </table>
    </div>
    <form action="./CheckQuantityServlet" method="get">
        <div class="buy-button-wrapper">
            <button type="submit">Mua</button>
        </div>
    </form>
</div>

<div id="footerContainer"></div>

<script>
    // Define listImagesThumbnail as a JavaScript variable
    var listImagesThumbnail = {
        <%
            for (Map.Entry<String, String> entry : listImagesThumbnail.entrySet()) {
                String productId = entry.getKey();
                String imageUrl = entry.getValue();
        %>
        '<%= productId %>': '<%= imageUrl %>',
        <% } %>
    };

    // Now you can safely use listImagesThumbnail in your JavaScript functions
    function updateCart(action, productId) {
        $.ajax({
            url: './QuantityServlet',
            method: 'GET',
            data: { thuchien: action, masanpham: productId },
            success: function (response) {
                if (response) {
                    $('#cart-size').text(response.cartSize);
                    updateCartTable(response.sanPhams);
                    $('#grandTotal').text(response.totalPrice + 'đ');
                } else {
                    alert("Failed to update cart.");
                }
            }
        });
    }

    function deleteFromCart(productId) {
        $.ajax({
            url: './DeleteServlet',
            method: 'GET',
            data: { masanpham: productId },
            success: function (response) {
                if (response) {
                    $('#cart-size').text(response.cartSize);
                    updateCartTable(response.sanPhams);
                    $('#grandTotal').text(response.totalPrice + 'đ');
                } else {
                    alert("Failed to delete item from cart.");
                }
            }
        });
    }

    function updateCartTable(cartItems) {
        let cartTable = $('.cart-table tbody');
        cartTable.empty();
        let nf = new Intl.NumberFormat();
        let stt = 1;
        cartItems.forEach(function (sp) {
            let productName = sp.product.name;
            let image = listImagesThumbnail[sp.product.id];
            let productNameHtml = productName.length > 30
                ? productName.substring(0, 30) + '<br>' + productName.substring(30)
                : productName;
            let rowHtml = `
                <tr>
                    <td>${stt}</td>
                    <td>
                        <div>
                            <p>${productNameHtml}</p>
                        </div>
                    </td>
                    <td>
                        <div class="cart-info">
                            <img src="${image}" alt="">
                        </div>
                    </td>
                    <td>${sp.product.id}</td>
                    <td>${nf.format(sp.product.price)}đ</td>
                    <td>
                        <a href="javascript:void(0)" onclick="updateCart('tang', '${sp.product.id}')" class="cart-btn-plus">+</a>
                        <input type="number" value="${sp.quantity}" name="quantity" disabled>
                        <a href="javascript:void(0)" onclick="updateCart('giam', '${sp.product.id}')" class="cart-btn-minus">-</a>
                    </td>
                    <td>${nf.format(sp.totalPrice)}đ</td>
                    <td><a href="javascript:void(0)" onclick="deleteFromCart('${sp.product.id}')">Xóa</a></td>
                </tr>
            `;
            cartTable.append(rowHtml);
            stt++;
        });
    }
</script>

</body>
</html>
