package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ProveedorModel;
import service.ProveedorService;

@WebServlet("/ProveedorController")
public class ProveedorController extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
                request.setAttribute("listaProveedores", proveedorService.listar());
                request.getRequestDispatcher("/proveedores/lista.jsp").forward(request, response);
                break;

            case "nuevo":
                request.getRequestDispatcher("/proveedores/formulario.jsp").forward(request, response);
                break;

            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("proveedor", proveedorService.obtener(id));
                request.getRequestDispatcher("/proveedores/formulario.jsp").forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                proveedorService.eliminar(idEliminar);
                response.sendRedirect(request.getContextPath() + "/ProveedorController?accion=listar");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/ProveedorController?accion=listar");
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

        ProveedorModel p = new ProveedorModel();
        p.setNombre(request.getParameter("nombre"));
        p.setTelefono(request.getParameter("telefono"));
        p.setPais(request.getParameter("pais"));

        if ("guardar".equals(accion)) {
            proveedorService.registrar(p);
        } else if ("actualizar".equals(accion)) {
            p.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));
            proveedorService.actualizar(p);
        }

        response.sendRedirect(request.getContextPath() + "/ProveedorController?accion=listar");
    }
}