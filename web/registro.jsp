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
        @keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
        @keyframes zoomIn{from{transform:scale(1.1)}to{transform:scale(1)}}
        @keyframes gradientOverlay{0%{background-position:0% 50%}50%{background-position:100% 50%}100%{background-position:0% 50%}}
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:-apple-system,BlinkMacSystemFont,sans-serif;min-height:100vh;display:flex;align-items:center;justify-content:center;overflow:hidden;position:relative;background:#080808}
        .bg-slideshow{position:fixed;inset:0;z-index:0}
        .bg-slideshow img{position:absolute;inset:0;width:100%;height:100%;object-fit:cover;opacity:0;transition:opacity 1.5s ease-in-out;animation:zoomIn 6s ease-out}
        .bg-slideshow img.active{opacity:1}
        .bg-overlay{position:fixed;inset:0;z-index:1;background:linear-gradient(135deg,rgba(8,8,12,.85) 0%,rgba(15,5,32,.7) 50%,rgba(8,8,12,.85) 100%);background-size:200% 200%;animation:gradientOverlay 8s ease infinite}
        .bg-vignette{position:fixed;inset:0;z-index:1;box-shadow:inset 0 0 150px rgba(0,0,0,.6)}
        .card{background:linear-gradient(145deg,rgba(22,22,42,.88),rgba(30,30,56,.88));border:1px solid rgba(61,48,96,.5);border-radius:20px;backdrop-filter:blur(24px);padding:2.2rem;width:100%;max-width:440px;animation:fadeUp .8s cubic-bezier(.4,0,.2,1);position:relative;z-index:2;overflow:hidden}
        .card::before{content:'';position:absolute;top:0;left:-100%;width:200%;height:2px;background:linear-gradient(90deg,transparent,rgba(124,58,237,.6),rgba(79,70,229,.6),transparent);animation:gradientOverlay 4s linear infinite}
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
        .photo-credit{position:fixed;bottom:12px;right:16px;z-index:3;font-size:10px;color:rgba(255,255,255,.15)}
        .photo-credit a{color:rgba(255,255,255,.15);text-decoration:none}
        @media(max-width:480px){.card{padding:1.5rem;margin:1rem}}
    </style>
</head>
<body>
    <div class="bg-slideshow" id="bgSlideshow"></div>
    <div class="bg-overlay"></div>
    <div class="bg-vignette"></div>

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
        <hr>
        <a href="index.jsp" class="btn-outline-morado">Ya tengo cuenta</a>
    </div>
</div>

    <div class="photo-credit">Fotos: <a href="https://unsplash.com" target="_blank">Unsplash</a> via picsum.photos</div>

<script>
(function(){
    const seeds = ['ai','tech','future','digital','cyber','neon','code','data','brain','network','robot','abstract','light','space','nature','city','stars','planet','ocean','mountain','forest','galaxy','crystal','glass','wave','dawn','aurora','tower','bridge','cloud'];
    const container = document.getElementById('bgSlideshow');
    let current = 0;
    function loadBg(idx){
        const img = document.createElement('img');
        const seed = seeds[idx % seeds.length] + current;
        img.src = 'https://picsum.photos/seed/' + seed + '/1920/1080';
        img.alt = '';
        if(idx === 0) img.className = 'active';
        container.appendChild(img);
        if(idx > 0){
            setTimeout(() => {
                document.querySelectorAll('.bg-slideshow img').forEach(i => i.classList.remove('active'));
                img.classList.add('active');
                if(container.children.length > 3){
                    container.removeChild(container.children[0]);
                }
            }, 100);
        }
    }
    for(let i=0; i<3; i++) loadBg(i);
    setInterval(() => {
        current++;
        loadBg(current);
    }, 7000);
})();
</script>
</body>
</html>