package Service;

import DAO.FeedbackDAO;

import java.io.UnsupportedEncodingException;

public class FeedbackAndRatingService {
    private static FeedbackAndRatingService instance;

    public static FeedbackAndRatingService getInstance() {
        if (instance == null) instance = new FeedbackAndRatingService();

        return instance;
    }

    public int saveCommentFeedback(String content, String productId, int idAccount) throws UnsupportedEncodingException {
        return FeedbackDAO.saveCommentFeedback(content, productId, idAccount);
    }
}
