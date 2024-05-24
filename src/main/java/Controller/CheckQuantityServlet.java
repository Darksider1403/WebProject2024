package Controller;

import Model.CartItems;
import Model.ShoppingCart;
import Model.Product;
import Service.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

@WebServlet(name = "CheckQuantityServlet", value = "/CheckQuantityServlet")
public class CheckQuantityServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ShoppingCart cart = (ShoppingCart) req.getSession().getAttribute("cart");
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
                allProductsAvailable = false;
            }
        }

        if (allProductsAvailable) {
            resp.sendRedirect("order.jsp");
        } else {
            req.getSession().setAttribute("cart", cart);
            req.setAttribute("errorMessage", "Some products have insufficient stock and have been removed from your cart.");
            req.getRequestDispatcher("cart.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
