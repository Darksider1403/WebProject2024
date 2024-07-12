package Controller;

import DAO.LogDAO;
import DAO.LogDAOImp;
import Model.Log;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LogManager", value = "/LogManager")
public class LogManager extends HttpServlet {
    LogDAO logDAO = new LogDAOImp();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Log> logs = logDAO.findAll();
        for (Log log : logs) {
            System.out.println("Log ID: " + log.getId());
            System.out.println("Log Level: " + log.getLevel());
            System.out.println("Address: " + log.getAddress());
            System.out.println("IP: " + log.getIp());
            System.out.println("Pre Value: " + log.getPreValue());
            System.out.println("Value: " + log.getValue());
            System.out.println("Date: " + log.getCreateAt());
        }
        request.setAttribute("logs", logs);
        request.getRequestDispatcher("/logManager.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
