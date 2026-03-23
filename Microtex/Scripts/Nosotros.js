/* ============================================================
   Nosotros.js  –  Scripts para la página Nosotros | Microtex
   Ubicación: Scripts/Nosotros.js
   ============================================================ */

(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        initStickyHeader();
        initValueCards();
        initSearchClear();
    });

    /* ── Header: sombra al hacer scroll ──────────────────── */
    function initStickyHeader() {
        var header = document.querySelector('header');
        if (!header) return;

        window.addEventListener('scroll', function () {
            header.classList.toggle('header-scrolled', window.scrollY > 10);
        });
    }

    /* ── Value Cards: fade-in al entrar en viewport ──────── */
    function initValueCards() {
        var cards = document.querySelectorAll('.value-card');
        if (!cards.length || !('IntersectionObserver' in window)) return;

        var observer = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                    observer.unobserve(entry.target);
                }
            });
        }, { threshold: 0.15 });

        cards.forEach(function (card, i) {
            card.style.opacity = '0';
            card.style.transform = 'translateY(24px)';
            card.style.transition =
                'opacity 0.5s ease ' + (i * 0.15) + 's, ' +
                'transform 0.5s ease ' + (i * 0.15) + 's';
            observer.observe(card);
        });
    }

    /* ── Search: limpiar con Escape ──────────────────────── */
    function initSearchClear() {
        // ASP.NET genera el id con el ClientID, buscar por sufijo
        var input = document.querySelector('input[id$="txtSearch"]');
        if (!input) return;

        input.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                input.value = '';
                input.blur();
            }
        });
    }

})();
