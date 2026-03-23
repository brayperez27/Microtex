<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registro.aspx.cs" Inherits="Microtex.registro" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>MicroTex | Crear Cuenta</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="Scripts/tailwind.config.js"></script>
    <link href="Styles/site.css" rel="stylesheet" />
    <style>
        body { font-family: 'Inter', sans-serif; }
        .bg-subtle-pattern {
            background-color: #F7F5EC;
            background-image: radial-gradient(#e5e1cc 0.5px, transparent 0.5px);
            background-size: 24px 24px;
        }
        input::placeholder { color: #9CA3AF; }
        #reg-mobile-menu { display: none; flex-direction: column; }
        #reg-mobile-menu.open { display: flex; }

        /* ===== TOAST ===== */
        #toast {
            position: fixed;
            top: 80px;
            left: 50%;
            transform: translateX(-50%) translateY(-20px);
            z-index: 9999;
            display: flex;
            align-items: center;
            gap: 12px;
            background: #1a1a1a;
            color: #fff;
            padding: 14px 24px 17px 20px;
            border-radius: 14px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.18);
            font-size: 0.875rem;
            font-weight: 600;
            min-width: 280px;
            max-width: 90vw;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.35s ease, transform 0.35s ease;
            overflow: hidden;
        }
        #toast.show {
            opacity: 1;
            transform: translateX(-50%) translateY(0);
        }
        #toast .toast-icon {
            width: 32px; height: 32px;
            border-radius: 50%;
            background: #22c55e;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        #toast .toast-bar {
            position: absolute;
            bottom: 0; left: 0;
            height: 3px;
            background: #22c55e;
            width: 100%;
            transform-origin: left;
        }
        @keyframes shrink {
            from { transform: scaleX(1); }
            to   { transform: scaleX(0); }
        }
    </style>
