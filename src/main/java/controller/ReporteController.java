package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.ProductoService;
import service.VentaService;

@WebServlet("/ReporteController")
public class ReporteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductoService productoService = new ProductoService();
    private VentaService ventaService = new VentaService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginController");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null) accion = "stock";

        if ("stock".equals(accion)) {
            request.setAttribute("listaStockBajo", productoService.reporteStockBajo(5));
            request.getRequestDispatcher("/reportes/stockBajo.jsp").forward(request, response);

        } else if ("ventasMensuales".equals(accion)) {
            request.setAttribute("listaVentasMensuales", ventaService.reporteVentasMensuales());
            request.getRequestDispatcher("/reportes/ventasMensuales.jsp").forward(request, response);
        }
    }
}