package Controller;

import Model.Account;
import Model.Comment;
import Service.FeedbackAndRatingService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


@WebServlet("/submitFeedback")
public class FeedbackServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Do not create a new session if not existing

        if (session != null) {
            Account account = (Account) session.getAttribute("account");
            if (account != null) {
                String content = request.getParameter("content");
                String productId = request.getParameter("productId");
                int idAccount = account.getID();

                FeedbackAndRatingService feedbackService = FeedbackAndRatingService.getInstance();
                int updateCount = feedbackService.saveCommentFeedback(content, productId, idAccount);
                if (updateCount > 0) {
                    List<Comment> comments = feedbackService.getCommentsByProductId(productId);
                    request.setAttribute("comments", comments);
                    // Redirect the user to the product detail page with the updated comments
                    response.sendRedirect("./productDetail?id=" + productId);
                } else {
                    // Redirect to product detail with error message
                    response.sendRedirect("./productDetail?id=" + productId + "&feedbackError=true");
                }
            } else {
                // Handle the case where the user account is not available
                response.sendRedirect( "./login"); // Redirect the user to the login page
            }
        } else {
            // Handle the case where the session is not available
            response.sendRedirect(request.getContextPath() + "/errorPage"); // Redirect to an error page or handle the situation accordingly
        }
    }
}

