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
import java.sql.SQLException;
import java.util.List;

@WebServlet("/submitFeedback") // Maps to URL pattern "/submitFeedback"
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String content = request.getParameter("content");
        String productId = request.getParameter("productId");


        // Get user ID from session (assuming user ID is stored in session)
        HttpSession session = request.getSession(false); // Don't create a new session if not existing
        Account account = null;
        List<Comment> comments = null;
        int idAccount = 0;

        if (session != null) {
            account = (Account) session.getAttribute("account");
            if (account != null) {
                idAccount = account.getID(); // Access user ID from Account object
            }
        }

        // Call service to save comment (check for null userId)
        FeedbackAndRatingService feedbackService = FeedbackAndRatingService.getInstance();
        request.setAttribute("feedbackAndRatingService", feedbackService);
        int updateCount = feedbackService.saveCommentFeedback(content, productId, idAccount);
        if (updateCount > 0) {
            // Feedback saved successfully
            comments = feedbackService.getCommentsByProductId(productId);
            response.sendRedirect("./productDetail?id=" + productId); // Redirect to product detail with success message
        } else {
            response.sendRedirect("./productDetail?id=" + productId + "&feedbackError=true"); // Redirect to product detail with error message
        }

        request.setAttribute("comments", comments);
    }
}
