<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%
    if(session.getAttribute("usuario") == null){
        response.sendRedirect("index.jsp"); return;
    }
    String usuario = (String) session.getAttribute("usuario");
    String inicial = usuario.substring(0,1).toUpperCase();
    int id_usuario  = (Integer) session.getAttribute("id_usuario");

    String accion = request.getParameter("accion");
    if("guardar".equals(accion)){
        String[] preguntas = {
            "¿Qué es la IA Generativa?",
            "¿Qué significa LLM?",
            "¿Qué herramienta genera imágenes artísticas de alta calidad?",
            "¿Qué técnica hace que el modelo razone paso a paso?",
            "¿Cuál IA de video es de OpenAI?"
        };
        String[] respuestas = {
            request.getParameter("r1"),
            request.getParameter("r2"),
            request.getParameter("r3"),
            request.getParameter("r4"),
            request.getParameter("r5")
        };
        String[] correctas = {"b","c","a","b","a"};

        for(int i=0;i<preguntas.length;i++){
            boolean ok = correctas[i].equals(respuestas[i]);
            st = conexion.prepareStatement(
                "INSERT INTO evaluaciones(id_usuario,pregunta,respuesta_usuario,correcta) VALUES(?,?,?,?)");
            st.setInt(1, id_usuario);
            st.setString(2, preguntas[i]);
            st.setString(3, respuestas[i] != null ? respuestas[i] : "sin respuesta");
            st.setBoolean(4, ok);
            st.executeUpdate();
        }
        response.sendRedirect("resultado.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz - Plataforma IA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
        @keyframes scaleIn{from{transform:scale(.85);opacity:0}to{transform:scale(1);opacity:1}}
        body{background:#080808;font-family:-apple-system,BlinkMacSystemFont,sans-serif;min-height:100vh;color:#fff}
        .navbar-custom{display:flex;align-items:center;justify-content:space-between;padding:.8rem 2rem;border-bottom:1px solid rgba(255,255,255,.07);background:rgba(8,8,8,.97);position:sticky;top:0;z-index:100}
        .avatar{width:28px;height:28px;border-radius:50%;background:#1e1e1e;border:1px solid rgba(255,255,255,.15);display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:500}
        .btn-apple{font-size:11px;padding:4px 14px;border-radius:20px;background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.1);color:rgba(255,255,255,.6);text-decoration:none}
        .btn-apple-w{background:rgba(255,255,255,.93)!important;color:#000!important;font-weight:500}
        .q-card{background:#0f0f0f;border:1px solid rgba(255,255,255,.07);border-radius:16px;padding:1.5rem;margin-bottom:12px;animation:fadeUp .5s ease both}
        .q-card:nth-child(1){animation-delay:.05s}.q-card:nth-child(2){animation-delay:.1s}.q-card:nth-child(3){animation-delay:.15s}.q-card:nth-child(4){animation-delay:.2s}.q-card:nth-child(5){animation-delay:.25s}
        .q-num{font-size:10px;color:rgba(255,255,255,.3);text-transform:uppercase;letter-spacing:.8px;margin-bottom:.5rem}
        .q-text{font-size:15px;font-weight:500;color:#fff;margin-bottom:1.1rem;line-height:1.4}
        .opt{display:flex;align-items:center;gap:10px;padding:.7rem 1rem;border-radius:10px;border:1px solid rgba(255,255,255,.07);background:rgba(255,255,255,.03);margin-bottom:8px;cursor:pointer;transition:all .2s}
        .opt:hover{border-color:rgba(255,255,255,.2);background:rgba(255,255,255,.06)}
        .opt input[type=radio]{accent-color:#fff;width:15px;height:15px;flex-shrink:0}
        .opt label{font-size:13px;color:rgba(255,255,255,.65);cursor:pointer;margin:0;line-height:1.4}
        .opt:has(input:checked){border-color:rgba(255,255,255,.35);background:rgba(255,255,255,.08)}
        .opt:has(input:checked) label{color:#fff}
        .btn-submit{width:100%;padding:13px;background:rgba(255,255,255,.93);color:#000;font-weight:600;font-size:15px;border:none;border-radius:12px;cursor:pointer;margin-top:.5rem;transition:all .2s}
        .btn-submit:hover{background:#fff;transform:scale(1.01)}
        .progress-quiz{background:rgba(255,255,255,.06);border-radius:20px;height:3px;margin-bottom:2rem;overflow:hidden}
        .progress-fill{height:100%;background:rgba(255,255,255,.5);border-radius:20px;width:0;transition:width .4s}
        .lock-overlay{display:flex;align-items:center;justify-content:center;min-height:70vh;animation:fadeUp .6s ease}
        .lock-card{background:#0f0f0f;border:1px solid rgba(255,255,255,.07);border-radius:20px;padding:2.5rem;text-align:center;max-width:420px;width:100%;animation:scaleIn .5s cubic-bezier(.4,0,.2,1)}
        .lock-icon{font-size:56px;margin-bottom:.5rem}
        .lock-card h2{font-size:20px;font-weight:600;margin-bottom:.5rem}
        .lock-card p{font-size:13px;color:rgba(255,255,255,.4);line-height:1.6;margin-bottom:1.5rem}
        .progress-ring{display:flex;justify-content:center;gap:6px;margin-bottom:1.5rem}
        .progress-ring span{width:32px;height:32px;border-radius:50%;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);display:flex;align-items:center;justify-content:center;font-size:11px;color:rgba(255,255,255,.25)}
        .progress-ring span.done{background:rgba(124,58,237,.2);border-color:#7c3aed;color:#a78bfa}
        .btn-lock-go{display:inline-block;padding:10px 28px;border-radius:20px;background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.1);color:rgba(255,255,255,.6);text-decoration:none;font-size:13px;transition:all .2s}
        .btn-lock-go:hover{background:rgba(255,255,255,.13);color:#fff}
        .quiz-content{display:none}
    </style>
</head>
<body>
<nav class="navbar-custom">
    <div class="d-flex align-items-center gap-2">
        <span style="font-size:8px">●</span>
        <span style="font-size:14px;font-weight:500">IA Generativa <span style="color:rgba(255,255,255,.35)">/ Quiz</span></span>
    </div>
    <div class="d-flex align-items-center gap-2">
        <div class="avatar"><%= inicial %></div>
        <a href="contenido.jsp" class="btn-apple">Contenido</a>
        <a href="chat.jsp" class="btn-apple">Chat IA</a>
        <a href="logout.jsp" class="btn-apple btn-apple-w">Salir</a>
    </div>
</nav>

<div class="lock-overlay" id="lockOverlay">
    <div class="lock-card">
        <div class="lock-icon">🔒</div>
        <h2>Quiz bloqueado</h2>
        <p>Completa los 6 módulos de contenido para desbloquear el quiz. Debes leer y marcar como completado cada módulo.</p>
        <div class="progress-ring" id="progressRing"></div>
        <p style="font-size:12px;color:rgba(255,255,255,.3)" id="lockMsg">Progreso: 0/6 módulos</p>
        <a href="contenido.jsp" class="btn-lock-go">Ir al contenido →</a>
    </div>
</div>

<div class="quiz-content" id="quizContent">
<div class="container" style="max-width:660px;padding:2rem 1rem">
    <h1 style="font-size:24px;font-weight:600;letter-spacing:-.4px;margin-bottom:.4rem">Pon a prueba<br>lo que aprendiste.</h1>
    <p style="font-size:13px;color:rgba(255,255,255,.38);margin-bottom:1.5rem">5 preguntas sobre IA Generativa · Selecciona la respuesta correcta</p>
    <div class="progress-quiz"><div class="progress-fill" id="pbar"></div></div>

    <form action="quiz.jsp?accion=guardar" method="post" onchange="updateProgress()">

        <div class="q-card">
            <div class="q-num">Pregunta 1 de 5</div>
            <div class="q-text">¿Cuál es la principal característica de la IA Generativa?</div>
            <div class="opt"><input type="radio" name="r1" id="r1a" value="a"><label for="r1a">Solo clasifica información existente</label></div>
            <div class="opt"><input type="radio" name="r1" id="r1b" value="b"><label for="r1b">Crea contenido nuevo como texto, imágenes y código</label></div>
            <div class="opt"><input type="radio" name="r1" id="r1c" value="c"><label for="r1c">Únicamente traduce idiomas</label></div>
            <div class="opt"><input type="radio" name="r1" id="r1d" value="d"><label for="r1d">Solo funciona con datos numéricos</label></div>
        </div>

        <div class="q-card">
            <div class="q-num">Pregunta 2 de 5</div>
            <div class="q-text">¿Qué significa LLM en el contexto de la Inteligencia Artificial?</div>
            <div class="opt"><input type="radio" name="r2" id="r2a" value="a"><label for="r2a">Limited Language Machine</label></div>
            <div class="opt"><input type="radio" name="r2" id="r2b" value="b"><label for="r2b">Logical Learning Method</label></div>
            <div class="opt"><input type="radio" name="r2" id="r2c" value="c"><label for="r2c">Large Language Model</label></div>
            <div class="opt"><input type="radio" name="r2" id="r2d" value="d"><label for="r2d">Linear Learning Module</label></div>
        </div>

        <div class="q-card">
            <div class="q-num">Pregunta 3 de 5</div>
            <div class="q-text">¿Cuál herramienta es reconocida por generar imágenes con la mayor calidad artística?</div>
            <div class="opt"><input type="radio" name="r3" id="r3a" value="a"><label for="r3a">Midjourney</label></div>
            <div class="opt"><input type="radio" name="r3" id="r3b" value="b"><label for="r3b">Microsoft Excel</label></div>
            <div class="opt"><input type="radio" name="r3" id="r3c" value="c"><label for="r3c">Google Maps</label></div>
            <div class="opt"><input type="radio" name="r3" id="r3d" value="d"><label for="r3d">GitHub Pages</label></div>
        </div>

        <div class="q-card">
            <div class="q-num">Pregunta 4 de 5</div>
            <div class="q-text">¿Qué técnica de Prompt Engineering hace que el modelo razone paso a paso?</div>
            <div class="opt"><input type="radio" name="r4" id="r4a" value="a"><label for="r4a">Zero-Shot Prompting</label></div>
            <div class="opt"><input type="radio" name="r4" id="r4b" value="b"><label for="r4b">Chain-of-Thought Prompting</label></div>
            <div class="opt"><input type="radio" name="r4" id="r4c" value="c"><label for="r4c">Random Prompting</label></div>
            <div class="opt"><input type="radio" name="r4" id="r4d" value="d"><label for="r4d">Copy-Paste Prompting</label></div>
        </div>

        <div class="q-card">
            <div class="q-num">Pregunta 5 de 5</div>
            <div class="q-text">¿Cuál es la herramienta de generación de video desarrollada por OpenAI?</div>
            <div class="opt"><input type="radio" name="r5" id="r5a" value="a"><label for="r5a">Sora</label></div>
            <div class="opt"><input type="radio" name="r5" id="r5b" value="b"><label for="r5b">Runway</label></div>
            <div class="opt"><input type="radio" name="r5" id="r5c" value="c"><label for="r5c">Kling</label></div>
            <div class="opt"><input type="radio" name="r5" id="r5d" value="d"><label for="r5d">Pika Labs</label></div>
        </div>

        <button type="submit" class="btn-submit">Enviar respuestas →</button>
    </form>
</div>
</div>
<script>
function updateProgress(){
    const total=5;
    let answered=0;
    for(let i=1;i<=total;i++){
        if(document.querySelector('input[name="r'+i+'"]:checked')) answered++;
    }
    document.getElementById('pbar').style.width=(answered/total*100)+'%';
}

function checkQuizAccess(){
    const done = parseInt(localStorage.getItem('doneCount') || '0');
    const total = 6;
    const ring = document.getElementById('progressRing');
    ring.innerHTML = '';
    for(let i=1;i<=total;i++){
        const s = document.createElement('span');
        s.textContent = i;
        if(i <= done) s.className = 'done';
        ring.appendChild(s);
    }
    document.getElementById('lockMsg').textContent = 'Progreso: ' + done + '/' + total + ' módulos';
    if(done >= total){
        document.getElementById('lockOverlay').style.display = 'none';
        document.getElementById('quizContent').style.display = 'block';
    }
}
checkQuizAccess();
</script>
</body>
</html>