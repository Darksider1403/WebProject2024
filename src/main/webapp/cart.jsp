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
    <title>Title</title>
    <link rel="stylesheet" href="css/cart.css">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="container">
    <div class="small-container cart-page">
        <table class="cart-table">
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
            <%
                NumberFormat nf = NumberFormat.getInstance();
                List<CartItems> sanPhams = (List<CartItems>) session.getAttribute("list-sp");
                double tongGiaTri = 0;
                Map<String, String> listImagesThumbnail = ProductService.getInstance().selectImageThumbnail();
                int stt=1;
                boolean checkValue = false;
                for (CartItems sp :sanPhams) {

            %>
            <td>
                <input type="checkbox" name="isChecked-<%= sp.getProduct().getId() %>" onclick="updateGrandTotal(this)" />
            </td>

            </td>
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
                        String productId =sp.getProduct().getId();
                        String imageSource = listImagesThumbnail.get(productId);
                    %>
                    <img src="<%=imageSource%>" alt="">
                </div>
            </td>
            <td>
                <div>
                    <p><%= sp.getProduct().getId() %></p>
                </div>
            </td>
            <td>
                <div class="cart-price">
                    <p><%= nf.format(sp.getProduct().getPrice()) %>đ</p>
                </div>
            </td>
            <td>
                <div class="change-quantity">
                    <a href="QuantityServlet?thuchien=tang&masanpham=<%= sp.getProduct().getId()%>" class="cart-btn-plus" style="font-size: 2.4rem; padding: 8px; border: 4px; cursor: pointer;">+</a>
                    <input type="number" value="<%= sp.getQuantity()%>" name="quantity" disabled>
                    <a href="QuantityServlet?thuchien=giam&masanpham=<%= sp.getProduct().getId()%>" class="cart-btn-minus" style="font-size: 2.4rem; padding: 8px;border: 4px; cursor: pointer; font-weight: 800;">-</a>
                </div>
            </td>
            <td class="totalPricePerItem"><%= nf.format(sp.getTotalPrice()) %>đ</td>
            <td>
                <a href="DeleteServlet?masanpham=<%=sp.getProduct().getId()%>">Xóa</a>
                <%--                <i class="fas fa-trash-alt"></i> <!-- Font Awesome trash icon -->--%>
                </a>
            </td>
            </tr>
            <%
                    tongGiaTri += sp.getTotalPrice();
                } // End of for loop
            %>
        </table>
        <!-- Other HTML content... -->
    </div>
    <div class="total-price">
        <table>
            <tr>
                <td>
                    Tổng số tiền
                </td>
                <td id="grandTotal"> <%= session.getAttribute("grandTotal") %>đ</td>
            </tr>
        </table>
    </div>
    <div class="buy-button-wraper">
        <a href="order.jsp" class="button-link">Mua</a>
    </div>
</div>
<div id="footerContainer">

</div>
<script>
    function updateGrandTotal(checkbox) {
        var productId = checkbox.name.split('-')[1]; // Extract product ID from checkbox name

        // AJAX request to servlet
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'UpdateGrandTotalServlet?productId=' + productId + '&checked=' + checkbox.checked, true);
        xhr.onload = function () {
            if (xhr.status === 200) {
                // Reload the page after successful update
                location.reload();
            }
        };
        xhr.send();
    }
</script>

</body>
</html>
