<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pago.aspx.cs" Inherits="Microtex.pago" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Microtex | Checkout</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="Scripts/tailwind.config.js"></script>
    <link href="Styles/site.css" rel="stylesheet" />
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8f7f6; }
        #pago-mobile-menu { display: none; flex-direction: column; }
        #pago-mobile-menu.open { display: flex; }
        .spinner {
            width: 36px; height: 36px;
            border: 3px solid #e2e8f0;
            border-top-color: #1e293b;
            border-radius: 50%;
            animation: spin .7s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }
        @keyframes fadeUp { from { opacity:0; transform:translateY(16px); } to { opacity:1; transform:translateY(0); } }
        .fade-up   { animation: fadeUp .4s ease both; }
        .fade-up-2 { animation: fadeUp .4s .1s ease both; }
        .fade-up-3 { animation: fadeUp .4s .2s ease both; }
    </style>
</head>
<body class="text-slate-900 min-h-screen">
<form id="form1" runat="server">

    <asp:HiddenField ID="hfConektaCheckoutId" runat="server" />
    <asp:HiddenField ID="hfConektaOrderId"    runat="server" />

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
                        class="w-full rounded-full border border-slate-200 bg-slate-50 pl-9 pr-4 py-2 text-sm text-slate-700 focus:outline-none" />
                </div>
            </div>
            <nav class="hidden lg:flex items-center gap-8">
                <a class="text-sm font-medium text-slate-600 hover:text-slate-900" href="productos.aspx">Catalogo</a>
                <a class="text-sm font-medium text-slate-600 hover:text-slate-900" href="proyectos.aspx">Proyectos</a>
                <a class="text-sm font-medium text-slate-600 hover:text-slate-900" href="Nosotros.aspx">Nosotros</a>
            </nav>
            <div class="flex items-center gap-2 shrink-0 ml-auto">
                <asp:Literal ID="litNavUser" runat="server" />
                <a href="carrito.aspx" class="relative w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100">
                    <span class="material-symbols-outlined text-xl">shopping_bag</span>
                    <span class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none">
                        <asp:Literal ID="litCartBadge" runat="server" Text="0" />
                    </span>
                </a>
                <button type="button" onclick="document.getElementById('pago-mobile-menu').classList.toggle('open')"
                    class="lg:hidden w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100">
                    <span class="material-symbols-outlined text-xl">menu</span>
                </button>
            </div>
        </div>
        <div id="pago-mobile-menu" class="lg:hidden border-t border-slate-100 bg-white px-4 py-3 gap-1">
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="productos.aspx">Catalogo</a>
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="proyectos.aspx">Proyectos</a>
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="Nosotros.aspx">Nosotros</a>
        </div>
    </header>

    <main class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-12">

        <div class="flex items-center gap-2 text-sm text-slate-400 mb-8 fade-up">
            <a href="carrito.aspx" class="hover:text-slate-700">Carrito</a>
            <span class="material-symbols-outlined text-xs">chevron_right</span>
            <span class="text-slate-900 font-semibold">Checkout</span>
            <span class="material-symbols-outlined text-xs">chevron_right</span>
            <span class="text-slate-300">Confirmacion</span>
        </div>

        <!-- Stepper -->
        <div class="w-full max-w-lg mx-auto mb-10 fade-up-2">
            <div class="flex items-center justify-between relative">
                <div class="absolute top-5 left-0 w-full h-0.5 bg-slate-200 z-0"></div>
                <div class="relative z-10 flex flex-col items-center gap-2">
                    <div class="w-10 h-10 rounded-full bg-slate-900 flex items-center justify-center shadow-sm">
                        <span class="material-symbols-outlined text-white text-xl">local_shipping</span>
                    </div>
                    <span class="text-xs font-bold text-slate-900">Envio</span>
                </div>
                <div class="relative z-10 flex flex-col items-center gap-2">
                    <div class="w-10 h-10 rounded-full bg-slate-900 flex items-center justify-center shadow-sm">
                        <span class="material-symbols-outlined text-white text-xl">payments</span>
                    </div>
                    <span class="text-xs font-bold text-slate-900">Pago</span>
                </div>
                <div class="relative z-10 flex flex-col items-center gap-2">
                    <div class="w-10 h-10 rounded-full bg-slate-100 border-2 border-slate-200 flex items-center justify-center">
                        <span class="material-symbols-outlined text-slate-400 text-xl">checklist</span>
                    </div>
                    <span class="text-xs font-medium text-slate-400">Revision</span>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-12">

            <!-- COLUMNA IZQUIERDA -->
            <div class="lg:col-span-7 flex flex-col gap-6 fade-up-3">

                <!-- Entrega -->
                <section class="bg-white rounded-2xl border border-slate-200 shadow-sm p-6 sm:p-8">
                    <div class="flex items-center gap-3 mb-6">
                        <div class="w-10 h-10 rounded-xl bg-slate-900 flex items-center justify-center shrink-0">
                            <span class="material-symbols-outlined text-white text-lg">location_on</span>
                        </div>
                        <h2 class="text-xl font-black text-slate-900">Informacion de Entrega</h2>
                    </div>
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div class="sm:col-span-2 flex flex-col gap-1.5">
                            <label class="text-xs font-bold uppercase tracking-wider text-slate-500">Nombre Completo *</label>
                            <asp:TextBox ID="txtNombre" runat="server" placeholder="Ej: Juan Perez"
                                CssClass="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm focus:outline-none focus:border-slate-400 focus:bg-white transition-all" />
                        </div>
                        <div class="flex flex-col gap-1.5">
                            <label class="text-xs font-bold uppercase tracking-wider text-slate-500">Codigo Postal *</label>
                            <asp:TextBox ID="txtCP" runat="server" placeholder="00000"
                                CssClass="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm focus:outline-none focus:border-slate-400 focus:bg-white transition-all" />
                        </div>
                        <div class="flex flex-col gap-1.5">
                            <label class="text-xs font-bold uppercase tracking-wider text-slate-500">Ciudad *</label>
                            <asp:TextBox ID="txtCiudad" runat="server" placeholder="Ciudad de Mexico"
                                CssClass="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm focus:outline-none focus:border-slate-400 focus:bg-white transition-all" />
                        </div>
                        <div class="sm:col-span-2 flex flex-col gap-1.5">
                            <label class="text-xs font-bold uppercase tracking-wider text-slate-500">Direccion *</label>
                            <asp:TextBox ID="txtDireccion" runat="server" placeholder="Calle, Numero, Colonia"
                                CssClass="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm focus:outline-none focus:border-slate-400 focus:bg-white transition-all" />
                        </div>
                        <div class="sm:col-span-2 flex flex-col gap-1.5">
                            <label class="text-xs font-bold uppercase tracking-wider text-slate-500">Referencia <span class="normal-case font-normal text-slate-400">(Opcional)</span></label>
                            <asp:TextBox ID="txtReferencia" runat="server" placeholder="Entre calles, indicaciones..."
                                CssClass="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm focus:outline-none focus:border-slate-400 focus:bg-white transition-all" />
                        </div>
                        <div class="flex flex-col gap-1.5">
                            <label class="text-xs font-bold uppercase tracking-wider text-slate-500">Telefono *</label>
                            <asp:TextBox ID="txtTelefono" runat="server" placeholder="771 000 0000"
                                CssClass="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm focus:outline-none focus:border-slate-400 focus:bg-white transition-all" />
                        </div>
                        <div class="flex flex-col gap-1.5">
                            <label class="text-xs font-bold uppercase tracking-wider text-slate-500">Email *</label>
                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="correo@ejemplo.com"
                                CssClass="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm focus:outline-none focus:border-slate-400 focus:bg-white transition-all" />
                        </div>
                    </div>
                    <asp:Button ID="btnIrPago" runat="server" Text="Continuar al Pago"
                        OnClick="btnIrPago_Click"
                        CssClass="mt-6 w-full bg-slate-900 hover:bg-black text-white font-bold py-3.5 rounded-xl transition-all shadow-sm text-sm cursor-pointer" />
                    <asp:Label ID="lblErrorEnvio" runat="server" Visible="false"
                        CssClass="mt-3 block text-sm font-semibold text-red-600 bg-red-50 px-4 py-3 rounded-xl" />
                </section>

                <!-- Seccion de pago Conekta -->
                <div id="seccionPago" style="display:none;">
                    <div class="bg-white rounded-2xl border border-slate-200 shadow-sm p-6 sm:p-8">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="w-10 h-10 rounded-xl bg-slate-900 flex items-center justify-center shrink-0">
                                <span class="material-symbols-outlined text-white text-lg">lock</span>
                            </div>
                            <div>
                                <h2 class="text-xl font-black text-slate-900">Pago Seguro</h2>
                                <p class="text-xs text-slate-400">Procesado por Conekta - PCI DSS Certificado</p>
                            </div>
                        </div>

                        <div id="checkout-loader" style="display:flex;flex-direction:column;align-items:center;justify-content:center;min-height:200px;gap:12px;">
                            <div class="spinner"></div>
                            <p class="text-sm text-slate-400">Cargando formulario de pago seguro...</p>
                        </div>

                        <%-- ✅ height:714px requerido por el SDK de Conekta --%>
                        <div id="conekta-checkout-container" style="width:100%;height:714px;"></div>

                        <div class="flex items-center justify-center gap-4 sm:gap-6 mt-5 pt-5 border-t border-slate-100 flex-wrap">
                            <div class="flex items-center gap-1.5 text-slate-400">
                                <span class="material-symbols-outlined text-sm">lock</span>
                                <span class="text-xs font-medium">SSL 256-bit</span>
                            </div>
                            <div class="flex items-center gap-1.5 text-slate-400">
                                <span class="material-symbols-outlined text-sm">verified_user</span>
                                <span class="text-xs font-medium">PCI DSS</span>
                            </div>
                            <div class="flex items-center gap-1.5 text-slate-400">
                                <span class="material-symbols-outlined text-sm">credit_card</span>
                                <span class="text-xs font-medium">Visa / MC / Amex</span>
                            </div>
                            <div class="flex items-center gap-1.5 text-slate-400">
                                <span class="material-symbols-outlined text-sm">store</span>
                                <span class="text-xs font-medium">OXXO / SPEI</span>
                            </div>
                        </div>
                    </div>
                </div>

                <asp:Label ID="lblErrorPago" runat="server" Visible="false"
                    CssClass="block text-sm font-semibold text-red-600 bg-red-50 px-4 py-3 rounded-xl" />
            </div>

            <!-- COLUMNA DERECHA -->
            <div class="lg:col-span-5 fade-up-3">
                <div class="sticky top-24 flex flex-col gap-4">
                    <div class="bg-white rounded-2xl border border-slate-200 shadow-sm p-6">
                        <h3 class="text-lg font-black text-slate-900 mb-5">Resumen del Pedido</h3>
                        <div class="flex flex-col divide-y divide-slate-100 mb-5">
                            <asp:Literal ID="litResumenItems" runat="server" />
                        </div>
                        <div class="flex flex-col gap-3 border-t border-dashed border-slate-200 pt-5">
                            <div class="flex justify-between text-sm">
                                <span class="text-slate-500">Subtotal (<asp:Literal ID="litItemCount" runat="server" Text="0 articulos" />)</span>
                                <span class="font-semibold text-slate-800"><asp:Literal ID="litSubtotal" runat="server" Text="$0.00" /></span>
                            </div>
                            <div class="flex justify-between text-sm">
                                <span class="text-slate-500">Envio</span>
                                <span class="text-green-600 font-bold text-xs bg-green-50 px-2 py-0.5 rounded-full uppercase">Gratis</span>
                            </div>
                            <div class="flex justify-between text-sm">
                                <span class="text-slate-500">IVA (16%)</span>
                                <span class="font-semibold text-slate-800"><asp:Literal ID="litTax" runat="server" Text="$0.00" /></span>
                            </div>
                            <div class="flex justify-between items-center pt-4 border-t border-slate-100">
                                <span class="text-lg font-black text-slate-900">Total</span>
                                <span class="text-2xl font-black text-slate-900 tracking-tight">
                                    <asp:Literal ID="litTotal" runat="server" Text="$0.00" />
                                </span>
                            </div>
                        </div>
                        <p class="text-[10px] text-center text-slate-400 mt-4 uppercase tracking-widest font-bold">
                            Ambiente 100% Seguro y Protegido
                        </p>
                    </div>
                    <div class="grid grid-cols-2 gap-3">
                        <div class="flex items-center gap-2 bg-white border border-slate-200 rounded-xl p-3 shadow-sm">
                            <span class="material-symbols-outlined text-slate-400 text-sm shrink-0">verified_user</span>
                            <span class="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Compra Segura</span>
                        </div>
                        <div class="flex items-center gap-2 bg-white border border-slate-200 rounded-xl p-3 shadow-sm">
                            <span class="material-symbols-outlined text-slate-400 text-sm shrink-0">local_shipping</span>
                            <span class="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Envio Gratis</span>
                        </div>
                        <div class="flex items-center gap-2 bg-white border border-slate-200 rounded-xl p-3 shadow-sm">
                            <span class="material-symbols-outlined text-slate-400 text-sm shrink-0">support_agent</span>
                            <span class="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Soporte 24/7</span>
                        </div>
                        <div class="flex items-center gap-2 bg-white border border-slate-200 rounded-xl p-3 shadow-sm">
                            <span class="material-symbols-outlined text-slate-400 text-sm shrink-0">replay</span>
                            <span class="text-[10px] font-bold text-slate-500 uppercase tracking-wider">Devoluciones</span>
                        </div>
                    </div>
                    <a href="carrito.aspx" class="flex items-center justify-center gap-2 text-sm text-slate-500 hover:text-slate-800 transition-colors py-2">
                        <span class="material-symbols-outlined text-base">arrow_back</span>
                        Volver al carrito
                    </a>
                </div>
            </div>
        </div>
    </main>

    <footer class="mt-16 border-t border-slate-200 bg-white py-8 px-4 text-center">
        <p class="text-xs text-slate-400">&#169; <%= DateTime.Now.Year %> Microtex - Pagos procesados de forma segura por Conekta</p>
    </footer>

