<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin-pedidos.aspx.cs" Inherits="Microtex.AdminPedidos" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Microtex | Admin Pedidos</title>
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

        .badge { display:inline-flex; align-items:center; padding:3px 10px; border-radius:20px; font-size:.6875rem; font-weight:700; }
        .badge-pend { background:#f8f7f6; color:#8f8a7a; }
        .badge-prep { background:#eceae3; color:#6f6a5d; }
        .badge-env  { background:#e5e2d9; color:#8f8a7a; }
        .badge-ok   { background:#e6f4ea; color:#2f855a; }
        .badge-bad  { background:#fdecea; color:#c53030; }

        .card { background:#fff; border:1px solid #e5e7eb; border-radius:14px; overflow:hidden; margin-bottom:16px; }
        .card-head { display:flex; align-items:center; justify-content:space-between; padding:16px 20px; border-bottom:1px solid #f3f4f6; }

        select.estado-sel { padding:6px 10px; border:1.5px solid #e5e7eb; border-radius:8px; font-size:.8125rem; font-family:'Inter',sans-serif; background:#f9fafb; cursor:pointer; outline:none; }
        select.estado-sel:focus { border-color:#111827; }

        .orders-table { width:100%; border-collapse:collapse; font-size:.8125rem; }
        .orders-table th { padding:10px 16px; text-align:left; font-size:.6875rem; font-weight:700; text-transform:uppercase; letter-spacing:.06em; color:#9ca3af; border-bottom:1px solid #f3f4f6; }
        .orders-table td { padding:14px 16px; border-bottom:1px solid #f9fafb; color:#374151; vertical-align:middle; }
        .orders-table tbody tr:last-child td { border-bottom:none; }
        .orders-table tbody tr:hover td { background:#fafafa; }

        .btn-save { padding:6px 14px; background:#8f8a7a; color:#fff; border:none; border-radius:8px; font-size:.75rem; font-weight:700; cursor:pointer; transition:background .15s ease; }
        .btn-save:hover { background:#6f6a5d; }

        .alert { font-size:.8125rem; font-weight:600; padding:9px 14px; border-radius:9px; margin-bottom:16px; }
        .alert-ok  { background:#f0fdf4; color:#15803d; }
        .alert-err { background:#fef2f2; color:#dc2626; }

        /* Modal */
        #modalDetalle { position:fixed; inset:0; z-index:9999; display:none; align-items:center; justify-content:center; padding:16px; }
        #modalDetalle.open { display:flex; }
        #modalOverlay { position:absolute; inset:0; background:rgba(0,0,0,.45); }
        #modalBox { position:relative; background:#fff; border-radius:20px; width:100%; max-width:560px; max-height:88vh; overflow-y:auto; box-shadow:0 24px 48px rgba(0,0,0,.18); }

        /* ✅ Toast — sin icono */
        #toast {
            position:fixed; bottom:28px; right:28px; z-index:99999;
            display:flex; align-items:center; gap:0;
            padding:14px 22px; border-radius:14px;
            background:#111827; color:#fff;
            font-family:'Inter',sans-serif; font-size:.875rem; font-weight:600;
            box-shadow:0 8px 32px rgba(0,0,0,.22);
            transform:translateY(80px); opacity:0;
            transition:transform .35s cubic-bezier(.34,1.56,.64,1), opacity .3s ease;
            pointer-events:none; max-width:340px;
        }
        #toast.show { transform:translateY(0) !important; opacity:1 !important; pointer-events:auto !important; }
        #toastBar { position:absolute; bottom:0; left:0; height:3px; border-radius:0 0 14px 14px; width:100%; transform-origin:left; }
        @keyframes shrink { from { width:100%; } to { width:0%; } }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <!-- HEADER -->
    <header class="sticky top-0 z-50 w-full bg-white/95 backdrop-blur-md border-b border-slate-200 shadow-sm">
        <div class="flex w-full items-center gap-3 px-4 sm:px-6 py-3">
            <a href="Default.aspx" class="flex items-center gap-2 shrink-0">
                <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-slate-900 text-white font-black text-sm">M</div>
                <span class="text-base font-black tracking-tight text-slate-900">Microtex</span>
            </a>
            <span class="text-xs font-bold px-2 py-1 rounded-full ml-2" style="background:#eceae3;color:#8f8a7a;">ADMIN</span>
            <div class="ml-auto flex items-center gap-3">
                <a href="admin-contactos.aspx" class="text-sm text-slate-500 hover:text-slate-900">Solicitudes</a>
                <a href="perfil.aspx" class="text-sm text-slate-500 hover:text-slate-900">Mi cuenta</a>
                <a href="Default.aspx" class="text-sm text-slate-500 hover:text-slate-900">Sitio</a>
            </div>
        </div>
    </header>

    <main style="flex:1; padding:2rem 1rem;">
        <div style="max-width:1100px; margin:0 auto;">

            <div style="margin-bottom:1.5rem; display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:12px;">
                <div>
                    <h1 style="font-size:1.375rem; font-weight:800; color:#111827; margin:0 0 2px;">Gestion de Pedidos</h1>
                    <p style="font-size:.8125rem; color:#9ca3af; margin:0;">Actualiza el estado de los pedidos de tus clientes</p>
                </div>
                <div style="display:flex; align-items:center; gap:8px;">
                    <span style="font-size:.8125rem; color:#6b7280; font-weight:600;">Filtrar:</span>
                    <select id="filtroEstado" onchange="filtrarTabla(this.value)"
                        style="padding:7px 12px; border:1.5px solid #e5e7eb; border-radius:8px; font-size:.8125rem; font-family:'Inter',sans-serif; background:#fff; cursor:pointer; outline:none;">
                        <option value="">Todos</option>
                        <option value="Pendiente">Pendiente</option>
                        <option value="Confirmado">Confirmado</option>
                        <option value="Preparando">Preparando</option>
                        <option value="Enviado">Enviado</option>
                        <option value="Entregado">Entregado</option>
                        <option value="Cancelado">Cancelado</option>
                    </select>
                </div>
            </div>

            <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert" />

            <!-- Estadisticas -->
            <div style="display:grid; grid-template-columns:repeat(auto-fit,minmax(140px,1fr)); gap:12px; margin-bottom:20px;">
                <div style="background:#fff; border:1px solid #e5e7eb; border-radius:12px; padding:14px 16px;">
                    <p style="font-size:.6875rem; font-weight:700; color:#9ca3af; text-transform:uppercase; letter-spacing:.05em; margin:0 0 4px;">Total pedidos</p>
                    <asp:Label ID="lblTotalPedidos" runat="server" Style="font-size:1.5rem; font-weight:800; color:#111827;" />
                </div>
                <div style="background:#f8f7f6; border:1px solid #e5e2d9; border-radius:12px; padding:14px 16px;">
                    <p style="font-size:.6875rem; font-weight:700; color:#8f8a7a; text-transform:uppercase; letter-spacing:.05em; margin:0 0 4px;">Pendientes</p>
                    <asp:Label ID="lblPendientes" runat="server" Style="font-size:1.5rem; font-weight:800; color:#8f8a7a;" />
                </div>
                <div style="background:#eceae3; border:1px solid #d6d3c9; border-radius:12px; padding:14px 16px;">
                    <p style="font-size:.6875rem; font-weight:700; color:#6f6a5d; text-transform:uppercase; letter-spacing:.05em; margin:0 0 4px;">En camino</p>
                    <asp:Label ID="lblEnviados" runat="server" Style="font-size:1.5rem; font-weight:800; color:#6f6a5d;" />
                </div>
                <div style="background:#f8f7f6; border:1px solid #e5e2d9; border-radius:12px; padding:14px 16px;">
                    <p style="font-size:.6875rem; font-weight:700; color:#8f8a7a; text-transform:uppercase; letter-spacing:.05em; margin:0 0 4px;">Entregados</p>
                    <asp:Label ID="lblEntregados" runat="server" Style="font-size:1.5rem; font-weight:800; color:#8f8a7a;" />
                </div>
                <div style="background:#eceae3; border:1px solid #d6d3c9; border-radius:12px; padding:14px 16px;">
                    <p style="font-size:.6875rem; font-weight:700; color:#6f6a5d; text-transform:uppercase; letter-spacing:.05em; margin:0 0 4px;">Total vendido</p>
                    <asp:Label ID="lblTotalVendido" runat="server" Style="font-size:1.25rem; font-weight:800; color:#6f6a5d;" />
                </div>
            </div>

            <!-- Tabla -->
            <div class="card">
                <div class="card-head">
                    <h2 style="font-size:.9375rem; font-weight:700; color:#111827; margin:0;">Todos los Pedidos</h2>
                </div>
                <div style="overflow-x:auto;">
                    <table class="orders-table" id="tablaPedidos">
                        <thead>
                            <tr>
                                <th># Pedido</th>
                                <th>Cliente</th>
                                <th>Fecha</th>
                                <th>Productos</th>
                                <th>Total</th>
                                <th>Estado actual</th>
                                <th>Cambiar estado</th>
                                <th>Detalle</th>
                            </tr>
                        </thead>
                        <asp:Repeater ID="rptPedidos" runat="server" OnItemDataBound="rptPedidos_ItemDataBound">
                            <HeaderTemplate><tbody></HeaderTemplate>
                            <ItemTemplate>
                                <tr data-estado='<%# Eval("Estado") %>'>
                                    <td style="font-weight:700; color:#111827;">#<%# Eval("IdPedido") %></td>
                                    <td>
                                        <p style="font-weight:600; color:#111827; margin:0;"><%# Eval("Nombre") %></p>
                                        <p style="font-size:.75rem; color:#9ca3af; margin:0;"><%# Eval("Email") %></p>
                                    </td>
                                    <td style="color:#6b7280; white-space:nowrap;"><%# Eval("FechaPedido", "{0:dd/MM/yyyy HH:mm}") %></td>
                                    <td style="color:#6b7280;"><%# Eval("NumProductos") %> art.</td>
                                    <td style="font-weight:700; color:#111827;">$<%# Eval("Total", "{0:N2}") %></td>
                                    <td><asp:Label ID="lblEstado" runat="server" /></td>
                                    <td>
                                        <div style="display:flex; align-items:center; gap:6px;">
                                            <asp:DropDownList ID="ddlEstado" runat="server" CssClass="estado-sel" />
                                            <asp:Button ID="btnGuardar" runat="server"
                                                Text="Guardar"
                                                CommandArgument='<%# Eval("IdPedido") %>'
                                                OnClick="btnGuardar_Click"
                                                CssClass="btn-save" />
                                        </div>
                                    </td>
                                    <td>
                                        <button type="button"
                                            onclick="verDetalle('<%# Eval("IdPedido") %>','<%# Eval("Nombre") %>','<%# Eval("Email") %>','<%# Eval("Telefono") %>','<%# Eval("Direccion") %>','<%# Eval("Ciudad") %>','<%# Eval("CodigoPostal") %>','<%# Eval("ConektaOrder") %>','<%# Eval("Total", "{0:N2}") %>')"
                                            style="display:inline-flex;align-items:center;gap:4px;padding:5px 10px;background:#eceae3;border:none;border-radius:7px;font-size:.75rem;font-weight:600;color:#6f6a5d;cursor:pointer;">
                                            <span class="material-symbols-outlined" style="font-size:14px;">visibility</span>
                                            Ver
                                        </button>
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

<!-- MODAL DETALLE -->
<div id="modalDetalle">
    <div id="modalOverlay" onclick="cerrarModal()"></div>
    <div id="modalBox">
        <div style="display:flex;align-items:center;justify-content:space-between;padding:18px 22px;border-bottom:1px solid #f3f4f6;position:sticky;top:0;background:#fff;border-radius:20px 20px 0 0;z-index:1;">
            <h3 style="font-size:1rem;font-weight:800;color:#111827;margin:0;">Detalle del Pedido</h3>
            <button type="button" onclick="cerrarModal()"
                style="width:30px;height:30px;border-radius:50%;background:#f3f4f6;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;">
                <span class="material-symbols-outlined" style="font-size:16px;color:#6b7280;">close</span>
            </button>
        </div>
        <div style="padding:20px 22px;">
            <div style="background:#f9fafb;border-radius:10px;padding:14px;margin-bottom:16px;">
                <p style="font-size:.6875rem;font-weight:700;color:#9ca3af;text-transform:uppercase;letter-spacing:.05em;margin:0 0 8px;">Cliente</p>
                <p id="dNombre"   style="font-size:.875rem;font-weight:700;color:#111827;margin:0 0 2px;"></p>
                <p id="dEmail"    style="font-size:.8125rem;color:#6b7280;margin:0 0 2px;"></p>
                <p id="dTelefono" style="font-size:.8125rem;color:#6b7280;margin:0;"></p>
            </div>
            <div style="background:#eff6ff;border:1px solid #dbeafe;border-radius:10px;padding:14px;margin-bottom:16px;">
                <p style="font-size:.6875rem;font-weight:700;color:#1d4ed8;text-transform:uppercase;letter-spacing:.05em;margin:0 0 8px;">Direccion de entrega</p>
                <p id="dDireccion" style="font-size:.8125rem;color:#1e40af;margin:0 0 2px;font-weight:600;"></p>
                <p id="dCiudad"    style="font-size:.8125rem;color:#3b82f6;margin:0;"></p>
            </div>
            <div style="background:#f9fafb;border-radius:10px;padding:14px;margin-bottom:16px;display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap;">
                <div>
                    <p style="font-size:.6875rem;font-weight:700;color:#9ca3af;text-transform:uppercase;letter-spacing:.05em;margin:0 0 4px;">Orden Conekta</p>
                    <p id="dConekta" style="font-size:.75rem;font-weight:700;color:#111827;font-family:monospace;word-break:break-all;margin:0;"></p>
                </div>
                <div style="text-align:right;">
                    <p style="font-size:.6875rem;font-weight:700;color:#9ca3af;text-transform:uppercase;letter-spacing:.05em;margin:0 0 4px;">Total</p>
                    <p id="dTotal" style="font-size:1.25rem;font-weight:800;color:#111827;margin:0;"></p>
                </div>
            </div>
            <p style="font-size:.6875rem;font-weight:700;color:#9ca3af;text-transform:uppercase;letter-spacing:.05em;margin:0 0 10px;">Productos</p>
            <div id="dProductos" style="border:1px solid #f3f4f6;border-radius:10px;overflow:hidden;">
                <p style="text-align:center;padding:16px;color:#9ca3af;font-size:.8125rem;">Cargando...</p>
            </div>
        </div>
    </div>
</div>

<!-- ✅ TOAST — sin icono -->
<div id="toast">
    <span id="toastMsg"></span>
    <div id="toastBar"></div>
</div>

<script type="text/javascript">
    function filtrarTabla(estado) {
        document.querySelectorAll('#tablaPedidos tbody tr').forEach(function (row) {
            row.style.display = (!estado || row.dataset.estado === estado) ? '' : 'none';
        });
    }

    function verDetalle(id, nombre, email, tel, dir, ciudad, cp, conekta, total) {
        document.getElementById('dNombre').textContent = nombre || '—';
        document.getElementById('dEmail').textContent = email || '—';
        document.getElementById('dTelefono').textContent = 'Tel: ' + (tel || '—');
        document.getElementById('dDireccion').textContent = dir || '—';
        document.getElementById('dCiudad').textContent = (ciudad || '') + (cp ? ' CP: ' + cp : '');
        document.getElementById('dConekta').textContent = conekta || '—';
        document.getElementById('dTotal').textContent = '$' + total + ' MXN';

        document.getElementById('dProductos').innerHTML =
            '<p style="text-align:center;padding:16px;color:#9ca3af;font-size:.8125rem;">Cargando...</p>';

        fetch('GetDetallesPedido.ashx?id=' + id)
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (!data || data.length === 0) {
                    document.getElementById('dProductos').innerHTML =
                        '<p style="text-align:center;padding:16px;color:#9ca3af;font-size:.8125rem;">Sin productos.</p>';
                    return;
                }
                var html = '';
                data.forEach(function (item) {
                    html += '<div style="display:flex;gap:10px;padding:10px 14px;border-bottom:1px solid #f9fafb;">' +
                        '<img src="' + (item.ImagenUrl || '') + '" style="width:44px;height:44px;border-radius:8px;object-fit:cover;border:1px solid #f3f4f6;flex-shrink:0;" />' +
                        '<div style="flex:1;min-width:0;">' +
                        '<p style="font-size:.8125rem;font-weight:700;color:#111827;margin:0 0 2px;">' + item.NombreProducto + '</p>' +
                        '<p style="font-size:.75rem;color:#9ca3af;margin:0;">Color: ' + (item.Color || '—') + ' · Cant: ' + item.Cantidad + ' · $' + parseFloat(item.Subtotal).toFixed(2) + '</p>' +
                        '</div></div>';
                });
                document.getElementById('dProductos').innerHTML = html;
            })
            .catch(function () {
                document.getElementById('dProductos').innerHTML =
                    '<p style="text-align:center;padding:16px;color:#9ca3af;font-size:.8125rem;">Error al cargar productos.</p>';
            });

        document.getElementById('modalDetalle').classList.add('open');
        document.body.style.overflow = 'hidden';
    }

    function cerrarModal() {
        document.getElementById('modalDetalle').classList.remove('open');
        document.body.style.overflow = '';
    }

    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') cerrarModal(); });

    /* ── Toast sin icono ── */
    function showToast(msg, type) {
        var t = document.getElementById('toast');
        var bar = document.getElementById('toastBar');

        document.getElementById('toastMsg').textContent = msg;

        if (type === 'ok') {
            t.style.background = '#111827';
            bar.style.background = 'rgba(134,239,172,.5)';
        } else {
            t.style.background = '#7f1d1d';
            bar.style.background = 'rgba(252,165,165,.5)';
        }

        t.classList.add('show');
        bar.style.animation = 'none';
        void bar.offsetWidth;
        bar.style.animation = 'shrink 3.2s linear forwards';

        clearTimeout(window._toastTimer);
        window._toastTimer = setTimeout(function () {
            t.classList.remove('show');
        }, 3400);
    }
</script>
</body>
</html>