</head>
<body class="min-h-screen flex flex-col bg-subtle-pattern">
<form id="form1" runat="server">

    <!-- Campo oculto — el servidor lo pone en "ok" cuando el registro fue exitoso -->
    <asp:HiddenField ID="hdnToast" runat="server" Value="" />

    <!-- ===== TOAST ===== -->
    <div id="toast">
        <div class="toast-icon">
            <span class="material-symbols-outlined text-white" style="font-size:18px;">check</span>
        </div>
        <span>¡Cuenta creada! Bienvenido a Microtex</span>
        <div class="toast-bar" id="toastBar"></div>
    </div>

    <!-- ===== NAVBAR ===== -->
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
                <asp:Button ID="btnGetQuote" runat="server" Text="" OnClick="btnGetQuote_Click" CausesValidation="false" style="display:none;" />
                <a href="login.aspx" class="w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                    <span class="material-symbols-outlined text-xl">person</span>
                </a>
                <a href="carrito.aspx" class="relative w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                    <span class="material-symbols-outlined text-xl">shopping_bag</span>
                    <span id="cartBadge" class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none">0</span>
                </a>
                <button type="button" onclick="document.getElementById('reg-mobile-menu').classList.toggle('open')"
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
        <div id="reg-mobile-menu" class="lg:hidden border-t border-slate-100 bg-white px-4 py-3 gap-1">
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="productos.aspx">Catálogo</a>
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="proyectos.aspx">Proyectos</a>
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="Nosotros.aspx">Nosotros</a>
        </div>
    </header>

    <!-- ===== MAIN ===== -->
    <main class="flex-grow flex flex-col items-center justify-center py-8 sm:py-12 px-4">
        <div class="w-full max-w-sm sm:max-w-md">
            <div class="bg-white shadow-xl rounded-xl overflow-hidden border border-slate-100">

                <div class="px-6 sm:px-8 pt-8 sm:pt-10 pb-5 sm:pb-6 text-center">
                    <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-slate-900 text-white font-black text-lg mx-auto mb-4">M</div>
                    <h1 class="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight mb-2">Crear Cuenta</h1>
                    <p class="text-slate-500 text-sm">Únete a la comunidad Microtex hoy</p>
                </div>

                <asp:Label ID="lblMessage" runat="server" Visible="false"
                    CssClass="mx-6 sm:mx-8 mb-2 block text-sm font-semibold text-center px-4 py-3 rounded-xl" />

                <div class="px-6 sm:px-8 pb-8 sm:pb-10 space-y-4 sm:space-y-5">

                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1.5">Nombre completo</label>
                        <div class="relative">
                            <span class="material-symbols-outlined absolute left-3 top-3 text-slate-400 text-xl pointer-events-none">person_outline</span>
                            <asp:TextBox ID="txtNombre" runat="server" placeholder="Juan Pérez"
                                CssClass="block w-full pl-10 py-3 border border-slate-200 rounded-lg bg-slate-50 text-slate-900 text-sm focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300 transition-all" />
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1.5">Correo electrónico</label>
                        <div class="relative">
                            <span class="material-symbols-outlined absolute left-3 top-3 text-slate-400 text-xl pointer-events-none">mail</span>
                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="nombre@ejemplo.com"
                                CssClass="block w-full pl-10 py-3 border border-slate-200 rounded-lg bg-slate-50 text-slate-900 text-sm focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300 transition-all" />
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1.5">Contraseña</label>
                        <div class="relative">
                            <span class="material-symbols-outlined absolute left-3 top-3 text-slate-400 text-xl pointer-events-none">lock</span>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="••••••••"
                                CssClass="block w-full pl-10 pr-10 py-3 border border-slate-200 rounded-lg bg-slate-50 text-slate-900 text-sm focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300 transition-all" />
                            <button type="button" onclick="togglePass()"
                                class="absolute right-3 top-3 text-slate-400 hover:text-slate-700 transition-colors">
                                <span class="material-symbols-outlined text-xl" id="eye1">visibility</span>
                            </button>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1.5">Confirmar contraseña</label>
                        <div class="relative">
                            <span class="material-symbols-outlined absolute left-3 top-3 text-slate-400 text-xl pointer-events-none">lock_clock</span>
                            <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" placeholder="••••••••"
                                CssClass="block w-full pl-10 py-3 border border-slate-200 rounded-lg bg-slate-50 text-slate-900 text-sm focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300 transition-all" />
                        </div>
                    </div>

                    <div class="flex items-start gap-3">
                        <asp:CheckBox ID="chkTerminos" runat="server"
                            CssClass="mt-0.5 h-4 w-4 text-slate-800 border-slate-300 rounded focus:ring-slate-800 shrink-0" />
                        <label for="<%= chkTerminos.ClientID %>" class="text-sm text-slate-500 leading-snug">
                            Acepto los <a href="#" class="text-slate-800 font-semibold hover:underline">Términos de Servicio</a>
                            y la <a href="#" class="text-slate-800 font-semibold hover:underline">Política de Privacidad</a>.
                        </label>
                    </div>

                    <asp:Button ID="btnRegistrar" runat="server"
                        Text="Crear Cuenta"
                        OnClick="btnRegistrar_Click"
                        CausesValidation="false"
                        CssClass="w-full bg-slate-800 text-white font-bold py-3 sm:py-4 px-6 rounded-lg shadow-lg hover:bg-black transition-all mt-2 text-sm" />

                </div>

                <div class="px-6 sm:px-8 py-5 sm:py-6 bg-slate-50 border-t border-slate-100 text-center">
                    <p class="text-slate-500 text-sm">
                        ¿Ya tienes cuenta?
                        <a href="login.aspx" class="text-slate-800 font-bold hover:underline ml-1">Iniciar sesión</a>
                    </p>
                </div>
            </div>

            <div class="mt-6 sm:mt-8 flex justify-center gap-4 sm:gap-6 text-xs font-medium text-slate-400 uppercase tracking-widest">
                <a class="hover:text-slate-700 transition-colors" href="#">Ayuda</a>
                <a class="hover:text-slate-700 transition-colors" href="#">Privacidad</a>
                <a class="hover:text-slate-700 transition-colors" href="#">Términos</a>
            </div>
        </div>
    </main>

    <div class="hidden sm:block fixed top-0 right-0 -z-10 opacity-20 pointer-events-none overflow-hidden h-screen w-screen">
        <div class="absolute top-[10%] right-[-5%] w-96 h-96 bg-yellow-100 rounded-full blur-[100px]"></div>
        <div class="absolute bottom-[10%] left-[-5%] w-96 h-96 bg-yellow-50 rounded-full blur-[100px]"></div>
    </div>

</form>

<script type="text/javascript">
    // Toggle contraseña
    function togglePass() {
        var inp = document.getElementById('<%= txtPassword.ClientID %>');
        var icon = document.getElementById('eye1');
        if (!inp) return;
        inp.type = inp.type === 'password' ? 'text' : 'password';
        icon.textContent = inp.type === 'password' ? 'visibility' : 'visibility_off';
    }

    // Al cargar la página, revisar si el servidor dejó señal en hdnToast
    window.addEventListener('DOMContentLoaded', function () {
        var hdn = document.getElementById('<%= hdnToast.ClientID %>');
        if (hdn && hdn.value === 'ok') {
            var toast = document.getElementById('toast');
            var bar = document.getElementById('toastBar');
            var dur = 5000;

            // Activar barra animada
            bar.style.animation = 'shrink ' + dur + 'ms linear forwards';
            toast.classList.add('show');

            setTimeout(function () {
                toast.classList.remove('show');
                setTimeout(function () {
                    window.location.href = 'perfil.aspx';
                }, 400);
            }, dur);
        }
    });
</script>
</body>
</html>
