package Model;

import java.time.LocalDate;

public class Comment {

    private int id;
    private String content;
    private LocalDate dateComment;
    private String idProduct;
    private int idAccount;
    private Account account;
    private int status;

    public Comment() {
    }

    public Comment(int id, String content, LocalDate dateComment, String idProduct, int idAccount, Account account, int status) {
        this.id = id;
        this.content = content;
        this.dateComment = dateComment;
        this.idProduct = idProduct;
        this.idAccount = idAccount;
        this.account = account;
        this.status = status;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
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
                ", idProduct='" + idProduct + '\'' +
                ", idAccount=" + idAccount +
                ", account=" + account +
                ", status=" + status +
                '}';
    }
}
