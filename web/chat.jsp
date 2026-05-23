<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%
    if(session.getAttribute("usuario") == null){
        response.sendRedirect("index.jsp"); return;
    }
    String usuario = (String) session.getAttribute("usuario");
    String inicial = usuario.substring(0,1).toUpperCase();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat IA - Plataforma IA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @keyframes fadeUp{from{opacity:0;transform:translateY(12px)}to{opacity:1;transform:translateY(0)}}
        @keyframes pulse{0%,100%{opacity:.5}50%{opacity:1}}
        @keyframes slideIn{from{opacity:0;transform:translateX(-8px)}to{opacity:1;transform:translateX(0)}}
        body{background:#080808;font-family:-apple-system,BlinkMacSystemFont,sans-serif;min-height:100vh;color:#fff}
        .navbar-custom{display:flex;align-items:center;justify-content:space-between;padding:.8rem 2rem;border-bottom:1px solid rgba(255,255,255,.07);background:rgba(8,8,8,.97);position:sticky;top:0;z-index:100}
        .avatar{width:28px;height:28px;border-radius:50%;background:#1e1e1e;border:1px solid rgba(255,255,255,.15);display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:500}
        .btn-apple{font-size:11px;padding:4px 14px;border-radius:20px;background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.1);color:rgba(255,255,255,.6);text-decoration:none;transition:all .2s}
        .btn-apple:hover{background:rgba(255,255,255,.13);color:#fff}
        .btn-apple-w{background:rgba(255,255,255,.93)!important;color:#000!important;font-weight:500}
        .chat-container{max-width:720px;margin:0 auto;padding:2rem 1rem;display:flex;flex-direction:column;height:calc(100vh - 60px)}
        .chat-messages{flex:1;overflow-y:auto;padding:.5rem 0;scroll-behavior:smooth}
        .chat-messages::-webkit-scrollbar{width:4px}
        .chat-messages::-webkit-scrollbar-track{background:transparent}
        .chat-messages::-webkit-scrollbar-thumb{background:rgba(255,255,255,.15);border-radius:10px}
        .msg{display:flex;gap:10px;margin-bottom:1.2rem;animation:fadeUp .35s ease both}
        .msg.user{flex-direction:row-reverse}
        .msg-bubble{max-width:78%;padding:.75rem 1rem;border-radius:14px;font-size:13px;line-height:1.6;animation:slideIn .3s ease}
        .msg.bot .msg-bubble{background:#141414;border:1px solid rgba(255,255,255,.08);color:rgba(255,255,255,.82);border-bottom-left-radius:4px}
        .msg.user .msg-bubble{background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.15);color:#fff;border-bottom-right-radius:4px}
        .msg-avatar{width:28px;height:28px;border-radius:50%;flex-shrink:0;display:flex;align-items:center;justify-content:center;font-size:11px;margin-top:4px}
        .msg.bot .msg-avatar{background:linear-gradient(135deg,#7c3aed,#4f46e5)}
        .msg.user .msg-avatar{background:#1e1e1e;border:1px solid rgba(255,255,255,.15)}
        .chat-input{display:flex;gap:8px;padding:.8rem 0;border-top:1px solid rgba(255,255,255,.07);margin-top:.5rem}
        .chat-input input{flex:1;background:#0f0f0f;border:1px solid rgba(255,255,255,.1);border-radius:12px;padding:.7rem 1rem;color:#fff;font-size:13px;outline:none;transition:border .2s}
        .chat-input input:focus{border-color:rgba(255,255,255,.25)}
        .chat-input input::placeholder{color:rgba(255,255,255,.25)}
        .chat-input button{background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.12);border-radius:12px;color:#fff;padding:.7rem 1.2rem;font-size:13px;cursor:pointer;transition:all .2s}
        .chat-input button:hover{background:rgba(255,255,255,.18)}
        .typing{display:flex;gap:4px;padding:.3rem 0}
        .typing span{width:6px;height:6px;border-radius:50%;background:rgba(255,255,255,.3);animation:pulse 1.4s infinite}
        .typing span:nth-child(2){animation-delay:.2s}
        .typing span:nth-child(3){animation-delay:.4s}
        .suggestions{display:flex;gap:6px;flex-wrap:wrap;margin-bottom:1rem}
        .suggestion-chip{padding:6px 14px;border-radius:20px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);font-size:11px;color:rgba(255,255,255,.45);cursor:pointer;transition:all .2s}
        .suggestion-chip:hover{background:rgba(255,255,255,.1);color:#fff}
        .msg.bot .msg-bubble strong{color:#fff}
        .msg.bot .msg-bubble code{background:rgba(255,255,255,.06);padding:2px 6px;border-radius:4px;font-size:12px}
    </style>
</head>
<body>
<nav class="navbar-custom">
    <div class="d-flex align-items-center gap-2">
        <span style="font-size:8px">●</span>
        <span style="font-size:14px;font-weight:500">IA Generativa <span style="color:rgba(255,255,255,.35)">/ Chat</span></span>
    </div>
    <div class="d-flex align-items-center gap-2">
        <div class="avatar"><%= inicial %></div>
        <a href="contenido.jsp" class="btn-apple">Contenido</a>
        <a href="quiz.jsp" class="btn-apple">Quiz</a>
        <a href="logout.jsp" class="btn-apple btn-apple-w">Salir</a>
    </div>
</nav>

<div class="chat-container">
    <h1 style="font-size:20px;font-weight:600;letter-spacing:-.3px;margin-bottom:.2rem">Asistente IA</h1>
    <p style="font-size:12px;color:rgba(255,255,255,.35);margin-bottom:.8rem">Pregunta lo que quieras sobre IA Generativa</p>

    <div class="suggestions" id="suggestions">
        <span class="suggestion-chip" onclick="ask('¿Qué es un LLM?')">¿Qué es un LLM?</span>
        <span class="suggestion-chip" onclick="ask('¿Cómo escribir buenos prompts?')">¿Cómo escribir buenos prompts?</span>
        <span class="suggestion-chip" onclick="ask('Mejores herramientas de IA 2025')">Mejores herramientas 2025</span>
        <span class="suggestion-chip" onclick="ask('¿La IA va a reemplazar programadores?')">¿Reemplaza programadores?</span>
    </div>

    <div class="chat-messages" id="chatMessages">
        <div class="msg bot">
            <div class="msg-avatar">AI</div>
            <div class="msg-bubble">¡Hola <strong><%= usuario %></strong>! Soy tu asistente de IA Generativa.<br>Pregúntame cualquier cosa sobre modelos, herramientas, prompts o aplicaciones de IA.</div>
        </div>
    </div>

    <div class="chat-input">
        <input type="text" id="userInput" placeholder="Escribe tu pregunta..." onkeydown="if(event.key==='Enter') sendMessage()">
        <button onclick="sendMessage()">Enviar</button>
    </div>
</div>

<script>
const responses = {
    "llm": "Un <strong>Large Language Model (LLM)</strong> es un modelo de IA entrenado con enormes volúmenes de texto. Aprende a predecir palabras en contexto y desarrolla comprensión del lenguaje, razonamiento y conocimiento general. Los más conocidos son <strong>GPT-4o</strong> (OpenAI), <strong>Claude</strong> (Anthropic), <strong>Gemini</strong> (Google) y <strong>LLaMA</strong> (Meta, open-source).",
    "prompt": "Para escribir buenos prompts usa esta fórmula:<br><br><strong>Rol</strong>: 'Actúa como experto en...'<br><strong>Contexto</strong>: explica la situación<br><strong>Tarea</strong>: qué necesitas exactamente<br><strong>Formato</strong>: cómo quieres la respuesta (lista, código, tabla)<br><strong>Restricciones</strong>: qué evitar<br><br>Ejemplo: 'Actúa como tutor de IA. Explícame qué es fine-tuning en 3 párrafos con ejemplos prácticos.'",
    "herramienta": "Las mejores herramientas de IA en 2025:<br><br>📝 <strong>ChatGPT</strong> - texto, código, análisis<br>🎨 <strong>Midjourney</strong> - imágenes artísticas<br>🎬 <strong>Sora</strong> - videos (OpenAI)<br>💻 <strong>GitHub Copilot</strong> - código<br>🎵 <strong>Suno AI</strong> - música<br>📹 <strong>HeyGen</strong> - avatares que hablan<br><br>¿Quieres detalles de alguna en particular?",
    "reemplazar": "No, la IA <strong>no va a reemplazar programadores</strong>. Va a reemplazar programadores que <em>no usen IA</em>. Los estudios de GitHub muestran que los devs que usan IA producen hasta <strong>3x más rápido</strong>. La IA es una herramienta que amplifica tu capacidad, no un reemplazo. Aprender a usarla bien es la habilidad más valiosa hoy.",
    "default": "Buena pregunta! La IA Generativa está transformando muchas áreas. ¿Podrías ser más específico? Así puedo darte una respuesta más precisa. Puedes preguntarme sobre:<br><br>• Modelos de lenguaje (LLMs)<br>• Prompt Engineering<br>• Generación de imágenes y video<br>• Herramientas para developers<br>• Aplicaciones de IA en la industria"
};

function findResponse(text){
    const t = text.toLowerCase();
    if(t.includes("llm") || t.includes("lenguaje") || t.includes("modelo")) return responses.llm;
    if(t.includes("prompt") || t.includes("escribir") || t.includes("instrucci")) return responses.prompt;
    if(t.includes("herramienta") || t.includes("mejores") || t.includes("2025") || t.includes("top")) return responses.herramienta;
    if(t.includes("reemplaz") || t.includes("programador") || t.includes("trabajo") || t.includes("empleo")) return responses.reemplazar;
    return responses.default;
}

function addMessage(text, isUser){
    const container = document.getElementById('chatMessages');
    const msg = document.createElement('div');
    msg.className = 'msg ' + (isUser ? 'user' : 'bot');
    msg.innerHTML = '<div class="msg-avatar">' + (isUser ? 'Tú' : 'AI') + '</div><div class="msg-bubble">' + text + '</div>';
    container.appendChild(msg);
    container.scrollTop = container.scrollHeight;
}

function sendMessage(){
    const input = document.getElementById('userInput');
    const text = input.value.trim();
    if(!text) return;
    addMessage(text, true);
    input.value = '';

    const typing = document.createElement('div');
    typing.className = 'msg bot';
    typing.id = 'typing';
    typing.innerHTML = '<div class="msg-avatar">AI</div><div class="typing"><span></span><span></span><span></span></div>';
    document.getElementById('chatMessages').appendChild(typing);
    document.getElementById('chatMessages').scrollTop = document.getElementById('chatMessages').scrollHeight;

    setTimeout(() => {
        const t = document.getElementById('typing');
        if(t) t.remove();
        addMessage(findResponse(text), false);
    }, 1000 + Math.random() * 800);
}

function ask(text){
    document.getElementById('userInput').value = text;
    sendMessage();
}
</script>
</body>
</html>