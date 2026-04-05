package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ClienteModel;
import service.ClienteService;

@WebServlet("/ClienteController")
public class ClienteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ClienteService clienteService = new ClienteService();

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
                request.setAttribute("listaClientes", clienteService.listar());
                request.getRequestDispatcher("/clientes/lista.jsp").forward(request, response);
                break;

            case "nuevo":
                request.getRequestDispatcher("/clientes/formulario.jsp").forward(request, response);
                break;

            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("cliente", clienteService.obtener(id));
                request.getRequestDispatcher("/clientes/formulario.jsp").forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                clienteService.eliminar(idEliminar);
                response.sendRedirect(request.getContextPath() + "/ClienteController?accion=listar");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/ClienteController?accion=listar");
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

        ClienteModel c = new ClienteModel();
        c.setNombre(request.getParameter("nombre"));
        c.setTelefono(request.getParameter("telefono"));

        if ("guardar".equals(accion)) {
            clienteService.registrar(c);
        } else if ("actualizar".equals(accion)) {
            c.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
            clienteService.actualizar(c);
        }

        response.sendRedirect(request.getContextPath() + "/ClienteController?accion=listar");
    }
}