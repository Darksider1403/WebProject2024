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
import java.util.List;
import java.util.Map;

@WebServlet("/productDetail")
public class ProductDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productId = req.getParameter("id");
        System.out.println(productId);

        if (productId != null) {
//            List<Product> listProduct = ProductService.getInstance().findByCategory(0);

            Product selectedProduct = ProductService.getInstance().findById(productId);
            ProductService productService = ProductService.getInstance();

            resp.setContentType("text/html;charset=UTF-8");

            RequestDispatcher rd = req.getRequestDispatcher("/productDetail.jsp");
            req.setAttribute("selectedProduct", selectedProduct);
//            req.setAttribute("listProduct", listProduct);
            req.setAttribute("ps", productService);

            Map<String, String> listImagesThumbnail = ProductService.getInstance().selectImageProductDetail(productId);
            req.setAttribute("listImagesThumbnailForProductDetail", listImagesThumbnail);
            rd.forward(req, resp);
        } else {
            System.out.println("error");
        }
    }
}
