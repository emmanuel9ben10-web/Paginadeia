<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%
    String accion = request.getParameter("accion");
    String error = null;
    String exito = null;

    if("guardar".equals(accion)){
        String nombre   = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo   = request.getParameter("correo");
        String password = request.getParameter("password");

        if(nombre == null || nombre.trim().isEmpty() || apellido == null || apellido.trim().isEmpty()){
            error = "Completa todos los campos.";
        } else if(correo == null || !correo.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")){
            error = "Ingresa un correo válido.";
        } else if(password == null || password.length() < 6){
            error = "La contraseña debe tener al menos 6 caracteres.";
        } else {
            try {
                st = conexion.prepareStatement("SELECT id FROM usuarios WHERE correo=?");
                st.setString(1, correo);
                rs = st.executeQuery();
                if(rs.next()){
                    error = "Ese correo ya está registrado. <a href='index.jsp' style='color:#a78bfa'>Inicia sesión</a>";
                } else {
                    st = conexion.prepareStatement(
                        "INSERT INTO usuarios(nombre,correo,password) VALUES(?,?,?)");
                    st.setString(1, nombre.trim() + " " + apellido.trim());
                    st.setString(2, correo.toLowerCase().trim());
                    st.setString(3, password);
                    st.executeUpdate();
                    exito = "Cuenta creada con éxito. <a href='index.jsp' style='color:#a78bfa'>Inicia sesión</a>";
                }
            } catch(Exception e) {
                error = "Error al registrar: " + e.getMessage();
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro - Plataforma IA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background:#0a0a0f; background-image: radial-gradient(ellipse at 10% 30%, #2d1f5e 0%, transparent 50%), radial-gradient(ellipse at 90% 70%, #1a0f3d 0%, transparent 50%); min-height:100vh; }
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
<div class="container d-flex justify-content-center align-items-center" style="min-height:100vh; padding:2rem 0">
    <div class="card p-4 col-md-5">
        <h5 class="text-center fw-bold mb-1" style="color:#e2d9ff">🧠 Crear cuenta</h5>
        <p class="text-center small mb-3" style="color:#8b7fc4">Únete a la plataforma</p>

        <% if(error != null){ %>
            <div class="alert alert-danger py-2 small"><%= error %></div>
        <% } %>
        <% if(exito != null){ %>
            <div class="alert alert-success py-2 small"><%= exito %></div>
        <% } else { %>
        <form action="registro.jsp?accion=guardar" method="post">
            <div class="row g-2 mb-2">
                <div class="col">
                    <label>Nombre</label>
                    <input type="text" name="nombre" class="form-control" placeholder="Tu nombre" required>
                </div>
                <div class="col">
                    <label>Apellido</label>
                    <input type="text" name="apellido" class="form-control" placeholder="Tu apellido" required>
                </div>
            </div>
            <label class="mt-2">Correo</label>
            <input type="email" name="correo" class="form-control mb-2" placeholder="tucorreo@email.com" required>
            <label class="mt-2">Contraseña</label>
            <input type="password" name="password" class="form-control mb-3" placeholder="••••••••" required>
            <button type="submit" class="btn btn-morado w-100 py-2">Crear cuenta</button>
        </form>
        <% } %>
        <hr style="border-color:#2a2040">
        <a href="index.jsp" class="btn btn-outline-morado w-100">Ya tengo cuenta</a>
    </div>
</div>
</body>
</html>