<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Plataforma IA - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @keyframes bgShift{0%{background-position:0% 50%}50%{background-position:100% 50%}100%{background-position:0% 50%}}
        @keyframes float{0%,100%{transform:translateY(0) translateX(0)}25%{transform:translateY(-20px) translateX(10px)}50%{transform:translateY(-10px) translateX(-10px)}75%{transform:translateY(-25px) translateX(15px)}}
        @keyframes pulse{0%,100%{opacity:.4}50%{opacity:.8}}
        @keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
        @keyframes glow{0%,100%{box-shadow:0 0 20px rgba(124,58,237,.15)}50%{box-shadow:0 0 40px rgba(124,58,237,.3)}}
        @keyframes orbit{from{transform:rotate(0deg) translateX(60px) rotate(0deg)}to{transform:rotate(360deg) translateX(60px) rotate(-360deg)}}
        @keyframes orbit2{from{transform:rotate(0deg) translateX(90px) rotate(0deg)}to{transform:rotate(-360deg) translateX(90px) rotate(360deg)}}
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
        .card{background:linear-gradient(145deg,rgba(22,22,42,.85),rgba(30,30,56,.85));border:1px solid rgba(61,48,96,.5);border-radius:20px;backdrop-filter:blur(20px);padding:2.2rem;width:100%;max-width:400px;animation:fadeUp .8s cubic-bezier(.4,0,.2,1);position:relative;overflow:hidden}
        .card::before{content:'';position:absolute;top:0;left:-100%;width:200%;height:2px;background:linear-gradient(90deg,transparent,#7c3aed,#4f46e5,transparent);animation:orbit 4s linear infinite}
        .logo-wrap{text-align:center;margin-bottom:1.5rem}
        .logo-icon{font-size:48px;display:block;margin-bottom:.3rem}
        .logo-wrap h1{font-size:22px;font-weight:700;background:linear-gradient(135deg,#e2d9ff,#a78bfa,#7c3aed);-webkit-background-clip:text;-webkit-text-fill-color:transparent;letter-spacing:-.5px}
        .logo-wrap p{font-size:12px;color:rgba(255,255,255,.35);margin-top:4px}
        .form-control{background:rgba(14,14,32,.7);border:1px solid rgba(61,48,96,.5);border-radius:12px;color:#e2d9ff;padding:.75rem 1rem;font-size:14px;transition:all .3s}
        .form-control:focus{background:rgba(19,19,42,.8);border-color:#7c3aed;box-shadow:0 0 0 3px rgba(124,58,237,.15);color:#e2d9ff;outline:none}
        .form-control::placeholder{color:rgba(74,64,112,.6)}
        label{color:#a78bfa;font-size:11px;text-transform:uppercase;letter-spacing:.8px;margin-bottom:6px;display:block}
        .btn-morado{background:linear-gradient(135deg,#7c3aed,#4f46e5);border:none;color:white;padding:.8rem;border-radius:12px;font-weight:600;font-size:14px;transition:all .3s;position:relative;overflow:hidden}
        .btn-morado:hover{transform:translateY(-1px);box-shadow:0 8px 25px rgba(124,58,237,.3)}
        .btn-morado:active{transform:scale(.98)}
        .btn-outline-morado{background:transparent;border:1px solid rgba(61,48,96,.6);color:#a78bfa;padding:.7rem;border-radius:12px;font-size:13px;transition:all .3s;text-decoration:none;display:block;text-align:center}
        .btn-outline-morado:hover{background:rgba(124,58,237,.08);border-color:#7c3aed;color:#c4b5fd}
        .divider{display:flex;align-items:center;gap:12px;margin:1.2rem 0;color:rgba(255,255,255,.12);font-size:11px}
        .divider::before,.divider::after{content:'';flex:1;height:1px;background:rgba(255,255,255,.06)}
        .input-group-custom{margin-bottom:1rem}
        .input-group-custom label{display:flex;align-items:center;gap:4px}
        .features-row{display:flex;justify-content:center;gap:16px;margin-bottom:1.2rem;font-size:10px;color:rgba(255,255,255,.2)}
        .features-row span{display:flex;align-items:center;gap:3px}
        @media(max-width:480px){.card{padding:1.5rem;margin:1rem}.logo-icon{font-size:36px}}
    </style>
</head>
<body>
    <div class="bg-orb"></div><div class="bg-orb"></div><div class="bg-orb"></div><div class="bg-orb"></div>
    <div class="particle"></div><div class="particle"></div><div class="particle"></div><div class="particle"></div><div class="particle"></div>

    <div class="card">
        <div class="logo-wrap">
            <span class="logo-icon">🧠</span>
            <h1>Plataforma IA</h1>
            <p>Tu viaje por la inteligencia artificial comienza aquí</p>
        </div>

        <div class="features-row">
            <span>📚 6 módulos</span>
            <span>⚡ Quiz final</span>
            <span>🤖 Chat asistente</span>
        </div>

        <% String error = request.getParameter("error");
           if("1".equals(error)){ %>
            <div class="alert alert-danger py-2 small" style="background:rgba(220,38,38,.1);border:1px solid rgba(220,38,38,.2);border-radius:10px;color:#fca5a5;font-size:12px;padding:.6rem .8rem;margin-bottom:1rem">Correo o contraseña incorrectos</div>
        <% } else if("2".equals(error)){ %>
            <div class="alert alert-danger py-2 small" style="background:rgba(220,38,38,.1);border:1px solid rgba(220,38,38,.2);border-radius:10px;color:#fca5a5;font-size:12px;padding:.6rem .8rem;margin-bottom:1rem">Error del servidor. Intenta de nuevo.</div>
        <% } %>
        <% if("1".equals(request.getParameter("registrado"))){ %>
            <div class="alert alert-success py-2 small" style="background:rgba(34,197,94,.1);border:1px solid rgba(34,197,94,.2);border-radius:10px;color:#86efac;font-size:12px;padding:.6rem .8rem;margin-bottom:1rem">Cuenta creada. Inicia sesión.</div>
        <% } %>

        <form action="login.jsp" method="post">
            <div class="input-group-custom">
                <label>📧 Correo</label>
                <input type="email" name="correo" class="form-control" placeholder="tucorreo@email.com" required>
            </div>
            <div class="input-group-custom">
                <label>🔒 Contraseña</label>
                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
            </div>
            <button type="submit" class="btn btn-morado w-100">Iniciar sesión</button>
        </form>

        <div class="divider">O</div>

        <a href="registro.jsp" class="btn-outline-morado">Crear cuenta nueva</a>
    </div>
</body>
</html>