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

    List<ProductoModel> lista = (List<ProductoModel>) request.getAttribute("listaConsultaProductos");
    String texto = request.getParameter("texto") != null ? request.getParameter("texto") : "";
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Consulta de Productos - Shopping Girl</title>
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
        --danger-soft: #fff1f2;
        --success-soft: #fce7f3;
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

    .btn-light {
        background: #f9eaf3;
        color: var(--texto);
        border: 1px solid var(--borde);
    }

    .btn-light:hover {
        background: #f6ddea;
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

    .search-card {
        background: var(--blanco);
        border: 1px solid rgba(243, 215, 230, 0.8);
        border-radius: 22px;
        box-shadow: var(--sombra);
        padding: 24px;
        margin-bottom: 24px;
    }

    .search-card h3 {
        margin-bottom: 8px;
        font-size: 1.1rem;
        color: var(--texto);
    }

    .search-card p {
        color: var(--texto-secundario);
        font-size: 0.93rem;
        margin-bottom: 18px;
    }

    .search-form {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
        align-items: center;
    }

    .search-form input[type="text"] {
        flex: 1;
        min-width: 260px;
        padding: 14px 16px;
        border: 1px solid var(--borde);
        border-radius: 12px;
        outline: none;
        font-size: 0.95rem;
        color: var(--texto);
        background: #fff;
        transition: all 0.25s ease;
    }

    .search-form input[type="text"]:focus {
        border-color: var(--lila);
        box-shadow: 0 0 0 4px rgba(167, 139, 250, 0.15);
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
        min-width: 1050px;
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

    .producto-nombre {
        font-weight: 600;
        color: var(--texto);
    }

    .precio {
        font-weight: 700;
        color: var(--texto);
    }

    .stock-badge {
        display: inline-block;
        padding: 6px 10px;
        border-radius: 999px;
        background: var(--success-soft);
        color: #9d174d;
        font-weight: 700;
        font-size: 0.85rem;
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

        .search-form {
            flex-direction: column;
            align-items: stretch;
        }

        .search-form input[type="text"] {
            width: 100%;
            min-width: 100%;
        }
    }
</style>
</head>
<body>

    <div class="container">
        <div class="topbar">
            <h1>Shopping <span class="accent">Girl</span></h1>
            <p>Módulo de consulta de productos</p>
        </div>

        <div class="header-actions">
            <h2>Consulta de Productos</h2>
            <a href="<%= request.getContextPath() %>/inicio.jsp" class="btn btn-light">Volver al inicio</a>
        </div>

        <div class="search-card">
            <h3>Buscar productos</h3>
            <p>Filtra por nombre, talla o color.</p>

            <form action="<%= request.getContextPath() %>/ConsultaController" method="get" class="search-form">
                <input type="hidden" name="accion" value="productos">
                <input type="text" name="texto" value="<%= texto %>" placeholder="Escribe nombre, talla o color">
                <button type="submit" class="btn btn-primary">Buscar</button>
            </form>
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
                            <th>Precio Venta</th>
                            <th>Stock</th>
                            <th>Proveedor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (lista != null && !lista.isEmpty()) {
                                for (ProductoModel p : lista) {
                        %>
                        <tr>
                            <td><%= p.getIdProducto() %></td>
                            <td><span class="producto-nombre"><%= p.getNombre() %></span></td>
                            <td><%= p.getDescripcion() != null ? p.getDescripcion() : "" %></td>
                            <td><%= p.getTalla() != null ? p.getTalla() : "" %></td>
                            <td><%= p.getColor() != null ? p.getColor() : "" %></td>
                            <td class="precio">S/ <%= p.getPrecioVenta() %></td>
                            <td><span class="stock-badge"><%= p.getStock() %></span></td>
                            <td><%= p.getNombreProveedor() %></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" class="empty-state">No se encontraron resultados.</td>
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