<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="proyectos.aspx.cs" Inherits="Microtex.proyectos" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Proyectos | Microtex - Galería</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="Scripts/tailwind.config.js"></script>
    <link href="Styles/site.css" rel="stylesheet" />

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #fcfcfc; }

        .project-card:hover .project-overlay { opacity: 1; }
        .project-overlay {
            transition: opacity 0.3s ease;
            background: linear-gradient(to top, rgba(79,76,68,0.85), transparent);
        }
        .filter-btn.active {
            background-color: #1e293b;
            color: #fff;
            border-color: #1e293b;
        }

        /* Mobile menu */
        #proy-mobile-menu { display: none; flex-direction: column; }
        #proy-mobile-menu.open { display: flex; }

        /* Altura de cards responsive */
        .project-card { height: 360px; }
        @media(min-width: 640px) { .project-card { height: 440px; } }
        @media(min-width: 1024px) { .project-card { height: 500px; } }
    </style>
</head>
<body class="text-slate-800">
<form id="form1" runat="server">

    <!-- ===== HEADER ===== -->
    <header class="sticky top-0 z-50 w-full bg-white/95 backdrop-blur-md border-b border-slate-200 shadow-sm">
        <div class="flex w-full items-center gap-3 px-4 sm:px-6 py-3">

            <!-- Logo -->
            <a href="Default.aspx" class="flex items-center gap-2 shrink-0">
                <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-900 text-white font-black text-sm">M</div>
                <span class="text-base font-black tracking-tight text-slate-900">Microtex</span>
            </a>

            <!-- Buscador — oculto en xs -->
            <div class="hidden sm:flex flex-1 mx-4 max-w-md">
                <div class="relative w-full">
                    <span class="material-symbols-outlined absolute left-3 top-2.5 text-slate-400 text-sm pointer-events-none">search</span>
                    <input type="text" placeholder="Buscar proyectos o acabados..."
                        onkeydown="if(event.key==='Enter'){location.href='productos.aspx?q='+this.value}"
                        class="w-full rounded-full border border-slate-200 bg-slate-50 pl-9 pr-4 py-2 text-sm text-slate-700 focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300" />
                </div>
            </div>

            <!-- Nav links — solo desktop -->
            <nav class="hidden lg:flex items-center gap-8">
                <a class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors" href="productos.aspx">Catálogo</a>
                <a class="text-sm font-bold text-slate-900" href="proyectos.aspx">Proyectos</a>
                <a class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors" href="Nosotros.aspx">Nosotros</a>
            </nav>

            <!-- Íconos derecha -->
            <div class="flex items-center gap-2 shrink-0 ml-auto">
                <asp:Button ID="btnGetQuote" runat="server" Text="" OnClick="btnGetQuote_Click" UseSubmitBehavior="false" Style="display: none;" />
                <asp:Literal ID="litNavUser" runat="server" />
                <!-- Carrito → carrito.aspx -->
                <a href="carrito.aspx"
                    class="relative w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                    <span class="material-symbols-outlined text-xl">shopping_bag</span>
                    <span id="cartBadge" class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none">0</span>
                </a>
                <!-- Hamburguesa — solo móvil/tablet -->
                <button type="button" id="menu-btn"
                    onclick="document.getElementById('mobile-menu').classList.toggle('open')"
                    class="lg:hidden w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                    <span class="material-symbols-outlined text-xl">menu</span>
                </button>
            </div>
        </div>

        <!-- Search móvil -->
        <div class="sm:hidden px-4 pb-3">
            <div class="relative">
                <span class="material-symbols-outlined absolute left-3 top-2.5 text-slate-400 text-sm pointer-events-none">search</span>
                <input type="text" placeholder="Buscar proyectos..."
                    onkeydown="if(event.key==='Enter'){location.href='productos.aspx?q='+this.value}"
                    class="w-full rounded-full border border-slate-200 bg-slate-50 pl-9 pr-4 py-2 text-sm text-slate-700 focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300" />
            </div>
        </div>

        <!-- Mobile menu -->
        <div id="proy-mobile-menu" class="lg:hidden border-t border-slate-100 bg-white px-4 py-3 gap-1">
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="productos.aspx">Catálogo</a>
            <a class="block px-3 py-2.5 text-sm font-bold text-slate-900 bg-slate-50 rounded-lg" href="proyectos.aspx">Proyectos</a>
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="Nosotros.aspx">Nosotros</a>
        </div>
    </header>

    <main>

        <!-- ===== HERO ===== -->
        <section class="relative flex items-center justify-center overflow-hidden bg-[#EDE8D0]"
                 style="min-height: 280px; height: clamp(280px, 50vw, 450px);">
            <img alt="Hero Background"
                class="absolute inset-0 w-full h-full object-cover opacity-60"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuBbXCqd3MKtlk5utk9eYo14w-2eAs4Fzsx77NhYgd3Y_WcaDmfN2v6MQz5W1ggxLl5D0FLXa-7JDK7zPxhaS_x9ejLLO5hyGdQsvEtce2iZFXc65QkKmw1KOBGj4v4PhjiJK0eUXVrJioDiMaaU3Qql4EazUqnxsiIK8wXfF7JZGZm2TO-AESYVEvRieAG9JF0Tm5yEG0KH_ltX6BQIIooJtNQUQALefcx7VWPDT7FF-lmWWsAlZnatUbDRmovcAXvV9ZZqqNy28_vc" />
            <div class="relative z-10 text-center px-4 sm:px-6 max-w-3xl">
                <h1 class="text-3xl sm:text-5xl md:text-6xl font-bold mb-4 sm:mb-6 tracking-tight text-slate-900">
                    <asp:Literal ID="litHeroTitle" runat="server" Text="Inspiración en cada rincón" />
                </h1>
                <p class="text-base sm:text-lg md:text-xl text-slate-700 opacity-90 leading-relaxed mb-5 sm:mb-8">
                    <asp:Literal ID="litHeroSubtitle" runat="server"
                        Text="Explora cómo nuestros acabados transforman espacios arquitectónicos en experiencias visuales únicas y duraderas." />
                </p>
                <nav class="flex justify-center text-xs sm:text-sm font-medium uppercase tracking-widest text-[#8F8A7A]">
                    <a class="px-2 hover:text-slate-800 transition-colors" href="Default.aspx">Home</a>
                    <span class="px-2">/</span>
                    <span class="px-2 text-slate-900">Proyectos</span>
                </nav>
            </div>
        </section>

        <!-- ===== FILTROS ===== -->
        <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-12">
            <!-- Scroll horizontal en móvil -->
            <div class="flex gap-2 sm:gap-4 overflow-x-auto pb-2 sm:pb-0 sm:flex-wrap sm:justify-center -mx-4 px-4 sm:mx-0 sm:px-0 scrollbar-hide"
                 id="filterContainer">
                <button type="button" onclick="filterProjects('todos', this)"
                    class="filter-btn active px-5 sm:px-8 py-2 rounded-full border border-slate-200 font-medium transition-all text-xs sm:text-sm shrink-0">Todos</button>
                <button type="button" onclick="filterProjects('residencial', this)"
                    class="filter-btn px-5 sm:px-8 py-2 rounded-full border border-slate-200 hover:bg-[#EDE8D0] font-medium transition-all text-xs sm:text-sm shrink-0">Residencial</button>
                <button type="button" onclick="filterProjects('comercial', this)"
                    class="filter-btn px-5 sm:px-8 py-2 rounded-full border border-slate-200 hover:bg-[#EDE8D0] font-medium transition-all text-xs sm:text-sm shrink-0">Comercial</button>
                <button type="button" onclick="filterProjects('industrial', this)"
                    class="filter-btn px-5 sm:px-8 py-2 rounded-full border border-slate-200 hover:bg-[#EDE8D0] font-medium transition-all text-xs sm:text-sm shrink-0">Industrial</button>
                <button type="button" onclick="filterProjects('restauracion', this)"
                    class="filter-btn px-5 sm:px-8 py-2 rounded-full border border-slate-200 hover:bg-[#EDE8D0] font-medium transition-all text-xs sm:text-sm shrink-0">Restauración</button>
                <button type="button" onclick="filterProjects('interiorismo', this)"
                    class="filter-btn px-5 sm:px-8 py-2 rounded-full border border-slate-200 hover:bg-[#EDE8D0] font-medium transition-all text-xs sm:text-sm shrink-0">Interiorismo</button>
            </div>
        </section>

        <!-- ===== GALERÍA ===== -->
        <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pb-16 sm:pb-24">
            <!-- 1 col en móvil, 2 en md -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 sm:gap-8" id="projectGrid">

                <asp:Repeater ID="rptProjects" runat="server" OnItemCommand="rptProjects_ItemCommand">
                    <ItemTemplate>
                        <article class="project-card relative group overflow-hidden rounded-xl cursor-pointer"
                            data-category='<%# Eval("CategorySlug") %>'>
                            <img alt='<%# Eval("Title") %>'
                                class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
                                src='<%# Eval("ImageUrl") %>' />
                            <div class="project-overlay absolute inset-0 flex flex-col justify-end p-5 sm:p-8 opacity-0">
                                <span class="text-[#EDE8D0] uppercase text-xs tracking-widest mb-2"><%# Eval("Category") %></span>
                                <h3 class="text-2xl sm:text-3xl font-bold text-white mb-3 sm:mb-4"><%# Eval("Title") %></h3>
                                <p class="text-white/80 max-w-sm mb-4 sm:mb-6 text-sm sm:text-base"><%# Eval("Description") %></p>
                                <asp:LinkButton CommandName="VerDetalle" CommandArgument='<%# Eval("Id") %>'
                                    runat="server"
                                    CssClass="w-fit px-5 sm:px-6 py-2 bg-white text-slate-800 text-xs sm:text-sm font-bold uppercase hover:bg-[#EDE8D0] transition-colors">
                                    Ver Detalles
                                </asp:LinkButton>
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>

            </div>

            <!-- Paginación -->
            <div class="mt-12 sm:mt-16 flex items-center justify-center gap-1 sm:gap-2">
                <asp:Button ID="btnPrevPage" runat="server" Text="‹" OnClick="btnPrevPage_Click"
                    CssClass="p-2 w-9 h-9 sm:w-10 sm:h-10 border border-slate-200 rounded-md hover:bg-slate-100 text-slate-600 font-bold text-lg transition-colors" />

                <asp:Repeater ID="rptPages" runat="server" OnItemCommand="rptPages_ItemCommand">
                    <ItemTemplate>
                        <asp:LinkButton CommandName="GoPage" CommandArgument='<%# Eval("PageNumber") %>'
                            runat="server"
                            CssClass='<%# (bool)Eval("IsActive") ? "w-9 h-9 sm:w-10 sm:h-10 bg-slate-900 text-white rounded-md font-bold text-sm flex items-center justify-center" : "w-9 h-9 sm:w-10 sm:h-10 border border-transparent hover:border-slate-200 rounded-md text-sm font-medium flex items-center justify-center transition-colors" %>'>
                            <%# Eval("PageNumber") %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Button ID="btnNextPage" runat="server" Text="›" OnClick="btnNextPage_Click"
                    CssClass="p-2 w-9 h-9 sm:w-10 sm:h-10 border border-slate-200 rounded-md hover:bg-slate-100 text-slate-600 font-bold text-lg transition-colors" />
            </div>

        </section>

    </main>

    <!-- ===== FOOTER ===== -->
    <footer class="bg-white border-t border-slate-100 pt-14 sm:pt-20 pb-8 sm:pb-10">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8 sm:gap-12 mb-10 sm:mb-16">

                <!-- Brand -->
                <div class="sm:col-span-2 lg:col-span-1">
                    <div class="flex items-center gap-2 mb-4 sm:mb-6">
                        <div class="flex h-6 w-6 items-center justify-center rounded bg-slate-900 text-white font-bold text-xs">M</div>
                        <span class="text-lg font-bold tracking-tight text-slate-900">Microtex</span>
                    </div>
                    <p class="text-[#8F8A7A] text-sm leading-relaxed mb-5 sm:mb-6">
                        Redefiniendo las superficies arquitectónicas con innovación, durabilidad y un compromiso con la armonía ambiental desde 1994.
                    </p>
                    <div class="flex gap-4 text-[#8F8A7A]">
                        <a class="hover:text-slate-900 transition-colors" href="#">
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24"><path d="M12 2C6.477 2 2 6.477 2 12c0 4.418 2.865 8.166 6.839 9.489.5.092.682-.217.682-.482 0-.237-.008-.866-.013-1.7-2.782.603-3.369-1.34-3.369-1.34-.454-1.156-1.11-1.463-1.11-1.463-.908-.62.069-.608.069-.608 1.003.07 1.531 1.03 1.531 1.03.892 1.529 2.341 1.087 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482C19.138 20.161 22 16.416 22 12c0-5.523-4.477-10-10-10z"/></svg>
                        </a>
                        <a class="hover:text-slate-900 transition-colors" href="#">
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24"><path d="M23 3a10.9 10.9 0 01-3.14 1.53 4.48 4.48 0 00-7.86 3v1A10.66 10.66 0 013 4s-4 9 5 13a11.64 11.64 0 01-7 2c9 5 20 0 20-11.5a4.5 4.5 0 00-.08-.83A7.72 7.72 0 0023 3z"/></svg>
                        </a>
                        <a class="hover:text-slate-900 transition-colors" href="#">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" stroke-linecap="round" stroke-linejoin="round"/></svg>
                        </a>
                    </div>
                </div>

                <!-- Productos -->
                <div>
                    <h4 class="font-bold text-xs uppercase tracking-widest mb-4 sm:mb-6 text-slate-900">Productos</h4>
                    <ul class="space-y-3 sm:space-y-4 text-[#8F8A7A] text-sm">
                        <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=1">Interior Solutions</a></li>
                        <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=2">Exterior Protection</a></li>
                        <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=3">Industrial Coatings</a></li>
                        <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=4">Eco-Series</a></li>
                    </ul>
                </div>

                <!-- Compañía -->
                <div>
                    <h4 class="font-bold text-xs uppercase tracking-widest mb-4 sm:mb-6 text-slate-900">Compañía</h4>
                    <ul class="space-y-3 sm:space-y-4 text-[#8F8A7A] text-sm">
                        <li><a class="hover:text-slate-900 transition-colors" href="Nosotros.aspx">Sobre Nosotros</a></li>
                        <li><a class="hover:text-slate-900 transition-colors" href="#">Sustentabilidad</a></li>
                        <li><a class="hover:text-slate-900 transition-colors" href="Default.aspx#contacto">Contacto</a></li>
                        <li><a class="hover:text-slate-900 transition-colors" href="#">Carreras</a></li>
                    </ul>
                </div>

                <!-- Newsletter -->
                <div>
                    <h4 class="font-bold text-xs uppercase tracking-widest mb-4 sm:mb-6 text-slate-900">Newsletter</h4>
                    <p class="text-[#8F8A7A] text-sm mb-4">Suscríbete para recibir tendencias de color e inspiración.</p>
                    <div class="flex">
                        <asp:TextBox ID="txtNewsletterEmail" runat="server" TextMode="Email"
                            placeholder="Tu email"
                            CssClass="flex-1 px-3 sm:px-4 py-2 bg-slate-50 border border-slate-200 rounded-l-md focus:outline-none focus:ring-1 focus:ring-slate-400 text-sm min-w-0" />
                        <asp:Button ID="btnNewsletter" runat="server" Text="Unirse"
                            OnClick="btnNewsletter_Click"
                            CssClass="px-4 sm:px-6 py-2 bg-slate-900 text-white font-bold text-sm rounded-r-md hover:bg-black transition-colors shrink-0" />
                    </div>
                    <asp:Label ID="lblNewsletterMsg" runat="server" Visible="false"
                        CssClass="text-xs mt-2 block" />
                </div>

            </div>

            <div class="pt-6 sm:pt-8 border-t border-slate-100 flex flex-col sm:flex-row justify-between items-center gap-4">
                <asp:Label ID="lblCopyright" runat="server" CssClass="text-xs text-[#8F8A7A] text-center sm:text-left" />
                <div class="flex gap-4 sm:gap-6 text-xs font-medium text-[#8F8A7A]">
                    <a class="hover:text-slate-900 transition-colors" href="#">Privacidad</a>
                    <a class="hover:text-slate-900 transition-colors" href="#">Términos</a>
                    <a class="hover:text-slate-900 transition-colors" href="#">Cookies</a>
                </div>
            </div>

        </div>
    </footer>

</form>

<script type="text/javascript">
    function filterProjects(category, btn) {
        document.querySelectorAll('.filter-btn').forEach(function (b) {
            b.classList.remove('active');
            b.style.backgroundColor = '';
            b.style.color = '';
        });
        btn.classList.add('active');

        var cards = document.querySelectorAll('#projectGrid article');
        cards.forEach(function (card) {
            if (category === 'todos' || card.getAttribute('data-category') === category) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    }
</script>
</body>
</html>
