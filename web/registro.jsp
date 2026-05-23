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
        @keyframes bgShift{0%{background-position:0% 50%}50%{background-position:100% 50%}100%{background-position:0% 50%}}
        @keyframes float{0%,100%{transform:translateY(0) translateX(0)}25%{transform:translateY(-20px) translateX(10px)}50%{transform:translateY(-10px) translateX(-10px)}75%{transform:translateY(-25px) translateX(15px)}}
        @keyframes pulse{0%,100%{opacity:.4}50%{opacity:.8}}
        @keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:-apple-system,BlinkMacSystemFont,sans-serif;min-height:100vh;display:flex;align-items:center;justify-content:center;background:linear-gradient(-45deg,#0a0a0f,#0f0520,#0a0f1a,#050510);background-size:400% 400%;animation:bgShift 12s ease infinite;overflow:hidden;position:relative}
        .bg-orb{position:fixed;border-radius:50%;pointer-events:none;filter:blur(80px);opacity:.3;animation:pulse 4s infinite}
        .bg-orb:nth-child(1){width:400px;height:400px;background:#7c3aed;top:-10%;left:-5%;animation-delay:0s}
        .bg-orb:nth-child(2){width:300px;height:300px;background:#4f46e5;bottom:-5%;right:-5%;animation-delay:1s}
        .bg-orb:nth-child(3){width:250px;height:250px;background:#2563eb;top:50%;left:60%;animation-delay:2s}
        .bg-orb:nth-child(4){width:200px;height:200px;background:#9333ea;top:20%;right:20%;animation-delay:.5s}
        .particle{position:fixed;width:3px;height:3px;background:rgba(167,139,250,.2);border-radius:50%;pointer-events:none}
        .particle:nth-child(5){top:15%;left:10%;animation:float 7s infinite}
        .particle:nth-child(6){top:75%;left:85%;animation:float 9s infinite 1s;width:2px;height:2px}
        .particle:nth-child(7){top:40%;left:70%;animation:float 8s infinite 2s;width:4px;height:4px}
        .particle:nth-child(8){top:85%;left:20%;animation:float 6s infinite .5s}
        .particle:nth-child(9){top:25%;left:50%;animation:float 10s infinite 3s;width:2px;height:2px}
        .particle:nth-child(10){top:60%;left:30%;animation:float 7s infinite 1.5s}
        .card{background:linear-gradient(145deg,rgba(22,22,42,.85),rgba(30,30,56,.85));border:1px solid rgba(61,48,96,.5);border-radius:20px;backdrop-filter:blur(20px);padding:2.2rem;width:100%;max-width:440px;animation:fadeUp .8s cubic-bezier(.4,0,.2,1);position:relative;overflow:hidden}
        .card::before{content:'';position:absolute;top:0;left:-100%;width:200%;height:2px;background:linear-gradient(90deg,transparent,#7c3aed,#4f46e5,transparent);animation:float 4s linear infinite}
        .form-control{background:rgba(14,14,32,.7);border:1px solid rgba(61,48,96,.5);border-radius:12px;color:#e2d9ff;padding:.75rem 1rem;font-size:14px;transition:all .3s}
        .form-control:focus{background:rgba(19,19,42,.8);border-color:#7c3aed;box-shadow:0 0 0 3px rgba(124,58,237,.15);color:#e2d9ff;outline:none}
        .form-control::placeholder{color:rgba(74,64,112,.6)}
        .btn-morado{background:linear-gradient(135deg,#7c3aed,#4f46e5);border:none;color:white;padding:.8rem;border-radius:12px;font-weight:600;font-size:14px;transition:all .3s}
        .btn-morado:hover{transform:translateY(-1px);box-shadow:0 8px 25px rgba(124,58,237,.3)}
        .btn-outline-morado{background:transparent;border:1px solid rgba(61,48,96,.6);color:#a78bfa;padding:.7rem;border-radius:12px;font-size:13px;transition:all .3s;text-decoration:none;display:block;text-align:center}
        .btn-outline-morado:hover{background:rgba(124,58,237,.08);border-color:#7c3aed;color:#c4b5fd}
        label{color:#a78bfa;font-size:11px;text-transform:uppercase;letter-spacing:.8px;margin-bottom:6px;display:block}
        .input-group-custom{margin-bottom:1rem}
        .logo-wrap{text-align:center;margin-bottom:1.5rem}
        .logo-wrap h1{font-size:22px;font-weight:700;background:linear-gradient(135deg,#e2d9ff,#a78bfa,#7c3aed);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
        .logo-wrap p{font-size:12px;color:rgba(255,255,255,.35);margin-top:4px}
        hr{border-color:rgba(255,255,255,.06)!important;margin:1rem 0}
        @media(max-width:480px){.card{padding:1.5rem;margin:1rem}}
    </style>
</head>
<body>
    <div class="bg-orb"></div><div class="bg-orb"></div><div class="bg-orb"></div><div class="bg-orb"></div>
    <div class="particle"></div><div class="particle"></div><div class="particle"></div><div class="particle"></div><div class="particle"></div>

<div class="container d-flex justify-content-center align-items-center" style="min-height:100vh; padding:2rem 0">
    <div class="card">
        <div class="logo-wrap">
            <span style="font-size:42px;display:block;margin-bottom:.3rem">🧠</span>
            <h1>Crear cuenta</h1>
            <p>Únete a la plataforma de IA Generativa</p>
        </div>

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