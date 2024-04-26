package DAO;


import Model.Comment;
import org.jdbi.v3.core.Jdbi;

import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.List;


public class FeedbackDAO {
    private static Jdbi JDBI;

    public static int saveCommentFeedback(String content, String productId, int idAccount) {
        String SAVE_FEEDBACK_SQL = "INSERT INTO reviews (content, date_comment, idProduct, idAccount) VALUES (?, ?, ?, ?)";
        String contentUTF8 = new String(content.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        LocalDate currentDate = LocalDate.now();
        JDBI = ConnectJDBI.connector();

        int execute = JDBI.withHandle(handle ->
                handle.createUpdate(SAVE_FEEDBACK_SQL)
                        .bind(0, contentUTF8)
                        .bind(1, currentDate)
                        .bind(2, productId)
                        .bind(3, idAccount)
                        .execute()
        );

        return execute;
    }

    public static List<Comment> getCommentsByProductId(String productId) {
        String GET_COMMENTS_SQL = "SELECT content, date_comment, idAccount FROM reviews WHERE idProduct = ?";
        JDBI = ConnectJDBI.connector();
        List<Comment> comments = JDBI.withHandle(handle ->
                handle.createQuery(GET_COMMENTS_SQL)
                        .bind(0, productId)
                        .mapToBean(Comment.class).stream().toList()
        );
        System.out.println("Number of comments retrieved: " + comments.size());

        return comments;
    }
}


