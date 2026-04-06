<%@ page import="org.ShoppingGirl.bean.entity.Proveedor" %>
<%@ page import="org.ShoppingGirl.bean.entity.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/LoginController");
        return;
    }

    Proveedor proveedor = (Proveedor) request.getAttribute("proveedor");
    boolean esEdicion = (proveedor != null);
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title><%= esEdicion ? "Editar Proveedor" : "Nuevo Proveedor" %></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
    :root {
        --rosa: #f472b6;
        --rosa-hover: #ec4899;
        --lila: #a78bfa;
        --lila-hover: #8b5cf6;
        --fondo: #fff7fb;
        --blanco: #ffffff;
        --texto: #3b2f46;
        --texto-secundario: #7c6f87;
        --borde: #f3d7e6;
        --sombra: 0 12px 35px rgba(164, 116, 171, 0.16);
        --radio: 18px;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        min-height: 100vh;
        background: linear-gradient(135deg, #fff7fb 0%, #fdf2f8 45%, #f3e8ff 100%);
        color: var(--texto);
        padding: 24px;
    }

    .container {
        max-width: 850px;
        margin: 0 auto;
    }

    .topbar {
        background: var(--blanco);
        border: 1px solid rgba(243, 215, 230, 0.8);
        border-radius: 22px;
        box-shadow: var(--sombra);
        padding: 24px 28px;
        margin-bottom: 24px;
    }

    .topbar h1 {
        font-size: 2rem;
        margin-bottom: 8px;
        color: var(--texto);
    }

    .topbar .accent {
        color: var(--rosa);
    }

    .topbar p {
        color: var(--texto-secundario);
        font-size: 0.96rem;
    }

    .card {
        background: var(--blanco);
        border: 1px solid rgba(243, 215, 230, 0.8);
        border-radius: 22px;
        box-shadow: var(--sombra);
        padding: 30px;
    }

    .card-header {
        margin-bottom: 24px;
    }

    .card-header h2 {
        font-size: 1.6rem;
        color: var(--texto);
        margin-bottom: 8px;
    }

    .card-header p {
        color: var(--texto-secundario);
        font-size: 0.95rem;
    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 18px 20px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
    }

    .form-group.full {
        grid-column: 1 / -1;
    }

    label {
        margin-bottom: 8px;
        color: var(--texto);
        font-weight: 600;
        font-size: 0.95rem;
    }

    input {
        width: 100%;
        padding: 14px 16px;
        border: 1px solid var(--borde);
        border-radius: 12px;
        outline: none;
        font-size: 0.95rem;
        color: var(--texto);
        background-color: #fff;
        transition: all 0.25s ease;
    }

    input:focus {
        border-color: var(--lila);
        box-shadow: 0 0 0 4px rgba(167, 139, 250, 0.15);
    }

    .actions {
        display: flex;
        gap: 14px;
        margin-top: 28px;
        flex-wrap: wrap;
    }

    .btn {
        display: inline-block;
        padding: 14px 24px;
        border-radius: 12px;
        text-decoration: none;
        font-weight: 700;
        font-size: 0.95rem;
        transition: all 0.25s ease;
        border: none;
        cursor: pointer;
    }

    .btn-primary {
        background: linear-gradient(90deg, var(--rosa), var(--lila));
        color: white;
        box-shadow: 0 10px 20px rgba(244, 114, 182, 0.18);
    }

    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 24px rgba(244, 114, 182, 0.24);
    }

    .btn-secondary {
        background: #f9eaf3;
        color: var(--texto);
        border: 1px solid var(--borde);
    }

    .btn-secondary:hover {
        background: #f6ddea;
    }

    @media (max-width: 768px) {
        .form-grid {
            grid-template-columns: 1fr;
        }

        .card {
            padding: 22px;
        }

        .topbar {
            padding: 22px;
        }

        .topbar h1 {
            font-size: 1.7rem;
        }
    }
</style>
</head>
<body>

    <div class="container">
        <div class="topbar">
            <h1>Shopping <span class="accent">Girl</span></h1>
            <p>Gestión de proveedores del sistema</p>
        </div>

        <div class="card">
            <div class="card-header">
                <h2><%= esEdicion ? "Editar Proveedor" : "Nuevo Proveedor" %></h2>
                <p>Completa la información del proveedor para registrarlo correctamente.</p>
            </div>

            <form action="<%= request.getContextPath() %>/ProveedorController" method="post">
                <input type="hidden" name="accion" value="<%= esEdicion ? "actualizar" : "guardar" %>">
                <input type="hidden" name="idProveedor" value="<%= esEdicion ? proveedor.getIdProveedor() : 0 %>">

                <div class="form-grid">
                    <div class="form-group full">
                        <label for="nombre">Nombre</label>
                        <input type="text" id="nombre" name="nombre" required
                               value="<%= esEdicion ? proveedor.getNombre() : "" %>">
                    </div>

                    <div class="form-group">
                        <label for="telefono">Teléfono</label>
                        <input type="text" id="telefono" name="telefono"
                               value="<%= esEdicion ? proveedor.getTelefono() : "" %>">
                    </div>

                    <div class="form-group">
                        <label for="pais">País</label>
                        <input type="text" id="pais" name="pais"
                               value="<%= esEdicion ? proveedor.getPais() : "" %>">
                    </div>
                </div>

                <div class="actions">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= request.getContextPath() %>/ProveedorController?accion=listar" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>

</body>
</html>