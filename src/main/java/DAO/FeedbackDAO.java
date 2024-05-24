package DAO;


import Model.Account;
import Model.Comment;
import Service.AccountService;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.PreparedBatch;

import java.nio.charset.StandardCharsets;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;


public class FeedbackDAO {
    private static Jdbi JDBI;

    public static int saveCommentFeedback(String content, String productId, int idAccount) {
        String SAVE_FEEDBACK_SQL = "INSERT INTO reviews (content, dateComment, idProduct, idAccount) VALUES (?, ?, ?, ?)";
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
        String GET_COMMENTS_SQL = "SELECT content, dateComment, idAccount FROM reviews WHERE idProduct = ?";
        JDBI = ConnectJDBI.connector();
        List<Comment> comments = JDBI.withHandle(handle ->
                handle.createQuery(GET_COMMENTS_SQL)
                        .bind(0, productId)
                        .mapToBean(Comment.class).stream().toList()
        );

        AccountService as = AccountService.getInstance();
        for (Comment comment : comments) {
            comment.setAccount(as.getAccountByAccountId(comment.getIdAccount()));
        }
        System.out.println("Number of comments retrieved: " + comments.size());

        return comments;
    }

    public static int getTotalNumberOfComments() {
        String GET_TOTAL_COMMENTS_SQL = "SELECT COUNT(*) as total FROM reviews";

        JDBI = ConnectJDBI.connector();
        int totalComments = JDBI.withHandle(handle ->
                handle.createQuery(GET_TOTAL_COMMENTS_SQL)
                        .mapTo(Integer.class)
                        .one()
        );

        return totalComments;
    }
    public static void main(String[] args) {
//        System.out.println(getCommentsByProductId("Tl001").get(2).getAccount().getID());
    }
}


