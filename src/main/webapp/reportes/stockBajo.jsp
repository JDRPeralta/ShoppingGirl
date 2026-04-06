<%@ page import="java.util.List" %>
<%@ page import="org.ShoppingGirl.bean.entity.Producto" %>
<%@ page import="org.ShoppingGirl.bean.entity.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/LoginController");
        return;
    }

    List<Producto> lista = (List<Producto>) request.getAttribute("listaStockBajo");
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Reporte Stock Bajo - Shopping Girl</title>
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
        --warning-bg: #fff1f2;
        --warning-text: #be123c;
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
        max-width: 1150px;
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
        min-width: 820px;
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

    .stock-bajo {
        display: inline-block;
        padding: 6px 10px;
        border-radius: 999px;
        background: var(--warning-bg);
        color: var(--warning-text);
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
    }
</style>
</head>
<body>

    <div class="container">
        <div class="topbar">
            <h1>Shopping <span class="accent">Girl</span></h1>
            <p>Módulo de reportes del sistema</p>
        </div>

        <div class="header-actions">
            <h2>Reporte de Stock Bajo</h2>
            <a href="<%=request.getContextPath()%>/inicio.jsp" class="btn btn-light">Volver al inicio</a>
        </div>

        <div class="table-card">
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Producto</th>
                            <th>Talla</th>
                            <th>Color</th>
                            <th>Stock</th>
                            <th>Proveedor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        if (lista != null && !lista.isEmpty()) {
                                                        for (Producto p : lista) {
                        %>
                        <tr>
                            <td><%= p.getIdProducto() %></td>
                            <td><span class="producto-nombre"><%= p.getNombre() %></span></td>
                            <td><%= p.getTalla() != null ? p.getTalla() : "" %></td>
                            <td><%= p.getColor() != null ? p.getColor() : "" %></td>
                            <td><span class="stock-bajo"><%= p.getStock() %></span></td>
                            <td><%= p.getNombreProveedor() %></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" class="empty-state">No hay productos con stock bajo.</td>
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