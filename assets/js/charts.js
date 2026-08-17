/* ============================================================
   charts.js — graficas de linea en SVG, sin dependencias.
   Escala con el contenedor (viewBox), respeta el tema claro /
   oscuro y trae capa de exploracion (cruceta + tooltip).
   Uso:
     Charts.line(document.querySelector('#g1'), {
       periods: SERIES.periodo,
       series: [{ name: 'IGAE', values: SERIES.igae, c: 1 }],
       yTitle: 'Indice 2018 = 100'
     });
   ============================================================ */
(function (global) {
  "use strict";

  var NS = "http://www.w3.org/2000/svg";
  var MESES = ["ene", "feb", "mar", "abr", "may", "jun",
               "jul", "ago", "sep", "oct", "nov", "dic"];

  function svgEl(name, attrs, parent) {
    var n = document.createElementNS(NS, name);
    for (var k in attrs) {
      if (attrs[k] !== null && attrs[k] !== undefined) n.setAttribute(k, attrs[k]);
    }
    if (parent) parent.appendChild(n);
    return n;
  }

  function htmlEl(tag, cls, parent) {
    var n = document.createElement(tag);
    if (cls) n.className = cls;
    if (parent) parent.appendChild(n);
    return n;
  }

  /* "2002/01" -> "ene 2002" */
  function etiquetaPeriodo(p) {
    if (!p) return "";
    var parts = String(p).split("/");
    var m = parseInt(parts[1], 10);
    return (MESES[m - 1] || parts[1]) + " " + parts[0];
  }

  function fmtNum(v, dec) {
    if (v === null || v === undefined || isNaN(v)) return "—";
    if (Object.is(v, -0)) v = 0;              /* evita el "-0" en los cortes */
    return v.toLocaleString("es-MX", {
      minimumFractionDigits: dec, maximumFractionDigits: dec
    });
  }

  /* Cortes redondos para el eje vertical */
  function ticksBonitos(min, max, objetivo) {
    if (min === max) { min -= 1; max += 1; }
    var crudo = (max - min) / objetivo;
    var mag = Math.pow(10, Math.floor(Math.log10(crudo)));
    var norm = crudo / mag;
    var paso = (norm <= 1 ? 1 : norm <= 2 ? 2 : norm <= 2.5 ? 2.5 : norm <= 5 ? 5 : 10) * mag;
    var t = [], v = Math.ceil(min / paso) * paso;
    for (; v <= max + paso * 1e-6; v += paso) t.push(Math.round(v / paso) * paso);
    return { ticks: t, paso: paso };
  }

  function decimalesDe(paso) {
    if (paso >= 10) return 0;
    if (paso >= 1) return 0;
    if (paso >= 0.1) return 1;
    if (paso >= 0.01) return 2;
    return 3;
  }

  function extremos(series) {
    var lo = Infinity, hi = -Infinity;
    series.forEach(function (s) {
      s.values.forEach(function (v) {
        if (v === null || v === undefined || isNaN(v)) return;
        if (v < lo) lo = v;
        if (v > hi) hi = v;
      });
    });
    return [lo, hi];
  }

  function line(host, opt) {
    if (!host) return null;
    opt = opt || {};
    var series = opt.series || [];
    var periods = opt.periods || [];
    var n = periods.length;
    var W = opt.width || 920;
    var H = opt.height || 330;
    var mostrarLeyenda = opt.legend !== undefined ? opt.legend : series.length > 1;
    var etiquetasFin = opt.endLabels !== undefined ? opt.endLabels : true;

    var lim = extremos(series);
    var lo = opt.yMin !== undefined ? opt.yMin : lim[0];
    var hi = opt.yMax !== undefined ? opt.yMax : lim[1];
    var holgura = (hi - lo) * 0.08 || 1;
    if (opt.yMin === undefined) lo -= holgura;
    if (opt.yMax === undefined) hi += holgura;
    var ejeY = ticksBonitos(lo, hi, opt.yTicks || 4);
    var dec = opt.yDecimals !== undefined ? opt.yDecimals : decimalesDe(ejeY.paso);
    var ancho = Math.max.apply(null, ejeY.ticks.map(function (t) {
      return fmtNum(t, dec).length;
    }));

    var pad = {
      l: (opt.padLeft !== undefined ? opt.padLeft : 14 + ancho * 7.2),
      r: opt.padRight !== undefined ? opt.padRight : (etiquetasFin ? 58 : 14),
      t: opt.padTop !== undefined ? opt.padTop : (opt.plotTitle ? 26 : 12),
      b: opt.xLabels === false ? 10 : 26
    };
    var x0 = pad.l, x1 = W - pad.r, y0 = pad.t, y1 = H - pad.b;

    var X = function (i) { return n < 2 ? x0 : x0 + (i / (n - 1)) * (x1 - x0); };
    var Y = function (v) { return y1 - ((v - lo) / (hi - lo)) * (y1 - y0); };

    /* ---- armazon HTML ---- */
    host.innerHTML = "";
    var fig = htmlEl("figure", "chart", host);
    if (mostrarLeyenda) {
      var leg = htmlEl("div", "chart-legend", fig);
      series.forEach(function (s) {
        var sp = htmlEl("span", "key k" + (s.c || 1), leg);
        sp.textContent = s.name;
      });
    }
    var frame = htmlEl("div", "chart-frame", fig);
    var svg = svgEl("svg", {
      viewBox: "0 0 " + W + " " + H,
      role: "img",
      "aria-label": opt.alt || opt.plotTitle || "Grafica de serie de tiempo"
    }, frame);

    if (opt.plotTitle) {
      svgEl("text", { class: "plot-title", x: x0, y: 14 }, svg).textContent = opt.plotTitle;
    }

    /* ---- retícula y eje vertical ---- */
    ejeY.ticks.forEach(function (t) {
      var y = Y(t);
      if (y < y0 - 1 || y > y1 + 1) return;
      svgEl("line", { class: "grid", x1: x0, x2: x1, y1: y, y2: y }, svg);
      var lab = svgEl("text", {
        class: "tick", x: x0 - 8, y: y, "text-anchor": "end", "dominant-baseline": "middle"
      }, svg);
      lab.textContent = fmtNum(t, dec);
    });
    if (lo < 0 && hi > 0) {
      svgEl("line", { class: "zero", x1: x0, x2: x1, y1: Y(0), y2: Y(0) }, svg);
    }
    svgEl("line", { class: "axis", x1: x0, x2: x1, y1: y1, y2: y1 }, svg);

    /* ---- eje de tiempo: un corte cada k años ---- */
    var cadaK = opt.yearStep || 4;
    for (var i = 0; opt.xLabels !== false && i < n; i++) {
      var p = String(periods[i]).split("/");
      if (p[1] !== "01" || (parseInt(p[0], 10) % cadaK) !== 0) continue;
      var xx = X(i);
      svgEl("line", { class: "axis", x1: xx, x2: xx, y1: y1, y2: y1 + 4 }, svg);
      svgEl("text", {
        class: "tick", x: xx, y: y1 + 17, "text-anchor": "middle"
      }, svg).textContent = p[0];
    }

    /* ---- trazos ---- */
    series.forEach(function (s) {
      var d = "", abierto = false;
      for (var i = 0; i < n; i++) {
        var v = s.values[i];
        if (v === null || v === undefined || isNaN(v)) { abierto = false; continue; }
        d += (abierto ? "L" : "M") + X(i).toFixed(1) + " " + Y(v).toFixed(1) + " ";
        abierto = true;
      }
      s._path = svgEl("path", { class: "line c" + (s.c || 1), d: d }, svg);
    });

    /* ---- punto y etiqueta directa al final de cada serie ---- */
    if (etiquetasFin) {
      var usados = [];
      series.forEach(function (s) {
        var i = n - 1;
        while (i >= 0 && (s.values[i] === null || isNaN(s.values[i]))) i--;
        if (i < 0) return;
        var yv = Y(s.values[i]);
        svgEl("circle", { class: "dot c" + (s.c || 1), cx: X(i), cy: yv, r: 4 }, svg);
        /* evitar que dos etiquetas se encimen */
        var ye = yv;
        usados.forEach(function (u) { if (Math.abs(ye - u) < 14) ye = u + 14; });
        usados.push(ye);
        svgEl("text", {
          class: "endlab", x: Math.min(X(i) + 9, W - 4), y: ye, "dominant-baseline": "middle"
        }, svg).textContent = s.label || fmtNum(s.values[i], dec);
      });
    }

    /* ---- capa de exploracion ---- */
    var cruceta = svgEl("line", { class: "crosshair", x1: 0, x2: 0, y1: y0, y2: y1 }, svg);
    var marcas = series.map(function (s) {
      return svgEl("circle", {
        class: "dot c" + (s.c || 1), cx: -20, cy: -20, r: 4, opacity: 0
      }, svg);
    });
    var tip = htmlEl("div", "chart-tip", frame);
    var hit = svgEl("rect", {
      class: "hit", x: x0, y: y0, width: Math.max(1, x1 - x0), height: Math.max(1, y1 - y0)
    }, svg);

    function mover(ev) {
      var caja = svg.getBoundingClientRect();
      var px = (ev.clientX - caja.left) / caja.width * W;
      var i = Math.round((px - x0) / ((x1 - x0) || 1) * (n - 1));
      i = Math.max(0, Math.min(n - 1, i));
      fig.classList.add("is-hover");
      cruceta.setAttribute("x1", X(i));
      cruceta.setAttribute("x2", X(i));
      var filas = "";
      series.forEach(function (s, k) {
        var v = s.values[i];
        if (v === null || v === undefined || isNaN(v)) {
          marcas[k].setAttribute("opacity", 0);
        } else {
          marcas[k].setAttribute("cx", X(i));
          marcas[k].setAttribute("cy", Y(v));
          marcas[k].setAttribute("opacity", 1);
          filas += '<span class="tip-row"><span class="key dot k' + (s.c || 1) + '">' +
                   s.name + "</span><b>" + fmtNum(v, opt.tipDecimals !== undefined ? opt.tipDecimals : dec) +
                   (opt.unit ? " " + opt.unit : "") + "</b></span>";
        }
      });
      tip.innerHTML = '<span class="tip-when">' + etiquetaPeriodo(periods[i]) + "</span>" + filas;
      tip.style.left = (X(i) / W * 100) + "%";
      tip.style.top = (y0 / H * 100) + "%";
    }

    function salir() { fig.classList.remove("is-hover"); }
    hit.addEventListener("pointermove", mover);
    hit.addEventListener("pointerdown", mover);
    hit.addEventListener("pointerleave", salir);

    if (opt.caption) {
      htmlEl("figcaption", null, fig).innerHTML = opt.caption;
    }
    return fig;
  }

  /* Indice base 100 en la primera observacion disponible */
  function indexar(v, base) {
    var b = base !== undefined ? base : v.find(function (x) { return x !== null && !isNaN(x); });
    return v.map(function (x) {
      return (x === null || isNaN(x)) ? null : 100 * x / b;
    });
  }

  /* Diferencia logaritmica en % (aproximacion a la tasa de variacion) */
  function diffLog(v, escala) {
    var k = escala === undefined ? 100 : escala;
    return v.map(function (x, i) {
      if (i === 0 || x === null || v[i - 1] === null || x <= 0 || v[i - 1] <= 0) return null;
      return k * (Math.log(x) - Math.log(v[i - 1]));
    });
  }

  global.Charts = {
    line: line, indexar: indexar, diffLog: diffLog,
    etiquetaPeriodo: etiquetaPeriodo, fmtNum: fmtNum
  };
})(window);
