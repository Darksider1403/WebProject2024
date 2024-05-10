<%@ page import="Model.Order_detail" %>
<%@ page import="Service.OrderService" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Details</title>
  <!-- Include necessary CSS and JS here -->
</head>
<body>
<div class="container">
  <h1>Chi tiết đơn hàng</h1>
  <%
    String orderIdParam = request.getParameter("orderId");
    if (orderIdParam != null) {
      // Fetch order details based on orderIdParam using your OrderService
      List<Order_detail> orderDetails = OrderService.getInstance().showOrderDetail(orderIdParam);
  %>
  <table class="table">
    <thead>
    <tr>
      <th>ID Sản phẩm</th>
      <th>Số lượng</th>
      <th>Giá</th>
    </tr>
    </thead>
    <tbody>
    <% for (Order_detail detail : orderDetails) { %>
    <tr>
      <td><%= detail.getIdProduct() %></td>
      <td><%= detail.getQuantity() %></td>
      <td><%= detail.getPrice() %></td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <% } else { %>
  <p>Không tìm thấy chi tiết đơn hàng.</p>
  <% } %>
</div>
</body>
</html>
