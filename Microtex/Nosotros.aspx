<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Nosotros.aspx.cs" Inherits="Microtex.Nosotros" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Nosotros | Microtex - Pinturas Premium</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="Styles/site.css" rel="stylesheet" type="text/css" />
    <style>
    /* ── Layout fix: contrarrestar site.css ── */
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        font-family: 'Inter', sans-serif;
        background-color: #F7F5EC;
    }
    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }
    body > form {
        display: flex;
        flex-direction: column;
        flex: 1;
        min-height: 100vh;
    }
    body > form > main { flex: 1; }

    /* ── Colores Microtex ── */
    .bg-microtex-beige     { background-color: #F7F5EC; }
    .bg-microtex-dark-beige{ background-color: #E8E4D4; }
    .bg-microtex-brown     { background-color: #3D3529; }
    .text-microtex-brown   { color: #3D3529; }
    .text-microtex-muted   { color: #6B6560; }
    .hero-subtitle         { color: #4A4540; }
    .lab-text              { color: rgba(255,255,255,0.85); }

    /* ── Botones ── */
    .btn-process {
        display: inline-flex;
        align-items: center;
        padding: 0.75rem 1.75rem;
        background: white;
        color: #3D3529;
        font-size: 0.875rem;
        font-weight: 700;
        border-radius: 9999px;
        border: none;
        cursor: pointer;
        transition: background 0.2s;
    }
    .btn-process:hover { background: #F7F5EC; }

    .btn-newsletter {
        padding: 0.5rem 1rem;
        background: #3D3529;
        color: white;
        font-size: 0.875rem;
        font-weight: 600;
        border-radius: 0 0.375rem 0.375rem 0;
        border: none;
        cursor: pointer;
        transition: background 0.2s;
        white-space: nowrap;
    }
    .btn-newsletter:hover { background: #1a1410; }

    /* ── Cards ── */
    .value-card { transition: box-shadow 0.2s, transform 0.2s; }
    .value-card:hover { transform: translateY(-2px); }
    .lab-img-container { min-height: 260px; }
    @media (min-width: 1024px) { .lab-img-container { min-height: 400px; } }

    /* ── CRÍTICO: neutralizar nav global de site.css ── */
    header nav,
    header nav a {
        flex-direction: row !important;
        flex-wrap: nowrap !important;
        flex: none !important;
    }
    header nav a {
        display: inline-flex !important;
        width: auto !important;
        text-align: left !important;
        padding: 0 !important;
        border-bottom: none !important;
    }

    /* ── Mobile menu ── */
    #nos-mobile-menu { display: none; flex-direction: column; }
    #nos-mobile-menu.open { display: flex; }
</style>
</head>
<body class="antialiased">
    <form id="form1" runat="server">

        <header class="sticky top-0 z-50 w-full bg-white/95 backdrop-blur-md border-b border-slate-200 shadow-sm">
            <div class="flex w-full items-center gap-3 px-4 sm:px-6 py-3">

                <a href="Default.aspx" class="flex items-center gap-2 shrink-0">
                    <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-900 text-white font-black text-sm">M</div>
                    <span class="text-base font-black tracking-tight text-slate-900">Microtex</span>
                </a>

                <div class="hidden sm:flex flex-1 mx-4 max-w-md">
                    <div class="relative w-full">
                        <span class="material-symbols-outlined absolute left-3 top-2.5 text-slate-400 text-sm pointer-events-none">search</span>
                        <input type="text" placeholder="Buscar acabados premium..."
                            onkeydown="if(event.key==='Enter'){location.href='productos.aspx?q='+this.value}"
                            class="w-full rounded-full border border-slate-200 bg-slate-50 pl-9 pr-4 py-2 text-sm text-slate-700 focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300" />
                    </div>
                </div>

                <nav class="hidden lg:flex items-center gap-8">
                    <a class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors" href="productos.aspx">Catálogo</a>
                    <a class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors" href="proyectos.aspx">Proyectos</a>
                    <a class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors" href="Nosotros.aspx">Nosotros</a>
                </nav>

                <div class="flex items-center gap-2 shrink-0 ml-auto">
                    <asp:Button ID="btnGetQuote" runat="server" Text="" OnClick="btnGetQuote_Click" UseSubmitBehavior="false" style="display:none;" />
                    <asp:Literal ID="litNavUser" runat="server" />

                    <a href="carrito.aspx"
                        class="relative w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                        <span class="material-symbols-outlined text-xl">shopping_bag</span>
                        <span id="cartBadge" class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none">0</span>
                    </a>
                    <button type="button" id="menu-btn"
                        onclick="document.getElementById('nos-mobile-menu').classList.toggle('open')"
                        class="lg:hidden w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                        <span class="material-symbols-outlined text-xl">menu</span>
                    </button>
                </div>
            </div>

            <div class="sm:hidden px-4 pb-3">
                <div class="relative">
                    <span class="material-symbols-outlined absolute left-3 top-2.5 text-slate-400 text-sm pointer-events-none">search</span>
                    <input type="text" placeholder="Buscar acabados..."
                        onkeydown="if(event.key==='Enter'){location.href='productos.aspx?q='+this.value}"
                        class="w-full rounded-full border border-slate-200 bg-slate-50 pl-9 pr-4 py-2 text-sm text-slate-700 focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300" />
                </div>
            </div>

            <div id="nos-mobile-menu" class="lg:hidden border-t border-slate-100 bg-white px-4 py-3 gap-1">
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="productos.aspx">Catálogo</a>
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="proyectos.aspx">Proyectos</a>
                <a class="block px-3 py-2.5 text-sm font-bold text-slate-900 bg-slate-50 rounded-lg" href="Nosotros.aspx">Nosotros</a>
            </div>
        </header>
        <main>

            <section class="hero-section relative flex items-center bg-microtex-beige overflow-hidden" style="min-height: 320px;">
                <div class="absolute inset-0 opacity-40">
                    <img alt="Textura arquitectónica" class="w-full h-full object-cover"
                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuCPPym0tiRLSe3TSEh6c9ctXFW9w6ERAyROdRMSX-0v6CaAlj5bPcFAUlA1tBgbx3vXAzESSd53vVXvZKdjlUY7mfxrB2V4ydus-Ub19tpyvozCIQTsaER5ewoHWV1SdLJwH6iB2tt2aI9AI9T2zuTfiihhoEIpyUd9GmjPCcUTHKJVqtw4vTYrQpEegI1HZEgw8dFKaWvC8VwbJjt5hLJJuIvH09cbTGdIMBfRUXTCopo964a1vm34jF1YnD6QKxX4z2Q1U6kNUANd" />
                </div>
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10 py-14 sm:py-20">
                    <div class="max-w-2xl">
                        <nav aria-label="Breadcrumb" class="flex mb-4 text-xs sm:text-sm text-microtex-muted font-medium">
                            <ol class="inline-flex items-center space-x-1 md:space-x-3">
                                <li><a class="hover:text-black" href="Default.aspx">Home</a></li>
                                <li><span class="mx-2">/</span></li>
                                <li class="text-black">Nosotros</li>
                            </ol>
                        </nav>
                        <h1 class="text-3xl sm:text-5xl md:text-6xl font-bold text-microtex-brown mb-4 sm:mb-6 leading-tight">
                            <asp:Literal ID="litHeroTitle" runat="server" Text="Nuestra Historia" />
                        </h1>
                        <p class="text-base sm:text-xl hero-subtitle leading-relaxed mb-6 sm:mb-8">
                            <asp:Literal ID="litHeroSubtitle" runat="server"
                                Text="Desde 2024, Microtex nace con el objetivo de ofrecer soluciones de pintura de alta calidad para proyectos residenciales, comerciales e industriales. Combinamos innovación, tecnología y materiales de primera para transformar espacios con acabados duraderos, modernos y confiables." />
                        </p>
                    </div>
                </div>
            </section>

            <section class="py-14 sm:py-24 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-10 sm:gap-16 items-center">

                        <div>
                            <div class="mb-8 sm:mb-12">
                                <div class="w-12 h-1 bg-microtex-brown mb-4 sm:mb-6"></div>
                                <h2 class="text-2xl sm:text-3xl font-bold mb-3 sm:mb-4">Misión</h2>
                                <p class="text-base sm:text-lg text-microtex-muted leading-relaxed">
                                    <asp:Literal ID="litMission" runat="server"
                                        Text="Nuestra misión es ofrecer pinturas y recubrimientos de alta calidad que brinden protección, durabilidad y estética a cada proyecto. Buscamos superar las expectativas de nuestros clientes mediante productos confiables, innovación constante y un servicio comprometido con la excelencia." />
                                </p>
                            </div>
                            <div>
                                <div class="w-12 h-1 bg-microtex-brown mb-4 sm:mb-6"></div>
                                <h2 class="text-2xl sm:text-3xl font-bold mb-3 sm:mb-4">Visión</h2>
                                <p class="text-base sm:text-lg text-microtex-muted leading-relaxed">
                                    <asp:Literal ID="litVision" runat="server"
                                        Text="Ser una empresa reconocida en el sector de pinturas y recubrimientos por la calidad de nuestros productos, la innovación en nuestras soluciones y la confianza que generamos en nuestros clientes, consolidándonos como una marca referente en el mercado nacional." />
                                </p>
                            </div>
                        </div>

                        <div class="relative">
                            <div class="aspect-square rounded-2xl overflow-hidden bg-microtex-beige shadow-xl">
                                <img alt="Arquitectura moderna" class="w-full h-full object-cover"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuD45L27TRqbMtidpwr2IishbKTnk_5ZYalUgmj7UF4sC8g9v4dEKZh6y1ia6AWdMqlh3EFzne25eMjnNfxbDcAdOvdkAY3hwx0mGYqZpkyUWqq49q8-za6r-b4AeH4knG7BmI_3IdxpKwEE8h8Uour6IJrSOV-7X1GYWdMjrp9uQ4CwyS30sEL5WhM-rVHQQa8L34vWthGTvdQZCZwzw2PhHbLw74pJ5ELnTTbsmIsMu2IcpCDtDlPEySqjNH_-idhCPMB24VyD9QAe" />
                            </div>
                            <div class="hidden md:block absolute -bottom-6 -left-6 w-48 h-48 bg-microtex-dark-beige -z-10 rounded-2xl"></div>
                        </div>

                    </div>
                </div>
            </section>

            <section class="py-14 sm:py-24 bg-gray-50">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-10 sm:mb-16">
                        <h2 class="text-3xl sm:text-4xl font-bold mb-3 sm:mb-4">Valores que nos Definen</h2>
                        <p class="text-microtex-muted max-w-2xl mx-auto text-sm sm:text-base">La esencia de Microtex reside en el compromiso inquebrantable con la excelencia y la responsabilidad.</p>
                    </div>
                    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 sm:gap-12">

                        <div class="bg-white p-8 sm:p-10 rounded-xl shadow-sm hover:shadow-md transition text-center border border-gray-100 value-card">
                            <div class="w-14 h-14 sm:w-16 sm:h-16 bg-microtex-beige rounded-full flex items-center justify-center mx-auto mb-5 sm:mb-6">
                                <svg class="w-7 h-7 sm:w-8 sm:h-8 text-microtex-brown" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"></path>
                                </svg>
                            </div>
                            <h3 class="text-lg sm:text-xl font-bold mb-3 sm:mb-4">Calidad Superior</h3>
                            <p class="text-microtex-muted text-sm sm:text-base">Utilizamos materias primas de grado profesional para garantizar acabados duraderos y vibrantes.</p>
                        </div>

                        <div class="bg-white p-8 sm:p-10 rounded-xl shadow-sm hover:shadow-md transition text-center border border-gray-100 value-card">
                            <div class="w-14 h-14 sm:w-16 sm:h-16 bg-microtex-beige rounded-full flex items-center justify-center mx-auto mb-5 sm:mb-6">
                                <svg class="w-7 h-7 sm:w-8 sm:h-8 text-microtex-brown" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M13 10V3L4 14h7v7l9-11h-7z" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"></path>
                                </svg>
                            </div>
                            <h3 class="text-lg sm:text-xl font-bold mb-3 sm:mb-4">Innovación Constante</h3>
                            <p class="text-microtex-muted text-sm sm:text-base">Inversión continua en I+D para crear fórmulas inteligentes que resisten el paso del tiempo.</p>
                        </div>

                        <div class="bg-white p-8 sm:p-10 rounded-xl shadow-sm hover:shadow-md transition text-center border border-gray-100 value-card sm:col-span-2 md:col-span-1">
                            <div class="w-14 h-14 sm:w-16 sm:h-16 bg-microtex-beige rounded-full flex items-center justify-center mx-auto mb-5 sm:mb-6">
                                <svg class="w-7 h-7 sm:w-8 sm:h-8 text-microtex-brown" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9m-9 9a9 9 0 019-9" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"></path>
                                </svg>
                            </div>
                            <h3 class="text-lg sm:text-xl font-bold mb-3 sm:mb-4">Sostenibilidad</h3>
                            <p class="text-microtex-muted text-sm sm:text-base">Fórmulas eco-amigables con bajos COVs, priorizando la salud planetaria y del usuario.</p>
                        </div>

                    </div>
                </div>
            </section>

            <section class="py-14 sm:py-24 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="lab-card bg-microtex-brown overflow-hidden flex flex-col lg:flex-row items-stretch rounded-2xl">

                        <div class="lg:w-1/2 p-8 sm:p-12 lg:p-20 flex flex-col justify-center text-white">
                            <h2 class="text-2xl sm:text-4xl font-bold mb-4 sm:mb-6">Donde la Calidad Nace</h2>
                            <p class="text-sm sm:text-lg lab-text leading-relaxed mb-6 sm:mb-8">
                                En Microtex cuidamos cada detalle del proceso de producción. Nuestros productos son desarrollados con materias primas de alta calidad y sometidos a estrictos controles para garantizar resistencia, durabilidad y un acabado profesional en cada aplicación.
                            </p>
                            <div>
                                <asp:Button ID="btnProcess" runat="server"
                                    Text="Conoce el Proceso"
                                    CssClass="btn-process"
                                    OnClick="btnProcess_Click" />
                            </div>
                        </div>

                        <div class="lg:w-1/2 relative lab-img-container" style="min-height: 260px;">
                            <img alt="Laboratorio Moderno Microtex" class="absolute inset-0 w-full h-full object-cover"
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuAaHYef8etOU6dFrAYQttAYGWxegzYdYuo2vJZN_xgY_kHbAEJF9tlaD6elXhOqMq6F49g2lxe3oWkbjVqH9H_7Hg7CjBHObwaovXUUie3tPM0X4DnvvKA5J3XkvWhQKBAzeQ-5Zs_F7MIDZGz-X-DlyQEHckifAxj7MkTUpQ9ozqrWmzzfl-rR_EM-jesJkY3tpH9bG0XZNXDqTyx__6UE2v8c7OieGSHS5QBJfmzEazlLjKiOysdZZ3UNHcgbVtKnY7pzl1uOW_KD" />
                        </div>

                    </div>
                </div>
            </section>

        </main>

        <footer class="bg-white border-t border-gray-100 pt-14 sm:pt-20 pb-8 sm:pb-10">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8 sm:gap-12 mb-10 sm:mb-16">

                    <div class="sm:col-span-2 lg:col-span-1">
                        <div class="flex items-center gap-2 mb-4 sm:mb-6">
                            <div class="w-6 h-6 bg-black flex items-center justify-center text-white text-xs font-bold rounded">M</div>
                            <span class="text-lg font-bold tracking-tight text-gray-900 uppercase">Microtex</span>
                        </div>
                        <p class="text-microtex-muted text-sm leading-relaxed mb-6 sm:mb-8">
                            Transformando superficies con innovación, durabilidad y calidad desde 2024. 
                        </p>
                        <div class="flex space-x-4 text-microtex-muted">
                            <a class="hover:text-black" href="#">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3V2z"></path></svg></a>
                            <a class="hover:text-black" href="#">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.791-4-4s1.791-4 4-4 4 1.791 4 4-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"></path></svg></a>
                            <a class="hover:text-black" href="#">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></a>
                        </div>
                    </div>

                    <div>
                        <h4 class="font-bold text-sm uppercase tracking-wider mb-4 sm:mb-6">Productos</h4>
                        <ul class="space-y-3 sm:space-y-4 text-sm text-microtex-muted">
                            <li><a class="hover:text-black" href="productos.aspx">Interior Solutions</a></li>
                            <li><a class="hover:text-black" href="productos.aspx">Exterior Protection</a></li>
                            <li><a class="hover:text-black" href="productos.aspx">Industrial Coatings</a></li>
                            <li><a class="hover:text-black" href="productos.aspx">Eco-Series</a></li>
                        </ul>
                    </div>

                    <div>
                        <h4 class="font-bold text-sm uppercase tracking-wider mb-4 sm:mb-6">Empresa</h4>
                        <ul class="space-y-3 sm:space-y-4 text-sm text-microtex-muted">
                            <li><a class="text-black font-semibold" href="Nosotros.aspx">Nosotros</a></li>
                            <li><a class="hover:text-black" href="#">Sostenibilidad</a></li>
                            <li><a class="hover:text-black" href="#">Contacto</a></li>
                            <li><a class="hover:text-black" href="#">Carreras</a></li>
                        </ul>
                    </div>

                    <div>
                        <h4 class="font-bold text-sm uppercase tracking-wider mb-4 sm:mb-6">Newsletter</h4>
                        <p class="text-sm text-microtex-muted mb-4">Suscríbete para recibir tendencias de color e inspiración.</p>
                        <div class="flex">
                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"
                                CssClass="flex-1 px-3 sm:px-4 py-2 border-none bg-gray-100 rounded-l-md text-sm min-w-0"
                                placeholder="Tu email" />
                            <asp:Button ID="btnNewsletter" runat="server"
                                Text="Unirse"
                                CssClass="btn-newsletter shrink-0"
                                OnClick="btnNewsletter_Click" />
                        </div>
                        <asp:Label ID="lblNewsletterMsg" runat="server" CssClass="text-sm mt-2 block" Visible="false" />
                    </div>

                </div>

                <div class="mt-10 sm:mt-12 pt-8 border-t border-slate-100 flex flex-col sm:flex-row items-center justify-between gap-4">
                    <asp:Label ID="lblCopyright" runat="server" CssClass="text-xs text-slate-400" />
                    <div class="flex gap-6 text-xs text-slate-400">
                        <a class="hover:text-slate-700" href="#">Política de Privacidad</a>
                        <a class="hover:text-slate-700" href="#">Términos de Servicio</a>
                    </div>
                </div>
            </div>
        </footer>

    </form>

    <script src="Scripts/Nosotros.js" type="text/javascript"></script>
</body>
</html>
