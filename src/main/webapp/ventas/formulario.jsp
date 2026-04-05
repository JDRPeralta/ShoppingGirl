<%@ page import="java.util.List" %>
<%@ page import="model.ClienteModel" %>
<%@ page import="model.ProductoModel" %>
<%@ page import="model.UsuarioModel" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    UsuarioModel usuario = (UsuarioModel) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/LoginController");
        return;
    }

    List<ClienteModel> listaClientes = (List<ClienteModel>) request.getAttribute("listaClientes");
    List<ProductoModel> listaProductos = (List<ProductoModel>) request.getAttribute("listaProductos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Registrar Venta - Shopping Girl</title>
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
        --danger: #ef4444;
        --danger-soft: #fff1f2;
        --error-fondo: #ffe4e6;
        --error-texto: #be123c;
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

    .card {
        background: var(--blanco);
        border: 1px solid rgba(243, 215, 230, 0.8);
        border-radius: 22px;
        box-shadow: var(--sombra);
        padding: 28px;
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 16px;
        flex-wrap: wrap;
        margin-bottom: 24px;
    }

    .card-header h2 {
        font-size: 1.6rem;
        color: var(--texto);
        margin-bottom: 6px;
    }

    .card-header p {
        color: var(--texto-secundario);
        font-size: 0.95rem;
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

    .btn-danger {
        background: var(--danger-soft);
        color: var(--danger);
    }

    .btn-danger:hover {
        background: #ffe4e6;
    }

    .form-section {
        margin-bottom: 24px;
    }

    .form-section label {
        display: block;
        margin-bottom: 8px;
        color: var(--texto);
        font-weight: 600;
        font-size: 0.95rem;
    }

    select,
    input[type="text"],
    input[type="date"],
    input[type="number"] {
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

    select:focus,
    input:focus {
        border-color: var(--lila);
        box-shadow: 0 0 0 4px rgba(167, 139, 250, 0.15);
    }

    .table-card {
        border: 1px solid rgba(243, 215, 230, 0.8);
        border-radius: 18px;
        overflow: hidden;
        background: #fff;
        margin-bottom: 18px;
    }

    .table-responsive {
        width: 100%;
        overflow-x: auto;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        min-width: 850px;
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

    .acciones-secundarias {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
        margin-bottom: 18px;
    }

    .total-box {
        display: flex;
        justify-content: flex-end;
        margin-top: 8px;
        margin-bottom: 22px;
    }

    .total-card {
        min-width: 260px;
        background: linear-gradient(135deg, #fdf2f8, #f3e8ff);
        border: 1px solid var(--borde);
        border-radius: 18px;
        padding: 18px;
    }

    .total-card label {
        display: block;
        margin-bottom: 8px;
        font-weight: 700;
        color: var(--texto);
    }

    .total-card input {
        font-weight: 700;
        background: #fff;
    }

    .form-actions {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    .mensaje-error {
        margin-top: 20px;
        padding: 12px 14px;
        border-radius: 12px;
        background-color: var(--error-fondo);
        color: var(--error-texto);
        font-size: 0.92rem;
        text-align: center;
        border: 1px solid #fecdd3;
    }

    @media (max-width: 768px) {
        .topbar {
            padding: 22px;
        }

        .topbar h1 {
            font-size: 1.7rem;
        }

        .card {
            padding: 22px;
        }

        .card-header {
            flex-direction: column;
            align-items: flex-start;
        }

        .total-box {
            justify-content: stretch;
        }

        .total-card {
            width: 100%;
            min-width: 100%;
        }
    }
</style>

<script>
function agregarFila() {
    const tbody = document.getElementById("detalleVentaBody");
    const fila = tbody.insertRow();

    fila.innerHTML =
        '<td>' +
            '<select name="idProducto" onchange="actualizarFila(this)" required>' +
                '<option value="">Seleccione</option>' +
                '<% if (listaProductos != null) { for (ProductoModel p : listaProductos) { %>' +
                    '<option value="<%= p.getIdProducto() %>" data-precio="<%= p.getPrecioVenta() %>">' +
                        '<%= p.getNombre() %> - Stock: <%= p.getStock() %>' +
                    '</option>' +
                '<% } } %>' +
            '</select>' +
        '</td>' +
        '<td><input type="number" step="0.01" name="precio" readonly></td>' +
        '<td><input type="number" name="cantidad" min="1" value="1" oninput="calcularFila(this)" required></td>' +
        '<td><input type="number" step="0.01" name="subtotal" readonly></td>' +
        '<td><button type="button" class="btn btn-danger" onclick="eliminarFila(this)">Quitar</button></td>';

    recalcularTotal();
}

function actualizarFila(select) {
    const fila = select.closest("tr");
    const precio = select.options[select.selectedIndex].getAttribute("data-precio") || 0;

    fila.querySelector('input[name="precio"]').value = parseFloat(precio).toFixed(2);
    calcularFila(fila.querySelector('input[name="cantidad"]'));
}

function calcularFila(inputCantidad) {
    const fila = inputCantidad.closest("tr");
    const precio = parseFloat(fila.querySelector('input[name="precio"]').value || 0);
    const cantidad = parseInt(inputCantidad.value || 0);

    fila.querySelector('input[name="subtotal"]').value = (precio * cantidad).toFixed(2);
    recalcularTotal();
}

function eliminarFila(boton) {
    const fila = boton.closest("tr");
    fila.remove();
    recalcularTotal();
}

function recalcularTotal() {
    let total = 0;
    const subtotales = document.getElementsByName("subtotal");

    for (let i = 0; i < subtotales.length; i++) {
        total += parseFloat(subtotales[i].value || 0);
    }

    document.getElementById("totalVisible").value = total.toFixed(2);
    document.getElementById("total").value = total.toFixed(2);
}

window.onload = function () {
    recalcularTotal();
};
</script>
</head>
<body>

    <div class="container">
        <div class="topbar">
            <h1>Shopping <span class="accent">Girl</span></h1>
            <p>Módulo de registro de ventas</p>
        </div>

        <div class="card">
            <div class="card-header">
                <div>
                    <h2>Registrar Venta</h2>
                    <p>Selecciona el cliente y agrega los productos al detalle de venta.</p>
                </div>

                <a href="<%= request.getContextPath() %>/inicio.jsp" class="btn btn-light">Volver al inicio</a>
            </div>

            <form action="<%= request.getContextPath() %>/VentaController" method="post">
                <div class="form-section">
                    <label for="idCliente">Cliente</label>
                    <select name="idCliente" id="idCliente" required>
                        <option value="">Seleccione</option>
                        <%
                            if (listaClientes != null) {
                                for (ClienteModel c : listaClientes) {
                        %>
                        <option value="<%= c.getIdCliente() %>"><%= c.getNombre() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="acciones-secundarias">
                    <button type="button" class="btn btn-light" onclick="agregarFila()">Agregar producto</button>
                </div>

                <div class="table-card">
                    <div class="table-responsive">
                        <table id="detalleVenta">
                            <thead>
                                <tr>
                                    <th>Producto</th>
                                    <th>Precio</th>
                                    <th>Cantidad</th>
                                    <th>Subtotal</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody id="detalleVentaBody">
                                <tr>
                                    <td>
                                        <select name="idProducto" onchange="actualizarFila(this)" required>
                                            <option value="">Seleccione</option>
                                            <%
                                                if (listaProductos != null) {
                                                    for (ProductoModel p : listaProductos) {
                                            %>
                                            <option value="<%= p.getIdProducto() %>" data-precio="<%= p.getPrecioVenta() %>">
                                                <%= p.getNombre() %> - Stock: <%= p.getStock() %>
                                            </option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td><input type="number" step="0.01" name="precio" readonly></td>
                                    <td><input type="number" name="cantidad" min="1" value="1" oninput="calcularFila(this)" required></td>
                                    <td><input type="number" step="0.01" name="subtotal" readonly></td>
                                    <td><button type="button" class="btn btn-danger" onclick="eliminarFila(this)">Quitar</button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="total-box">
                    <div class="total-card">
                        <label for="totalVisible">Total</label>
                        <input type="number" step="0.01" id="totalVisible" readonly>
                        <input type="hidden" name="total" id="total" value="0">
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Registrar venta</button>
                    <a href="<%= request.getContextPath() %>/inicio.jsp" class="btn btn-light">Cancelar</a>
                </div>
            </form>

            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null && !mensaje.trim().isEmpty()) {
            %>
                <div class="mensaje-error">
                    <%= mensaje %>
                </div>
            <%
                }
            %>
        </div>
    </div>

</body>
</html>