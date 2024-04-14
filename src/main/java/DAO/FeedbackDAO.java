package DAO;


import org.jdbi.v3.core.Jdbi;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;


public class FeedbackDAO {
    private static Jdbi JDBI;

    public static int saveCommentFeedback(String content, String productId, int idAccount) {
        String SAVE_FEEDBACK_SQL = "INSERT INTO reviews (content, date_comment, idProduct, idAccount) VALUES (?, ?, ?, ?)";
        String contentUTF8 = new String(content.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        LocalDate currentDate = LocalDate.now();
        JDBI = ConnectJDBI.connector();
        int execute = JDBI.withHandle(handle ->
                        handle.createUpdate(SAVE_FEEDBACK_SQL))
                .bind(0, contentUTF8)
                .bind(1, currentDate)
                .bind(2, productId)
                .bind(3, idAccount)
                .execute();

        return execute;
    }
}


