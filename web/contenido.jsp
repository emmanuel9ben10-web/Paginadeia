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
        @keyframes pulse{0%,100%{opacity:.5}50%{opacity:1}}
        body{background:#080808;font-family:-apple-system,BlinkMacSystemFont,sans-serif;min-height:100vh;color:#fff}
        .navbar-custom{display:flex;align-items:center;justify-content:space-between;padding:.8rem 2rem;border-bottom:1px solid rgba(255,255,255,.07);background:rgba(8,8,8,.97);position:sticky;top:0;z-index:100}
        .avatar{width:28px;height:28px;border-radius:50%;background:#1e1e1e;border:1px solid rgba(255,255,255,.15);display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:500}
        .btn-apple{font-size:11px;padding:4px 14px;border-radius:20px;background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.1);color:rgba(255,255,255,.6);text-decoration:none;transition:all .2s}
        .btn-apple:hover{background:rgba(255,255,255,.13);color:#fff}
        .btn-apple-w{background:rgba(255,255,255,.93)!important;color:#000!important;font-weight:500}
        .live-tag{display:inline-flex;align-items:center;gap:5px;background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.09);border-radius:20px;padding:3px 12px;font-size:10px;color:rgba(255,255,255,.45);text-transform:uppercase;letter-spacing:.6px;margin-bottom:.9rem}
        .live-dot{width:5px;height:5px;border-radius:50%;background:#fff;display:inline-block;animation:pulse 2s infinite}
        .card-tema{background:#0f0f0f;border:1px solid rgba(255,255,255,.07);border-radius:16px;overflow:hidden;margin-bottom:10px;animation:fadeUp .6s ease both}
        .card-header-btn{width:100%;background:none;border:none;padding:1rem 1.2rem;cursor:pointer;text-align:left;display:flex;align-items:center;justify-content:space-between;gap:12px}
        .card-header-btn:hover{background:rgba(255,255,255,.03)}
        .icon-box{width:42px;height:42px;border-radius:11px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0}
        .card-cat{font-size:10px;color:rgba(255,255,255,.32);text-transform:uppercase;letter-spacing:.7px;margin-bottom:3px}
        .card-title-ap{font-size:14px;font-weight:500;color:#fff;line-height:1.3}
        .chevron{font-size:16px;color:rgba(255,255,255,.22);transition:transform .3s}
        .card-tema.open .chevron{transform:rotate(180deg);color:rgba(255,255,255,.5)}
        .card-body-ap{max-height:0;overflow:hidden;transition:max-height .5s cubic-bezier(.4,0,.2,1),opacity .4s;opacity:0}
        .card-tema.open .card-body-ap{max-height:900px;opacity:1}
        .card-content-ap{padding:.25rem 1.2rem 1.2rem;border-top:1px solid rgba(255,255,255,.05)}
        .para{font-size:13px;color:rgba(255,255,255,.48);line-height:1.75;margin-top:.85rem}
        .para strong{color:rgba(255,255,255,.82);font-weight:500}
        .tool-grid{display:grid;grid-template-columns:1fr 1fr;gap:8px;margin-top:.85rem}
        .tool-chip{background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.08);border-radius:10px;padding:.6rem .85rem;font-size:11px;color:rgba(255,255,255,.55)}
        .tool-chip strong{display:block;color:rgba(255,255,255,.85);font-size:12px;margin-bottom:2px}
        .card-foot-ap{display:flex;align-items:center;justify-content:space-between;margin-top:1rem;padding-top:.85rem;border-top:1px solid rgba(255,255,255,.05)}
        .badge-s{font-size:10px;padding:3px 10px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);border-radius:20px;color:rgba(255,255,255,.3);transition:all .3s}
        .badge-s.done{background:rgba(255,255,255,.1);border-color:rgba(255,255,255,.22);color:rgba(255,255,255,.75)}
        .btn-read{font-size:11px;padding:5px 16px;border-radius:20px;background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.1);color:rgba(255,255,255,.65);cursor:pointer;transition:all .2s}
        .btn-read.done{background:rgba(255,255,255,.1);color:rgba(255,255,255,.8);cursor:default}
    </style>
</head>
<body>
<nav class="navbar-custom">
    <div class="d-flex align-items-center gap-2">
        <span style="font-size:8px">●</span>
        <span style="font-size:14px;font-weight:500">IA Generativa <span style="color:rgba(255,255,255,.35)">/ Contenido</span></span>
    </div>
    <div class="d-flex align-items-center gap-2">
        <div class="avatar"><%= inicial %></div>
        <a href="chat.jsp" class="btn-apple">Chat IA</a>
        <a href="quiz.jsp" class="btn-apple">Quiz</a>
        <a href="logout.jsp" class="btn-apple btn-apple-w">Salir</a>
    </div>
</nav>

<div class="container" style="max-width:700px;padding:2rem 1rem">
    <div class="live-tag"><span class="live-dot"></span>&nbsp;Sesión activa</div>
    <h1 style="font-size:24px;font-weight:600;letter-spacing:-.4px;margin-bottom:.4rem">Hola, <%= usuario %>.<br>¿Qué aprendes hoy?</h1>
    <p style="font-size:13px;color:rgba(255,255,255,.38);margin-bottom:2rem">Toca cada módulo para desplegarlo y leer su contenido completo.</p>
    <p style="font-size:10px;color:rgba(255,255,255,.28);text-transform:uppercase;letter-spacing:1px;margin-bottom:.75rem">6 Módulos disponibles</p>

    <!-- MÓDULO 1 -->
    <div class="card-tema" id="c1">
      <button class="card-header-btn" onclick="toggle('c1')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">🤖</div><div><div class="card-cat">Introducción</div><div class="card-title-ap">¿Qué es la IA Generativa?</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>¿Qué es?</strong> La IA Generativa es una rama de la inteligencia artificial capaz de crear contenido nuevo: texto, imágenes, audio, video y código. A diferencia de la IA tradicional que solo clasifica datos, esta produce algo original aprendiendo patrones de enormes conjuntos de información.</p>
        <p class="para"><strong>¿Cómo aprende?</strong> Se entrena con millones de ejemplos. Un modelo de texto aprende de libros e internet; uno de imágenes aprende de fotos etiquetadas. Con eso desarrolla la capacidad de generar contenido coherente y creativo que nunca existió antes pero que sigue patrones reales.</p>
        <p class="para"><strong>Aplicaciones reales.</strong> Hoy se usa para redactar textos, crear arte digital, componer música, programar código, traducir idiomas y construir asistentes virtuales. Empresas como OpenAI, Google, Anthropic y Meta lideran este campo con modelos cada vez más potentes y accesibles.</p>
        <p class="para"><strong>Impacto profesional.</strong> Saber usar IA Generativa ya es una ventaja competitiva enorme. Diseñadores, programadores, marketers y educadores que dominan estas herramientas producen más en menos tiempo. Es la habilidad más demandada del mercado tech actual y del futuro cercano.</p>
        <div class="card-foot-ap"><span class="badge-s" id="s1">5 min</span><button class="btn-read" id="b1" onclick="markDone('s1','b1')">Marcar leído ✓</button></div>
      </div></div>
    </div>

    <!-- MÓDULO 2 -->
    <div class="card-tema" id="c2">
      <button class="card-header-btn" onclick="toggle('c2')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">📚</div><div><div class="card-cat">Modelos</div><div class="card-title-ap">Modelos de lenguaje LLM</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>¿Qué es un LLM?</strong> Un Large Language Model es un modelo de IA entrenado con enormes volúmenes de texto. Aprende a predecir palabras en contexto y con eso desarrolla comprensión del lenguaje, razonamiento lógico y conocimiento general amplio sobre prácticamente cualquier tema.</p>
        <p class="para"><strong>Los más importantes.</strong> GPT-4o de OpenAI es el más popular mundialmente. Claude de Anthropic destaca en razonamiento y seguridad. Gemini de Google integra texto, imágenes y audio nativamente. LLaMA de Meta es open-source y se puede instalar localmente sin ningún costo.</p>
        <p class="para"><strong>¿Cómo se entrenan?</strong> Primero pasan por preentrenamiento con texto masivo de internet y libros. Luego un ajuste fino (fine-tuning) con datos específicos mejora su utilidad. Finalmente, RLHF (Reinforcement Learning from Human Feedback) los hace más seguros y alineados con lo que el usuario necesita.</p>
        <p class="para"><strong>Limitaciones importantes.</strong> Los LLMs pueden "alucinar": generar información incorrecta con total confianza. No tienen acceso a internet en tiempo real salvo con plugins especiales. Su conocimiento tiene fecha de corte. Siempre verifica su output en contextos médicos, legales o técnicos críticos.</p>
        <div class="card-foot-ap"><span class="badge-s" id="s2">8 min</span><button class="btn-read" id="b2" onclick="markDone('s2','b2')">Marcar leído ✓</button></div>
      </div></div>
    </div>

    <!-- MÓDULO 3 -->
    <div class="card-tema" id="c3">
      <button class="card-header-btn" onclick="toggle('c3')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">⚡</div><div><div class="card-cat">Técnica</div><div class="card-title-ap">Prompt Engineering</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>¿Qué es?</strong> Es el arte de escribir instrucciones precisas a modelos de IA para obtener los mejores resultados posibles. Con el mismo modelo, una persona con buen prompting obtiene resultados notablemente mejores que alguien sin esta habilidad desarrollada.</p>
        <p class="para"><strong>Fórmula básica.</strong> Todo buen prompt incluye: rol ("actúa como experto en..."), contexto (situación actual), tarea (qué necesitas exactamente), formato (cómo quieres la respuesta: lista, código, tabla) y restricciones (qué evitar o qué límites respetar).</p>
        <p class="para"><strong>Técnicas avanzadas.</strong> Chain-of-Thought: pide que razone paso a paso antes de responder. Few-Shot: muestra ejemplos antes de tu pregunta real. Tree-of-Thought: hace que el modelo explore múltiples caminos de solución. System Prompts: instrucciones globales que condicionan toda la conversación.</p>
        <p class="para"><strong>Ejemplo práctico.</strong> Mal prompt: "hazme una página web". Buen prompt: "Crea una página en HTML con Bootstrap 5, tema oscuro, para una plataforma educativa de IA. Incluye navbar sticky, hero con botón CTA y 3 tarjetas de cursos con íconos emoji. Fondo #080808, tipografía blanca, estilo minimalista Apple." La diferencia es abismal.</p>
        <div class="card-foot-ap"><span class="badge-s" id="s3">10 min</span><button class="btn-read" id="b3" onclick="markDone('s3','b3')">Marcar leído ✓</button></div>
      </div></div>
    </div>

    <!-- MÓDULO 4 -->
    <div class="card-tema" id="c4">
      <button class="card-header-btn" onclick="toggle('c4')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">🎨</div><div><div class="card-cat">Generación Visual</div><div class="card-title-ap">IA para generar imágenes</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>¿Cómo funciona?</strong> Los modelos de generación de imágenes aprenden de millones de pares imagen-texto. Al recibir un prompt, generan píxeles que corresponden a esa descripción usando Diffusion Models. El resultado puede ser fotorrealista, artístico, ilustrativo o de cualquier estilo visual imaginable.</p>
        <div class="tool-grid">
          <div class="tool-chip"><strong>🎭 Midjourney</strong>Calidad artística top, resultados increíbles con poco prompt</div>
          <div class="tool-chip"><strong>🤍 DALL·E 3</strong>De OpenAI, integrado en ChatGPT Plus, muy preciso con texto</div>
          <div class="tool-chip"><strong>⚙️ Stable Diffusion</strong>Open source, gratis, instalable en tu PC sin internet</div>
          <div class="tool-chip"><strong>🔥 Adobe Firefly</strong>Legal para uso comercial, integrado en Photoshop</div>
          <div class="tool-chip"><strong>✏️ Ideogram</strong>Excelente para texto dentro de imágenes, logos y carteles</div>
          <div class="tool-chip"><strong>🦁 Leonardo AI</strong>Muy bueno para personajes, concept art y videojuegos</div>
        </div>
        <p class="para"><strong>Cómo escribir prompts para imágenes.</strong> Especifica: estilo (fotorrealista, anime, acuarela, 3D render), iluminación (luz dorada, neón, estudio), composición (plano general, primer plano, aéreo), cámara (bokeh, gran angular, macro) y calidad (4K, 8K, hyperdetailed). Ejemplo: "futuristic city at night, neon lights, cyberpunk style, cinematic lighting, 4K, photorealistic".</p>
        <p class="para"><strong>Negative prompts.</strong> La mayoría de herramientas permiten indicar qué NO quieres en la imagen. Usa: "blurry, low quality, distorted, watermark, extra fingers, bad anatomy" para eliminar los defectos más comunes que los modelos generan espontáneamente.</p>
        <div class="card-foot-ap"><span class="badge-s" id="s4">8 min</span><button class="btn-read" id="b4" onclick="markDone('s4','b4')">Marcar leído ✓</button></div>
      </div></div>
    </div>

    <!-- MÓDULO 5 -->
    <div class="card-tema" id="c5">
      <button class="card-header-btn" onclick="toggle('c5')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">🎬</div><div><div class="card-cat">Generación Visual</div><div class="card-title-ap">IA para generar videos</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>La nueva frontera.</strong> La generación de video con IA es la tecnología que más avanzó en 2024-2025. Ya es posible crear videos realistas de segundos a minutos desde texto o imágenes. La calidad mejora cada mes y el costo baja drásticamente, haciendo la producción de video accesible para cualquiera.</p>
        <div class="tool-grid">
          <div class="tool-chip"><strong>🌀 Sora (OpenAI)</strong>Genera videos hasta 1 min, calidad cinematográfica real</div>
          <div class="tool-chip"><strong>🎞️ Runway Gen-3</strong>Profesional, usado en producción real de películas</div>
          <div class="tool-chip"><strong>🪁 Kling AI</strong>Excelente calidad, gratis con límites diarios generosos</div>
          <div class="tool-chip"><strong>⚡ Pika Labs</strong>Rápido y fácil de usar, ideal para comenzar</div>
          <div class="tool-chip"><strong>👤 HeyGen</strong>Avatares que hablan, ideal para cursos y presentaciones</div>
          <div class="tool-chip"><strong>💫 Luma Dream Machine</strong>Gratis, buena calidad, videos fluidos de 5 segundos</div>
        </div>
        <p class="para"><strong>Flujo de trabajo profesional con IA.</strong> Genera la imagen base en Midjourney → anímala en Runway o Kling → agrega voz realista con ElevenLabs → añade música original con Suno AI → edita en CapCut con subtítulos automáticos. Con este flujo produces contenido de nivel profesional completamente con IA.</p>
        <p class="para"><strong>Usos profesionales.</strong> Publicidad de productos sin sesión fotográfica, presentaciones empresariales animadas, contenido viral para redes sociales, prototipos de cortometrajes, avatares digitales para cursos online y videos explicativos sin necesidad de cámara, actores ni locación.</p>
        <div class="card-foot-ap"><span class="badge-s" id="s5">10 min</span><button class="btn-read" id="b5" onclick="markDone('s5','b5')">Marcar leído ✓</button></div>
      </div></div>
    </div>

    <!-- MÓDULO 6 -->
    <div class="card-tema" id="c6">
      <button class="card-header-btn" onclick="toggle('c6')">
        <div class="d-flex align-items-center gap-3"><div class="icon-box">💻</div><div><div class="card-cat">Para Programadores</div><div class="card-title-ap">IA Tools para Developers</div></div></div>
        <span class="chevron">⌄</span>
      </button>
      <div class="card-body-ap"><div class="card-content-ap">
        <p class="para"><strong>IA que programa contigo.</strong> Los desarrolladores que usan IA producen código hasta 3 veces más rápido según estudios de GitHub. No reemplaza al programador, amplifica su capacidad. Saber qué herramienta usar y cuándo es la nueva habilidad fundamental del developer moderno.</p>
        <div class="tool-grid">
          <div class="tool-chip"><strong>🤖 GitHub Copilot</strong>Autocompleta código en tiempo real en VS Code y NetBeans</div>
          <div class="tool-chip"><strong>🧠 Claude</strong>Mejor para explicar código, refactoring y arquitectura</div>
          <div class="tool-chip"><strong>💬 ChatGPT</strong>Excelente para debugging, SQL y explicaciones paso a paso</div>
          <div class="tool-chip"><strong>⌨️ Cursor IDE</strong>Editor con IA integrada, reemplaza VS Code completamente</div>
          <div class="tool-chip"><strong>📝 Tabnine</strong>IA de código que aprende tu estilo de programación personal</div>
          <div class="tool-chip"><strong>🚀 v0 by Vercel</strong>Genera interfaces web completas desde descripción de texto</div>
        </div>
        <p class="para"><strong>Cómo usarla bien en Java.</strong> Pídele que explique errores de compilación línea por línea, genere métodos con JavaDoc automático, refactorice código legacy, escriba queries SQL optimizados, cree pruebas unitarias JUnit automáticamente y sugiera patrones de diseño adecuados para tu arquitectura específica.</p>
        <p class="para"><strong>Consejo final.</strong> No copies código sin entenderlo. Úsala para aprender más rápido, no para evadir el aprendizaje. Pídele que te explique cada línea que genera. Un programador que entiende y usa IA es invaluable; uno que solo copia sin entender queda expuesto cuando la IA falla o el cliente hace preguntas técnicas.</p>
        <div class="card-foot-ap"><span class="badge-s" id="s6">12 min</span><button class="btn-read" id="b6" onclick="markDone('s6','b6')">Marcar leído ✓</button></div>
      </div></div>
    </div>

</div>
<script>
function toggle(id){document.getElementById(id).classList.toggle('open')}
function markDone(sId,bId){
    const s=document.getElementById(sId),b=document.getElementById(bId);
    s.textContent='✓ Leído';s.classList.add('done');
    b.textContent='✓ Completado';b.classList.add('done');b.disabled=true;
}
</script>
</body>
</html>