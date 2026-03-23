<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Microtex.index" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>MicroTex | Fabricamos Texturas, Efectos y Colores</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="Scripts/tailwind.config.js"></script>
    <link href="Styles/site.css" rel="stylesheet" />
    <style>
        .hero-split-img {
            height: 320px;
        }

        @media(min-width:1024px) {
            .hero-split-img {
                height: 500px;
            }
        }

        .project-card {
            height: 260px;
        }

        @media(min-width:1024px) {
            .project-card {
                height: 340px;
            }
        }

        .product-card {
            height: 280px;
        }

        @media(min-width:640px) {
            .product-card {
                height: 340px;
            }
        }

        @media(min-width:1024px) {
            .product-card {
                height: 380px;
            }
        }

        #mobile-menu {
            display: none;
            flex-direction: column;
        }

            #mobile-menu.open {
                display: flex;
            }

        @media(max-width:640px) {
            .hero-heading {
                font-size: 2.5rem;
                line-height: 1;
            }
        }
    </style>
</head>
<body class="bg-white text-slate-900 font-display">
    <form id="form1" runat="server">
        <!-- HEADER -->
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
                    <asp:Button ID="btnGetQuote" runat="server" Text="" OnClick="btnGetQuote_Click" UseSubmitBehavior="false" Style="display: none;" />
                    <asp:Literal ID="litNavUser" runat="server" />
                    <a href="carrito.aspx" class="relative w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                        <span class="material-symbols-outlined text-xl">shopping_bag</span>
                        <span id="cartBadge" class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none">0</span>
                    </a>
                    <button type="button" id="menu-btn"
                        onclick="document.getElementById('mobile-menu').classList.toggle('open')"
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
            <div id="mobile-menu" class="lg:hidden border-t border-slate-100 bg-white px-4 py-3 gap-1">
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 hover:text-slate-900 rounded-lg transition-colors" href="productos.aspx">Catálogo</a>
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 hover:text-slate-900 rounded-lg transition-colors" href="proyectos.aspx">Proyectos</a>
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 hover:text-slate-900 rounded-lg transition-colors" href="Nosotros.aspx">Nosotros</a>
            </div>
        </header>
        <main>
            <!-- HERO -->
            <section class="w-full bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 py-10 sm:py-16 lg:py-24 flex flex-col lg:flex-row items-center gap-8 lg:gap-12">
                    <div class="lg:w-1/2 flex flex-col gap-5 sm:gap-6 text-center lg:text-left">
                        <span class="text-xs font-bold uppercase tracking-widest text-slate-400">Premium Architecture</span>
                        <h1 class="hero-heading text-5xl lg:text-6xl font-black text-slate-900 leading-none">Fabricamos<br />
                            Texturas,<br />
                            <span class="text-accent">Efectos y<br />
                                Colores.</span>
                        </h1>
                        <p class="text-slate-500 text-sm sm:text-base max-w-md mx-auto lg:mx-0 leading-relaxed">
                            Resinas vinílicas-acrílicas, microcementos, impermeabilizantes, esmaltes y productos luminiscentes para cada superficie y proyecto.
                        </p>
                        <div class="flex flex-wrap gap-3 mt-2 justify-center lg:justify-start">
                            <asp:Button ID="btnExplore" runat="server"
                                Text="Ver Productos"
                                OnClick="btnExplore_Click"
                                CssClass="h-11 rounded-lg bg-slate-100 px-6 text-sm font-bold text-slate-900 hover:bg-slate-200 transition-colors border border-slate-200" />
                            <asp:Button ID="btnContact" runat="server"
                                Text="Contactar Especialista"
                                OnClick="btnContact_Click"
                                CssClass="h-11 rounded-lg border border-slate-300 px-6 text-sm font-bold text-slate-600 hover:bg-slate-50 transition-colors" />
                        </div>
                    </div>

                    <!-- IMAGEN HERO -->
                    <div class="lg:w-1/2 w-full">
                        <div class="hero-split-img overflow-hidden rounded-3xl bg-slate-100 w-full">
                            <asp:Image ID="imgHero" runat="server"
                                ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuC6b5aZ5kNaR2KhuC8FRm9g4MMVm1Kj4VxnnwqOiM4qykuItDozTdO0ZiWle-FdhGxzfalOmxuhPnb2ejitwWNetAotN_jVD2ZcodCkwaZOAE0u8juz83zcFpy3YgVUQZUPYYyu5vU3mCIMwk3V6YEGQjEao4JQLepW-UViHm67Z3anUhKTf9JGbS9-2oRE2hj8AMLA8aXRKmwtlmIjD-BTithZyrksD7zK8VNMecCPf1jsCP8WiQHCjO_eYM_d-xgbSHcv1fZ4XQ0u"
                                AlternateText="Recubrimientos MicroTex"
                                CssClass="h-full w-full object-cover" />
                        </div>
                    </div>
                </div>
            </section>
            <!-- NOSOTROS -->
            <section class="py-14 sm:py-20 bg-white" id="nosotros">
                <div class="max-w-7xl mx-auto px-4 sm:px-6">
                    <div class="flex flex-col lg:flex-row items-center gap-10 lg:gap-16">
                        <div class="lg:w-1/2 flex flex-col gap-5 sm:gap-6 text-center lg:text-left">
                            <span class="text-xs font-bold uppercase tracking-widest text-slate-400">Nuestro Legado</span>
                            <h2 class="text-3xl sm:text-4xl font-black text-slate-900 leading-tight">Especialistas en Recubrimientos Arquitectónicos</h2>
                            <p class="text-slate-500 text-sm sm:text-base leading-relaxed">
                                En MicroTex fabricamos texturas, efectos y colores con tecnología avanzada. Nuestras fórmulas innovadoras se adaptan a diversas superficies, proporcionando protección y acabados impecables.
                       
                            </p>
                            <div class="grid grid-cols-2 gap-3 sm:gap-4 mt-2">
                                <div class="flex items-center gap-3 bg-slate-50 rounded-xl p-3 sm:p-4 border border-slate-100">
                                    <span class="material-symbols-outlined text-slate-400 text-xl sm:text-2xl shrink-0">history</span>
                                    <div>
                                        <p class="text-xs font-bold text-slate-900">Trayectoria</p>
                                        <p class="text-xs text-slate-400 hidden sm:block">Alta experiencia en recubrimientos</p>
                                    </div>
                                </div>
                                <div class="flex items-center gap-3 bg-slate-50 rounded-xl p-3 sm:p-4 border border-slate-100">
                                    <span class="material-symbols-outlined text-slate-400 text-xl sm:text-2xl shrink-0">verified</span>
                                    <div>
                                        <p class="text-xs font-bold text-slate-900">Calidad</p>
                                        <p class="text-xs text-slate-400 hidden sm:block">Estándares certificados</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="lg:w-1/2 grid grid-cols-2 gap-3 sm:gap-4 w-full max-w-sm sm:max-w-none mx-auto">
                            <div class="aspect-square overflow-hidden rounded-2xl bg-slate-100">
                                <asp:Image ID="imgAbout1" runat="server"
                                    ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuBeSaFaTxKVJacsYnt1NcUjwh06ZpR-clGsLD1z2t6vOnb904ZT3Up5sPOPCO1M9aNJjVGZhcYmvdbrVFD0WQY-f390jtLF3qfxzFQYIhmk67RwHw3v_uGt-A4qTdg_avo_MAlDKs5atWS2z5LpC4dWfnyj2toNC7aS8vAopqKErewUuHe8J6cOgxzqCMxuBdJ_L6xQ7p1LO8mhvUtYdI1vbiGpoD7NLFiGPTdT4ztR3EA6ShAFNuiU7NFX1O2eGLS15_itGS3KxyMD"
                                    AlternateText="Interior arquitectónico" CssClass="h-full w-full object-cover grayscale hover:grayscale-0 transition-all duration-500" />
                            </div>
                            <div class="aspect-square overflow-hidden rounded-2xl bg-slate-100 mt-6 sm:mt-8">
                                <asp:Image ID="imgAbout2" runat="server"
                                    ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuBZ5ZvnBKOOjuRhHJixBYE9d3HilQnAPGh6lQ2c3zP5HRdNWHKj0wDah7L4n8oYgm-D6dox_BXCAJs0eXJ4_zrXFG6mPFik-YPP4jOw0OkY8O-RHcyYrrSk0ZZiWx2oPf7MkMmZ2bGcCbmDMuBfnSNGzLp56ZN7bzHG7ImsjZQfnXEYcGr_0zhjqm_ehj4RMq6b771HoS9dMkKAAg3Or3vJfAieoGMpdT3IdegNkxA-LGhgtr9wzt_6J0gvtDyQhMtBtekFr1kMcYt6"
                                    AlternateText="Oficina minimalista" CssClass="h-full w-full object-cover grayscale hover:grayscale-0 transition-all duration-500" />
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- PRODUCTOS -->
            <section class="py-14 sm:py-20 bg-white" id="productos">
                <div class="max-w-7xl mx-auto px-4 sm:px-6">
                    <div class="flex items-end justify-between mb-8 sm:mb-10">
                        <div>
                            <span class="text-xs font-bold uppercase tracking-widest text-slate-400">Nuestras Colecciones</span>
                            <h2 class="text-3xl sm:text-4xl font-black text-slate-900 mt-1">Superficies Arquitectónicas</h2>
                        </div>
                        <a class="hidden sm:flex text-sm font-bold text-slate-600 hover:text-slate-900 items-center gap-1 group transition-colors" href="productos.aspx">Ver Catálogo Completo
                       
                            <span class="material-symbols-outlined text-base group-hover:translate-x-1 transition-transform">arrow_forward</span>
                        </a>
                    </div>
                    <asp:Repeater ID="rptProducts" runat="server">
                        <HeaderTemplate>
                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3 sm:gap-4">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <a href='<%# "detalle.aspx?id=" + Eval("Id") %>' class="group relative product-card overflow-hidden rounded-2xl bg-slate-100 block">
                                <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' AlternateText='<%# Eval("AltText") %>'
                                    CssClass="h-full w-full object-cover transition-transform duration-700 group-hover:scale-105" />
                                <div class="absolute inset-0 bg-gradient-to-t from-slate-900/80 via-slate-900/10 to-transparent"></div>
                                <div class="absolute bottom-0 left-0 p-4 sm:p-6">
                                    <h4 class="text-base sm:text-lg font-bold text-white"><%# Eval("Title") %></h4>
                                    <p class="mt-1 text-xs sm:text-sm text-white/70"><%# Eval("Description") %></p>
                                </div>
                            </a>
                        </ItemTemplate>
                        <FooterTemplate></div></FooterTemplate>
                    </asp:Repeater>
                    <div class="sm:hidden mt-6 text-center">
                        <a class="text-sm font-bold text-slate-600 hover:text-slate-900 inline-flex items-center gap-1 group transition-colors" href="productos.aspx">Ver Catálogo Completo
                       
                            <span class="material-symbols-outlined text-base group-hover:translate-x-1 transition-transform">arrow_forward</span>
                        </a>
                    </div>
                </div>
            </section>

            <!-- BENEFICIOS -->
            <section class="py-14 sm:py-20 bg-slate-900 text-white" id="beneficios">
                <div class="max-w-7xl mx-auto px-4 sm:px-6">
                    <div class="text-center mb-10 sm:mb-16">
                        <span class="text-xs font-bold uppercase tracking-widest text-slate-400">Por qué MicroTex</span>
                        <h2 class="text-3xl sm:text-4xl font-black mt-2">El Rendimiento se Encuentra con el Diseño</h2>
                    </div>
                    <div class="grid grid-cols-2 lg:grid-cols-4 gap-8 sm:gap-10">
                        <asp:Repeater ID="rptBenefits" runat="server">
                            <ItemTemplate>
                                <div class="flex flex-col items-center text-center gap-3">
                                    <div class="w-10 h-10 sm:w-12 sm:h-12 rounded-full bg-white/10 flex items-center justify-center">
                                        <span class="material-symbols-outlined text-xl sm:text-2xl text-white/80"><%# Eval("Icon") %></span>
                                    </div>
                                    <h4 class="font-bold text-white text-xs sm:text-sm"><%# Eval("Title") %></h4>
                                    <p class="text-white/50 text-xs leading-relaxed"><%# Eval("Description") %></p>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </section>

            <!-- PROYECTOS -->
            <section class="py-14 sm:py-20 bg-white" id="proyectos">
                <div class="max-w-7xl mx-auto px-4 sm:px-6">
                    <div class="mb-8 sm:mb-10">
                        <span class="text-xs font-bold uppercase tracking-widest text-slate-400">Portafolio</span>
                        <h2 class="text-3xl sm:text-4xl font-black text-slate-900 mt-1">Realizaciones Icónicas</h2>
                    </div>
                    <div class="flex flex-col gap-3 sm:gap-4 lg:grid lg:grid-cols-3">
                        <div class="group relative overflow-hidden rounded-2xl bg-slate-100 lg:col-span-1 lg:row-span-2 w-full" style="height: 280px;">
                            <asp:Image ID="imgProject1" runat="server" ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuC6b5aZ5kNaR2KhuC8FRm9g4MMVm1Kj4VxnnwqOiM4qykuItDozTdO0ZiWle-FdhGxzfalOmxuhPnb2ejitwWNetAotN_jVD2ZcodCkwaZOAE0u8juz83zcFpy3YgVUQZUPYYyu5vU3mCIMwk3V6YEGQjEao4JQLepW-UViHm67Z3anUhKTf9JGbS9-2oRE2hj8AMLA8aXRKmwtlmIjD-BTithZyrksD7zK8VNMecCPf1jsCP8WiQHCjO_eYM_d-xgbSHcv1fZ4XQ0u" AlternateText="Lobby microcemento" CssClass="h-full w-full object-cover transition-transform duration-700 group-hover:scale-105" />
                            <div class="absolute inset-0 bg-gradient-to-t from-slate-900/70 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-5 sm:p-8">
                                <p class="text-sm font-bold text-white">Recubrimiento Cementicio</p>
                                <p class="text-xs text-white/70 uppercase tracking-widest">Pachuca, Hidalgo</p>
                            </div>
                        </div>
                        <div class="group relative overflow-hidden rounded-2xl bg-slate-100 lg:col-span-2 project-card">
                            <asp:Image ID="imgProject2" runat="server" ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuBOenzHicFB5JwsSPwf1fNQupo7hgo_YkQDLjTUyS5_HcxV5d22Ygrwf5GzXUUaJOwZKXoiVI5LKFGr6wzC2pVxXGjRT8auuiVEUFX4iUXxgFWluUh4DjVPNRKis0onRxZntvfQJaGYJFLh1bCS_WsXWny-VZ1-0KZUIBCue3Jvys_W5Y35z7bUKdJuiuR02ynTbpj2E8uuXIBL8cMUvWUvQ6-W3OIlkFXy8wpYtBAWxSOBAXnTfFOGTKCRvoMqaf5sa8PNxLH2U4kO" AlternateText="Oficina corporativa" CssClass="h-full w-full object-cover transition-transform duration-700 group-hover:scale-105" />
                            <div class="absolute inset-0 bg-gradient-to-t from-slate-900/70 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-5 sm:p-8">
                                <p class="text-sm font-bold text-white">Acabado Arquitectónico</p>
                                <p class="text-xs text-white/70 uppercase tracking-widest">Tulancingo, Hidalgo</p>
                            </div>
                        </div>
                        <div class="group relative overflow-hidden rounded-2xl bg-slate-100 lg:col-span-2 project-card">
                            <asp:Image ID="imgProject3" runat="server" ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuCrLxpfPyoiNKAVHmloLIpZyK-S20f0USY-QEouYH94Ekn0UDpBIR_kEjmA0t6fW3Donk4vstKMMXAZEro5zqVOIqjHz9qRlecU9YB0eAJHuhkEq3yGuBbgrxo2SAXVphtQ-gazC2_RbBHF73Ko_e438WPfgV2XdJ8hhLDmo2xaTeQCVEjTRbjm8NuG_YbRJbnbAOfzNU2d4LIDT_PVltXuIScK2cBhGssAV2I7TVoNAlhHZljw5zvFgKwBqqn4pX_nOAlocV2p5mGe" AlternateText="Cocina de lujo" CssClass="h-full w-full object-cover transition-transform duration-700 group-hover:scale-105" />
                            <div class="absolute inset-0 bg-gradient-to-t from-slate-900/70 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex flex-col justify-end p-5 sm:p-8">
                                <p class="text-sm font-bold text-white">Impermeabilización</p>
                                <p class="text-xs text-white/70 uppercase tracking-widest">Ciudad de México</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- UBICACION -->
            <section class="py-14 sm:py-20 bg-slate-50" id="ubicacion">
                <div class="max-w-7xl mx-auto px-4 sm:px-6">
                    <div class="mb-8 sm:mb-10">
                        <span class="text-xs font-bold uppercase tracking-widest text-slate-400">Visítanos</span>
                        <h2 class="text-3xl sm:text-4xl font-black text-slate-900 mt-1">Encuéntranos</h2>
                    </div>
                    <div class="grid grid-cols-1 lg:grid-cols-3 overflow-hidden rounded-3xl shadow-sm border border-slate-200">
                        <div class="lg:col-span-2 relative" style="min-height: 400px;">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d936.3433886206666!2d-99.1053835!3d20.1601662!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x85d17f94d630c9f5%3A0x281924f41df6f76e!2sMicrotex!5e0!3m2!1ses-419!2smx!4v1773332659233!5m2!1ses-419!2smx"
                                width="100%" height="100%" style="border: 0; position: absolute; inset: 0;"
                                allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>
                        <div class="bg-white p-8 md:p-10 flex flex-col justify-between gap-8">
                            <div class="flex flex-col gap-8">
                                <div>
                                    <div class="flex items-center gap-3 mb-3">
                                        <span class="material-symbols-outlined text-slate-400 text-xl">location_on</span>
                                        <h4 class="font-bold text-slate-900">Sede Central</h4>
                                    </div>
                                    <p class="text-sm text-slate-500 leading-relaxed pl-8">Ajacuba, Hidalgo, México</p>
                                </div>
                                <div>
                                    <div class="flex items-center gap-3 mb-3">
                                        <span class="material-symbols-outlined text-slate-400 text-xl">schedule</span>
                                        <h4 class="font-bold text-slate-900">Horario Comercial</h4>
                                    </div>
                                    <div class="flex flex-col gap-2 text-sm text-slate-500 pl-8">
                                        <div class="flex justify-between"><span>Lunes - Viernes:</span><span class="font-semibold text-slate-700">08:00 - 18:00</span></div>
                                        <div class="flex justify-between"><span>Sábados:</span><span class="font-semibold text-slate-700">09:00 - 14:00</span></div>
                                        <div class="flex justify-between"><span>Domingos:</span><span class="font-semibold text-slate-500">Cerrado</span></div>
                                    </div>
                                </div>
                                <div>
                                    <div class="flex items-center gap-3 mb-3">
                                        <span class="material-symbols-outlined text-slate-400 text-xl">phone_in_talk</span>
                                        <h4 class="font-bold text-slate-900">Atención Directa</h4>
                                    </div>
                                    <div class="flex flex-col gap-1 text-sm text-slate-500 pl-8">
                                        <p>Ventas: 771 567 6119</p>
                                        <p>Email: dante_ceron@outlook.com</p>
                                    </div>
                                </div>
                            </div>
                            <a href="https://maps.app.goo.gl/T2NYso9s61nAEgeb6" target="_blank"
                                class="w-full mt-2 rounded-xl border border-slate-200 py-3 text-sm font-bold text-slate-700 hover:bg-slate-50 transition-colors text-center flex items-center justify-center gap-2">
                                <span class="material-symbols-outlined text-base">near_me</span>
                                Obtener Direcciones
                        </a>
                        </div>
                    </div>
                </div>
            </section>

            <!-- CONTACTO -->
            <section class="py-14 sm:py-20 bg-white" id="contacto">
                <div class="max-w-5xl mx-auto px-4 sm:px-6">
                    <div class="rounded-3xl bg-slate-50 border border-slate-200 p-6 sm:p-8 md:p-14">
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 sm:gap-12">
                            <div class="flex flex-col gap-5 sm:gap-6">
                                <h3 class="text-2xl sm:text-3xl font-black text-slate-900">Inicia tu Proyecto</h3>
                                <p class="text-slate-500 text-sm leading-relaxed">
                                    Contáctanos para obtener una cotización personalizada o muestras para tu próximo proyecto arquitectónico.
                           
                                </p>
                                <div class="flex flex-col gap-3 sm:gap-4">
                                    <div class="flex items-center gap-3 text-sm text-slate-600">
                                        <span class="material-symbols-outlined text-slate-400 text-base shrink-0">mail</span>
                                        <asp:Label ID="lblEmail" runat="server" Text="dante_ceron@outlook.com" />
                                    </div>
                                    <div class="flex items-center gap-3 text-sm text-slate-600">
                                        <span class="material-symbols-outlined text-slate-400 text-base shrink-0">call</span>
                                        <asp:Label ID="lblPhone" runat="server" Text="771 567 6119" />
                                    </div>
                                    <div class="flex items-center gap-3 text-sm text-slate-600">
                                        <span class="material-symbols-outlined text-slate-400 text-base shrink-0">location_on</span>
                                        <asp:Label ID="lblAddress" runat="server" Text="Ajacuba, Hidalgo" />
                                    </div>
                                </div>

                                <%-- ✅ Mensaje profesional de éxito/error --%>
                                <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                                    <div id="msgBox" runat="server" style="display: flex; align-items: flex-start; gap: 12px; border-radius: 14px; padding: 16px 18px;">
                                        <div id="msgIcon" runat="server" style="width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; flex-shrink: 0; margin-top: 1px;">
                                            <span id="msgIconSymbol" runat="server" class="material-symbols-outlined" style="font-size: 18px; color: #fff;"></span>
                                        </div>
                                        <div>
                                            <p id="msgTitle" runat="server" style="font-size: .875rem; font-weight: 700; margin: 0 0 3px;"></p>
                                            <asp:Label ID="lblMessage" runat="server" Style="font-size: .8125rem; line-height: 1.5; display: block;" />
                                        </div>
                                    </div>
                                </asp:Panel>

                            </div>
                            <div class="flex flex-col gap-3">
                                <asp:TextBox ID="txtName" runat="server" placeholder="Tu Nombre"
                                    CssClass="rounded-lg border border-slate-200 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300" />
                                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Correo Electrónico"
                                    CssClass="rounded-lg border border-slate-200 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300" />
                                <asp:DropDownList ID="ddlInquiry" runat="server"
                                    CssClass="rounded-lg border border-slate-200 bg-white px-4 py-3 text-sm text-slate-500 focus:outline-none focus:border-slate-400">
                                    <asp:ListItem Text="Consulta de Producto" Value="product" />
                                    <asp:ListItem Text="Solicitar Cotización" Value="quote" />
                                    <asp:ListItem Text="Soporte Técnico" Value="support" />
                                </asp:DropDownList>
                                <asp:TextBox ID="txtDetails" runat="server" TextMode="MultiLine" Rows="4"
                                    placeholder="Detalles del Proyecto"
                                    CssClass="rounded-lg border border-slate-200 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:border-slate-400 resize-none" />
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                    ErrorMessage="El nombre es requerido." CssClass="text-xs text-red-500" Display="Dynamic" />
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                    ErrorMessage="El correo es requerido." CssClass="text-xs text-red-500" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                    ValidationExpression="\w+([-+.\']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ErrorMessage="Ingresa un correo válido." CssClass="text-xs text-red-500" Display="Dynamic" />
                                <asp:Button ID="btnSendInquiry" runat="server" Text="Enviar Consulta"
                                    OnClick="btnSendInquiry_Click"
                                    CssClass="mt-1 rounded-xl bg-slate-900 py-3 text-sm font-bold text-white hover:bg-slate-700 transition-colors w-full" />
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <!-- FOOTER -->
        <footer class="bg-white border-t border-slate-100 py-10 sm:py-12">
            <div class="max-w-7xl mx-auto px-4 sm:px-6">
                <div class="flex flex-col md:flex-row justify-between gap-8 sm:gap-12">
                    <div class="max-w-xs">
                        <div class="flex items-center gap-2 mb-4">
                            <div class="flex h-6 w-6 items-center justify-center rounded-lg bg-slate-900 text-white font-black text-xs">M</div>
                            <span class="font-black text-slate-900 text-base tracking-tight">MICROTEX</span>
                        </div>
                        <p class="text-xs text-slate-400 leading-relaxed">
                            Fabricamos texturas, efectos y colores. Soluciones avanzadas en recubrimientos arquitectónicos para transformar tus espacios.
                   
                        </p>
                    </div>
                    <div class="grid grid-cols-2 gap-8 sm:gap-12 sm:grid-cols-3">
                        <div>
                            <h4 class="text-xs font-bold uppercase tracking-widest text-slate-400 mb-4">Empresa</h4>
                            <ul class="flex flex-col gap-2 text-sm text-slate-500">
                                <li><a class="hover:text-slate-900 transition-colors" href="#nosotros">Nosotros</a></li>
                                <li><a class="hover:text-slate-900 transition-colors" href="#proyectos">Proyectos</a></li>
                                <li><a class="hover:text-slate-900 transition-colors" href="productos.aspx">Catálogo</a></li>
                                <li><a class="hover:text-slate-900 transition-colors" href="#contacto">Contacto</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="text-xs font-bold uppercase tracking-widest text-slate-400 mb-4">Productos</h4>
                            <ul class="flex flex-col gap-2 text-sm text-slate-500">
                                <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=1">Pintura Arquitectónica</a></li>
                                <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=2">Cementicio</a></li>
                                <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=3">Impermeabilizantes</a></li>
                                <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=4">Luminiscentes</a></li>
                                <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=5">Esmaltes</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="text-xs font-bold uppercase tracking-widest text-slate-400 mb-4">Social</h4>
                            <div class="flex gap-4">
                                <a class="text-slate-400 hover:text-slate-900 transition-colors" href="#">
                                    <svg class="h-5 w-5 fill-current" viewBox="0 0 24 24">
                                        <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z" />
                                    </svg>
                                </a>
                                <a class="text-slate-400 hover:text-slate-900 transition-colors" href="#">
                                    <svg class="h-5 w-5 fill-current" viewBox="0 0 24 24">
                                        <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z" />
                                    </svg>
                                </a>
                            </div>
                        </div>
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
</body>
</html>
