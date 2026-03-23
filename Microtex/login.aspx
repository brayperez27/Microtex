 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Microtex.login" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>MicroTex | Iniciar Sesión</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
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

        .login-card {
            box-shadow: 0 10px 40px -8px rgba(0,0,0,0.08);
        }

        input::placeholder {
            color: #9CA3AF;
        }

        #login-mobile-menu {
            display: none;
            flex-direction: column;
        }

            #login-mobile-menu.open {
                display: flex;
            }
    </style>
</head>
<body>
    <%-- defaultbutton aquí garantiza que Enter siempre dispare btnLogin --%>
    <form id="form1" runat="server" defaultbutton="btnLogin">

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
                    <%-- btnGetQuote va DESPUÉS de btnLogin y con UseSubmitBehavior="false" --%>
                    <asp:Literal ID="litNavUser" runat="server" />
                    <a href="carrito.aspx" class="relative w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors">
                        <span class="material-symbols-outlined text-xl">shopping_bag</span>
                        <span id="cartBadge" class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none">0</span>
                    </a>
                    <button type="button" id="menu-btn"
                        onclick="document.getElementById('login-mobile-menu').classList.toggle('open')"
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
            <div id="login-mobile-menu" class="lg:hidden border-t border-slate-100 bg-white px-4 py-3 gap-1">
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="productos.aspx">Catálogo</a>
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="proyectos.aspx">Proyectos</a>
                <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="Nosotros.aspx">Nosotros</a>
            </div>
        </header>

        <!-- ===== MAIN ===== -->
        <main style="flex: 1; display: flex; align-items: center; justify-content: center; padding: 2.5rem 1rem;">
            <div class="w-full bg-white rounded-2xl p-6 login-card" style="max-width: 440px;">

                <div class="text-center mb-8">
                    <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-slate-900 text-white font-black text-lg mx-auto mb-4">M</div>
                    <h1 class="text-2xl font-bold text-slate-800 mb-2">Bienvenido</h1>
                    <p class="text-slate-500 text-sm">Accede a tu cuenta de Microtex</p>
                </div>

                <asp:Label ID="lblMessage" runat="server" Visible="false"
                    CssClass="block mb-6 text-sm font-semibold text-center px-4 py-3 rounded-xl" />

                <div class="mb-5">
                    <asp:Label AssociatedControlID="txtEmail" runat="server"
                        Text="Correo electrónico"
                        CssClass="block text-sm font-semibold text-slate-700 mb-2" />
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"
                        placeholder="ejemplo@microtex.com"
                        CssClass="block w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50 text-slate-800 text-sm focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300 transition-all" />
                </div>

                <div class="mb-2">
                    <div class="flex justify-between items-center mb-2">
                        <asp:Label AssociatedControlID="txtPassword" runat="server"
                            Text="Contraseña"
                            CssClass="block text-sm font-semibold text-slate-700" />
                        <a href="olvide_contrasena.aspx"
                            class="text-xs font-medium text-slate-500 hover:text-slate-800 hover:underline transition-colors">¿Olvidaste tu contraseña?
                        </a>
                    </div>
                    <div class="relative">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                            placeholder="••••••••"
                            CssClass="block w-full px-4 py-3 rounded-xl border border-slate-200 bg-slate-50 text-slate-800 text-sm focus:outline-none focus:border-slate-400 focus:ring-1 focus:ring-slate-300 transition-all" />
                        <button type="button" onclick="togglePass()"
                            class="absolute right-3 top-3 text-slate-400 hover:text-slate-700 transition-colors">
                            <span class="material-symbols-outlined text-xl" id="eyeIcon">visibility</span>
                        </button>
                    </div>
                </div>

                <div class="mt-7">
                    <asp:Button ID="btnLogin" runat="server"
                        Text="Iniciar sesión"
                        OnClick="btnLogin_Click"
                        CausesValidation="false"
                        CssClass="w-full flex justify-center py-3 px-4 rounded-xl text-sm font-bold text-white bg-slate-800 hover:bg-black focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-slate-800 transition-all duration-200 shadow-sm" />
                </div>

                <div class="mt-6 text-center">
                    <p class="text-sm text-slate-500">
                        ¿No tienes cuenta?
                       
                        <a href="registro.aspx" class="font-bold text-slate-800 hover:underline ml-1">Regístrate</a>
                    </p>
                </div>

            </div>
        </main>

        <%-- btnGetQuote al final del form y con UseSubmitBehavior="false" para que nunca sea el botón default --%>
        <asp:Button ID="btnGetQuote" runat="server" Text="" OnClick="btnGetQuote_Click"
            UseSubmitBehavior="false" Style="display: none;" />

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

    <script type="text/javascript">
        function togglePass() {
            var inp = document.getElementById('<%= txtPassword.ClientID %>');
            var icon = document.getElementById('eyeIcon');
            if (inp.type === 'password') { inp.type = 'text'; icon.textContent = 'visibility_off'; }
            else { inp.type = 'password'; icon.textContent = 'visibility'; }
        }
    </script>
</body>
</html>
