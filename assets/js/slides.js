/* ============================================================
   slides.js — motor de diapositivas sin dependencias.
   Escala un escenario de 1280x720 al viewport, navega con
   teclado / clic / gestos, revela fragmentos, sincroniza el
   hash de la URL y ofrece indice, ayuda y cronometro.
   ============================================================ */
(function () {
  "use strict";

  var stage = document.querySelector(".stage");
  if (!stage) return;
  var slides = Array.prototype.slice.call(stage.querySelectorAll(".slide"));
  var total = slides.length;
  var i = 0;          /* diapositiva activa */
  var f = 0;          /* fragmentos revelados en la activa */
  var t0 = null, tTick = null;

  var barra = document.querySelector(".progress");
  var numero = document.querySelector(".chrome-num");
  var indice = document.getElementById("indice");
  var ayuda = document.getElementById("ayuda");

  function fragmentos(k) {
    return Array.prototype.slice.call(slides[k].querySelectorAll(".frag"));
  }

  function pintar() {
    slides.forEach(function (s, k) { s.classList.toggle("is-active", k === i); });
    fragmentos(i).forEach(function (el, k) { el.classList.toggle("on", k < f); });
    if (barra) barra.style.width = (total < 2 ? 100 : (i / (total - 1)) * 100) + "%";
    if (numero) numero.textContent = (i + 1) + " / " + total + (t0 ? "  ·  " + reloj() : "");
    if (indice && indice.classList.contains("on")) marcarIndice();
    var h = "#s" + (i + 1);
    if (location.hash !== h) history.replaceState(null, "", h);
  }

  function ir(k, alFinal) {
    k = Math.max(0, Math.min(total - 1, k));
    i = k;
    f = alFinal ? fragmentos(i).length : 0;
    pintar();
  }

  function siguiente() {
    if (f < fragmentos(i).length) { f++; pintar(); return; }
    if (i < total - 1) ir(i + 1, false);
  }

  function anterior() {
    if (f > 0) { f--; pintar(); return; }
    if (i > 0) ir(i - 1, true);
  }

  /* ---------- escalado del escenario ---------- */
  function escalar() {
    var k = Math.min((window.innerWidth - 20) / 1280, (window.innerHeight - 20) / 720);
    stage.style.transform = "scale(" + k + ")";
  }

  /* ---------- cronometro de sesion ---------- */
  function reloj() {
    var s = Math.floor((Date.now() - t0) / 1000);
    return Math.floor(s / 60) + ":" + String(s % 60).padStart(2, "0");
  }
  function cronometro() {
    if (t0) { t0 = null; clearInterval(tTick); tTick = null; }
    else { t0 = Date.now(); tTick = setInterval(pintar, 1000); }
    pintar();
  }

  /* ---------- indice ---------- */
  function construirIndice() {
    if (!indice) return;
    var cont = indice.querySelector(".ov-grid");
    slides.forEach(function (s, k) {
      var b = document.createElement("button");
      b.type = "button";
      b.innerHTML = '<span class="i">' + (k + 1) + "</span><span>" +
        (s.getAttribute("data-title") || "Diapositiva " + (k + 1)) + "</span>";
      b.addEventListener("click", function () { cerrar(); ir(k, false); });
      cont.appendChild(b);
    });
  }
  function marcarIndice() {
    var bs = indice.querySelectorAll(".ov-grid button");
    Array.prototype.forEach.call(bs, function (b, k) { b.classList.toggle("cur", k === i); });
  }

  function alternar(ov) {
    if (!ov) return;
    var abierto = ov.classList.contains("on");
    cerrar();
    if (!abierto) { ov.classList.add("on"); if (ov === indice) marcarIndice(); }
  }
  function cerrar() {
    [indice, ayuda].forEach(function (o) { if (o) o.classList.remove("on"); });
  }

  function pantallaCompleta() {
    if (document.fullscreenElement) document.exitFullscreen();
    else document.documentElement.requestFullscreen();
  }

  /* ---------- eventos ---------- */
  document.addEventListener("keydown", function (e) {
    if (e.metaKey || e.ctrlKey || e.altKey) return;
    var k = e.key;
    if (k === "Escape") { cerrar(); return; }
    if (["ArrowRight", "ArrowDown", "PageDown", " ", "n"].indexOf(k) >= 0) { e.preventDefault(); siguiente(); }
    else if (["ArrowLeft", "ArrowUp", "PageUp", "p"].indexOf(k) >= 0) { e.preventDefault(); anterior(); }
    else if (k === "Home") { e.preventDefault(); ir(0, false); }
    else if (k === "End") { e.preventDefault(); ir(total - 1, true); }
    else if (k === "o" || k === "s") { e.preventDefault(); alternar(indice); }
    else if (k === "?" || k === "h") { e.preventDefault(); alternar(ayuda); }
    else if (k === "t") { if (window.Theme) window.Theme.alternar(); }
    else if (k === "f") { e.preventDefault(); pantallaCompleta(); }
    else if (k === "c") { e.preventDefault(); cronometro(); }
  });

  /* avance con clic, sin robarse los clics de enlaces ni de las graficas */
  stage.addEventListener("click", function (e) {
    if (e.target.closest("a, button, .chart-frame")) return;
    siguiente();
  });

  var x0 = null;
  stage.addEventListener("touchstart", function (e) { x0 = e.touches[0].clientX; }, { passive: true });
  stage.addEventListener("touchend", function (e) {
    if (x0 === null) return;
    var dx = e.changedTouches[0].clientX - x0;
    if (Math.abs(dx) > 45) { dx < 0 ? siguiente() : anterior(); }
    x0 = null;
  }, { passive: true });

  window.addEventListener("resize", escalar);
  window.addEventListener("orientationchange", escalar);

  /* navegar tambien con el hash de la URL (atras / adelante del navegador) */
  window.addEventListener("hashchange", function () {
    var h = /^#s(\d+)$/.exec(location.hash);
    if (h && parseInt(h[1], 10) - 1 !== i) ir(parseInt(h[1], 10) - 1, false);
  });

  var btn = {
    prev: document.querySelector("[data-nav='prev']"),
    next: document.querySelector("[data-nav='next']"),
    idx: document.querySelector("[data-nav='indice']"),
    full: document.querySelector("[data-nav='full']"),
    help: document.querySelector("[data-nav='ayuda']")
  };
  if (btn.prev) btn.prev.addEventListener("click", anterior);
  if (btn.next) btn.next.addEventListener("click", siguiente);
  if (btn.idx) btn.idx.addEventListener("click", function () { alternar(indice); });
  if (btn.full) btn.full.addEventListener("click", pantallaCompleta);
  if (btn.help) btn.help.addEventListener("click", function () { alternar(ayuda); });
  Array.prototype.forEach.call(document.querySelectorAll(".overlay"), function (o) {
    o.addEventListener("click", function (e) { if (e.target === o) cerrar(); });
  });

  /* ---------- arranque ---------- */
  construirIndice();
  escalar();
  var m = /^#s(\d+)$/.exec(location.hash);
  ir(m ? parseInt(m[1], 10) - 1 : 0, false);

  window.Deck = { ir: ir, siguiente: siguiente, anterior: anterior, total: total };
})();
