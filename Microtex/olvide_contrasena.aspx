<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="olvide-contrasena.aspx.cs" Inherits="Microtex.olvidecontrasena" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>MicroTex | Recuperar Contraseña</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="Scripts/tailwind.config.js"></script>
    <link href="Styles/site.css" rel="stylesheet" />
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: 'Inter',sans-serif;
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

        input::placeholder {
            color: #9CA3AF;
        }

        #mob-menu {
            display: none;
            flex-direction: column;
        }

            #mob-menu.open {
                display: flex;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">

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
                    <a href="login.aspx" class="w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                        <span class="material-symbols-outlined text-xl">person</span>
                    </a>
                    <a href="carrito.aspx" class="relative w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                        <span class="material-symbols-outlined text-xl">shopping_bag</span>
                        <span class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none">0</span>
                    </a>
                    <button type="button" onclick="document.getElementById('mob-menu').classList.toggle('open')"
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
            <div id="mob-menu" class="lg:hidden border-t border-slate-100 bg-white px-4 py-3 gap-1">
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="productos.aspx">Catálogo</a>
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="proyectos.aspx">Proyectos</a>
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="Nosotros.aspx">Nosotros</a>
            </div>
        </header>

        <!-- ===== MAIN ===== -->
        <main style="flex: 1; display: flex; align-items: center; justify-content: center; padding: 2.5rem 1rem;">
            <div class="w-full" style="max-width: 440px;">

                <!-- PANEL FORMULARIO -->
                <asp:Panel ID="panelForm" runat="server">
                    <div class="bg-white rounded-2xl p-8 shadow-sm border border-slate-100">

                        <!-- Ícono + título -->
                        <div class="text-center mb-7">
                            <div class="w-14 h-14 rounded-2xl bg-slate-100 flex items-center justify-center mx-auto mb-4">
                                <span class="material-symbols-outlined text-slate-600" style="font-size: 28px;">lock_reset</span>
                            </div>
                            <h1 class="text-2xl font-black text-slate-900 mb-2">¿Olvidaste tu contraseña?</h1>
                            <p class="text-slate-500 text-sm leading-relaxed">
                                Ingresa el correo con el que te registraste y te enviamos tu contraseña registrada..
                       
                            </p>
                        </div>

                        <!-- Mensaje feedback -->
                        <asp:Label ID="lblMessage" runat="server" Visible="false" />

                        <!-- Campo correo -->
                        <div class="mb-5">
                            <label class="block text-sm font-semibold text-slate-700 mb-2">Correo electrónico</label>
                            <div class="relative">
                                <span class="material-symbols-outlined absolute left-3 top-3 text-slate-400 text-xl pointer-events-none">mail</span>
                                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"
                                    placeholder="ejemplo@microtex.com"
                                    CssClass="block w-full pl-10 pr-4 py-3 rounded-xl border border-slate-200 bg-slate-50 text-slate-800 text-sm focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300 transition-all" />
                            </div>
                        </div>

                        <!-- Botón -->
                        <asp:Button ID="btnRecuperar" runat="server"
                            Text="Enviar contraseña"
                            OnClick="btnRecuperar_Click"
                            CausesValidation="false"
                            CssClass="w-full py-3 rounded-xl bg-slate-900 text-sm font-bold text-white hover:bg-black transition-colors mb-4" />

                        <!-- Volver al login -->
                        <div class="text-center">
                            <a href="login.aspx" class="text-sm font-medium text-slate-500 hover:text-slate-800 inline-flex items-center gap-1 transition-colors">
                                <span class="material-symbols-outlined text-base">arrow_back</span>
                                Volver al inicio de sesión
                        </a>
                        </div>

                    </div>
                </asp:Panel>

                <!-- PANEL ÉXITO (se muestra tras enviar) -->
                <asp:Panel ID="panelExito" runat="server" Visible="false">
                    <div class="bg-white rounded-2xl p-8 shadow-sm border border-slate-100 text-center">

                        <!-- Check animado -->
                        <div class="w-16 h-16 rounded-full bg-green-100 flex items-center justify-center mx-auto mb-5">
                            <span class="material-symbols-outlined text-green-600" style="font-size: 32px;">mark_email_read</span>
                        </div>

                        <h2 class="text-xl font-black text-slate-900 mb-2">¡Correo enviado!</h2>
                        <p class="text-slate-500 text-sm leading-relaxed mb-2">
                            Enviamos tu contraseña a:
                   
                        </p>
                        <p class="font-bold text-slate-800 text-sm mb-6">
                            <asp:Label ID="lblEmailEnviado" runat="server" />
                        </p>
                        <p class="text-slate-400 text-xs mb-7">
                            Revisa tu bandeja de entrada. Si no lo ves, revisa la carpeta de spam.
                   
                        </p>

                        <a href="login.aspx"
                            class="block w-full py-3 rounded-xl bg-slate-900 text-sm font-bold text-white hover:bg-black transition-colors text-center">Ir a Iniciar Sesión
                    </a>

                    </div>
                </asp:Panel>

            </div>
        </main>

        <!-- ===== FOOTER ===== -->
        <footer class="bg-white border-t border-slate-100 py-6">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 flex flex-col sm:flex-row justify-between items-center gap-4">
                <asp:Label ID="lblCopyright" runat="server" CssClass="text-xs text-slate-400 text-center sm:text-left" />
                <div class="flex gap-4 sm:gap-6 text-xs font-medium text-slate-400">
                    <a class="hover:text-slate-700 transition-colors" href="#">Privacidad</a>
                    <a class="hover:text-slate-700 transition-colors" href="#">Términos de Servicio</a>
                    <a class="hover:text-slate-700 transition-colors" href="#">Cookies</a>
                </div>
            </div>
        </footer>

    </form>
</body>
</html>
