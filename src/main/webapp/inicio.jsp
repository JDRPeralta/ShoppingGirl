<%@ page import="org.ShoppingGirl.bean.entity.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("LoginController");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Shopping Girl - Inicio</title>
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
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 32px 20px;
    }

    .header {
        background: var(--blanco);
        border: 1px solid rgba(243, 215, 230, 0.8);
        border-radius: 22px;
        box-shadow: var(--sombra);
        padding: 28px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 20px;
        margin-bottom: 28px;
        flex-wrap: wrap;
    }

    .brand h1 {
        font-size: 2rem;
        color: var(--texto);
        margin-bottom: 8px;
    }

    .brand .accent {
        color: var(--rosa);
    }

    .brand p {
        color: var(--texto-secundario);
        font-size: 0.98rem;
    }

    .user-box {
        background: linear-gradient(135deg, #fdf2f8, #f3e8ff);
        border: 1px solid var(--borde);
        border-radius: 16px;
        padding: 16px 20px;
        min-width: 250px;
    }

    .user-box h3 {
        font-size: 1.1rem;
        margin-bottom: 6px;
        color: var(--texto);
    }

    .user-box p {
        color: var(--texto-secundario);
        font-size: 0.95rem;
    }

    .section-title {
        margin-bottom: 18px;
        font-size: 1.2rem;
        color: var(--texto);
        font-weight: 700;
    }

    .menu-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
        gap: 18px;
    }

    .menu-card {
        display: block;
        text-decoration: none;
        background: var(--blanco);
        border: 1px solid rgba(243, 215, 230, 0.85);
        border-radius: 18px;
        box-shadow: var(--sombra);
        padding: 22px 20px;
        transition: all 0.25s ease;
        color: var(--texto);
    }

    .menu-card:hover {
        transform: translateY(-4px);
        border-color: var(--lila);
        box-shadow: 0 14px 28px rgba(167, 139, 250, 0.18);
    }

    .menu-card h4 {
        font-size: 1.08rem;
        margin-bottom: 8px;
        color: var(--texto);
    }

    .menu-card p {
        font-size: 0.92rem;
        color: var(--texto-secundario);
        line-height: 1.5;
    }

    .menu-card.destacado {
        background: linear-gradient(135deg, #fdf2f8, #f3e8ff);
    }

    .logout-box {
        margin-top: 30px;
        text-align: center;
    }

    .btn-logout {
        display: inline-block;
        text-decoration: none;
        background: linear-gradient(90deg, var(--rosa), var(--lila));
        color: white;
        padding: 14px 28px;
        border-radius: 12px;
        font-weight: 700;
        transition: all 0.25s ease;
        box-shadow: 0 10px 20px rgba(244, 114, 182, 0.18);
    }

    .btn-logout:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 24px rgba(244, 114, 182, 0.25);
    }

    @media (max-width: 768px) {
        .header {
            flex-direction: column;
            align-items: flex-start;
        }

        .brand h1 {
            font-size: 1.7rem;
        }

        .user-box {
            width: 100%;
        }
    }
</style>
</head>
<body>

    <div class="container">

        <div class="header">
            <div class="brand">
                <h1>Shopping <span class="accent">Girl</span></h1>
                <p>Panel principal del sistema</p>
            </div>

            <div class="user-box">
                <h3>Bienvenido, <%= usuario.getNombres() %></h3>
                <p><strong>Rol:</strong> <%= usuario.getNombreRol() %></p>
            </div>
        </div>

        <h2 class="section-title">Módulos disponibles</h2>

        <div class="menu-grid">
            <a href="ProductoController?accion=listar" class="menu-card destacado">
                <h4>Productos</h4>
                <p>Administra el catálogo de productos registrados en el sistema.</p>
            </a>

            <a href="ProveedorController?accion=listar" class="menu-card">
                <h4>Proveedores</h4>
                <p>Consulta y gestiona la información de tus proveedores.</p>
            </a>

            <a href="ClienteController?accion=listar" class="menu-card">
                <h4>Clientes</h4>
                <p>Visualiza y administra la base de datos de clientes.</p>
            </a>

            <a href="VentaController" class="menu-card destacado">
                <h4>Registrar Venta</h4>
                <p>Procesa nuevas ventas de manera rápida y ordenada.</p>
            </a>

            <a href="ConsultaController?accion=productos" class="menu-card">
                <h4>Consulta Productos</h4>
                <p>Revisa la información detallada de los productos disponibles.</p>
            </a>

            <a href="ConsultaController?accion=ventas" class="menu-card">
                <h4>Consulta Ventas</h4>
                <p>Accede al historial y seguimiento de ventas realizadas.</p>
            </a>

            <a href="ReporteController?accion=stock" class="menu-card">
                <h4>Reporte Stock Bajo</h4>
                <p>Identifica productos con niveles de stock reducidos.</p>
            </a>

            <a href="ReporteController?accion=ventasMensuales" class="menu-card">
                <h4>Reporte Ventas Mensuales</h4>
                <p>Analiza el rendimiento mensual de las ventas del negocio.</p>
            </a>
        </div>

        <div class="logout-box">
            <a href="LogoutController" class="btn-logout">Cerrar sesión</a>
        </div>

    </div>

</body>
</html>