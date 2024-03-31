package Controller;

import Model.Product;
import Service.ProductService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/productDetail")
public class ProductDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productId = req.getParameter("id");

        ProductService ps = ProductService.getInstance();
        Product selectedProduct = ps.findById(productId);

        resp.setContentType("text/html;charset=UTF-8");

        RequestDispatcher rd = req.getRequestDispatcher("/productDetail.jsp");
        req.setAttribute("selectedProduct", selectedProduct);
        rd.forward(req, resp);
    }
}
