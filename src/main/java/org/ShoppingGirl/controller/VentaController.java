package org.ShoppingGirl.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.ShoppingGirl.bean.entity.DetalleVenta;
import org.ShoppingGirl.bean.entity.Usuario;
import org.ShoppingGirl.bean.entity.Venta;
import org.ShoppingGirl.model.ClienteModel;
import org.ShoppingGirl.model.ProductoModel;
import org.ShoppingGirl.model.VentaModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.ShoppingGirl.services.ClienteServices;
import org.ShoppingGirl.services.ProductoServices;
import org.ShoppingGirl.services.VentaServices;

@WebServlet("/VentaController")
public class VentaController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private VentaServices ventaService = new VentaModel();
    private ClienteServices clienteService = new ClienteModel();
    private ProductoServices productoService = new ProductoModel();

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

        Usuario usuario = (Usuario) sesion.getAttribute("usuario");

        Venta venta = new Venta();
        venta.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
        venta.setIdUsuario(usuario.getIdUsuario());
        venta.setTotal(Double.parseDouble(request.getParameter("total")));

        String[] productos = request.getParameterValues("idProducto");
        String[] cantidades = request.getParameterValues("cantidad");
        String[] precios = request.getParameterValues("precio");
        String[] subtotales = request.getParameterValues("subtotal");

        List<DetalleVenta> detalles = new ArrayList<>();

        if (productos != null) {
            for (int i = 0; i < productos.length; i++) {
                if (productos[i] == null || productos[i].isBlank()) {
                    continue;
                }

                DetalleVenta d = new DetalleVenta();
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