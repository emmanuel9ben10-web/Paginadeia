<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Plataforma IA - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background:#0a0a0f; background-image: radial-gradient(ellipse at 20% 20%, #2d1f5e 0%, transparent 50%), radial-gradient(ellipse at 80% 80%, #1a0f3d 0%, transparent 50%); min-height:100vh; }
        .card { background:linear-gradient(145deg,#16162a,#1e1e38); border:1px solid #3d3060; border-radius:16px; }
        .form-control { background:#0e0e20; border-color:#3d3060; color:#e2d9ff; }
        .form-control:focus { background:#13132a; border-color:#7c3aed; box-shadow:0 0 0 3px #7c3aed22; color:#e2d9ff; }
        .form-control::placeholder { color:#4a4070; }
        .btn-morado { background:linear-gradient(135deg,#7c3aed,#4f46e5); border:none; color:white; }
        .btn-outline-morado { background:transparent; border:1px solid #3d3060; color:#a78bfa; }
        label { color:#a78bfa; font-size:12px; text-transform:uppercase; letter-spacing:.5px; }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center align-items-center" style="min-height:100vh">
    <div class="card p-4 col-md-4">
        <h5 class="text-center fw-bold mb-1" style="color:#e2d9ff">🧠 Plataforma IA</h5>
        <p class="text-center small mb-3" style="color:#8b7fc4">Inicia sesión para continuar</p>

        <% String error = request.getParameter("error");
           if("1".equals(error)){ %>
            <div class="alert alert-danger py-2 small">Correo o contraseña incorrectos</div>
        <% } else if("2".equals(error)){ %>
            <div class="alert alert-danger py-2 small">Error del servidor. Intenta de nuevo.</div>
        <% } %>
        <% if("1".equals(request.getParameter("registrado"))){ %>
            <div class="alert alert-success py-2 small">Cuenta creada. Inicia sesión.</div>
        <% } %>

        <form action="login.jsp" method="post">
            <label>Correo</label>
            <input type="email" name="correo" class="form-control mb-3" placeholder="tucorreo@email.com" required>
            <label>Contraseña</label>
            <input type="password" name="password" class="form-control mb-3" placeholder="••••••••" required>
            <button type="submit" class="btn btn-morado w-100 py-2">Iniciar sesión</button>
        </form>
        <hr style="border-color:#2a2040">
        <a href="registro.jsp" class="btn btn-outline-morado w-100">Crear cuenta</a>
    </div>
</div>
</body>
</html>