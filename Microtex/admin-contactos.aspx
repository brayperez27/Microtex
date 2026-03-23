<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin-contactos.aspx.cs" Inherits="Microtex.AdminContactos" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Microtex | Solicitudes de Contacto</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="Scripts/tailwind.config.js"></script>
    <link href="Styles/site.css" rel="stylesheet" />
    <style>
        html, body { height:100%; margin:0; padding:0; font-family:'Inter',sans-serif; background:#F0EEE6; }
        body { display:flex; flex-direction:column; min-height:100vh; }
        body > form { display:flex; flex-direction:column; flex:1; }

        /* ✅ Badges tono página — beige/slate igual que admin-pedidos */
        .badge { display:inline-flex; align-items:center; padding:3px 10px; border-radius:20px; font-size:.6875rem; font-weight:700; }
        .badge-quote   { background:#eceae3; color:#6f6a5d; }
        .badge-support { background:#f8f7f6; color:#8f8a7a; }
        .badge-prod    { background:#e5e2d9; color:#6f6a5d; }
        .badge-new     { background:#111827; color:#fff;    }
        .badge-read    { background:#eceae3; color:#8f8a7a; }

        .card { background:#fff; border:1px solid #e5e7eb; border-radius:14px; overflow:hidden; margin-bottom:16px; }
        .card-head { display:flex; align-items:center; justify-content:space-between; padding:16px 20px; border-bottom:1px solid #f3f4f6; }

        .orders-table { width:100%; border-collapse:collapse; font-size:.8125rem; }
        .orders-table th { padding:10px 16px; text-align:left; font-size:.6875rem; font-weight:700; text-transform:uppercase; letter-spacing:.06em; color:#9ca3af; border-bottom:1px solid #f3f4f6; }
        .orders-table td { padding:14px 16px; border-bottom:1px solid #f9fafb; color:#374151; vertical-align:middle; }
        .orders-table tbody tr:last-child td { border-bottom:none; }
        .orders-table tbody tr:hover td { background:#fafafa; }

        .btn-ver   { display:inline-flex; align-items:center; gap:4px; padding:5px 10px; background:#eceae3; border:none; border-radius:7px; font-size:.75rem; font-weight:600; color:#6f6a5d; cursor:pointer; font-family:'Inter',sans-serif; }
        .btn-ver:hover { background:#d6d3c9; }
        .btn-leido { display:inline-flex; align-items:center; gap:4px; padding:5px 10px; background:#f8f7f6; border:1px solid #e5e2d9; border-radius:7px; font-size:.75rem; font-weight:600; color:#8f8a7a; cursor:pointer; font-family:'Inter',sans-serif; }
        .btn-leido:hover { background:#eceae3; }

        .alert { font-size:.8125rem; font-weight:600; padding:9px 14px; border-radius:9px; margin-bottom:16px; }
        .alert-ok  { background:#f0fdf4; color:#15803d; }
        .alert-err { background:#fef2f2; color:#dc2626; }

        #modalContacto { position:fixed; inset:0; z-index:9999; display:none; align-items:center; justify-content:center; padding:16px; }
        #modalContacto.open { display:flex; }
        #modalOverlay { position:absolute; inset:0; background:rgba(0,0,0,.45); }
        #modalBox { position:relative; background:#fff; border-radius:20px; width:100%; max-width:560px; max-height:88vh; overflow-y:auto; box-shadow:0 24px 48px rgba(0,0,0,.18); }

        #toast { position:fixed; bottom:28px; right:28px; z-index:99999; display:flex; align-items:center; padding:14px 22px; border-radius:14px; background:#111827; color:#fff; font-family:'Inter',sans-serif; font-size:.875rem; font-weight:600; box-shadow:0 8px 32px rgba(0,0,0,.22); transform:translateY(80px); opacity:0; transition:transform .35s cubic-bezier(.34,1.56,.64,1), opacity .3s ease; pointer-events:none; max-width:340px; }
        #toast.show { transform:translateY(0) !important; opacity:1 !important; pointer-events:auto !important; }
        #toastBar { position:absolute; bottom:0; left:0; height:3px; border-radius:0 0 14px 14px; width:100%; transform-origin:left; }
        @keyframes shrink { from{width:100%} to{width:0%} }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <header class="sticky top-0 z-50 w-full bg-white/95 backdrop-blur-md border-b border-slate-200 shadow-sm">
        <div class="flex w-full items-center gap-3 px-4 sm:px-6 py-3">
            <a href="Default.aspx" class="flex items-center gap-2 shrink-0">
                <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-900 text-white font-black text-sm">M</div>
                <span class="text-base font-black tracking-tight text-slate-900">Microtex</span>
            </a>
            <span class="text-xs font-bold px-2 py-1 rounded-full ml-2" style="background:#eceae3;color:#8f8a7a;">ADMIN</span>
            <div class="ml-auto flex items-center gap-3">
                <a href="admin-pedidos.aspx" class="text-sm text-slate-500 hover:text-slate-900">Pedidos</a>
                <a href="perfil.aspx" class="text-sm text-slate-500 hover:text-slate-900">Mi cuenta</a>
                <a href="Default.aspx" class="text-sm text-slate-500 hover:text-slate-900">Sitio</a>
            </div>
        </div>
    </header>

    <main style="flex:1; padding:2rem 1rem;">
        <div style="max-width:1100px; margin:0 auto;">

            <div style="margin-bottom:1.5rem; display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:12px;">
                <div>
                    <h1 style="font-size:1.375rem; font-weight:800; color:#111827; margin:0 0 2px;">Solicitudes de Contacto</h1>
                    <p style="font-size:.8125rem; color:#9ca3af; margin:0;">Mensajes y cotizaciones recibidas desde el sitio web</p>
                </div>
                <div style="display:flex; align-items:center; gap:8px;">
                    <span style="font-size:.8125rem; color:#6b7280; font-weight:600;">Filtrar:</span>
                    <select id="filtroTipo" onchange="filtrarTabla(this.value)"
                        style="padding:7px 12px; border:1.5px solid #e5e7eb; border-radius:8px; font-size:.8125rem; font-family:'Inter',sans-serif; background:#fff; cursor:pointer; outline:none;">
                        <option value="">Todos</option>
                        <option value="Consulta de Producto">Consulta de Producto</option>
                        <option value="Solicitar Cotización">Solicitar Cotización</option>
                        <option value="Soporte Técnico">Soporte Técnico</option>
                    </select>
                </div>
            </div>

            <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert" />

            <!-- ✅ Stats al tono beige de la página -->
            <div style="display:grid; grid-template-columns:repeat(auto-fit,minmax(140px,1fr)); gap:12px; margin-bottom:20px;">
                <div style="background:#fff; border:1px solid #e5e7eb; border-radius:12px; padding:14px 16px;">
                    <p style="font-size:.6875rem; font-weight:700; color:#9ca3af; text-transform:uppercase; letter-spacing:.05em; margin:0 0 4px;">Total</p>
                    <asp:Label ID="lblTotal" runat="server" Style="font-size:1.5rem; font-weight:800; color:#111827;" />
                </div>
                <div style="background:#f8f7f6; border:1px solid #e5e2d9; border-radius:12px; padding:14px 16px;">
                    <p style="font-size:.6875rem; font-weight:700; color:#8f8a7a; text-transform:uppercase; letter-spacing:.05em; margin:0 0 4px;">Sin leer</p>
                    <asp:Label ID="lblNoLeidos" runat="server" Style="font-size:1.5rem; font-weight:800; color:#111827;" />
                </div>
                <div style="background:#eceae3; border:1px solid #d6d3c9; border-radius:12px; padding:14px 16px;">
                    <p style="font-size:.6875rem; font-weight:700; color:#6f6a5d; text-transform:uppercase; letter-spacing:.05em; margin:0 0 4px;">Cotizaciones</p>
                    <asp:Label ID="lblCotizaciones" runat="server" Style="font-size:1.5rem; font-weight:800; color:#6f6a5d;" />
                </div>
                <div style="background:#f8f7f6; border:1px solid #e5e2d9; border-radius:12px; padding:14px 16px;">
                    <p style="font-size:.6875rem; font-weight:700; color:#8f8a7a; text-transform:uppercase; letter-spacing:.05em; margin:0 0 4px;">Consultas</p>
                    <asp:Label ID="lblConsultas" runat="server" Style="font-size:1.5rem; font-weight:800; color:#8f8a7a;" />
                </div>
            </div>

            <div class="card">
                <div class="card-head">
                    <h2 style="font-size:.9375rem; font-weight:700; color:#111827; margin:0;">Todos los Mensajes</h2>
                </div>
                <div style="overflow-x:auto;">
                    <table class="orders-table" id="tablaContactos">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nombre</th>
                                <th>Correo</th>
                                <th>Tipo</th>
                                <th>Fecha</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <asp:Repeater ID="rptContactos" runat="server" OnItemDataBound="rptContactos_ItemDataBound">
                            <HeaderTemplate><tbody></HeaderTemplate>
                            <ItemTemplate>
                                <tr data-tipo='<%# Eval("TipoConsulta") %>'>
                                    <td style="font-weight:700; color:#111827;"><%# Eval("IdContacto") %></td>
                                    <td style="font-weight:600; color:#111827;"><%# Eval("Nombre") %></td>
                                    <td><a href='mailto:<%# Eval("Email") %>' style="color:#6b7280; font-size:.8125rem;"><%# Eval("Email") %></a></td>
                                    <td><asp:Label ID="lblTipo" runat="server" /></td>
                                    <td style="color:#6b7280; white-space:nowrap; font-size:.8125rem;"><%# Eval("FechaEnvio", "{0:dd/MM/yyyy HH:mm}") %></td>
                                    <td><asp:Label ID="lblLeido" runat="server" /></td>
                                    <td>
                                        <div style="display:flex; gap:6px;">
                                            <%-- ✅ Literal generado desde code-behind como <button type="button"> --%>
                                            <asp:Literal ID="litBtnVer" runat="server" />
                                            <asp:Button ID="btnMarcarLeido" runat="server"
                                                Text="Leído"
                                                CommandArgument='<%# Eval("IdContacto") %>'
                                                OnClick="btnMarcarLeido_Click"
                                                CssClass="btn-leido" />
                                        </div>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate></tbody></FooterTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>

        </div>
    </main>

    <footer class="bg-white border-t border-slate-100 py-4 mt-4">
        <p class="text-xs text-slate-400 text-center">&#169; <%= DateTime.Now.Year %> Microtex Admin Panel</p>
    </footer>

</form>

<!-- MODAL -->
<div id="modalContacto">
    <div id="modalOverlay" onclick="cerrarModal()"></div>
    <div id="modalBox">
        <div style="display:flex;align-items:center;justify-content:space-between;padding:18px 22px;border-bottom:1px solid #f3f4f6;position:sticky;top:0;background:#fff;border-radius:20px 20px 0 0;z-index:1;">
            <div>
                <h3 style="font-size:1rem;font-weight:800;color:#111827;margin:0;">Detalle del Mensaje</h3>
                <p id="mSubtitle" style="font-size:.75rem;color:#9ca3af;margin:2px 0 0;"></p>
            </div>
            <button type="button" onclick="cerrarModal()"
                style="width:30px;height:30px;border-radius:50%;background:#f3f4f6;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;">
                <span class="material-symbols-outlined" style="font-size:16px;color:#6b7280;">close</span>
            </button>
        </div>
        <div style="padding:20px 22px;">
            <div style="background:#f9fafb;border-radius:10px;padding:14px;margin-bottom:16px;">
                <p style="font-size:.6875rem;font-weight:700;color:#9ca3af;text-transform:uppercase;letter-spacing:.05em;margin:0 0 8px;">Remitente</p>
                <p id="mNombre" style="font-size:.875rem;font-weight:700;color:#111827;margin:0 0 4px;"></p>
                <a id="mEmail" href="#" style="font-size:.8125rem;color:#3b82f6;text-decoration:none;"></a>
            </div>
            <div style="background:#f9fafb;border-radius:10px;padding:14px;margin-bottom:16px;display:flex;justify-content:space-between;align-items:center;">
                <div>
                    <p style="font-size:.6875rem;font-weight:700;color:#9ca3af;text-transform:uppercase;letter-spacing:.05em;margin:0 0 4px;">Tipo de consulta</p>
                    <p id="mTipo" style="font-size:.875rem;font-weight:700;color:#111827;margin:0;"></p>
                </div>
                <div style="text-align:right;">
                    <p style="font-size:.6875rem;font-weight:700;color:#9ca3af;text-transform:uppercase;letter-spacing:.05em;margin:0 0 4px;">Fecha</p>
                    <p id="mFecha" style="font-size:.8125rem;font-weight:600;color:#374151;margin:0;"></p>
                </div>
            </div>
            <div>
                <p style="font-size:.6875rem;font-weight:700;color:#9ca3af;text-transform:uppercase;letter-spacing:.05em;margin:0 0 10px;">Mensaje</p>
                <div style="background:#f9fafb;border-radius:10px;padding:16px;border:1px solid #f3f4f6;">
                    <p id="mDetalle" style="font-size:.875rem;color:#374151;line-height:1.6;margin:0;white-space:pre-wrap;"></p>
                </div>
            </div>
            <div style="margin-top:16px;">
                <a id="mResponder" href="#"
                    style="display:inline-flex;align-items:center;gap:8px;padding:10px 18px;background:#111827;color:#fff;border-radius:9px;font-size:.8125rem;font-weight:700;text-decoration:none;">
                    <span class="material-symbols-outlined" style="font-size:16px;">reply</span>
                    Responder por correo
                </a>
            </div>
        </div>
    </div>
</div>

<div id="toast"><span id="toastMsg"></span><div id="toastBar"></div></div>

<script type="text/javascript">
    function filtrarTabla(tipo) {
        document.querySelectorAll('#tablaContactos tbody tr').forEach(function (row) {
            row.style.display = (!tipo || row.dataset.tipo === tipo) ? '' : 'none';
        });
    }

    /* ✅ Recibe parámetros directos desde el button generado en code-behind */
    function verDetalle(id, nombre, email, tipo, fecha, detalle) {
        document.getElementById('mSubtitle').textContent = 'Mensaje #' + id;
        document.getElementById('mNombre').textContent = nombre || '—';
        document.getElementById('mEmail').textContent = email || '—';
        document.getElementById('mEmail').href = 'mailto:' + (email || '');
        document.getElementById('mTipo').textContent = tipo || '—';
        document.getElementById('mFecha').textContent = fecha || '—';
        document.getElementById('mDetalle').textContent = detalle || '(Sin mensaje)';
        document.getElementById('mResponder').href = 'mailto:' + (email || '') + '?subject=Re: ' + encodeURIComponent(tipo || 'Consulta Microtex');
        document.getElementById('modalContacto').classList.add('open');
        document.body.style.overflow = 'hidden';
    }

    function cerrarModal() {
        document.getElementById('modalContacto').classList.remove('open');
        document.body.style.overflow = '';
    }

    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') cerrarModal(); });

    function showToast(msg, type) {
        var t = document.getElementById('toast');
        var bar = document.getElementById('toastBar');
        document.getElementById('toastMsg').textContent = msg;
        t.style.background = type === 'ok' ? '#111827' : '#7f1d1d';
        bar.style.background = type === 'ok' ? 'rgba(134,239,172,.5)' : 'rgba(252,165,165,.5)';
        t.classList.add('show');
        bar.style.animation = 'none';
        void bar.offsetWidth;
        bar.style.animation = 'shrink 3.2s linear forwards';
        clearTimeout(window._toastTimer);
        window._toastTimer = setTimeout(function () { t.classList.remove('show'); }, 3400);
    }
</script>
</body>
</html>
