package Filter;


import Model.Account;
import Service.AccountService;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin", "/managerAccount", "/manageProduct", "/manageOrder"})
public class AdminAccessFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String url = httpRequest.getServletPath();

        HttpSession session = httpRequest.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account.getRole() == 0) {
            int role;
            AccountService accountService = AccountService.getInstance();
            role = accountService.getRoleByAccountId(account.getID());
            account.setRole(role);
        }

        if (account.getRole() == 1) {
            if (url.endsWith("/admin")
                    || url.endsWith("/manageAccount")
                    || url.endsWith("/manageProduct")
                    || url.endsWith("/manageOrder")) {
                httpResponse.sendRedirect("/home");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }
}