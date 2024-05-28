<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Account" %>
<%@ page import="Service.ProductService" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="Model.Comment" %>
<%@ page import="Service.FeedbackAndRatingService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="./css/base.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="./css/admin.css">
</head>
<body>
<%
    Comment comment = request.getAttribute("comment") == null ? new Comment() : (Comment) request.getAttribute("comment");
    Account account = session.getAttribute("account") == null ? new Account() : (Account) session.getAttribute("account");
    String id = request.getAttribute("id") == null ? "" : request.getAttribute("id").toString();
    int totalComment = request.getAttribute("totalComment") == null ? 0 : (int) request.getAttribute("totalComment");
    int totalPage = request.getAttribute("totalPage") == null ? 0 : (int) request.getAttribute("totalPage");
    int pageCurrent = request.getAttribute("pageCurrent") == null ? 1 : Integer.parseInt(request.getAttribute("pageCurrent").toString());
    String search = request.getAttribute("search") == null ? "" : "&search=" + request.getAttribute("search").toString();
    List<Comment> commentList = request.getAttribute("commentList") == null ? new ArrayList<>() : (List<Comment>) request.getAttribute("commentList");
    FeedbackAndRatingService feedbackAndRatingService =
            request.getAttribute("ps") == null
                    ? FeedbackAndRatingService.getInstance()
                    : (FeedbackAndRatingService) request.getAttribute("feedbackAndRatingService");
    System.out.println(commentList.size());
    NumberFormat nf = NumberFormat.getInstance();
%>
<div id="id">
    <div id="admin">
        <div class="left">
            <div class="menu">
                <div class="menu-title">
                    <h2 class="shop-name">PLQ SHOP</h2>
                </div>
                <div class="shop-user">
                    <p>Xin chào, <%=account.getFullname()%>
                    </p>
                </div>
                <div class="menu-item">
                    <a href="./admin">
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
                    <a href="./managerOrder?page=1" class="active">
                        <div class="icon"><i class="fa-solid fa-clipboard"></i></div>
                        <p class="menu-content">Quản lý đơn hàng</p>
                    </a>
                </div>
                <div class="menu-item">
                    <a href="./managerComment?page=1" class="active">
                        <div class="icon"><i class="fa-solid fa-comment"></i></div>
                        <p class="menu-content">Quản lý bình luận</p>
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
                    <h2>Quản lý bình luận</h2>
                </div>
                <div class="manager">
                    <div class="manager-search">
                        <form action="./managerOrder" method="post">
                            <div class="search">
                                <input type="text" name="search" class="search" autocomplete="off"
                                       placeholder="Tìm kiếm">
                                <button type="submit" class="btn-search"><i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="manager-infor">
                        <table>
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên tài khoản</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Nội dung bình luận</th>
                                <th>Ngày bình luận</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% for (Comment c : commentList) {
                                String numberPhone = (account.getNumberPhone() != null
                                        && !account.getNumberPhone().isEmpty())
                                        ? account.getNumberPhone()
                                        : "Chưa cập nhật";

                                if (c.getStatus() == 0) {
                                    int status = feedbackAndRatingService.getStatusComment(account.getID());
                                    List<String> idProduct = feedbackAndRatingService.getProductId(account.getID());
                                    c.setStatus(status);
                                    c.setIdProduct(String.valueOf(idProduct));
                                }
                            %>
                            <tr>
                                <th><%=c.getId()%>
                                </th>
                                <th><%=account.getUsername()%>
                                </th>
                                <% System.out.println(c);%>
                                <th><%=account.getEmail()%>
                                </th>
                                <th><%=numberPhone%>
                                <th><%=c.getContent()%>
                                </th>
                                <th><%=c.getDateComment()%>
                                </th>
                                <th>
                                    <select class="status" name="status">
                                        <% if (c.getStatus() == 1) {%>
                                        <option value="1" selected>Ẩn bình luận</option>
                                        <option value="2">Bình thường</option>
                                        <%} else if (c.getStatus() == 2) {%>
                                        <option value="1">Ẩn bình luận</option>
                                        <option value="2" selected>Bình thường</option>
                                        <%}%>
                                    </select>
                                </th>
                                <th>
                                    <button type="submit" class="btn-repair">Lưu</button>
                                </th>
                            </tr>
                            <%}%>
                            </tbody>
                        </table>
                    </div>
                    <div class="pagination">
                        <% if (pageCurrent > 1) {%>
                        <a href="./managerComment?page=<%=pageCurrent-1%><%=search%>"
                           class="other-page previous-page"><span>Trước</span></a>
                        <%}%>

                        <% for (int i = 1; i <= totalPage; i++) {%>
                        <% if (i == pageCurrent) {%>
                        <a href="./managerComment?page=<%=i%><%=search%>" style="color: red;"
                           class="other-page"><span><%=i%></span></a>
                        <%} else {%>
                        <a href="./managerComment?page=<%=i%><%=search%>" class="other-page"><span><%=i%></span></a>
                        <%}%>
                        <%}%>
                        <% if (pageCurrent > 1 && pageCurrent < totalPage) {%>
                        <a href="./managerComment?page=<%=pageCurrent+1%><%=search%>"
                           class="other-page next-page"><span>Sau</span></a>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>

</script>
</html>