/* Tema claro / oscuro con memoria en localStorage.
   El parpadeo inicial se evita con el snippet en <head> de cada pagina. */
(function (global) {
  "use strict";
  var LLAVE = "st-tema";

  function actual() {
    var t = document.documentElement.getAttribute("data-theme");
    if (t) return t;
    return global.matchMedia && global.matchMedia("(prefers-color-scheme: dark)").matches
      ? "dark" : "light";
  }

  function fijar(t) {
    document.documentElement.setAttribute("data-theme", t);
    try { localStorage.setItem(LLAVE, t); } catch (e) { /* modo privado */ }
  }

  function alternar() { fijar(actual() === "dark" ? "light" : "dark"); }

  function init() {
    var botones = document.querySelectorAll("[data-theme-toggle]");
    Array.prototype.forEach.call(botones, function (b) {
      b.addEventListener("click", alternar);
    });
  }

  global.Theme = { init: init, alternar: alternar, actual: actual, fijar: fijar };
  if (document.readyState !== "loading") init();
  else document.addEventListener("DOMContentLoaded", init);
})(window);
