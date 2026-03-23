<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="detalle.aspx.cs" Inherits="Microtex.detalle" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>MicroTex | Detalle de Producto</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="Scripts/tailwind.config.js"></script>
    <link href="Styles/site.css" rel="stylesheet" />
    <link href="Styles/detalle.css" rel="stylesheet" />
</head>
<body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 min-h-screen">
    <form id="form1" runat="server">

        <%-- ✅ Campos ocultos para el carrito --%>
        <asp:HiddenField ID="hfProductoId" runat="server" />
        <asp:HiddenField ID="hfColor"      runat="server" />

        <div class="relative flex min-h-screen w-full flex-col overflow-x-hidden">
            <div class="layout-container flex h-full grow flex-col">

                <!-- ===== HEADER ===== -->
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

                            <%-- ✅ Badge del carrito con Literal --%>
                            <a href="carrito.aspx"
                                class="relative w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                                <span class="material-symbols-outlined text-xl">shopping_bag</span>
                                <span class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none">
                                    <asp:Literal ID="litCartBadge" runat="server" Text="0" />
                                </span>
                            </a>

                            <button type="button" id="menu-btn"
                                onclick="document.getElementById('det-mobile-menu').style.display = document.getElementById('det-mobile-menu').style.display === 'none' ? 'flex' : 'none'; document.getElementById('det-mobile-menu').style.flexDirection='column';"
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

                    <div id="det-mobile-menu" class="lg:hidden border-t border-slate-100 bg-white px-4 py-3 gap-1" style="display: none;">
                        <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="productos.aspx">Catálogo</a>
                        <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="proyectos.aspx">Proyectos</a>
                        <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="Nosotros.aspx">Nosotros</a>
                    </div>
                </header>

                <!-- ===== BANNER DETALLE ===== -->
                <div class="relative w-full overflow-hidden" style="min-height: 120px;">
                    <div class="absolute inset-0 w-full h-full">
                        <img src="https://microtexmexico.com/wp-content/uploads/2024/08/1-1-1.png"
                            alt="Detalle Producto MicroTex" class="w-full h-full object-cover object-center" />
                        <div class="absolute inset-0 bg-gradient-to-r from-dark-neutral/90 via-dark-neutral/70 to-dark-neutral/30"></div>
                    </div>
                    <div class="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 py-8 sm:py-10 flex flex-col gap-2 justify-center" style="min-height: 120px;">
                        <span class="text-xs font-bold uppercase tracking-widest text-primary/60">MicroTex</span>
                        <h2 class="text-2xl sm:text-3xl font-black text-white">Detalle del Producto</h2>
                        <nav class="flex items-center gap-2 text-xs sm:text-sm text-white/50 mt-1 flex-wrap">
                            <a href="Default.aspx" class="hover:text-white transition-colors">Inicio</a>
                            <span class="material-symbols-outlined text-xs">chevron_right</span>
                            <a href="productos.aspx" class="hover:text-white transition-colors">Productos</a>
                            <span class="material-symbols-outlined text-xs">chevron_right</span>
                            <asp:Label ID="lblBreadcrumb" runat="server" CssClass="text-white font-semibold" />
                        </nav>
                    </div>
                </div>

                <!-- ===== MAIN ===== -->
                <main class="flex-1 max-w-7xl mx-auto w-full px-4 sm:px-6 py-8 sm:py-10">

                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 lg:gap-16 mb-16 sm:mb-20">

                        <!-- IMAGEN -->
                        <div class="flex flex-col gap-3 sm:gap-4">
                            <div class="aspect-square bg-slate-50 dark:bg-slate-800 rounded-2xl overflow-hidden border border-slate-100 dark:border-slate-700 flex items-center justify-center p-6 sm:p-8 detail-main-img">
                                <asp:Image ID="imgMain" runat="server" CssClass="w-full h-full object-contain drop-shadow-2xl transition-all duration-500" />
                            </div>
                            <div class="grid grid-cols-4 gap-2 sm:gap-3">
                                <asp:Repeater ID="rptThumbs" runat="server">
                                    <ItemTemplate>
                                        <div class="aspect-square rounded-xl overflow-hidden border-2 cursor-pointer thumb-item transition-all duration-200"
                                            onclick="setMainImage('<%# Eval("Url") %>', this)">
                                            <img src='<%# Eval("Url") %>' alt='<%# Eval("Alt") %>' class="w-full h-full object-cover" />
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>

                        <!-- DETALLES -->
                        <div class="flex flex-col">

                            <div class="mb-3">
                                <asp:Label ID="lblBadge" runat="server"
                                    CssClass="inline-block bg-primary/40 text-dark-neutral text-xs font-bold px-3 py-1 rounded-sm uppercase tracking-widest" />
                            </div>

                            <asp:Label ID="lblName" runat="server"
                                CssClass="text-3xl sm:text-4xl lg:text-5xl font-black text-dark-neutral dark:text-slate-100 mb-2 leading-tight block" />
                            <asp:Label ID="lblSubtitle" runat="server"
                                CssClass="text-sm sm:text-base text-slate-500 dark:text-slate-400 mb-4 block" />

                            <div class="flex items-center gap-3 mb-5 sm:mb-6">
                                <div class="flex text-yellow-400 text-lg" id="starsContainer" runat="server"></div>
                                <asp:Label ID="lblReviews" runat="server" CssClass="text-slate-400 text-sm" />
                            </div>

                            <asp:Label ID="lblPrice" runat="server"
                                CssClass="text-xl sm:text-2xl font-black text-dark-neutral dark:text-primary mb-6 sm:mb-8 block" />

                            <div class="space-y-5 sm:space-y-6 mb-6 sm:mb-8">

                                <!-- Selector de colores -->
                                <div>
                                    <h3 class="text-xs font-bold uppercase tracking-widest text-slate-400 mb-3">Selecciona un Color</h3>
                                    <div class="flex flex-wrap gap-2 sm:gap-3" id="colorPicker">
                                        <button type="button" onclick="selectColor(this,'#1B4F8A','Azul Contemporáneo')"
                                            class="color-swatch w-9 h-9 sm:w-10 sm:h-10 rounded-full border-2 border-dark-neutral ring-2 ring-offset-2 ring-dark-neutral/30 transition-all"
                                            style="background: #1B4F8A;" title="Azul Contemporáneo"></button>
                                        <button type="button" onclick="selectColor(this,'#2E7D4F','Verde Sayeb')"
                                            class="color-swatch w-9 h-9 sm:w-10 sm:h-10 rounded-full border-2 border-transparent hover:border-slate-300 transition-all"
                                            style="background: #2E7D4F;" title="Verde Sayeb"></button>
                                        <button type="button" onclick="selectColor(this,'#8B2022','Rojo Pacula')"
                                            class="color-swatch w-9 h-9 sm:w-10 sm:h-10 rounded-full border-2 border-transparent hover:border-slate-300 transition-all"
                                            style="background: #8B2022;" title="Rojo Pacula"></button>
                                        <button type="button" onclick="selectColor(this,'#C0BDB8','Gris Perla')"
                                            class="color-swatch w-9 h-9 sm:w-10 sm:h-10 rounded-full border-2 border-transparent hover:border-slate-300 transition-all"
                                            style="background: #C0BDB8;" title="Gris Perla"></button>
                                        <button type="button" onclick="selectColor(this,'#F5F0E8','Blanco Marfil')"
                                            class="color-swatch w-9 h-9 sm:w-10 sm:h-10 rounded-full border-2 border-transparent hover:border-slate-300 transition-all"
                                            style="background: #F5F0E8; border-color: #ccc!important;" title="Blanco Marfil"></button>
                                        <button type="button" onclick="selectColor(this,'#3D3D3D','Negro Óxido')"
                                            class="color-swatch w-9 h-9 sm:w-10 sm:h-10 rounded-full border-2 border-transparent hover:border-slate-300 transition-all"
                                            style="background: #3D3D3D;" title="Negro Óxido"></button>
                                    </div>
                                    <p class="text-xs text-slate-400 mt-2">Color: <span id="selectedColorName" class="text-dark-neutral dark:text-slate-200 font-semibold">Azul Contemporáneo</span></p>
                                </div>

                                <!-- Qty + Botones -->
                                <div class="flex flex-col sm:flex-row gap-3 sm:gap-4">
                                    <div class="flex items-center border border-slate-200 dark:border-slate-700 rounded-xl h-12 sm:h-14 bg-white dark:bg-transparent overflow-hidden w-full sm:w-auto">
                                        <button type="button" onclick="changeQty(-1)" class="px-3 sm:px-4 h-full flex items-center hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors text-dark-neutral dark:text-slate-100">
                                            <span class="material-symbols-outlined text-sm">remove</span>
                                        </button>
                                        <asp:TextBox ID="txtQty" runat="server" Text="1" CssClass="w-12 text-center border-none focus:ring-0 bg-transparent font-bold text-dark-neutral dark:text-slate-100" />
                                        <button type="button" onclick="changeQty(1)" class="px-3 sm:px-4 h-full flex items-center hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors text-dark-neutral dark:text-slate-100">
                                            <span class="material-symbols-outlined text-sm">add</span>
                                        </button>
                                    </div>
                                    <%-- ✅ Texto cambiado a "Agregar al Carrito" --%>
                                    <asp:Button ID="btnAddToCart" runat="server" Text="Agregar al Carrito"
                                        OnClick="btnAddToCart_Click"
                                        CssClass="flex-1 bg-dark-neutral hover:bg-slate-700 text-white font-bold h-12 sm:h-14 rounded-xl transition-all shadow-lg text-sm" />
                                    <button type="button" id="btnFav" onclick="toggleFav(this)"
                                        class="w-full sm:w-14 h-12 sm:h-14 border border-slate-200 dark:border-slate-700 rounded-xl flex items-center justify-center hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors text-slate-400">
                                        <span class="material-symbols-outlined">favorite</span>
                                    </button>
                                </div>

                            </div>

                            <!-- Características -->
                            <div class="grid grid-cols-2 gap-3 sm:gap-4 border-t border-slate-100 dark:border-slate-800 pt-6 sm:pt-8">
                                <div class="flex items-center gap-2 sm:gap-3">
                                    <span class="material-symbols-outlined text-accent text-base sm:text-xl shrink-0">eco</span>
                                    <span class="text-xs sm:text-sm font-medium">Baja emisión VOC</span>
                                </div>
                                <div class="flex items-center gap-2 sm:gap-3">
                                    <span class="material-symbols-outlined text-accent text-base sm:text-xl shrink-0">wash</span>
                                    <span class="text-xs sm:text-sm font-medium">Fácil limpieza</span>
                                </div>
                                <div class="flex items-center gap-2 sm:gap-3">
                                    <span class="material-symbols-outlined text-accent text-base sm:text-xl shrink-0">schedule</span>
                                    <span class="text-xs sm:text-sm font-medium">Secado rápido</span>
                                </div>
                                <div class="flex items-center gap-2 sm:gap-3">
                                    <span class="material-symbols-outlined text-accent text-base sm:text-xl shrink-0">shield</span>
                                    <span class="text-xs sm:text-sm font-medium">Alta durabilidad</span>
                                </div>
                            </div>

                            <!-- Contacto directo -->
                            <div class="mt-5 sm:mt-6 p-4 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 flex flex-col gap-1">
                                <p class="text-xs font-bold uppercase tracking-widest text-accent mb-1">Contacto Directo</p>
                                <a href="tel:7715676119" class="text-sm font-semibold text-dark-neutral hover:text-accent transition-colors flex items-center gap-2">
                                    <span class="material-symbols-outlined text-base">call</span>771 567 6119
                                </a>
                                <a href="mailto:dante_ceron@outlook.com" class="text-sm font-semibold text-dark-neutral hover:text-accent transition-colors flex items-center gap-2">
                                    <span class="material-symbols-outlined text-base">mail</span>dante_ceron@outlook.com
                                </a>
                            </div>

                            <asp:Label ID="lblFeedback" runat="server" Visible="false"
                                CssClass="mt-4 block text-sm font-semibold text-green-600 bg-green-50 px-4 py-3 rounded-xl" />
                        </div>
                    </div>

                    <!-- ===== TABS ===== -->
                    <div class="border-t border-slate-100 dark:border-slate-800 pt-10 sm:pt-12">
                        <div class="flex border-b border-slate-100 dark:border-slate-800 gap-4 sm:gap-8 mb-8 sm:mb-10 overflow-x-auto -mx-4 px-4 sm:mx-0 sm:px-0">
                            <button type="button" onclick="setTab(this,'tab-desc')"
                                class="tab-btn pb-4 border-b-2 border-dark-neutral font-bold text-dark-neutral dark:text-slate-100 whitespace-nowrap text-xs sm:text-sm shrink-0">Descripción</button>
                            <button type="button" onclick="setTab(this,'tab-spec')"
                                class="tab-btn pb-4 border-b-2 border-transparent font-medium text-slate-400 hover:text-dark-neutral transition-colors whitespace-nowrap text-xs sm:text-sm shrink-0">Ficha Técnica</button>
                            <button type="button" onclick="setTab(this,'tab-app')"
                                class="tab-btn pb-4 border-b-2 border-transparent font-medium text-slate-400 hover:text-dark-neutral transition-colors whitespace-nowrap text-xs sm:text-sm shrink-0">Aplicación</button>
                        </div>

                        <!-- Tab: Descripción -->
                        <div id="tab-desc" class="tab-content grid grid-cols-1 md:grid-cols-3 gap-8 sm:gap-12">
                            <div class="md:col-span-2 space-y-5 sm:space-y-6">
                                <asp:Label ID="lblTabTitle" runat="server" CssClass="text-xl sm:text-2xl font-black text-dark-neutral dark:text-slate-100 block" />
                                <asp:Label ID="lblTabDesc1" runat="server" CssClass="text-slate-500 leading-relaxed text-sm block" />
                                <asp:Label ID="lblTabDesc2" runat="server" CssClass="text-slate-500 leading-relaxed text-sm block" />
                                <div class="bg-primary/20 dark:bg-slate-800 p-5 sm:p-6 rounded-2xl border border-primary/30 dark:border-slate-700">
                                    <h4 class="font-bold text-dark-neutral dark:text-slate-100 mb-2 flex items-center gap-2 text-sm">
                                        <span class="material-symbols-outlined text-accent text-base">lightbulb</span>Consejo del Experto
                                    </h4>
                                    <asp:Label ID="lblExpertTip" runat="server" CssClass="text-xs text-slate-500 dark:text-slate-400" />
                                </div>
                            </div>
                            <div class="space-y-4 sm:space-y-5">
                                <h3 class="text-xs font-bold uppercase tracking-widest text-slate-400">Beneficios Técnicos</h3>
                                <ul class="space-y-3 sm:space-y-4">
                                    <li class="flex gap-3">
                                        <span class="material-symbols-outlined text-green-600 bg-green-50 rounded-full p-1 text-base shrink-0">check</span>
                                        <div><p class="font-bold text-sm text-dark-neutral">Resistencia a la Humedad</p><p class="text-xs text-slate-400">Previene hongos y proliferación de algas.</p></div>
                                    </li>
                                    <li class="flex gap-3">
                                        <span class="material-symbols-outlined text-green-600 bg-green-50 rounded-full p-1 text-base shrink-0">check</span>
                                        <div><p class="font-bold text-sm text-dark-neutral">Alta Cobertura</p><p class="text-xs text-slate-400">Rendimiento óptimo por metro cuadrado.</p></div>
                                    </li>
                                    <li class="flex gap-3">
                                        <span class="material-symbols-outlined text-green-600 bg-green-50 rounded-full p-1 text-base shrink-0">check</span>
                                        <div><p class="font-bold text-sm text-dark-neutral">Colores Intensos</p><p class="text-xs text-slate-400">Pigmentos que no se destiñen con el tiempo.</p></div>
                                    </li>
                                    <li class="flex gap-3">
                                        <span class="material-symbols-outlined text-green-600 bg-green-50 rounded-full p-1 text-base shrink-0">check</span>
                                        <div><p class="font-bold text-sm text-dark-neutral">Fácil Aplicación</p><p class="text-xs text-slate-400">Puedes usar el mismo día de aplicación.</p></div>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <!-- Tab: Ficha Técnica -->
                        <div id="tab-spec" class="tab-content hidden">
                            <div class="max-w-2xl overflow-x-auto">
                                <table class="w-full text-sm border-collapse min-w-[320px]">
                                    <tbody>
                                        <tr class="border-b border-slate-100"><td class="py-3 font-semibold text-dark-neutral w-36 sm:w-48 text-xs sm:text-sm">Acabado</td><td class="py-3 text-slate-500 text-xs sm:text-sm"><asp:Label ID="lblSpecAcabado" runat="server" /></td></tr>
                                        <tr class="border-b border-slate-100"><td class="py-3 font-semibold text-dark-neutral text-xs sm:text-sm">Base</td><td class="py-3 text-slate-500 text-xs sm:text-sm"><asp:Label ID="lblSpecBase" runat="server" /></td></tr>
                                        <tr class="border-b border-slate-100"><td class="py-3 font-semibold text-dark-neutral text-xs sm:text-sm">Cobertura</td><td class="py-3 text-slate-500 text-xs sm:text-sm"><asp:Label ID="lblSpecCobertura" runat="server" /></td></tr>
                                        <tr class="border-b border-slate-100"><td class="py-3 font-semibold text-dark-neutral text-xs sm:text-sm">Tiempo de Secado</td><td class="py-3 text-slate-500 text-xs sm:text-sm"><asp:Label ID="lblSpecSecado" runat="server" /></td></tr>
                                        <tr class="border-b border-slate-100"><td class="py-3 font-semibold text-dark-neutral text-xs sm:text-sm">VOC</td><td class="py-3 text-slate-500 text-xs sm:text-sm"><asp:Label ID="lblSpecVOC" runat="server" /></td></tr>
                                        <tr><td class="py-3 font-semibold text-dark-neutral text-xs sm:text-sm">Usos Recomendados</td><td class="py-3 text-slate-500 text-xs sm:text-sm"><asp:Label ID="lblSpecUsos" runat="server" /></td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Tab: Aplicación -->
                        <div id="tab-app" class="tab-content hidden">
                            <div class="max-w-2xl space-y-5 sm:space-y-6 text-sm text-slate-500 leading-relaxed">
                                <div class="flex gap-3 sm:gap-4">
                                    <div class="w-7 h-7 sm:w-8 sm:h-8 rounded-full bg-primary flex items-center justify-center text-dark-neutral font-black text-xs shrink-0 mt-0.5">1</div>
                                    <div><p class="font-bold text-dark-neutral mb-1 text-sm">Preparación de la Superficie</p><p class="text-xs sm:text-sm">Limpia la superficie de polvo, grasa o pintura suelta. Rellena grietas con masilla y lija hasta nivelar. Aplica sellador en superficies porosas o nuevas.</p></div>
                                </div>
                                <div class="flex gap-3 sm:gap-4">
                                    <div class="w-7 h-7 sm:w-8 sm:h-8 rounded-full bg-primary flex items-center justify-center text-dark-neutral font-black text-xs shrink-0 mt-0.5">2</div>
                                    <div><p class="font-bold text-dark-neutral mb-1 text-sm">Primera Mano</p><p class="text-xs sm:text-sm">Aplica con rodillo de pelo corto para superficies lisas o rodillo de pelo largo para texturas. Recorta bordes con brocha.</p></div>
                                </div>
                                <div class="flex gap-3 sm:gap-4">
                                    <div class="w-7 h-7 sm:w-8 sm:h-8 rounded-full bg-primary flex items-center justify-center text-dark-neutral font-black text-xs shrink-0 mt-0.5">3</div>
                                    <div><p class="font-bold text-dark-neutral mb-1 text-sm">Segunda Mano</p><p class="text-xs sm:text-sm">Espera mínimo 4 horas antes de aplicar la segunda mano. Se recomiendan dos manos para cobertura total.</p></div>
                                </div>
                                <div class="flex gap-3 sm:gap-4">
                                    <div class="w-7 h-7 sm:w-8 sm:h-8 rounded-full bg-primary flex items-center justify-center text-dark-neutral font-black text-xs shrink-0 mt-0.5">4</div>
                                    <div><p class="font-bold text-dark-neutral mb-1 text-sm">Limpieza de Herramientas</p><p class="text-xs sm:text-sm">Limpia las herramientas con agua y jabón inmediatamente después del uso.</p></div>
                                </div>
                            </div>
                        </div>
                    </div>

                </main>

                <!-- ===== FOOTER ===== -->
                <footer class="bg-white dark:bg-background-dark border-t border-slate-200 dark:border-slate-800 py-10 sm:py-12 px-4 sm:px-6">
                    <div class="max-w-7xl mx-auto grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-8 sm:gap-12 px-0 sm:px-6">
                        <div class="col-span-1 sm:col-span-2 md:col-span-1">
                            <div class="flex items-center gap-3 mb-4 sm:mb-6">
                                <div class="size-6 bg-primary rounded flex items-center justify-center text-dark-neutral">
                                    <span class="material-symbols-outlined text-sm">format_paint</span>
                                </div>
                                <h2 class="text-dark-neutral dark:text-primary text-lg font-black tracking-tight">MicroTex</h2>
                            </div>
                            <p class="text-slate-500 text-sm leading-relaxed mb-4 sm:mb-6">Fabricamos texturas, efectos y colores. Soluciones avanzadas en recubrimientos para transformar tus espacios.</p>
                        </div>
                        <div>
                            <h4 class="font-bold text-dark-neutral mb-4 sm:mb-6 text-sm">Productos</h4>
                            <ul class="flex flex-col gap-3 sm:gap-4 text-sm text-slate-500">
                                <li><a class="hover:text-dark-neutral transition-colors" href="detalle.aspx?id=1">Pintura Arquitectónica</a></li>
                                <li><a class="hover:text-dark-neutral transition-colors" href="detalle.aspx?id=2">Producto Cementicio</a></li>
                                <li><a class="hover:text-dark-neutral transition-colors" href="detalle.aspx?id=3">Impermeabilizantes</a></li>
                                <li><a class="hover:text-dark-neutral transition-colors" href="detalle.aspx?id=4">Luminiscentes</a></li>
                                <li><a class="hover:text-dark-neutral transition-colors" href="detalle.aspx?id=5">Esmaltes Alquidales</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="font-bold text-dark-neutral mb-4 sm:mb-6 text-sm">Empresa</h4>
                            <ul class="flex flex-col gap-3 sm:gap-4 text-sm text-slate-500">
                                <li><a class="hover:text-dark-neutral transition-colors" href="Default.aspx#nosotros">Sobre Nosotros</a></li>
                                <li><a class="hover:text-dark-neutral transition-colors" href="Default.aspx#contacto">Contacto</a></li>
                                <li><a class="hover:text-dark-neutral transition-colors" href="Default.aspx#proyectos">Proyectos</a></li>
                                <li><a class="hover:text-dark-neutral transition-colors" href="https://microtexmexico.com" target="_blank">Sitio Web</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="font-bold text-dark-neutral mb-4 sm:mb-6 text-sm">Contacto</h4>
                            <ul class="flex flex-col gap-3 sm:gap-4 text-sm text-slate-500">
                                <li class="flex items-center gap-2"><span class="material-symbols-outlined text-base text-accent shrink-0">call</span>771 567 6119</li>
                                <li class="flex items-center gap-2"><span class="material-symbols-outlined text-base text-accent shrink-0">mail</span>dante_ceron@outlook.com</li>
                                <li class="flex items-center gap-2"><span class="material-symbols-outlined text-base text-accent shrink-0">location_on</span>Ajacuba, Hidalgo</li>
                            </ul>
                        </div>
                    </div>
                    <div class="max-w-7xl mx-auto mt-10 sm:mt-12 pt-8 border-t border-slate-100 flex flex-col sm:flex-row justify-between items-center gap-4 px-0 sm:px-6">
                        <asp:Label ID="lblCopyright" runat="server" CssClass="text-xs text-slate-400 text-center sm:text-left" />
                        <div class="flex gap-6 text-xs text-slate-400">
                            <a class="hover:text-dark-neutral" href="#">Política de Privacidad</a>
                            <a class="hover:text-dark-neutral" href="#">Términos de Servicio</a>
                        </div>
                    </div>
                </footer>

            </div>
        </div>

        <script type="text/javascript">
            function setMainImage(url, el) {
                document.querySelector('.detail-main-img img').src = url;
                document.querySelectorAll('.thumb-item').forEach(function (t) { t.classList.remove('border-dark-neutral', 'border-slate-300'); });
                el.classList.add('border-dark-neutral');
            }
            window.addEventListener('DOMContentLoaded', function () {
                var first = document.querySelector('.thumb-item');
                if (first) first.classList.add('border-dark-neutral');
                // Color inicial en el hidden field
                document.getElementById('<%= hfColor.ClientID %>').value = 'Azul Contemporáneo';
            });
            function changeQty(delta) {
                var inp = document.getElementById('<%= txtQty.ClientID %>');
                var val = Math.max(1, (parseInt(inp.value) || 1) + delta);
                inp.value = val;
            }
            function selectColor(btn, hex, name) {
                document.querySelectorAll('.color-swatch').forEach(function (s) {
                    s.classList.remove('ring-2', 'ring-offset-2', 'ring-dark-neutral/30', 'border-dark-neutral');
                    s.classList.add('border-transparent');
                });
                btn.classList.add('ring-2', 'ring-offset-2', 'ring-dark-neutral/30', 'border-dark-neutral');
                btn.classList.remove('border-transparent');
                document.getElementById('selectedColorName').textContent = name;
                document.getElementById('<%= hfColor.ClientID %>').value = name;
            }
            function toggleFav(btn) {
                var icon = btn.querySelector('.material-symbols-outlined');
                if (icon.style.fontVariationSettings && icon.style.fontVariationSettings.includes("'FILL' 1")) {
                    icon.style.fontVariationSettings = "";
                    btn.classList.remove('text-red-500');
                    btn.classList.add('text-slate-400');
                } else {
                    icon.style.fontVariationSettings = "'FILL' 1, 'wght' 400";
                    btn.classList.remove('text-slate-400');
                    btn.classList.add('text-red-500');
                }
            }
            function setTab(btn, tabId) {
                document.querySelectorAll('.tab-btn').forEach(function (b) {
                    b.classList.remove('border-dark-neutral', 'font-bold', 'text-dark-neutral');
                    b.classList.add('border-transparent', 'font-medium', 'text-slate-400');
                });
                btn.classList.add('border-dark-neutral', 'font-bold', 'text-dark-neutral');
                btn.classList.remove('border-transparent', 'font-medium', 'text-slate-400');
                document.querySelectorAll('.tab-content').forEach(function (t) { t.classList.add('hidden'); });
                document.getElementById(tabId).classList.remove('hidden');
            }
        </script>
    </form>
</body>
</html>
