package mx.edu.utez.sisgea.utility;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("*.jsp")
public class JspFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Redirigir a la página principal si intenta acceder a un JSP directamente
        httpRequest.getRequestDispatcher("/views/layout/error403.jsp").forward(request, response);
    }
}
