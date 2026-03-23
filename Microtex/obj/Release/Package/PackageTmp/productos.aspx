<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="productos.aspx.cs" Inherits="Microtex.productos" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>MicroTex | Catálogo de Productos</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="Scripts/tailwind.config.js"></script>
    <link href="Styles/site.css" rel="stylesheet" />
    <link href="Styles/productos.css" rel="stylesheet" />
    <style>
        html, body { height:100%; margin:0; padding:0; font-family:'Inter',sans-serif; }
        body { display:flex; flex-direction:column; min-height:100vh; }
        body > form { display:flex; flex-direction:column; flex:1; min-height:100vh; }

        /* ✅ FIX CRÍTICO navbar — neutralizar site.css */
        header nav, header nav a { flex-direction:row !important; flex-wrap:nowrap !important; flex:none !important; }
        header nav a { display:inline-flex !important; width:auto !important; text-align:left !important; padding:0 !important; border-bottom:none !important; }

        #prod-mobile-menu { display:none; flex-direction:column; }
        #prod-mobile-menu.open { display:flex; }

        /* Sidebar slide en móvil */
        #prod-sidebar { transition: transform 0.3s ease; }
        @media(max-width:1023px){
            #prod-sidebar {
                position: fixed;
                top: 0; left: 0;
                height: 100vh;
                width: 280px;
                z-index: 100;
                transform: translateX(-100%);
                overflow-y: auto;
                box-shadow: 4px 0 24px rgba(0,0,0,0.12);
            }
            #prod-sidebar.open { transform: translateX(0); }
            #sidebar-overlay {
                display: none;
                position: fixed;
                inset: 0;
                background: rgba(0,0,0,0.4);
                z-index: 99;
            }
            #sidebar-overlay.open { display: block; }
        }

        .product-img-box {
            position: relative; width: 100%; height: 280px;
            overflow: hidden; border-radius: 0.75rem;
            background-color: #f1f5f9; display: block;
        }
        .product-img-box img {
            position: absolute; top:0; left:0;
            width:100%; height:100%; object-fit:cover;
        }
        @media(min-width:640px)  { .product-img-box { height:320px; } }
        @media(min-width:1024px) { .product-img-box { height:360px; } }
    </style>
