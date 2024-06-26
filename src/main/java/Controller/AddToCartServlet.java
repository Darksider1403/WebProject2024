package Controller;

import Model.ShoppingCart;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AddToCartServlet", value = "/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("AddToCartServlet doPost method is called");
        HttpSession session = req.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (cart == null) cart = new ShoppingCart();
        String maSp = req.getParameter("masanpham");
        if (maSp != null && !maSp.isEmpty()) {
            cart.add(maSp);
            session.setAttribute("cart", cart);
        }
        resp.sendRedirect("home");
        System.out.println(cart.getSize());
    }
}
