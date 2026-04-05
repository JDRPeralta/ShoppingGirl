package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ProductoModel;
import service.ProductoService;
import service.ProveedorService;

@WebServlet("/ProductoController")
public class ProductoController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductoService productoService = new ProductoService();
    private ProveedorService proveedorService = new ProveedorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginController");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "listar":
                request.setAttribute("listaProductos", productoService.listar());
                request.getRequestDispatcher("/productos/lista.jsp").forward(request, response);
                break;

            case "nuevo":
                request.setAttribute("listaProveedores", proveedorService.listar());
                request.getRequestDispatcher("/productos/formulario.jsp").forward(request, response);
                break;

            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("producto", productoService.obtener(id));
                request.setAttribute("listaProveedores", proveedorService.listar());
                request.getRequestDispatcher("/productos/formulario.jsp").forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                productoService.eliminar(idEliminar);
                response.sendRedirect(request.getContextPath() + "/ProductoController?accion=listar");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/ProductoController?accion=listar");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginController");
            return;
        }

        String accion = request.getParameter("accion");

        ProductoModel p = new ProductoModel();
        p.setNombre(request.getParameter("nombre"));
        p.setDescripcion(request.getParameter("descripcion"));
        p.setTalla(request.getParameter("talla"));
        p.setColor(request.getParameter("color"));
        p.setPrecioCompra(Double.parseDouble(request.getParameter("precioCompra")));
        p.setPrecioVenta(Double.parseDouble(request.getParameter("precioVenta")));
        p.setStock(Integer.parseInt(request.getParameter("stock")));
        p.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));

        if ("guardar".equals(accion)) {
            productoService.registrar(p);
        } else if ("actualizar".equals(accion)) {
            p.setIdProducto(Integer.parseInt(request.getParameter("idProducto")));
            productoService.actualizar(p);
        }

        response.sendRedirect(request.getContextPath() + "/ProductoController?accion=listar");
    }
}