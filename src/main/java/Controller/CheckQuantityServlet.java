package Controller;

import Model.CartItems;
import Model.ShoppingCart;
import Model.Product;
import Service.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

@WebServlet(name = "CheckQuantityServlet", value = "/CheckQuantityServlet")
public class CheckQuantityServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        ProductService productService = ProductService.getInstance();
        List<CartItems> cartItems = cart.getDanhSachSanPham();
        boolean allProductsAvailable = true;

        Iterator<CartItems> iterator = cartItems.iterator();
        while (iterator.hasNext()) {
            CartItems cartItem = iterator.next();
            String productId = cartItem.getProduct().getId();
            int requiredQuantity = cartItem.getQuantity();
            Product product = productService.findById(productId);

            if (product.getQuantity() < requiredQuantity) {
                iterator.remove();
                cart.remove(productId); // Remove the product from the cart
                allProductsAvailable = false;
                // Chuyển thông báo lỗi sang tiếng Việt và mã hóa URL
                String errorMessage = URLEncoder.encode("Sản phẩm với mã " + productId + " không đủ hàng và đã bị xóa khỏi giỏ hàng của bạn.", "UTF-8");
                resp.sendRedirect("CartServlet?errorMessage=" + errorMessage);
                return; // Thoát khỏi phương thức
            }
        }

        session.setAttribute("cart", cart); // Cập nhật giỏ hàng trong session

        if (allProductsAvailable) {
            resp.sendRedirect("order.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
