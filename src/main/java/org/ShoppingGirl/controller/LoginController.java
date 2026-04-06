package org.ShoppingGirl.controller;

import java.io.IOException;

import org.ShoppingGirl.bean.entity.Usuario;
import org.ShoppingGirl.model.UsuarioModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.ShoppingGirl.services.UsuarioServices;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UsuarioServices usuarioService = new UsuarioModel();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");

        Usuario usuario = usuarioService.login(correo, clave);

        if (usuario != null) {
            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuario", usuario);
            response.sendRedirect(request.getContextPath() + "/inicio.jsp");
        } else {
            request.setAttribute("mensaje", "Correo o contraseña incorrectos");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}