</head>
<body class="bg-background-light font-display text-slate-900 min-h-screen">
<form id="form1" runat="server">

    <!-- ===== NAVBAR — FUERA de cualquier div con overflow ===== -->
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
                <a class="text-sm font-bold text-slate-900" href="productos.aspx">Catalogo</a>
                <a class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors" href="proyectos.aspx">Proyectos</a>
                <a class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors" href="Nosotros.aspx">Nosotros</a>
            </nav>
            <div class="flex items-center gap-2 shrink-0 ml-auto">
                <asp:Button ID="btnGetQuote" runat="server" Text="" OnClick="btnGetQuote_Click" UseSubmitBehavior="false" style="display:none;" />
                <asp:Literal ID="litNavUser" runat="server" />
                <a href="carrito.aspx" class="relative w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                    <span class="material-symbols-outlined text-xl">shopping_bag</span>
                    <span id="cartBadge" class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none">0</span>
                </a>
                <button type="button"
                    onclick="document.getElementById('prod-mobile-menu').classList.toggle('open')"
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
        <div id="prod-mobile-menu" class="lg:hidden border-t border-slate-100 bg-white px-4 py-3 gap-1">
            <a class="block px-3 py-2.5 text-sm font-bold text-slate-900 bg-slate-50 rounded-lg" href="productos.aspx">Catalogo</a>
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="proyectos.aspx">Proyectos</a>
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="Nosotros.aspx">Nosotros</a>
        </div>
    </header>

    <!-- Overlay sidebar móvil -->
    <div id="sidebar-overlay" onclick="toggleSidebar()"></div>

    <!-- BODY: sidebar + contenido -->
    <div style="display:flex; flex:1; min-height:0;">

        <!-- ===== SIDEBAR ===== -->
        <aside id="prod-sidebar" class="w-72 lg:w-64 shrink-0 border-r border-slate-200 p-6 flex flex-col gap-8 bg-white">
            <div class="lg:hidden flex justify-between items-center -mb-2">
                <span class="text-sm font-bold text-slate-900">Filtros y Categorias</span>
                <button type="button" onclick="toggleSidebar()"
                    class="w-8 h-8 flex items-center justify-center rounded-full hover:bg-slate-100 text-slate-500">
                    <span class="material-symbols-outlined text-lg">close</span>
                </button>
            </div>
            <div>
                <h3 class="text-xs font-bold uppercase tracking-widest text-slate-400 mb-4">Categorias</h3>
                <nav class="flex flex-col gap-1">
                    <a class="flex items-center gap-3 px-3 py-2 rounded-lg bg-primary text-dark font-semibold" href="#">
                        <span class="material-symbols-outlined text-sm">grid_view</span>
                        <span class="text-sm">Todos los Productos</span>
                    </a>
                    <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-600 hover:bg-slate-100 transition-colors" href="#">
                        <span class="material-symbols-outlined text-sm">format_paint</span>
                        <span class="text-sm">Pintura Arquitectonica</span>
                    </a>
                    <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-600 hover:bg-slate-100 transition-colors" href="#">
                        <span class="material-symbols-outlined text-sm">texture</span>
                        <span class="text-sm">Producto Cementicio</span>
                    </a>
                    <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-600 hover:bg-slate-100 transition-colors" href="#">
                        <span class="material-symbols-outlined text-sm">water_drop</span>
                        <span class="text-sm">Impermeabilizantes</span>
                    </a>
                    <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-600 hover:bg-slate-100 transition-colors" href="#">
                        <span class="material-symbols-outlined text-sm">lightbulb</span>
                        <span class="text-sm">Luminiscentes</span>
                    </a>
                    <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-600 hover:bg-slate-100 transition-colors" href="#">
                        <span class="material-symbols-outlined text-sm">hardware</span>
                        <span class="text-sm">Esmaltes Alquidales</span>
                    </a>
                </nav>
            </div>
            <div>
                <h3 class="text-xs font-bold uppercase tracking-widest text-slate-400 mb-4">Filtros</h3>
                <div class="flex flex-col gap-4">
                    <div class="flex flex-col gap-2">
                        <p class="text-sm font-semibold text-dark">Acabado</p>
                        <label class="flex items-center gap-2 text-sm text-slate-600">
                            <asp:CheckBox ID="chkMatte" runat="server" Checked="true" CssClass="rounded border-slate-300" /> Mate
                        </label>
                        <label class="flex items-center gap-2 text-sm text-slate-600">
                            <asp:CheckBox ID="chkGlossy" runat="server" CssClass="rounded border-slate-300" /> Brillante
                        </label>
                        <label class="flex items-center gap-2 text-sm text-slate-600">
                            <asp:CheckBox ID="chkSatin" runat="server" CssClass="rounded border-slate-300" /> Satinado
                        </label>
                    </div>
                    <div class="flex flex-col gap-2 pt-2">
                        <p class="text-sm font-semibold text-dark">Tipo de Base</p>
                        <label class="flex items-center gap-2 text-sm text-slate-600">
                            <asp:CheckBox ID="chkWater" runat="server" CssClass="rounded border-slate-300" /> Base Agua
                        </label>
                        <label class="flex items-center gap-2 text-sm text-slate-600">
                            <asp:CheckBox ID="chkOil" runat="server" CssClass="rounded border-slate-300" /> Base Aceite
                        </label>
                    </div>
                </div>
            </div>
            <div class="mt-auto bg-primary/20 p-4 rounded-xl">
                <p class="text-xs font-bold text-accent mb-1">¡Nuevo Producto!</p>
                <p class="text-sm font-semibold text-dark mb-3">Luminiscentes 12 hrs</p>
                <asp:Button ID="btnEcoExplore" runat="server" Text="Explorar"
                    OnClick="btnEcoExplore_Click"
                    CssClass="w-full py-2 bg-dark text-white rounded-lg text-xs font-bold hover:bg-slate-700 transition-colors" />
            </div>
        </aside>

        <!-- ===== PRODUCT GRID ===== -->
        <div style="flex:1; min-width:0; overflow-y:auto;">
            <div class="p-4 sm:p-6 md:p-10">
                <div class="flex flex-col sm:flex-row justify-between items-start sm:items-end gap-4 sm:gap-6 mb-8 sm:mb-10">
                    <div>
                        <h2 class="text-xl sm:text-2xl font-black text-dark mb-1">Todos los Productos</h2>
                        <p class="text-slate-500 text-xs sm:text-sm max-w-2xl">
                            Resinas vinilicas-acrilicas, cementicios, impermeabilizantes, luminiscentes y esmaltes.
                        </p>
                    </div>
                    <div class="flex gap-3 w-full sm:w-auto">
                        <button type="button" onclick="toggleSidebar()"
                            class="lg:hidden flex items-center gap-2 px-4 py-2 bg-white border border-slate-200 rounded-lg text-sm font-bold shadow-sm">
                            <span class="material-symbols-outlined text-sm">tune</span>
                            Filtros
                        </button>
                        <asp:DropDownList ID="ddlSort" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlSort_SelectedIndexChanged"
                            CssClass="flex-1 sm:flex-none px-4 py-2 bg-white border border-slate-200 rounded-lg text-sm font-bold shadow-sm">
                            <asp:ListItem Text="Ordenar: Popular"    Value="popular" />
                            <asp:ListItem Text="Ordenar: Precio ↑"   Value="price_asc" />
                            <asp:ListItem Text="Ordenar: Precio ↓"   Value="price_desc" />
                            <asp:ListItem Text="Ordenar: Mas nuevo"  Value="newest" />
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5 sm:gap-8">
                    <asp:Repeater ID="rptProducts" runat="server">
                        <ItemTemplate>
                            <div class="group flex flex-col gap-3 sm:gap-4">
                                <a href='<%# "detalle.aspx?id=" + Eval("Id") %>' class="product-img-box">
                                    <asp:Image ID="imgProduct" runat="server"
                                        ImageUrl='<%# Eval("ImageUrl") %>'
                                        AlternateText='<%# Eval("AltText") %>'
                                        CssClass="transition-transform duration-500 group-hover:scale-110" />
                                    <%# GetBadgeHtml(Eval("Badge")) %>
                                    <div class="absolute inset-0 bg-dark-neutral/0 group-hover:bg-dark-neutral/10 transition-all duration-300 flex items-center justify-center">
                                        <span class="material-symbols-outlined text-white opacity-0 group-hover:opacity-100 transition-opacity text-4xl drop-shadow-lg">visibility</span>
                                    </div>
                                </a>
                                <div class="flex justify-between items-start gap-2">
                                    <div class="min-w-0">
                                        <a href='<%# "detalle.aspx?id=" + Eval("Id") %>' class="text-base sm:text-lg font-bold text-dark hover:text-accent transition-colors block truncate"><%# Eval("Name") %></a>
                                        <p class="text-xs sm:text-sm text-slate-500 truncate"><%# Eval("Subtitle") %></p>
                                    </div>
                                    <p class="font-black text-dark shrink-0 text-sm sm:text-base"><%# (decimal)Eval("Price") > 0 ? string.Format("${0:0.00}", Eval("Price")) : "Cotizar" %></p>
                                </div>
                                <asp:Button ID="btnQuickAdd" runat="server"
                                    Text="Agregar"
                                    CommandArgument='<%# Eval("Id") %>'
                                    OnCommand="btnQuickAdd_Command"
                                    CssClass="w-full py-2.5 sm:py-3 border border-dark text-dark rounded-lg text-sm font-bold hover:bg-dark hover:text-white transition-all" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <asp:Label ID="lblFeedback" runat="server" Visible="false"
                    CssClass="mt-6 block text-center text-sm font-semibold text-accent" />

                <div class="mt-12 sm:mt-16 flex justify-center">
                    <nav class="flex items-center gap-1 sm:gap-2">
                        <asp:LinkButton ID="lbtnPrev" runat="server" OnClick="lbtnPrev_Click"
                            CssClass="w-9 h-9 sm:w-10 sm:h-10 flex items-center justify-center rounded-lg border border-slate-200 text-slate-400 hover:bg-slate-50">
                            <span class="material-symbols-outlined text-sm sm:text-base">chevron_left</span>
                        </asp:LinkButton>
                        <asp:Repeater ID="rptPages" runat="server" OnItemCommand="rptPages_ItemCommand">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnPage" runat="server"
                                    CommandName="Page"
                                    CommandArgument='<%# Eval("PageNumber") %>'
                                    CssClass='<%# (int)Eval("PageNumber") == CurrentPage ? "w-9 h-9 sm:w-10 sm:h-10 flex items-center justify-center rounded-lg bg-dark text-white font-bold text-sm" : "w-9 h-9 sm:w-10 sm:h-10 flex items-center justify-center rounded-lg border border-transparent text-slate-600 font-bold hover:bg-slate-50 text-sm" %>'>
                                    <%# Eval("PageNumber") %>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:LinkButton ID="lbtnNext" runat="server" OnClick="lbtnNext_Click"
                            CssClass="w-9 h-9 sm:w-10 sm:h-10 flex items-center justify-center rounded-lg border border-slate-200 text-slate-400 hover:bg-slate-50">
                            <span class="material-symbols-outlined text-sm sm:text-base">chevron_right</span>
                        </asp:LinkButton>
                    </nav>
                </div>
            </div>

            <!-- FOOTER -->
            <footer class="bg-white border-t border-slate-200 py-10 sm:py-12 px-4 sm:px-6">
                <div class="max-w-7xl mx-auto grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-8 sm:gap-12 px-0 sm:px-6">
                    <div class="sm:col-span-2 md:col-span-1">
                        <div class="flex items-center gap-3 mb-4 sm:mb-6">
                            <div class="size-6 bg-primary rounded flex items-center justify-center text-dark">
                                <span class="material-symbols-outlined text-sm">format_paint</span>
                            </div>
                            <h2 class="text-dark text-lg font-black tracking-tight">Microtex</h2>
                        </div>
                        <p class="text-slate-500 text-sm leading-relaxed mb-4 sm:mb-6">
                            MicroTex — Fabricamos texturas, efectos y colores. Soluciones avanzadas en recubrimientos para transformar tus espacios.
                        </p>
                    </div>
                    <div>
                        <h4 class="font-bold text-dark mb-4 sm:mb-6 text-sm">Productos</h4>
                        <ul class="flex flex-col gap-3 sm:gap-4 text-sm text-slate-500">
                            <li><a class="hover:text-dark transition-colors" href="#">Pintura Arquitectonica</a></li>
                            <li><a class="hover:text-dark transition-colors" href="#">Producto Cementicio</a></li>
                            <li><a class="hover:text-dark transition-colors" href="#">Impermeabilizantes</a></li>
                            <li><a class="hover:text-dark transition-colors" href="#">Luminiscentes</a></li>
                            <li><a class="hover:text-dark transition-colors" href="#">Esmaltes Alquidales</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-bold text-dark mb-4 sm:mb-6 text-sm">Empresa</h4>
                        <ul class="flex flex-col gap-3 sm:gap-4 text-sm text-slate-500">
                            <li><a class="hover:text-dark transition-colors" href="Default.aspx#nosotros">Sobre Nosotros</a></li>
                            <li><a class="hover:text-dark transition-colors" href="Default.aspx#contacto">Contacto</a></li>
                            <li><a class="hover:text-dark transition-colors" href="Default.aspx#proyectos">Proyectos</a></li>
                            <li><a class="hover:text-dark transition-colors" href="https://microtexmexico.com" target="_blank">Sitio Web</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-bold text-dark mb-4 sm:mb-6 text-sm">Boletin</h4>
                        <p class="text-sm text-slate-500 mb-4">Suscribete para recibir tendencias de color e inspiracion.</p>
                        <div class="flex gap-2">
                            <asp:TextBox ID="txtNewsletter" runat="server" TextMode="Email" placeholder="Tu correo"
                                CssClass="flex-1 bg-slate-100 border-none rounded-lg text-sm px-3 sm:px-4 focus:ring-accent min-w-0" />
                            <asp:Button ID="btnNewsletter" runat="server" Text="Unirse"
                                OnClick="btnNewsletter_Click"
                                CssClass="bg-dark text-white px-3 sm:px-4 py-2 rounded-lg text-sm font-bold hover:bg-slate-700 transition-colors shrink-0" />
                        </div>
                        <asp:Label ID="lblNewsletterMsg" runat="server" Visible="false"
                            CssClass="mt-2 block text-xs font-semibold text-accent" />
                    </div>
                </div>
                <div class="max-w-7xl mx-auto mt-10 sm:mt-12 pt-6 sm:pt-8 border-t border-slate-100 flex flex-col sm:flex-row justify-between items-center gap-4 px-0 sm:px-6">
                    <asp:Label ID="lblCopyright" runat="server" CssClass="text-xs text-slate-400 text-center sm:text-left" />
                    <div class="flex gap-4 sm:gap-6 text-xs text-slate-400">
                        <a class="hover:text-dark" href="#">Politica de Privacidad</a>
                        <a class="hover:text-dark" href="#">Terminos de Servicio</a>
                        <a class="hover:text-dark" href="#">Cookies</a>
                    </div>
                </div>
            </footer>
        </div>
    </div>

</form>

<script type="text/javascript">
    function toggleSidebar() {
        var sidebar = document.getElementById('prod-sidebar');
        var overlay = document.getElementById('sidebar-overlay');
        sidebar.classList.toggle('open');
        overlay.classList.toggle('open');
    }
</script>
</body>
</html>
