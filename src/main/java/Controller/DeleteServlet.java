package Controller;

import Model.CartItems;
import Model.ShoppingCart;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import com.google.gson.Gson;
import org.json.JSONObject;

@WebServlet(name = "DeleteServlet", value = "/DeleteServlet")
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ShoppingCart gioHang = (ShoppingCart) req.getSession().getAttribute("cart");
        List<CartItems> sanPhams = gioHang.getDanhSachSanPham();
        String masanpham = req.getParameter("masanpham").trim();
        JSONObject jsonResponse = new JSONObject();

        for (CartItems sp : sanPhams) {
            if (sp.getProduct().getId().equals(masanpham)) {
                gioHang.remove(masanpham);
            }
        }
        req.getSession().setAttribute("cart", gioHang);

        jsonResponse.put("cartSize", gioHang.getSize());
        jsonResponse.put("sanPhams", sanPhams);


        resp.setContentType("application/json");
        resp.getWriter().write(jsonResponse.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
