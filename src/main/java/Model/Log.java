package Model;

import java.time.LocalDateTime;

public class Log {
    private int id;
    private String ip;
    private int level;
    private String address;
    private String preValue;
    private String value;
    private LocalDateTime date;
    private String country;
    private int status;

    public Log() {

    }
    public Log(int id, String ip, int level, String address, String preValue, String value, LocalDateTime date, String country, int status) {
        this.id = id;
        this.ip = ip;
        this.level = level;
        this.address = address;
        this.preValue = preValue;
        this.value = value;
        this.date = date;
        this.country = country;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPreValue() {
        return preValue;
    }

    public void setPreValue(String preValue) {
        this.preValue = preValue;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
