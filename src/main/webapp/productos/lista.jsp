<%@ page import="java.util.List" %>
<%@ page import="model.ProductoModel" %>
<%@ page import="model.UsuarioModel" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    UsuarioModel usuario = (UsuarioModel) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/LoginController");
        return;
    }

    List<ProductoModel> lista = (List<ProductoModel>) request.getAttribute("listaProductos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Productos - Shopping Girl</title>
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
        --danger: #ef4444;
        --danger-soft: #fff1f2;
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
        max-width: 1250px;
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

    .header-actions {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 16px;
        flex-wrap: wrap;
        margin-bottom: 20px;
    }

    .header-actions h2 {
        font-size: 1.5rem;
        color: var(--texto);
    }

    .action-buttons {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    .btn {
        display: inline-block;
        text-decoration: none;
        padding: 12px 18px;
        border-radius: 12px;
        font-weight: 700;
        font-size: 0.94rem;
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

    .btn-light {
        background: #f9eaf3;
        color: var(--texto);
        border: 1px solid var(--borde);
    }

    .btn-light:hover {
        background: #f6ddea;
    }

    .table-card {
        background: var(--blanco);
        border: 1px solid rgba(243, 215, 230, 0.8);
        border-radius: 22px;
        box-shadow: var(--sombra);
        overflow: hidden;
    }

    .table-responsive {
        width: 100%;
        overflow-x: auto;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        min-width: 1100px;
    }

    thead {
        background: linear-gradient(90deg, #fdf2f8, #f3e8ff);
    }

    th {
        padding: 16px 14px;
        text-align: left;
        font-size: 0.93rem;
        color: var(--texto);
        border-bottom: 1px solid var(--borde);
        white-space: nowrap;
    }

    td {
        padding: 14px;
        border-bottom: 1px solid #f7e4ee;
        color: var(--texto-secundario);
        font-size: 0.94rem;
        vertical-align: middle;
    }

    tbody tr:hover {
        background: #fff9fc;
    }

    .precio {
        font-weight: 600;
        color: var(--texto);
    }

    .stock-badge {
        display: inline-block;
        padding: 6px 10px;
        border-radius: 999px;
        background: #fce7f3;
        color: #9d174d;
        font-weight: 700;
        font-size: 0.85rem;
    }

    .acciones {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
    }

    .btn-sm {
        padding: 8px 12px;
        border-radius: 10px;
        font-size: 0.85rem;
        font-weight: 700;
        text-decoration: none;
        transition: all 0.25s ease;
    }

    .btn-edit {
        background: #ede9fe;
        color: #6d28d9;
    }

    .btn-edit:hover {
        background: #ddd6fe;
    }

    .btn-delete {
        background: var(--danger-soft);
        color: var(--danger);
    }

    .btn-delete:hover {
        background: #ffe4e6;
    }

    .empty-state {
        padding: 36px 20px;
        text-align: center;
        color: var(--texto-secundario);
        font-size: 1rem;
    }

    @media (max-width: 768px) {
        .topbar {
            padding: 22px;
        }

        .topbar h1 {
            font-size: 1.7rem;
        }

        .header-actions {
            flex-direction: column;
            align-items: flex-start;
        }

        .action-buttons {
            width: 100%;
        }
    }
</style>
</head>
<body>

    <div class="container">
        <div class="topbar">
            <h1>Shopping <span class="accent">Girl</span></h1>
            <p>Módulo de mantenimiento de productos</p>
        </div>

        <div class="header-actions">
            <h2>Lista de Productos</h2>

            <div class="action-buttons">
                <a href="<%= request.getContextPath() %>/inicio.jsp" class="btn btn-light">Volver al inicio</a>
                <a href="<%= request.getContextPath() %>/ProductoController?accion=nuevo" class="btn btn-primary">Nuevo producto</a>
            </div>
        </div>

        <div class="table-card">
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Talla</th>
                            <th>Color</th>
                            <th>Precio Compra</th>
                            <th>Precio Venta</th>
                            <th>Stock</th>
                            <th>Proveedor</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (lista != null && !lista.isEmpty()) {
                                for (ProductoModel p : lista) {
                        %>
                        <tr>
                            <td><%= p.getIdProducto() %></td>
                            <td><strong style="color:#3b2f46;"><%= p.getNombre() %></strong></td>
                            <td><%= p.getDescripcion() != null ? p.getDescripcion() : "" %></td>
                            <td><%= p.getTalla() != null ? p.getTalla() : "" %></td>
                            <td><%= p.getColor() != null ? p.getColor() : "" %></td>
                            <td class="precio">S/ <%= p.getPrecioCompra() %></td>
                            <td class="precio">S/ <%= p.getPrecioVenta() %></td>
                            <td><span class="stock-badge"><%= p.getStock() %></span></td>
                            <td><%= p.getNombreProveedor() %></td>
                            <td>
                                <div class="acciones">
                                    <a href="<%= request.getContextPath() %>/ProductoController?accion=editar&id=<%= p.getIdProducto() %>" class="btn-sm btn-edit">Editar</a>
                                    <a href="<%= request.getContextPath() %>/ProductoController?accion=eliminar&id=<%= p.getIdProducto() %>"
                                       class="btn-sm btn-delete"
                                       onclick="return confirm('¿Deseas eliminar este producto?')">Eliminar</a>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="10" class="empty-state">No hay productos registrados.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>