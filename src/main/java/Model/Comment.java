package Model;

import java.time.LocalDate;

public class Comment {

    private int id;
    private String content;
    private LocalDate dateComment;
    private String idProduct;
    private int idAccount;
    private Account account;

    public Comment() {
        this.id = 0;
        this.content = "";
        this.dateComment = LocalDate.now();
        this.idProduct = "";
        this.idAccount = 0;
    }

    public Comment(int id, String content, LocalDate dateComment, String idProduct, int idAccount) {
        this.id = id;
        this.content = content;
        this.dateComment = dateComment;
        this.idProduct = idProduct;
        this.idAccount = idAccount;
    }

    public String getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(String idProduct) {
        this.idProduct = idProduct;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDate getDateComment() {
        return dateComment;
    }

    public void setDateComment(LocalDate dateComment) {
        this.dateComment = dateComment;
    }

    public int getIdAccount() {
        return idAccount;
    }

    public void setIdAccount(int idAccount) {
        this.idAccount = idAccount;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", dateComment=" + dateComment +
                ", idProduct=" + idProduct +
                ", idAccount=" + idAccount +
                '}';
    }
}
