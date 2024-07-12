package DAO;

import DAO.LogDAO;
import Model.Log;
import Model.Log_Level;
import org.jdbi.v3.core.Jdbi;
import java.util.List;



public class LogDAOImp implements LogDAO {
    private static Jdbi JDBI;

    public LogDAOImp() {
        JDBI = ConnectJDBI.connector();
    }

    @Override
    public int add(Log log) {
        return JDBI.withHandle(handle ->
                handle.createUpdate("INSERT INTO log(ip, level, address, preValue, value) VALUES (?, ?, ?, ?, ?)")
                        .bind(0, log.getIp())
                        .bind(1, log.getLevel().toString())  // Use the integer value for LogLevel
                        .bind(2, log.getAddress())
                        .bind(3, log.getPreValue() != null ? log.getPreValue() : "")  // Ensure preValue is not null
                        .bind(4, log.getValue())
                        .execute());
    }

    @Override
    public List<Log> findAll() {
        return JDBI.withHandle(handle ->
                handle.createQuery("SELECT * FROM log")
                        .mapToBean(Log.class).list());
    }

    public static void main(String[] args) {
        LogDAO logDAO = new LogDAOImp();
        Log log = new Log();
//        log.setLevel(Log_Level.INFO);
//        log.setIp("192.168.1.1");
//        log.setAddress("user");
//        log.setPreValue("before");  // Ensure this value is valid according to the constraints
//        log.setValue("after");
//        logDAO.add(log);
        logDAO.findAll().forEach(System.out::println);
    }
}

