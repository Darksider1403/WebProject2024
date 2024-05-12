package Model;

public class UserGoogle {
    private String id;
    private String email;
    private String name;
    private boolean isVerified;

    public UserGoogle() {
    }

    public UserGoogle(String id, String email, String name, boolean isVerified) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.isVerified = isVerified;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isVerified() {
        return isVerified;
    }

    public void setVerified(boolean verified) {
        isVerified = verified;
    }

    @Override
    public String toString() {
        return "UserGoogle{" +
                "id='" + id + '\'' +
                ", email='" + email + '\'' +
                ", name='" + name + '\'' +
                ", isVerified=" + isVerified +
                '}';
    }
}
