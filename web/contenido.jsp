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
    <title>Contenido - Plataforma IA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
        @keyframes fadeIn{from{opacity:0}to{opacity:1}}
        @keyframes pulse{0%,100%{opacity:.5}50%{opacity:1}}
        @keyframes float{0%,100%{transform:translateY(0)}50%{transform:translateY(-10px)}}
        @keyframes glow{0%,100%{box-shadow:0 0 5px rgba(124,58,237,.2)}50%{box-shadow:0 0 20px rgba(124,58,237,.4)}}
        @keyframes bgShift{0%{background-position:0% 50%}50%{background-position:100% 50%}100%{background-position:0% 50%}}
        @keyframes confettiFall{0%{transform:translateY(-100vh) rotate(0deg);opacity:1}100%{transform:translateY(100vh) rotate(720deg);opacity:0}}
        @keyframes scaleIn{from{transform:scale(.8);opacity:0}to{transform:scale(1);opacity:1}}
        @keyframes slideDown{from{transform:translateY(-30px);opacity:0}to{transform:translateY(0);opacity:1}}
        @keyframes countdown{from{width:100%}to{width:0%}}
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:-apple-system,BlinkMacSystemFont,sans-serif;min-height:100vh;color:#fff;background:linear-gradient(-45deg,#080808,#0f0a1a,#0a0a14,#080808);background-size:400% 400%;animation:bgShift 15s ease infinite;overflow-x:hidden}
        .particle{position:fixed;width:2px;height:2px;background:rgba(124,58,237,.15);border-radius:50%;pointer-events:none;animation:float 6s infinite}
        .particle:nth-child(1){top:10%;left:5%;animation-delay:0s;width:3px;height:3px}
        .particle:nth-child(2){top:30%;left:90%;animation-delay:1s}
        .particle:nth-child(3){top:60%;left:15%;animation-delay:2s;width:3px;height:3px;background:rgba(79,70,229,.1)}
        .particle:nth-child(4){top:80%;left:80%;animation-delay:.5s}
        .particle:nth-child(5){top:20%;left:50%;animation-delay:3s;width:4px;height:4px;background:rgba(124,58,237,.08)}
        .particle:nth-child(6){top:70%;left:40%;animation-delay:1.5s}
        .navbar-custom{display:flex;align-items:center;justify-content:space-between;padding:.8rem 2rem;border-bottom:1px solid rgba(255,255,255,.07);background:rgba(8,8,8,.85);backdrop-filter:blur(12px);position:sticky;top:0;z-index:100}
        .avatar{width:28px;height:28px;border-radius:50%;background:#1e1e1e;border:1px solid rgba(255,255,255,.15);display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:500}
        .btn-apple{font-size:11px;padding:4px 14px;border-radius:20px;background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.1);color:rgba(255,255,255,.6);text-decoration:none;transition:all .2s}
        .btn-apple:hover{background:rgba(255,255,255,.13);color:#fff}
        .btn-apple-w{background:rgba(255,255,255,.93)!important;color:#000!important;font-weight:500}
        .btn-apple-accent{background:linear-gradient(135deg,#7c3aed,#4f46e5)!important;color:#fff!important;font-weight:500;animation:glow 2s infinite}
        .live-tag{display:inline-flex;align-items:center;gap:5px;background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.09);border-radius:20px;padding:3px 12px;font-size:10px;color:rgba(255,255,255,.45);text-transform:uppercase;letter-spacing:.6px;margin-bottom:.9rem}
        .live-dot{width:5px;height:5px;border-radius:50%;background:#7c3aed;display:inline-block;animation:pulse 2s infinite}
        .progress-tracker{display:flex;gap:8px;margin-bottom:1.5rem;align-items:center}
        .progress-step{width:28px;height:28px;border-radius:50%;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);display:flex;align-items:center;justify-content:center;font-size:10px;color:rgba(255,255,255,.25);transition:all .5s cubic-bezier(.4,0,.2,1)}
        .progress-step.done{background:rgba(124,58,237,.2);border-color:#7c3aed;color:#a78bfa;box-shadow:0 0 12px rgba(124,58,237,.15)}
        .progress-step.current{background:rgba(255,255,255,.1);border-color:rgba(255,255,255,.2);color:#fff}
        .progress-line{flex:1;height:1px;background:rgba(255,255,255,.06);position:relative;overflow:hidden}
        .progress-line-fill{height:100%;background:linear-gradient(90deg,#7c3aed,#4f46e5);width:0;transition:width .8s cubic-bezier(.4,0,.2,1)}
        .card-tema{background:linear-gradient(145deg,rgba(15,15,15,.9),rgba(20,20,30,.8));border:1px solid rgba(255,255,255,.07);border-radius:16px;overflow:hidden;margin-bottom:10px;animation:fadeUp .6s ease both;transition:all .4s cubic-bezier(.4,0,.2,1);position:relative}
        .card-tema::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,rgba(124,58,237,.3),transparent);opacity:0;transition:opacity .4s}
        .card-tema:hover::before{opacity:1}
        .card-tema:hover{border-color:rgba(124,58,237,.15);transform:translateY(-1px)}
        .card-tema:nth-child(1){animation-delay:.05s}.card-tema:nth-child(2){animation-delay:.1s}.card-tema:nth-child(3){animation-delay:.15s}.card-tema:nth-child(4){animation-delay:.2s}.card-tema:nth-child(5){animation-delay:.25s}.card-tema:nth-child(6){animation-delay:.3s}
        .card-tema.done-module{border-color:rgba(124,58,237,.2);background:linear-gradient(145deg,rgba(15,15,20,.9),rgba(20,15,30,.8))}
        .card-header-btn{width:100%;background:none;border:none;padding:1rem 1.2rem;cursor:pointer;text-align:left;display:flex;align-items:center;justify-content:space-between;gap:12px;transition:background .3s;position:relative;z-index:1}
        .card-header-btn:hover{background:rgba(255,255,255,.03)}
        .icon-box{width:42px;height:42px;border-radius:11px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0;transition:all .4s}
        .card-tema.done-module .icon-box{background:rgba(124,58,237,.12);border-color:rgba(124,58,237,.2)}
        .card-cat{font-size:10px;color:rgba(255,255,255,.32);text-transform:uppercase;letter-spacing:.7px;margin-bottom:3px}
        .card-title-ap{font-size:14px;font-weight:500;color:#fff;line-height:1.3}
        .card-tema.done-module .card-title-ap{color:#c4b5fd}
        .chevron{font-size:16px;color:rgba(255,255,255,.22);transition:transform .5s cubic-bezier(.4,0,.2,1)}
        .card-tema.open .chevron{transform:rotate(180deg);color:#7c3aed}
        .card-body-ap{max-height:0;overflow:hidden;transition:max-height .6s cubic-bezier(.4,0,.2,1),opacity .4s;opacity:0}
        .card-tema.open .card-body-ap{max-height:1200px;opacity:1}
        .card-content-ap{padding:.25rem 1.2rem 1.2rem;border-top:1px solid rgba(255,255,255,.05)}
        .para{font-size:13px;color:rgba(255,255,255,.48);line-height:1.75;margin-top:.85rem}
        .para strong{color:rgba(255,255,255,.82);font-weight:500}
        .para .highlight{padding:1px 6px;border-radius:4px;background:rgba(124,58,237,.1);color:#c4b5fd}
        .tool-grid{display:grid;grid-template-columns:1fr 1fr;gap:8px;margin-top:.85rem}
        .tool-chip{background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.08);border-radius:10px;padding:.6rem .85rem;font-size:11px;color:rgba(255,255,255,.55);transition:all .3s}
        .tool-chip:hover{background:rgba(255,255,255,.08);border-color:rgba(255,255,255,.15);transform:translateY(-1px)}
        .tool-chip strong{display:block;color:rgba(255,255,255,.85);font-size:12px;margin-bottom:2px}
        .card-foot-ap{display:flex;align-items:center;justify-content:space-between;margin-top:1rem;padding-top:.85rem;border-top:1px solid rgba(255,255,255,.05)}
        .badge-s{font-size:10px;padding:3px 10px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);border-radius:20px;color:rgba(255,255,255,.3);transition:all .3s}
        .badge-s.done{background:rgba(124,58,237,.15);border-color:rgba(124,58,237,.3);color:#a78bfa}
        .btn-read{font-size:11px;padding:5px 16px;border-radius:20px;background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.1);color:rgba(255,255,255,.65);cursor:pointer;transition:all .3s}
        .btn-read:hover{background:rgba(255,255,255,.13);color:#fff}
        .btn-read.done{background:rgba(124,58,237,.15);border-color:rgba(124,58,237,.3);color:#a78bfa;cursor:default}
        .complete-banner{display:none;background:linear-gradient(135deg,rgba(124,58,237,.15),rgba(79,70,229,.1));border:1px solid rgba(124,58,237,.25);border-radius:16px;padding:1.5rem;text-align:center;margin-bottom:1.5rem;animation:scaleIn .6s cubic-bezier(.4,0,.2,1)}
        .complete-banner.show{display:block}
        .complete-banner h3{font-size:20px;margin-bottom:.5rem}
        .complete-banner p{font-size:13px;color:rgba(255,255,255,.5);margin-bottom:1rem}
        .btn-quiz-go{display:inline-block;padding:10px 28px;border-radius:20px;background:linear-gradient(135deg,#7c3aed,#4f46e5);color:#fff;text-decoration:none;font-size:13px;font-weight:500;transition:all .3s;animation:glow 2s infinite}
        .btn-quiz-go:hover{transform:scale(1.05);color:#fff}
        .auto-redirect-countdown{font-size:11px;color:rgba(255,255,255,.35);margin-top:.8rem}
        .auto-redirect-bar{height:2px;background:rgba(255,255,255,.08);border-radius:4px;margin-top:.6rem;overflow:hidden}
        .auto-redirect-fill{height:100%;background:linear-gradient(90deg,#7c3aed,#4f46e5);width:0;border-radius:4px;transition:width 1s linear}
        .key-concept{display:inline-block;padding:2px 8px;background:rgba(124,58,237,.1);border:1px solid rgba(124,58,237,.15);border-radius:6px;font-size:11px;color:#a78bfa;margin:2px}
        @media(max-width:480px){.tool-grid{grid-template-columns:1fr}.navbar-custom{padding:.6rem 1rem}.btn-apple{font-size:10px;padding:3px 10px}}
    </style>
</head>
<body>
    <div class="particle"></div><div class="particle"></div><div class="particle"></div>
    <div class="particle"></div><div class="particle"></div><div class="particle"></div>

<nav class="navbar-custom">
    <div class="d-flex align-items-center gap-2">
        <span style="font-size:8px;color:#7c3aed">●</span>
        <span style="font-size:14px;font-weight:500">IA Generativa <span style="color:rgba(255,255,255,.35)">/ Contenido</span></span>
    </div>
    <div class="d-flex align-items-center gap-2">
        <div class="avatar"><%= inicial %></div>
        <a href="chat.jsp" class="btn-apple">Chat IA</a>
        <a href="quiz.jsp" class="btn-apple" id="navQuiz">Quiz</a>
        <a href="logout.jsp" class="btn-apple btn-apple-w">Salir</a>
    </div>
</nav>

<div class="container" style="max-width:700px;padding:2rem 1rem">
    <div class="live-tag"><span class="live-dot"></span>&nbsp;Sesión activa · <span id="modCount">0</span>/6 completado</div>
    <h1 style="font-size:24px;font-weight:600;letter-spacing:-.4px;margin-bottom:.4rem">Hola, <%= usuario %>.<br>Tu viaje por la <span style="background:linear-gradient(135deg,#c4b5fd,#7c3aed);-webkit-background-clip:text;-webkit-text-fill-color:transparent">IA Generativa</span></h1>
    <p style="font-size:13px;color:rgba(255,255,255,.38);margin-bottom:1.5rem">Explora cada módulo, domina los conceptos y prepárate para el quiz final.</p>

    <div class="progress-tracker" id="progressTracker">
        <div class="progress-step" id="ps1">1</div><div class="progress-line"><div class="progress-line-fill" id="pl1"></div></div>
        <div class="progress-step" id="ps2">2</div><div class="progress-line"><div class="progress-line-fill" id="pl2"></div></div>
        <div class="progress-step" id="ps3">3</div><div class="progress-line"><div class="progress-line-fill" id="pl3"></div></div>
        <div class="progress-step" id="ps4">4</div><div class="progress-line"><div class="progress-line-fill" id="pl4"></div></div>
        <div class="progress-step" id="ps5">5</div><div class="progress-line"><div class="progress-line-fill" id="pl5"></div></div>
        <div class="progress-step" id="ps6">6</div>
    </div>

    <div class="complete-banner" id="completeBanner">
        <div style="font-size:48px;margin-bottom:.5rem">🎉</div>
        <h3 style="color:#c4b5fd">¡Felicidades, completaste todos los módulos!</h3>
        <p>Has dominado los fundamentos de la IA Generativa. Ahora es momento de poner a prueba tu conocimiento.</p>
        <a href="quiz.jsp" class="btn-quiz-go">Ir al Quiz →</a>
        <div class="auto-redirect-countdown">Redirigiendo al quiz en <span id="countdownNum">8</span> segundos...</div>
        <div class="auto-redirect-bar"><div class="auto-redirect-fill" id="countdownBar"></div></div>
    </div>

    <!-- MÓDULO 1 -->
    <div class="card-tema" id="c1">
      <button class="card-header-btn" onclick="toggle('c1')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">🤖</div><div><div class="card-cat">Introducción</div><div class="card-title-ap">¿Qué es la IA Generativa?</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>¿Qué es?</strong> La <span class="highlight">IA Generativa</span> es una rama de la inteligencia artificial capaz de <strong>crear contenido nuevo</strong>: texto, imágenes, audio, video y código. A diferencia de la IA tradicional que solo clasifica o predice datos, esta produce algo original aprendiendo patrones de enormes conjuntos de información. Es como un <strong>artista digital</strong> que ha estudiado millones de obras y ahora puede crear las suyas propias.</p>
        <p class="para"><strong>¿Cómo aprende?</strong> Se entrena con millones de ejemplos mediante un proceso llamado <span class="highlight">entrenamiento profundo</span> (deep learning). Un modelo de texto aprende de libros, artículos e internet; uno de imágenes aprende de fotos etiquetadas. Con ese entrenamiento masivo, la IA desarrolla la capacidad de generar contenido coherente y creativo que <strong>nunca existió antes</strong> pero que sigue patrones reales aprendidos.</p>
        <p class="para"><strong>Aplicaciones reales.</strong> Hoy se usa para redactar textos profesionales, crear arte digital, componer música original, programar código completo, traducir idiomas con precisión y construir <span class="highlight">asistentes virtuales</span> inteligentes. Empresas como OpenAI, Google, Anthropic y Meta lideran este campo con modelos cada vez más potentes y accesibles para el público general.</p>
        <p class="para"><strong>Impacto profesional.</strong> Saber usar IA Generativa ya es una <span class="highlight">ventaja competitiva enorme</span>. Diseñadores, programadores, marketers y educadores que dominan estas herramientas producen más en menos tiempo y con mayor calidad. Según estudios recientes, es la habilidad más demandada del mercado tech actual y del futuro cercano.</p>
        <div style="margin-top:.85rem;display:flex;gap:4px;flex-wrap:wrap">
            <span class="key-concept">🤖 Inteligencia Artificial</span>
            <span class="key-concept">🧠 Deep Learning</span>
            <span class="key-concept">🎨 Creatividad Digital</span>
            <span class="key-concept">💼 Impacto Laboral</span>
        </div>
        <div class="card-foot-ap"><span class="badge-s" id="s1">5 min</span><button class="btn-read" id="b1" onclick="markDone('c1','s1','b1',1)">Marcar leído</button></div>
      </div></div>
    </div>

    <!-- MÓDULO 2 -->
    <div class="card-tema" id="c2">
      <button class="card-header-btn" onclick="toggle('c2')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">📚</div><div><div class="card-cat">Modelos</div><div class="card-title-ap">Modelos de lenguaje (LLM)</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>¿Qué es un LLM?</strong> Un <span class="highlight">Large Language Model</span> (Modelo de Lenguaje Grande) es un modelo de IA entrenado con enormes volúmenes de texto. Aprende a predecir palabras en contexto y con eso desarrolla <strong>comprensión del lenguaje</strong>, razonamiento lógico y conocimiento general amplio sobre prácticamente cualquier tema. Piensa en él como un <strong>lector voraz</strong> que ha devorado bibliotecas enteras.</p>
        <p class="para"><strong>Los más importantes del mercado.</strong> <span class="highlight">GPT-4o</span> de OpenAI es el más popular mundialmente y destaca por su versatilidad. <span class="highlight">Claude</span> de Anthropic sobresale en razonamiento profundo y seguridad. <span class="highlight">Gemini</span> de Google integra texto, imágenes y audio de forma nativa. <span class="highlight">LLaMA</span> de Meta es open-source, gratuito y se puede instalar localmente en tu propio ordenador sin depender de internet.</p>
        <p class="para"><strong>¿Cómo se entrenan?</strong> El proceso tiene 3 fases clave: <strong>Preentrenamiento</strong> con texto masivo de internet y libros para aprender el lenguaje. Luego <strong>Fine-tuning</strong> (ajuste fino) con datos específicos para mejorar su utilidad en tareas concretas. Finalmente, <span class="highlight">RLHF</span> (Reinforcement Learning from Human Feedback) los hace más seguros, precisos y alineados con lo que el usuario realmente necesita.</p>
        <p class="para"><strong>Limitaciones importantes.</strong> Los LLMs pueden <span class="highlight">"alucinar"</span>: generar información incorrecta con total confianza y apariencia de veracidad. No tienen acceso a internet en tiempo real salvo con plugins especiales. Su conocimiento tiene una fecha de corte (no saben eventos recientes). Siempre <strong>verifica su output</strong> en contextos médicos, legales o técnicos críticos donde un error tendría consecuencias graves.</p>
        <div style="margin-top:.85rem;display:flex;gap:4px;flex-wrap:wrap">
            <span class="key-concept">📖 LLM</span>
            <span class="key-concept">⚙️ Fine-tuning</span>
            <span class="key-concept">🔄 RLHF</span>
            <span class="key-concept">⚠️ Alucinaciones</span>
        </div>
        <div class="card-foot-ap"><span class="badge-s" id="s2">8 min</span><button class="btn-read" id="b2" onclick="markDone('c2','s2','b2',2)">Marcar leído</button></div>
      </div></div>
    </div>

    <!-- MÓDULO 3 -->
    <div class="card-tema" id="c3">
      <button class="card-header-btn" onclick="toggle('c3')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">⚡</div><div><div class="card-cat">Técnica</div><div class="card-title-ap">Prompt Engineering</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>¿Qué es?</strong> El <span class="highlight">Prompt Engineering</span> es el arte y la ciencia de escribir instrucciones precisas a modelos de IA para obtener los mejores resultados posibles. Con el mismo modelo, una persona con buen prompting obtiene resultados notablemente superiores a alguien sin esta habilidad. Es como <strong>saber dar instrucciones</strong> a un asistente天才: cuanto más claro y detallado seas, mejor será el resultado.</p>
        <p class="para"><strong>Fórmula básica del prompt perfecto.</strong> Todo buen prompt debe incluir: <span class="highlight">Rol</span> ("Actúa como experto en..."), <span class="highlight">Contexto</span> (la situación actual), <span class="highlight">Tarea</span> (qué necesitas exactamente), <span class="highlight">Formato</span> (cómo quieres la respuesta: lista, código, tabla, párrafos) y <span class="highlight">Restricciones</span> (qué evitar, longitud máxima, tono).</p>
        <p class="para"><strong>Técnicas avanzadas.</strong> <span class="highlight">Chain-of-Thought</span>: pide que razone paso a paso antes de responder, ideal para problemas complejos. <span class="highlight">Few-Shot</span>: muestra 2-3 ejemplos antes de tu pregunta real para guiar el estilo. <span class="highlight">Tree-of-Thought</span>: hace que el modelo explore múltiples caminos de solución simultáneamente. <span class="highlight">System Prompts</span>: instrucciones globales que condicionan toda la conversación desde el inicio.</p>
        <p class="para"><strong>Ejemplo práctico visual.</strong> <span style="display:block;background:rgba(255,255,255,.03);border:1px solid rgba(255,255,255,.06);border-radius:10px;padding:.7rem;margin-top:.5rem;font-size:12px">❌ <strong>Mal prompt:</strong> "hazme una página web"<br>✅ <strong>Buen prompt:</strong> "Actúa como desarrollador frontend. Crea una página en HTML con Bootstrap 5, tema oscuro (#080808), para una plataforma educativa de IA. Incluye navbar sticky con logo, hero section con botón CTA y 3 tarjetas de cursos con íconos emoji. Tipografía blanca, estilo minimalista Apple."</span> La diferencia en calidad es <strong>abismal</strong>.</p>
        <div style="margin-top:.85rem;display:flex;gap:4px;flex-wrap:wrap">
            <span class="key-concept">📝 Prompt</span>
            <span class="key-concept">🧩 Chain-of-Thought</span>
            <span class="key-concept">📋 Few-Shot</span>
            <span class="key-concept">🎯 System Prompt</span>
        </div>
        <div class="card-foot-ap"><span class="badge-s" id="s3">10 min</span><button class="btn-read" id="b3" onclick="markDone('c3','s3','b3',3)">Marcar leído</button></div>
      </div></div>
    </div>

    <!-- MÓDULO 4 -->
    <div class="card-tema" id="c4">
      <button class="card-header-btn" onclick="toggle('c4')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">🎨</div><div><div class="card-cat">Generación Visual</div><div class="card-title-ap">IA para generar imágenes</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>¿Cómo funciona?</strong> Los modelos de generación de imágenes aprenden de <strong>millones de pares imagen-texto</strong>. Al recibir un prompt descriptivo, generan píxeles que corresponden a esa descripción usando <span class="highlight">Diffusion Models</span> (Modelos de Difusión). El resultado puede ser fotorrealista, artístico, ilustrativo o de cualquier estilo visual imaginable. El proceso es similar a un <strong>pintor digital</strong> que parte de ruido aleatorio y lo transforma gradualmente en una imagen coherente.</p>
        <div class="tool-grid">
          <div class="tool-chip"><strong>🎭 Midjourney</strong>Calidad artística superior, resultados impactantes con descripciones simples</div>
          <div class="tool-chip"><strong>🤍 DALL·E 3</strong>De OpenAI, integrado en ChatGPT Plus, excelente precisión con texto</div>
          <div class="tool-chip"><strong>⚙️ Stable Diffusion</strong>Open source, completamente gratis, instalable en tu PC sin internet</div>
          <div class="tool-chip"><strong>🔥 Adobe Firefly</strong>Legal para uso comercial, integrado nativamente en Photoshop</div>
          <div class="tool-chip"><strong>✏️ Ideogram</strong>Especialista en texto dentro de imágenes, ideal para logos y carteles</div>
          <div class="tool-chip"><strong>🦁 Leonardo AI</strong>Perfecto para personajes, concept art y diseño de videojuegos</div>
        </div>
        <p class="para"><strong>Cómo escribir prompts para imágenes.</strong> Un buen prompt visual debe especificar: <span class="highlight">Estilo</span> (fotorrealista, anime, acuarela, 3D render), <span class="highlight">Iluminación</span> (luz dorada de atardecer, neón, estudio), <span class="highlight">Composición</span> (plano general, primer plano, aéreo), <span class="highlight">Cámara</span> (bokeh, gran angular, macro) y <span class="highlight">Calidad</span> (4K, 8K, hyperdetailed, award-winning). Ejemplo completo: <span style="color:rgba(255,255,255,.6)">"futuristic city at night, neon lights, cyberpunk style, cinematic lighting, 4K, photorealistic"</span>.</p>
        <p class="para"><strong>Negative prompts.</strong> La mayoría de herramientas permiten indicar qué <strong>NO</strong> quieres en la imagen. Usa términos como: "blurry, low quality, distorted, watermark, extra fingers, bad anatomy, ugly" para eliminar los defectos más comunes que los modelos generan espontáneamente. Los <span class="highlight">negative prompts</span> son tan importantes como el prompt principal.</p>
        <div style="margin-top:.85rem;display:flex;gap:4px;flex-wrap:wrap">
            <span class="key-concept">🎨 Difusión</span>
            <span class="key-concept">🖼️ Prompts Visuales</span>
            <span class="key-concept">🚫 Negative Prompt</span>
            <span class="key-concept">📐 Composición</span>
        </div>
        <div class="card-foot-ap"><span class="badge-s" id="s4">8 min</span><button class="btn-read" id="b4" onclick="markDone('c4','s4','b4',4)">Marcar leído</button></div>
      </div></div>
    </div>

    <!-- MÓDULO 5 -->
    <div class="card-tema" id="c5">
      <button class="card-header-btn" onclick="toggle('c5')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">🎬</div><div><div class="card-cat">Generación Visual</div><div class="card-title-ap">IA para generar videos</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>La nueva frontera de la IA.</strong> La generación de video con IA es la tecnología que más avanzó en <span class="highlight">2024-2025</span>. Ya es posible crear videos realistas de segundos a minutos partiendo solo de texto o imágenes. La calidad mejora cada mes y el costo baja drásticamente, haciendo la producción de video profesional accesible para cualquier persona sin equipo costoso ni conocimientos técnicos.</p>
        <div class="tool-grid">
          <div class="tool-chip"><strong>🌀 Sora (OpenAI)</strong>Genera videos hasta 1 minuto con calidad cinematográfica realista</div>
          <div class="tool-chip"><strong>🎞️ Runway Gen-3</strong>Profesional, usado en producción real de películas y comerciales</div>
          <div class="tool-chip"><strong>🪁 Kling AI</strong>Excelente calidad gratuita con límites diarios generosos</div>
          <div class="tool-chip"><strong>⚡ Pika Labs</strong>Rápido e intuitivo, ideal para principiantes y redes sociales</div>
          <div class="tool-chip"><strong>👤 HeyGen</strong>Avatares digitales que hablan, perfecto para cursos corporativos</div>
          <div class="tool-chip"><strong>💫 Luma Dream Machine</strong>Gratis, buena calidad, videos fluidos de 5 segundos</div>
        </div>
        <p class="para"><strong>Flujo de trabajo profesional con IA.</strong> <span class="highlight">Paso 1:</span> Genera la imagen base en Midjourney. <span class="highlight">Paso 2:</span> Anímala en Runway o Kling AI. <span class="highlight">Paso 3:</span> Agrega voz realista con ElevenLabs. <span class="highlight">Paso 4:</span> Añade música original con Suno AI. <span class="highlight">Paso 5:</span> Edita todo en CapCut con subtítulos automáticos. Con este flujo produces <strong>contenido de nivel profesional</strong> completamente con IA y en minutos.</p>
        <p class="para"><strong>Usos profesionales en el mundo real.</strong> Publicidad de productos sin sesión fotográfica costosa, presentaciones empresariales animadas, contenido viral para redes sociales, prototipos de cortometrajes, avatares digitales para cursos online, y videos explicativos sin necesidad de cámara, actores ni locación física. Las posibilidades son <strong>prácticamente ilimitadas</strong>.</p>
        <div style="margin-top:.85rem;display:flex;gap:4px;flex-wrap:wrap">
            <span class="key-concept">🎬 Sora</span>
            <span class="key-concept">🎞️ Runway</span>
            <span class="key-concept">👤 HeyGen</span>
            <span class="key-concept">🎵 Suno AI</span>
        </div>
        <div class="card-foot-ap"><span class="badge-s" id="s5">10 min</span><button class="btn-read" id="b5" onclick="markDone('c5','s5','b5',5)">Marcar leído</button></div>
      </div></div>
    </div>

    <!-- MÓDULO 6 -->
    <div class="card-tema" id="c6">
      <button class="card-header-btn" onclick="toggle('c6')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">💻</div><div><div class="card-cat">Para Programadores</div><div class="card-title-ap">IA Tools para Developers</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>IA que programa contigo.</strong> Los desarrolladores que usan IA producen código hasta <span class="highlight">3 veces más rápido</span> según estudios de GitHub. La IA no reemplaza al programador: <strong>amplifica su capacidad</strong>. Saber qué herramienta usar y cuándo es la nueva habilidad fundamental del developer moderno. No es trampa, es trabajar con <strong>inteligencia aumentada</strong>.</p>
        <div class="tool-grid">
          <div class="tool-chip"><strong>🤖 GitHub Copilot</strong>Autocompleta código en tiempo real, compatible con VS Code y NetBeans</div>
          <div class="tool-chip"><strong>🧠 Claude</strong>El mejor para explicar código legacy, refactoring y diseño de arquitectura</div>
          <div class="tool-chip"><strong>💬 ChatGPT</strong>Excelente para debugging, generar SQL y explicaciones paso a paso</div>
          <div class="tool-chip"><strong>⌨️ Cursor IDE</strong>Editor con IA integrada que promete reemplazar VS Code completamente</div>
          <div class="tool-chip"><strong>📝 Tabnine</strong>IA de código que aprende tu estilo personal de programación y se adapta</div>
          <div class="tool-chip"><strong>🚀 v0 by Vercel</strong>Genera interfaces web completas desde una simple descripción en texto</div>
        </div>
        <p class="para"><strong>Cómo usarla bien en Java.</strong> Pídele a la IA que: explique errores de compilación <span class="highlight">línea por línea</span>, genere métodos con JavaDoc automático completo, refactorice código legacy a versiones modernas, escriba queries SQL optimizados con índices, cree pruebas unitarias JUnit automáticas y sugiera <strong>patrones de diseño</strong> adecuados para tu arquitectura específica. La IA es tu <span class="highlight">pair programmer</span> ideal.</p>
        <p class="para"><strong>Consejo final del curso.</strong> <span style="display:block;background:linear-gradient(135deg,rgba(124,58,237,.1),rgba(79,70,229,.05));border:1px solid rgba(124,58,237,.15);border-radius:10px;padding:.7rem;margin-top:.5rem;font-size:12px">🔥 <strong>No copies código sin entenderlo.</strong> Usa la IA para <strong>aprender más rápido</strong>, no para evadir el aprendizaje. Pídele que te explique cada línea que genera, por qué eligió esa solución y qué alternativas existen. Un programador que entiende y usa IA es <strong>invaluable</strong>; uno que solo copia sin entender queda expuesto cuando la IA falla o el cliente hace preguntas técnicas profundas.</span></p>
        <div style="margin-top:.85rem;display:flex;gap:4px;flex-wrap:wrap">
            <span class="key-concept">🤖 Copilot</span>
            <span class="key-concept">⌨️ Cursor</span>
            <span class="key-concept">🧪 JUnit</span>
            <span class="key-concept">🚀 v0</span>
        </div>
        <div class="card-foot-ap"><span class="badge-s" id="s6">12 min</span><button class="btn-read" id="b6" onclick="markDone('c6','s6','b6',6)">Marcar leído</button></div>
      </div></div>
    </div>

</div>

<script>
let doneCount = parseInt(localStorage.getItem('doneCount') || '0');
const total = 6;
let redirectTimer = null;

function updateProgress(){
    document.getElementById('modCount').textContent = doneCount;
    for(let i=1; i<=total; i++){
        const step = document.getElementById('ps'+i);
        const line = document.getElementById('pl'+i);
        const card = document.getElementById('c'+i);
        if(i <= doneCount){
            step.classList.add('done');
            if(card) card.classList.add('done-module');
            if(line) line.style.width = '100%';
        } else {
            step.classList.remove('done');
            if(card) card.classList.remove('done-module');
            if(line) line.style.width = '0%';
        }
    }
    const banner = document.getElementById('completeBanner');
    const navQuiz = document.getElementById('navQuiz');
    if(doneCount >= total){
        banner.classList.add('show');
        if(navQuiz) navQuiz.className = 'btn-apple btn-apple-accent';
        startRedirectCountdown();
    } else {
        banner.classList.remove('show');
        if(navQuiz) navQuiz.className = 'btn-apple';
        clearInterval(redirectTimer);
    }
    localStorage.setItem('doneCount', doneCount.toString());
}

function toggle(id){
    document.getElementById(id).classList.toggle('open');
}

function markDone(cardId, sId, bId, num){
    const card = document.getElementById(cardId);
    if(!card.classList.contains('open')) {
        card.classList.add('open');
    }
    const s=document.getElementById(sId), b=document.getElementById(bId);
    if(b.disabled) return;
    s.textContent='✓ Leído'; s.classList.add('done');
    b.textContent='✓ Completado'; b.classList.add('done'); b.disabled=true;
    if(num > doneCount){
        doneCount = num;
    } else {
        doneCount++;
        if(doneCount > total) doneCount = total;
    }
    updateProgress();
}

function startRedirectCountdown(){
    let secs = 8;
    const numEl = document.getElementById('countdownNum');
    const barEl = document.getElementById('countdownBar');
    barEl.style.width = '100%';
    clearInterval(redirectTimer);
    redirectTimer = setInterval(() => {
        secs--;
        numEl.textContent = secs;
        barEl.style.width = (secs/8*100) + '%';
        if(secs <= 0){
            clearInterval(redirectTimer);
            window.location.href = 'quiz.jsp';
        }
    }, 1000);
}

function resetProgress(){
    doneCount = 0;
    localStorage.setItem('doneCount', '0');
    for(let i=1; i<=total; i++){
        const s = document.getElementById('s'+i);
        const b = document.getElementById('b'+i);
        if(s){ s.textContent = ['5 min','8 min','10 min','8 min','10 min','12 min'][i-1]; s.classList.remove('done'); }
        if(b){ b.textContent = 'Marcar leído'; b.classList.remove('done'); b.disabled = false; }
        const card = document.getElementById('c'+i);
        if(card) card.classList.remove('done-module');
    }
    updateProgress();
    clearInterval(redirectTimer);
}

String.prototype.hashCode = function(){let h=0;for(let i=0;i<this.length;i++){h=((h<<5)-h)+this.charCodeAt(i);h|=0}return h};
(function(){
    const stored = localStorage.getItem('doneCount');
    if(stored){
        doneCount = parseInt(stored) || 0;
        if(doneCount > total) doneCount = total;
        for(let i=1; i<=doneCount; i++){
            const s = document.getElementById('s'+i);
            const b = document.getElementById('b'+i);
            if(s){ s.textContent='✓ Leído'; s.classList.add('done'); }
            if(b){ b.textContent='✓ Completado'; b.classList.add('done'); b.disabled=true; }
        }
    }
    updateProgress();
})();
</script>
</body>
</html>