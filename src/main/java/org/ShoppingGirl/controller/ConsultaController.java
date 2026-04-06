package org.ShoppingGirl.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.ShoppingGirl.model.ProductoModel;
import org.ShoppingGirl.model.VentaModel;
import org.ShoppingGirl.services.ProductoServices;
import org.ShoppingGirl.services.VentaServices;

@WebServlet("/ConsultaController")
public class ConsultaController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductoServices productoService = new ProductoModel();
    private VentaServices ventaService = new VentaModel();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginController");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null) accion = "productos";

        if ("productos".equals(accion)) {
            String texto = request.getParameter("texto");
            if (texto == null) texto = "";

            request.setAttribute("listaConsultaProductos", productoService.consultar(texto));
            request.getRequestDispatcher("/consultas/productos.jsp").forward(request, response);

        } else if ("ventas".equals(accion)) {
            String fechaInicio = request.getParameter("fechaInicio");
            String fechaFin = request.getParameter("fechaFin");
            String cliente = request.getParameter("cliente");

            if (fechaInicio == null || fechaInicio.isBlank()) fechaInicio = "2000-01-01";
            if (fechaFin == null || fechaFin.isBlank()) fechaFin = "2100-12-31";
            if (cliente == null) cliente = "";

            request.setAttribute("listaConsultaVentas",
                    ventaService.consultarVentas(fechaInicio, fechaFin, cliente));

            request.getRequestDispatcher("/consultas/ventas.jsp").forward(request, response);
        }
    }
}