<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Shopping Girl - Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
    :root {
        --rosa: #f472b6;
        --rosa-hover: #ec4899;
        --lila: #a78bfa;
        --fondo: #fff7fb;
        --blanco: #ffffff;
        --texto: #3b2f46;
        --texto-secundario: #7c6f87;
        --borde: #f3d7e6;
        --error-fondo: #ffe4e6;
        --error-texto: #be123c;
        --sombra: 0 12px 35px rgba(164, 116, 171, 0.18);
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
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 24px;
    }

    .login-container {
        width: 100%;
        max-width: 420px;
        background: var(--blanco);
        border: 1px solid rgba(243, 215, 230, 0.8);
        border-radius: var(--radio);
        box-shadow: var(--sombra);
        padding: 36px 32px;
    }

    .brand {
        text-align: center;
        margin-bottom: 28px;
    }

    .brand h1 {
        font-size: 2rem;
        color: var(--texto);
        margin-bottom: 8px;
        font-weight: 700;
        letter-spacing: 0.5px;
    }

    .brand p {
        color: var(--texto-secundario);
        font-size: 0.95rem;
    }

    .brand .accent {
        color: var(--rosa);
    }

    .form-group {
        margin-bottom: 18px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        color: var(--texto);
        font-weight: 600;
        font-size: 0.95rem;
    }

    input[type="email"],
    input[type="password"] {
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

    input[type="email"]:focus,
    input[type="password"]:focus {
        border-color: var(--lila);
        box-shadow: 0 0 0 4px rgba(167, 139, 250, 0.15);
    }

    input::placeholder {
        color: #b6a8bf;
    }

    .btn-login {
        width: 100%;
        padding: 14px;
        border: none;
        border-radius: 12px;
        background: linear-gradient(90deg, var(--rosa), var(--lila));
        color: white;
        font-size: 1rem;
        font-weight: 700;
        cursor: pointer;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
        margin-top: 8px;
    }

    .btn-login:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(244, 114, 182, 0.22);
    }

    .mensaje-error {
        margin-top: 18px;
        padding: 12px 14px;
        border-radius: 12px;
        background-color: var(--error-fondo);
        color: var(--error-texto);
        font-size: 0.92rem;
        text-align: center;
        border: 1px solid #fecdd3;
    }

    .footer-text {
        margin-top: 22px;
        text-align: center;
        font-size: 0.85rem;
        color: var(--texto-secundario);
    }

    @media (max-width: 480px) {
        .login-container {
            padding: 28px 22px;
        }

        .brand h1 {
            font-size: 1.7rem;
        }
    }
</style>
</head>
<body>

    <div class="login-container">
        <div class="brand">
            <h1>Shopping <span class="accent">Girl</span></h1>
            <p>Bienvenida, inicia sesión para continuar</p>
        </div>

        <form action="LoginController" method="post">
            <div class="form-group">
                <label for="correo">Correo</label>
                <input type="email" id="correo" name="correo" placeholder="Ingresa tu correo" required>
            </div>

            <div class="form-group">
                <label for="clave">Clave</label>
                <input type="password" id="clave" name="clave" placeholder="Ingresa tu contraseña" required>
            </div>

            <button type="submit" class="btn-login">Ingresar</button>
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

        <div class="footer-text">
            Sistema de acceso de Shopping Girl
        </div>
    </div>

</body>
</html>