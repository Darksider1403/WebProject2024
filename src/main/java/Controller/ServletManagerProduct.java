package Controller;

import DAO.ProductDAO;
import Model.Product;
import Service.PaginationService;
import Service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletManagerProduct", value = "/managerProduct")
public class ServletManagerProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        ProductService ps = ProductService.getInstance();
        PaginationService paginationService = PaginationService.getInstance();
        String updateProduct = req.getParameter("updateProduct");
        String status = req.getParameter("status");
        String deleteProduct = req.getParameter("deleteProduct");
        String check = req.getParameter("check");
        if (deleteProduct != null && check != null) {
            if (ps.deleteProduct(deleteProduct) > 0) {
                req.setAttribute("notify", "Xóa sản phẩm thành công");
            } else {
                req.setAttribute("notify", "Xóa sản phẩm thất bại");
            }
        }
        if (updateProduct != null && status != null) {
            if (ps.updateProduct(updateProduct, Integer.parseInt(status)) > 0) {
                req.setAttribute("notify", "Thay đổi sản phẩm thành công");
            } else {
                req.setAttribute("notify", "Thay đổi sản phẩm thất bại");
            }
        }
        int totalProduct;
        List<Product> productList = ProductDAO.getProducts();
        req.setAttribute("deleteProduct", deleteProduct);
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("ManagerProduct.jsp").forward(req, resp);
    }
}
