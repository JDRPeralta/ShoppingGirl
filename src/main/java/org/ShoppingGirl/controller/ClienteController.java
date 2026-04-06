package org.ShoppingGirl.controller;
import org.ShoppingGirl.bean.entity.Cliente;
import org.ShoppingGirl.model.ClienteModel;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.ShoppingGirl.services.ClienteServices;

@WebServlet("/ClienteController")

public class ClienteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
  //POLIMORFISMO------------------------------------------------
    private ClienteServices clienteServices = new ClienteModel();    
  //POLIMORFISMO------------------------------------------------
    
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
                request.setAttribute("listaClientes",clienteServices.listar());
                request.getRequestDispatcher("/clientes/lista.jsp").forward(request, response);
                break;

            case "nuevo":
                request.getRequestDispatcher("/clientes/formulario.jsp").forward(request, response);
                break;

            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("cliente", clienteServices.obtener(id));
                request.getRequestDispatcher("/clientes/formulario.jsp").forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                clienteServices.eliminar(idEliminar);
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

        Cliente c = new Cliente();
        c.setNombre(request.getParameter("nombre"));
        c.setTelefono(request.getParameter("telefono"));

        if ("guardar".equals(accion)) {
            clienteServices.registrar(c);
        } else if ("actualizar".equals(accion)) {
            c.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
            clienteServices.actualizar(c);
        }

        response.sendRedirect(request.getContextPath() + "/ClienteController?accion=listar");
    }
}