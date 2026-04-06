<%@ page import="java.util.List" %>
<%@ page import="org.ShoppingGirl.bean.entity.Venta" %>
<%@ page import="org.ShoppingGirl.bean.entity.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/LoginController");
        return;
    }

    List<Venta> lista = (List<Venta>) request.getAttribute("listaConsultaVentas");

    String fechaInicio = request.getParameter("fechaInicio") != null ? request.getParameter("fechaInicio") : "";
    String fechaFin = request.getParameter("fechaFin") != null ? request.getParameter("fechaFin") : "";
    String cliente = request.getParameter("cliente") != null ? request.getParameter("cliente") : "";
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Consulta de Ventas - Shopping Girl</title>
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
        max-width: 1200px;
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
        display: grid;
        grid-template-columns: repeat(4, minmax(0, 1fr));
        gap: 14px;
        align-items: end;
    }

    .form-group {
        display: flex;
        flex-direction: column;
    }

    .form-group label {
        margin-bottom: 8px;
        color: var(--texto);
        font-weight: 600;
        font-size: 0.93rem;
    }

    .form-group input {
        width: 100%;
        padding: 14px 16px;
        border: 1px solid var(--borde);
        border-radius: 12px;
        outline: none;
        font-size: 0.95rem;
        color: var(--texto);
        background: #fff;
        transition: all 0.25s ease;
    }

    .form-group input:focus {
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
        min-width: 750px;
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

    .cliente-nombre {
        font-weight: 600;
        color: var(--texto);
    }

    .total-badge {
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

    @media (max-width: 900px) {
        .search-form {
            grid-template-columns: 1fr;
        }
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
            <p>Módulo de consulta de ventas</p>
        </div>

        <div class="header-actions">
            <h2>Consulta de Ventas</h2>
            <a href="<%=request.getContextPath()%>/inicio.jsp" class="btn btn-light">Volver al inicio</a>
        </div>

        <div class="search-card">
            <h3>Filtrar ventas</h3>
            <p>Busca por rango de fechas o por nombre del cliente.</p>

            <form action="<%=request.getContextPath()%>/ConsultaController" method="get" class="search-form">
                <input type="hidden" name="accion" value="ventas">

                <div class="form-group">
                    <label for="fechaInicio">Fecha inicio</label>
                    <input type="date" id="fechaInicio" name="fechaInicio" value="<%=fechaInicio%>">
                </div>

                <div class="form-group">
                    <label for="fechaFin">Fecha fin</label>
                    <input type="date" id="fechaFin" name="fechaFin" value="<%=fechaFin%>">
                </div>

                <div class="form-group">
                    <label for="cliente">Cliente</label>
                    <input type="text" id="cliente" name="cliente" value="<%=cliente%>" placeholder="Nombre del cliente">
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Buscar</button>
                </div>
            </form>
        </div>

        <div class="table-card">
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>ID Venta</th>
                            <th>Fecha</th>
                            <th>Cliente</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        if (lista != null && !lista.isEmpty()) {
                                                        for (Venta v : lista) {
                        %>
                        <tr>
                            <td><%= v.getIdVenta() %></td>
                            <td><%= v.getFecha() %></td>
                            <td><span class="cliente-nombre"><%= v.getNombreCliente() %></span></td>
                            <td><span class="total-badge">S/ <%= v.getTotal() %></span></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="4" class="empty-state">No se encontraron ventas.</td>
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