<%@ page import="Service.VoucherService" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Voucher" %>
<%@ page import="Model.Account" %>
<%@ page import="Service.AccountService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Voucher Management</title>
  <link rel="stylesheet" href="./css/base.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"/>
  <link rel="stylesheet" href="./css/admin.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
  <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
</head>
<%
  Account account = session.getAttribute("account") == null ? new Account() : (Account) session.getAttribute("account");
  List<Voucher> vouchers = VoucherService.getInstance().getVouchers();
%>
<body>
<div id="main">
  <div id="admin">
    <div class="left">
      <div class="menu">
        <div class="menu-title">
          <div class="logo">
            <a href="./home"><img src="./assets/logo.svg" alt=""></a>
          </div>
          <h2 class="shop-name"><a href="">PLQ SHOP</a></h2>
        </div>
        <div class="shop-user">
          <p>Xin chào, <%= account.getFullname() %></p>
        </div>
        <div class="menu-item">
          <a href="./admin" class="active">
            <div class="icon"><i class="fa-solid fa-house-chimney"></i></div>
            <p class="menu-content">Thống kê</p>
          </a>
        </div>
        <div class="menu-item">
          <a href="./managerAccount?page=1">
            <div class="icon"><i class="fa-solid fa-desktop"></i></div>
            <p class="menu-content">Quản lý tài khoản</p>
          </a>
        </div>
        <div class="menu-item">
          <a href="./managerProduct?page=1">
            <div class="icon"><i class="fa-regular fa-calendar-days"></i></div>
            <p class="menu-content">Quản lý sản phẩm</p>
          </a>
        </div>
        <div class="menu-item">
          <a href="./managerOrder?page=1">
            <div class="icon"><i class="fa-solid fa-clipboard"></i></div>
            <p class="menu-content">Quản lý đơn hàng</p>
          </a>
        </div>
        <div class="menu-item">
          <a href="/managerLog?page=1">
            <div class="icon"><i class="fa-solid fa-file-alt"></i></div>
            <p class="menu-content">Quản lý nhật ký</p>
          </a>
        </div>
        <div class="menu-item">
          <a href="./createVoucher?page=1">
            <div class="icon"><i class="fa-solid fa-gift"></i></div>
            <p class="menu-content">Quản lý Voucher</p>
          </a>
        </div>
        <div class="menu-item">
          <a href="./ServletLogOut">
            <p class="menu-content">Đăng xuất</p>
          </a>
        </div>
      </div>
    </div>
    <div class="right">
      <div class="contain">
        <div class="title">
          <h2>Quản lý Voucher</h2>
        </div>
        <div class="manager">
          <div class="manager-infor">
            <table id="myTable">
              <thead>
              <tr>
                <th scope="col">ID</th>
                <th scope="col">Tên Voucher</th>
                <th scope="col">Ngày bắt đầu</th>
                <th scope="col">Ngày kết thúc</th>
                <th scope="col">Giảm giá (%)</th>
              </tr>
              </thead>
              <tbody>
              <% for (Voucher voucher : vouchers) { %>
              <tr>
                <td><%= voucher.getId() %></td>
                <td><%= voucher.getName() %></td>
                <td><%= voucher.getDateStart() %></td>
                <td><%= voucher.getDateEnd() %></td>
                <td><%= voucher.getDiscount() %></td>
              </tr>
              <% } %>
              </tbody>
            </table>
          </div>
          <button class="btn-addProduct" onclick="openModal()">Thêm Voucher</button>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Modal thêm voucher -->
<div id="myModal" class="modal">
  <div class="modal-content">
    <div class="btn-close" onclick="closeModal()"><span class="close">&times;</span></div>
    <div class="modal-content__title"><h4>Thêm Voucher</h4></div>
    <form id="voucherForm" action="./createVoucher" method="post">
      <div class="modal-content__input">
        <div class="description"><span>Tên Voucher*: </span></div>
        <input type="text" name="name" autocomplete="off" required>
      </div>
      <div class="modal-content__input">
        <div class="description"><span>Ngày bắt đầu*: </span></div>
        <input type="date" name="dateStart" autocomplete="off" required>
      </div>
      <div class="modal-content__input">
        <div class="description"><span>Ngày kết thúc*: </span></div>
        <input type="date" name="dateEnd" autocomplete="off" required>
      </div>
      <div class="modal-content__input">
        <div class="description"><span>Giảm giá (%)*: </span></div>
        <input type="number" step="0.01" min="0" max="100" name="discount" autocomplete="off" required>
      </div>
      <button type="submit" class="btn-addProduct">Thêm Voucher</button>
    </form>
  </div>
</div>

<script>
  function openModal() {
    document.getElementById("myModal").style.display = "flex";
  }

  function closeModal() {
    document.getElementById("myModal").style.display = "none";
  }

  document.getElementById("voucherForm").addEventListener("submit", function(event) {
    // Prevent default form submission
    event.preventDefault();

    // Perform form submission via JavaScript
    this.submit();
  });

  $(document).ready(function() {
    $('#myTable').DataTable();
  });
</script>
</body>
</html>
