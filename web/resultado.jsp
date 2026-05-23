<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%
    if(session.getAttribute("usuario") == null){
        response.sendRedirect("index.jsp"); return;
    }
    int id_usuario = (Integer) session.getAttribute("id_usuario");

    st = conexion.prepareStatement(
        "SELECT COUNT(*) as total, SUM(correcta) as correctas FROM evaluaciones WHERE id_usuario=?");
    st.setInt(1, id_usuario);
    rs = st.executeQuery();

    int total = 0, correctas = 0;
    if(rs.next()){
        total     = rs.getInt("total");
        correctas = rs.getInt("correctas");
    }
    int pct     = total > 0 ? (correctas * 100 / total) : 0;
    String emoji = pct >= 80 ? "🏆" : pct >= 60 ? "👍" : "📚";
    String msg   = pct >= 80 ? "¡Excelente dominio del tema!" :
                   pct >= 60 ? "Buen trabajo, sigue practicando." :
                               "Repasa el contenido e intenta de nuevo.";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultado - Plataforma IA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
        body{background:#080808;font-family:-apple-system,BlinkMacSystemFont,sans-serif;min-height:100vh;color:#fff;display:flex;align-items:center;justify-content:center}
        .result-card{background:#0f0f0f;border:1px solid rgba(255,255,255,.08);border-radius:20px;padding:2.5rem;text-align:center;max-width:400px;width:100%;animation:fadeUp .5s ease}
        .big-emoji{font-size:56px;margin-bottom:.75rem}
        .score{font-size:64px;font-weight:700;letter-spacing:-2px;margin:.5rem 0 .25rem}
        .score span{font-size:28px;color:rgba(255,255,255,.35)}
        .pct-bar{background:rgba(255,255,255,.06);border-radius:20px;height:5px;margin:1rem 0;overflow:hidden}
        .pct-fill{height:100%;background:rgba(255,255,255,.5);border-radius:20px;transition:width 1s ease}
        .btn-r{display:inline-block;font-size:13px;padding:10px 24px;border-radius:20px;text-decoration:none;margin:4px;transition:all .2s}
        .btn-w{background:rgba(255,255,255,.93);color:#000;font-weight:500}
        .btn-w:hover{background:#fff;color:#000}
        .btn-o{background:transparent;border:1px solid rgba(255,255,255,.15);color:rgba(255,255,255,.6)}
        .btn-o:hover{border-color:rgba(255,255,255,.3);color:#fff}
    </style>
</head>
<body>
<div class="result-card">
    <div class="big-emoji"><%= emoji %></div>
    <h2 style="font-size:20px;font-weight:600;margin-bottom:.25rem">Tu resultado</h2>
    <p style="font-size:13px;color:rgba(255,255,255,.4);margin-bottom:1rem"><%= msg %></p>
    <div class="score"><%= correctas %><span> / <%= total %></span></div>
    <div class="pct-bar"><div class="pct-fill" id="bar"></div></div>
    <p style="font-size:13px;color:rgba(255,255,255,.4);margin-bottom:2rem"><%= pct %>% de respuestas correctas</p>
        <a href="quiz.jsp" class="btn-r btn-w">Intentar de nuevo</a>
    <a href="contenido.jsp" class="btn-r btn-o">Repasar contenido</a>
    <a href="chat.jsp" class="btn-r btn-o" style="margin-top:8px;display:inline-block">Chat IA</a>
</div>
<script>
    window.onload = function(){
        document.getElementById('bar').style.width = '<%= pct %>%';
    }
</script>
</body>
</html>--