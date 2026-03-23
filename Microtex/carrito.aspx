<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="carrito.aspx.cs" Inherits="Microtex.carrito" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Microtex | Carrito de Compras</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="Scripts/tailwind.config.js"></script>
    <link href="Styles/site.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #fcfcfc;
        }

        #cart-mobile-menu {
            display: none;
            flex-direction: column;
        }

            #cart-mobile-menu.open {
                display: flex;
            }

        @media (max-width: 639px) {
            .col-precio {
                display: none;
            }

            .col-subtotal {
                display: none;
            }

            .th-precio {
                display: none;
            }

            .th-subtotal {
                display: none;
            }
        }

        .cart-row {
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

            .cart-row.removing {
                opacity: 0;
                transform: translateX(20px);
            }
    </style>
</head>
<body class="text-slate-800 min-h-screen bg-[#fcfcfc]">
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
                    <a class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors" href="productos.aspx">Catalogo</a>
                    <a class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors" href="proyectos.aspx">Proyectos</a>
                    <a class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors" href="Nosotros.aspx">Nosotros</a>
                </nav>
                <div class="flex items-center gap-2 shrink-0 ml-auto">
                    <asp:Literal ID="litNavUser" runat="server" />
                    <a href="carrito.aspx" class="relative w-9 h-9 flex items-center justify-center rounded-full bg-slate-100 text-slate-900 transition-colors">
                        <span class="material-symbols-outlined text-xl">shopping_bag</span>
                        <span class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none cart-badge-count">
                            <asp:Literal ID="litCartBadge" runat="server" Text="0" />
                        </span>
                    </a>
                    <button type="button" onclick="var m=document.getElementById('cart-mobile-menu'); m.classList.toggle('open');"
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
            <div id="cart-mobile-menu" class="lg:hidden border-t border-slate-100 bg-white px-4 py-3 gap-1">
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="productos.aspx">Catalogo</a>
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="proyectos.aspx">Proyectos</a>
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="Nosotros.aspx">Nosotros</a>
            </div>
        </header>

        <!-- MAIN -->
        <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 sm:py-10">

            <nav class="flex items-center gap-2 mb-5 sm:mb-8 text-xs sm:text-sm text-slate-400">
                <a href="Default.aspx" class="hover:text-slate-700 transition-colors">Inicio</a>
                <span class="material-symbols-outlined text-xs">chevron_right</span>
                <span class="text-slate-800 font-semibold">Carrito de compras</span>
            </nav>

            <h1 class="text-2xl sm:text-3xl font-black tracking-tight text-slate-900 mb-6 sm:mb-10">Tu Carrito de Compras</h1>

            <div class="flex flex-col lg:flex-row gap-6 lg:gap-10 items-start">

                <!-- TABLA -->
                <div class="w-full flex-1 min-w-0">
                    <asp:Literal ID="litEmptyState" runat="server" />
                    <div id="cartTableWrapper">
                        <div class="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
                            <div class="overflow-x-auto">
                                <table class="w-full text-left border-collapse min-w-[320px]">
                                    <thead>
                                        <tr class="bg-slate-50 border-b border-slate-200">
                                            <th class="px-4 sm:px-6 py-3 sm:py-4 text-slate-700 text-xs font-bold uppercase tracking-wider">Producto</th>
                                            <th class="th-precio px-4 sm:px-6 py-3 sm:py-4 text-slate-700 text-xs font-bold uppercase tracking-wider">Precio</th>
                                            <th class="px-4 sm:px-6 py-3 sm:py-4 text-slate-700 text-xs font-bold uppercase tracking-wider">Cantidad</th>
                                            <th class="th-subtotal px-4 sm:px-6 py-3 sm:py-4 text-slate-700 text-xs font-bold uppercase tracking-wider">Subtotal</th>
                                            <th class="px-4 sm:px-6 py-3 sm:py-4"></th>
                                        </tr>
                                    </thead>
                                    <tbody id="cartTableBody" class="divide-y divide-slate-100">
                                        <asp:Literal ID="litCartRows" runat="server" />
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="mt-4 sm:mt-6 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 sm:gap-0">
                            <a href="productos.aspx" class="flex items-center gap-2 text-slate-700 text-sm font-bold hover:-translate-x-1 transition-transform">
                                <span class="material-symbols-outlined text-base">arrow_back</span>
                                Continuar Comprando
                        </a>
                            <div class="flex items-center gap-2 sm:gap-3 w-full sm:w-auto">
                                <asp:TextBox ID="txtCupon" runat="server"
                                    CssClass="flex-1 sm:flex-none border border-slate-200 rounded-lg bg-white px-3 sm:px-4 py-2 text-sm focus:outline-none focus:ring-1 focus:ring-slate-400 min-w-0"
                                    placeholder="Codigo de cupon" />
                                <asp:Button ID="btnAplicarCupon" runat="server" Text="Aplicar"
                                    CssClass="px-4 sm:px-6 py-2 border border-slate-200 rounded-lg text-sm font-bold hover:bg-slate-50 transition-colors cursor-pointer shrink-0"
                                    OnClick="btnAplicarCupon_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- RESUMEN -->
                <aside class="w-full lg:w-80 xl:w-96 shrink-0">
                    <div class="rounded-xl border border-slate-200 bg-white shadow-sm p-5 sm:p-6 lg:sticky lg:top-24">
                        <h3 class="text-slate-900 text-lg sm:text-xl font-bold mb-5 sm:mb-6">Resumen del pedido</h3>

                        <div class="space-y-3 sm:space-y-4 mb-5 sm:mb-6">
                            <div class="flex justify-between items-center text-slate-500 text-sm">
                                <%-- ✅ clase total-count para actualizar con JS --%>
                                <span>Subtotal (<span class="total-count"><asp:Literal ID="litItemCount" runat="server" Text="0 articulos" /></span>)</span>
                                <%-- ✅ clase total-subtotal --%>
                                <span class="text-slate-800 font-semibold total-subtotal">
                                    <asp:Literal ID="litSubtotal" runat="server" Text="$0.00" /></span>
                            </div>
                            <div class="flex justify-between items-center text-slate-500 text-sm">
                                <span>Gastos de envio</span>
                                <span class="text-green-600 font-bold uppercase text-[10px] bg-green-50 px-2 py-0.5 rounded-full">Gratis</span>
                            </div>
                            <div class="flex justify-between items-center text-slate-500 text-sm">
                                <span>Impuestos (IVA 16%)</span>
                                <%-- ✅ clase total-tax --%>
                                <span class="text-slate-800 font-semibold total-tax">
                                    <asp:Literal ID="litTax" runat="server" Text="$0.00" /></span>
                            </div>
                            <asp:Label ID="lblDescuento" runat="server" Visible="false"
                                CssClass="flex justify-between items-center text-green-600 text-sm" />
                            <div class="border-t border-slate-100 pt-4 flex justify-between items-center">
                                <span class="text-slate-900 font-bold text-base sm:text-lg">Total</span>
                                <%-- ✅ clase total-final --%>
                                <span class="text-slate-900 font-black text-xl sm:text-2xl tracking-tight total-final">
                                    <asp:Literal ID="litTotal" runat="server" Text="$0.00" />
                                </span>
                            </div>
                        </div>

                        <asp:Button ID="btnProcederPago" runat="server" Text="Proceder al pago"
                            CssClass="w-full bg-slate-900 hover:bg-black text-white font-bold py-3 sm:py-4 rounded-xl transition-all shadow-sm active:scale-[0.98] mb-4 cursor-pointer text-sm sm:text-base"
                            OnClick="btnProcederPago_Click" />

                        <div class="space-y-3 sm:space-y-4">
                            <div class="flex items-start gap-3 p-3 rounded-lg bg-slate-50 border border-slate-100">
                                <span class="material-symbols-outlined text-slate-400 text-xl shrink-0 mt-0.5">local_shipping</span>
                                <div>
                                    <p class="text-xs font-bold text-slate-700">Envio Express Gratis</p>
                                    <p class="text-[10px] text-slate-400 mt-0.5">Entrega estimada: 3-5 dias habiles</p>
                                </div>
                            </div>
                            <div class="flex items-center justify-center gap-4 py-2">
                                <span class="material-symbols-outlined text-slate-300 text-2xl">credit_card</span>
                                <span class="material-symbols-outlined text-slate-300 text-2xl">payments</span>
                                <span class="material-symbols-outlined text-slate-300 text-2xl">account_balance</span>
                            </div>
                            <p class="text-[10px] text-center text-slate-400 italic">
                                Tus transacciones estan protegidas con encriptacion de 256 bits.
                       
                            </p>
                        </div>
                    </div>
                </aside>

            </div>
        </main>

        <!-- FOOTER -->
        <footer class="bg-white border-t border-slate-100 pt-14 sm:pt-20 pb-8 sm:pb-10 mt-16 sm:mt-24">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8 sm:gap-12 mb-10 sm:mb-16">
                    <div class="sm:col-span-2 lg:col-span-1">
                        <div class="flex items-center gap-2 mb-4 sm:mb-6">
                            <div class="flex h-6 w-6 items-center justify-center rounded bg-slate-900 text-white font-bold text-xs">M</div>
                            <span class="text-lg font-bold tracking-tight text-slate-900">Microtex</span>
                        </div>
                        <p class="text-slate-400 text-sm leading-relaxed">Fabricamos texturas, efectos y colores. Soluciones avanzadas en recubrimientos para transformar tus espacios.</p>
                    </div>
                    <div>
                        <h4 class="font-bold text-xs uppercase tracking-widest mb-4 sm:mb-6 text-slate-900">Productos</h4>
                        <ul class="space-y-3 sm:space-y-4 text-slate-400 text-sm">
                            <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=1">Pintura Arquitectonica</a></li>
                            <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=2">Producto Cementicio</a></li>
                            <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=3">Impermeabilizantes</a></li>
                            <li><a class="hover:text-slate-900 transition-colors" href="detalle.aspx?id=4">Luminiscentes</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-bold text-xs uppercase tracking-widest mb-4 sm:mb-6 text-slate-900">Empresa</h4>
                        <ul class="space-y-3 sm:space-y-4 text-slate-400 text-sm">
                            <li><a class="hover:text-slate-900 transition-colors" href="Nosotros.aspx">Sobre Nosotros</a></li>
                            <li><a class="hover:text-slate-900 transition-colors" href="Default.aspx#contacto">Contacto</a></li>
                            <li><a class="hover:text-slate-900 transition-colors" href="proyectos.aspx">Proyectos</a></li>
                            <li><a class="hover:text-slate-900 transition-colors" href="https://microtexmexico.com" target="_blank">Sitio Web</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="font-bold text-xs uppercase tracking-widest mb-4 sm:mb-6 text-slate-900">Contacto</h4>
                        <ul class="space-y-3 sm:space-y-4 text-slate-400 text-sm">
                            <li class="flex items-center gap-2"><span class="material-symbols-outlined text-base shrink-0">call</span>771 567 6119</li>
                            <li class="flex items-center gap-2"><span class="material-symbols-outlined text-base shrink-0">mail</span>dante_ceron@outlook.com</li>
                            <li class="flex items-center gap-2"><span class="material-symbols-outlined text-base shrink-0">location_on</span>Ajacuba, Hidalgo</li>
                        </ul>
                    </div>
                </div>
                <div class="pt-6 sm:pt-8 border-t border-slate-100 flex flex-col sm:flex-row justify-between items-center gap-4">
                    <p class="text-xs text-slate-400">&#169; <%= DateTime.Now.Year %> Microtex. Todos los derechos reservados.</p>
                    <div class="flex gap-4 sm:gap-6 text-xs font-medium text-slate-400">
                        <a class="hover:text-slate-900 transition-colors" href="#">Terminos y Condiciones</a>
                        <a class="hover:text-slate-900 transition-colors" href="#">Privacidad</a>
                    </div>
                </div>
            </div>
        </footer>

    </form>

    <script type="text/javascript">
        function changeQty(btn, delta) {
            var row = btn.closest('tr');
            var qtySpan = row.querySelector('.qty-value');
            var price = parseFloat(row.dataset.price);
            var qty = parseInt(qtySpan.textContent) + delta;
            if (qty < 1) qty = 1;
            qtySpan.textContent = qty;
            row.querySelector('.subtotal-cell').textContent = '$' + (price * qty).toFixed(2);
            updateSummary();
        }

        function removeItem(btn) {
            var row = btn.closest('tr');
            row.classList.add('removing');
            setTimeout(function () { row.remove(); updateSummary(); }, 300);
        }

        function updateSummary() {
            var rows = document.querySelectorAll('#cartTableBody tr');
            var subtotal = 0;
            var count = 0;

            rows.forEach(function (row) {
                var price = parseFloat(row.dataset.price);
                var qty = parseInt(row.querySelector('.qty-value').textContent);
                subtotal += price * qty;
                count += qty;
            });

            var tax = subtotal * 0.16;
            var total = subtotal + tax;

            // ✅ Actualizar por clases CSS — funciona con cualquier ID generado por ASP.NET
            document.querySelectorAll('.total-subtotal').forEach(function (el) {
                el.textContent = '$' + subtotal.toFixed(2);
            });
            document.querySelectorAll('.total-tax').forEach(function (el) {
                el.textContent = '$' + tax.toFixed(2);
            });
            document.querySelectorAll('.total-final').forEach(function (el) {
                el.textContent = '$' + total.toFixed(2);
            });
            document.querySelectorAll('.total-count').forEach(function (el) {
                el.textContent = count + ' articulo' + (count !== 1 ? 's' : '');
            });
            document.querySelectorAll('.cart-badge-count').forEach(function (el) {
                el.textContent = count;
            });

            if (rows.length === 0) {
                document.getElementById('cartTableWrapper').style.display = 'none';
            }
        }
</script>
</body>
</html>
