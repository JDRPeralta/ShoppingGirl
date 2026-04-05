package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DetalleVentaModel;
import model.UsuarioModel;
import model.VentaModel;
import service.ClienteService;
import service.ProductoService;
import service.VentaService;

@WebServlet("/VentaController")
public class VentaController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private VentaService ventaService = new VentaService();
    private ClienteService clienteService = new ClienteService();
    private ProductoService productoService = new ProductoService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginController");
            return;
        }

        request.setAttribute("listaClientes", clienteService.listar());
        request.setAttribute("listaProductos", productoService.listar());
        request.getRequestDispatcher("/ventas/formulario.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginController");
            return;
        }

        UsuarioModel usuario = (UsuarioModel) sesion.getAttribute("usuario");

        VentaModel venta = new VentaModel();
        venta.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
        venta.setIdUsuario(usuario.getIdUsuario());
        venta.setTotal(Double.parseDouble(request.getParameter("total")));

        String[] productos = request.getParameterValues("idProducto");
        String[] cantidades = request.getParameterValues("cantidad");
        String[] precios = request.getParameterValues("precio");
        String[] subtotales = request.getParameterValues("subtotal");

        List<DetalleVentaModel> detalles = new ArrayList<>();

        if (productos != null) {
            for (int i = 0; i < productos.length; i++) {
                if (productos[i] == null || productos[i].isBlank()) {
                    continue;
                }

                DetalleVentaModel d = new DetalleVentaModel();
                d.setIdProducto(Integer.parseInt(productos[i]));
                d.setCantidad(Integer.parseInt(cantidades[i]));
                d.setPrecio(Double.parseDouble(precios[i]));
                d.setSubtotal(Double.parseDouble(subtotales[i]));
                detalles.add(d);
            }
        }

        venta.setDetalles(detalles);

        int resultado = ventaService.registrarVenta(venta);

        if (resultado > 0) {
            response.sendRedirect(request.getContextPath() + "/VentaController");
        } else {
            request.setAttribute("mensaje", "No se pudo registrar la venta");
            request.setAttribute("listaClientes", clienteService.listar());
            request.setAttribute("listaProductos", productoService.listar());
            request.getRequestDispatcher("/ventas/formulario.jsp").forward(request, response);
        }
    }
}