</form>

<script type="text/javascript">
    function initConektaCheckout(checkoutReqId) {
        var loader    = document.getElementById('checkout-loader');
        var container = document.getElementById('conekta-checkout-container');
        if (!loader || !container) return;

        loader.style.display    = 'flex';
        container.style.display = 'block';

        var config = {
            locale:            'es',
            publicKey:         'key_GYEwYJNO9cJLQbaKSSZunNP',
            targetIFrame:      '#conekta-checkout-container',
            checkoutRequestId: checkoutReqId
        };
        var options = {
            backgroundMode: 'lightMode',
            colorPrimary:   '#0f172a',
            colorText:      '#334155',
            colorLabel:     '#64748b',
            inputType:      'flatMode'
        };
        var callbacks = {
            onGetInfoSuccess: function(info) {
                loader.style.display = 'none';
            },
            onGetInfoError: function(error) {
                loader.innerHTML = '<p style="color:#ef4444;font-size:13px;text-align:center;">Error al cargar: ' + JSON.stringify(error) + '</p>';
            },
            onFinalizePayment: function(order) {
                window.location.href = 'confirmacion.aspx?order=' + (order.id || order.order_id || '');
            },
            onErrorPayment: function(error) {
                loader.style.display = 'none';
            }
        };
        window.ConektaCheckoutComponents.Integration({
            config: config, callbacks: callbacks, options: options
        });
    }

    function cargarConekta(checkoutId) {
        var s   = document.createElement('script');
        s.src   = 'https://pay.conekta.com/v1.0/js/conekta-checkout.min.js';
        s.onload = function() { initConektaCheckout(checkoutId); };
        s.onerror = function() {
            var l = document.getElementById('checkout-loader');
            if (l) l.innerHTML = '<p style="color:#ef4444;font-size:13px;text-align:center;">No se pudo cargar el SDK de Conekta.</p>';
        };
        document.body.appendChild(s);
    }

    (function() {
        var hf      = document.getElementById('<%= hfConektaCheckoutId.ClientID %>');
        var seccion = document.getElementById('seccionPago');
        if (!hf || !hf.value || hf.value.trim() === '') return;

        var checkoutId = hf.value.trim();
        if (seccion) seccion.style.display = 'block';

        setTimeout(function () {
            if (seccion) window.scrollTo({ top: seccion.offsetTop - 80, behavior: 'smooth' });
            cargarConekta(checkoutId);
        }, 200);
    })();
</script>
</body>
</html>
