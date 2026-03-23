<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="confirmacion.aspx.cs" Inherits="Microtex.confirmacion" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Microtex | Pedido Confirmado</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="Scripts/tailwind.config.js"></script>
    <link href="Styles/site.css" rel="stylesheet" />
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8f7f6; }
        @keyframes scaleIn { from { transform: scale(0); opacity: 0; } to { transform: scale(1); opacity: 1; } }
        @keyframes fadeUp  { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        .anim-check  { animation: scaleIn .5s cubic-bezier(.34,1.56,.64,1) both; }
        .anim-card   { animation: fadeUp .4s .2s ease both; }
        .anim-items  { animation: fadeUp .4s .35s ease both; }
        .anim-btns   { animation: fadeUp .4s .5s ease both; }
    </style>
</head>
<body class="text-slate-900 min-h-screen">
<form id="form1" runat="server">

    <!-- HEADER -->
    <header class="sticky top-0 z-50 w-full bg-white/95 backdrop-blur-md border-b border-slate-200 shadow-sm">
        <div class="flex w-full items-center gap-3 px-4 sm:px-6 py-3">
            <a href="Default.aspx" class="flex items-center gap-2 shrink-0">
                <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-900 text-white font-black text-sm">M</div>
                <span class="text-base font-black tracking-tight text-slate-900">Microtex</span>
            </a>
            <div class="flex items-center gap-2 shrink-0 ml-auto">
                <asp:Literal ID="litNavUser" runat="server" />
                <a href="carrito.aspx" class="relative w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100">
                    <span class="material-symbols-outlined text-xl">shopping_bag</span>
                    <span class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none">0</span>
                </a>
            </div>
        </div>
    </header>

    <main class="max-w-2xl mx-auto px-4 sm:px-6 py-12 sm:py-20">

        <!-- Icono check animado -->
        <div class="flex justify-center mb-8 anim-check">
            <div class="w-24 h-24 rounded-full bg-green-50 border-4 border-green-100 flex items-center justify-center">
                <div class="w-16 h-16 rounded-full bg-green-500 flex items-center justify-center shadow-lg">
                    <span class="material-symbols-outlined text-white text-4xl" style="font-variation-settings:'FILL' 1">check_circle</span>
                </div>
            </div>
        </div>

        <!-- Card principal -->
        <div class="bg-white rounded-3xl border border-slate-200 shadow-sm p-8 sm:p-10 text-center anim-card">
            <h1 class="text-2xl sm:text-3xl font-black text-slate-900 mb-2">¡Pedido Confirmado!</h1>
            <p class="text-slate-500 text-sm sm:text-base mb-6">
                Tu pago fue procesado exitosamente por Conekta.<br />
                Recibirás un correo de confirmacion a la brevedad.
            </p>

            <!-- ID del pedido -->
            <div class="inline-flex items-center gap-2 bg-slate-50 border border-slate-200 rounded-xl px-4 py-3 mb-8">
                <span class="material-symbols-outlined text-slate-400 text-base">receipt</span>
                <div class="text-left">
                    <p class="text-xs text-slate-400 font-medium uppercase tracking-wider">Numero de orden</p>
                    <asp:Label ID="lblOrderId" runat="server"
                        CssClass="text-sm font-black text-slate-900 font-mono" />
                </div>
            </div>

            <!-- Resumen items -->
            <div id="resumenItems" class="text-left mb-8 anim-items">
                <h3 class="text-xs font-bold uppercase tracking-wider text-slate-400 mb-4">Productos</h3>
                <div class="flex flex-col divide-y divide-slate-100 rounded-xl border border-slate-100 overflow-hidden">
                    <asp:Literal ID="litItems" runat="server" />
                </div>

                <!-- Totales -->
                <div class="mt-4 flex flex-col gap-2 pt-4 border-t border-dashed border-slate-200">
                    <div class="flex justify-between text-sm">
                        <span class="text-slate-500">Envio</span>
                        <span class="text-green-600 font-bold text-xs bg-green-50 px-2 py-0.5 rounded-full uppercase">Gratis</span>
                    </div>
                    <div class="flex justify-between items-center">
                        <span class="text-base font-black text-slate-900">Total pagado</span>
                        <span class="text-xl font-black text-slate-900">
                            <asp:Literal ID="litTotal" runat="server" Text="$0.00" />
                        </span>
                    </div>
                </div>
            </div>

            <!-- Info de contacto -->
            <div class="bg-blue-50 border border-blue-100 rounded-xl p-4 text-left mb-8">
                <div class="flex items-start gap-3">
                    <span class="material-symbols-outlined text-blue-500 shrink-0 mt-0.5">info</span>
                    <div>
                        <p class="text-sm font-bold text-slate-800 mb-1">Siguiente paso</p>
                        <p class="text-xs text-slate-600 leading-relaxed">
                            El Ing. Erick Dante Ceron te contactara en breve para coordinar la entrega.
                            Tambien puedes llamar al <strong>771 567 6119</strong> o escribir a <strong>dante_ceron@outlook.com</strong>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Botones -->
            <div class="flex flex-col sm:flex-row gap-3 anim-btns">
                <a href="productos.aspx"
                    class="flex-1 flex items-center justify-center gap-2 bg-slate-900 hover:bg-black text-white font-bold py-3.5 rounded-xl transition-colors text-sm">
                    <span class="material-symbols-outlined text-base">storefront</span>
                    Seguir Comprando
                </a>
                <a href="perfil.aspx"
                    class="flex-1 flex items-center justify-center gap-2 bg-white border border-slate-200 hover:bg-slate-50 text-slate-700 font-bold py-3.5 rounded-xl transition-colors text-sm">
                    <span class="material-symbols-outlined text-base">receipt_long</span>
                    Mis Pedidos
                </a>
            </div>
        </div>

    </main>

    <footer class="border-t border-slate-200 bg-white py-6 px-4 text-center mt-8">
        <p class="text-xs text-slate-400">&#169; <%= DateTime.Now.Year %> Microtex. Todos los derechos reservados.</p>
    </footer>

</form>
</body>
</html>
