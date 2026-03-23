<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="perfil.aspx.cs" Inherits="Microtex.perfil" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>MicroTex | Mi Cuenta</title>
    <link rel="icon" href="favicon.ico?v=2" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="Scripts/tailwind.config.js"></script>
    <link href="Styles/site.css" rel="stylesheet" />
    <style>
        html, body { height:100%; margin:0; padding:0; font-family:'Inter',sans-serif; background:#F0EEE6; }
        body { display:flex; flex-direction:column; min-height:100vh; }
        body > form { display:flex; flex-direction:column; flex:1; min-height:100vh; }
        header nav, header nav a { flex-direction:row !important; flex-wrap:nowrap !important; }
        header nav a { display:inline-flex !important; width:auto !important; padding:0 !important; border-bottom:none !important; }
        #perfil-mob-menu { display:none; flex-direction:column; }
        #perfil-mob-menu.open { display:flex; }
        .nav-item { display:flex; align-items:center; gap:10px; padding:9px 12px; border-radius:8px; font-size:.8125rem; font-weight:500; color:#4b5563; text-decoration:none; cursor:pointer; background:none; border:none; width:100%; text-align:left; transition:background .12s,color .12s; }
        .nav-item:hover { background:#f3f4f6; color:#111827; }
        .nav-item.active { background:#111827; color:#fff; font-weight:600; }
        .nav-item.active .nav-icon { color:#fff; }
        .nav-item.danger { color:#ef4444; }
        .nav-item.danger:hover { background:#fef2f2; color:#dc2626; }
        .nav-icon { font-size:17px; flex-shrink:0; color:#9ca3af; }
        .tab-panel { display:none; animation:fadeIn .18s ease; }
        .tab-panel.active { display:block; }
        @keyframes fadeIn { from{opacity:0;transform:translateY(4px)} to{opacity:1;transform:translateY(0)} }
        .section-card { background:#fff; border:1px solid #e5e7eb; border-radius:14px; margin-bottom:16px; overflow:hidden; }
        .section-head { display:flex; align-items:center; justify-content:space-between; padding:18px 22px; border-bottom:1px solid #f3f4f6; }
        .section-title { font-size:.9375rem; font-weight:700; color:#111827; margin:0; }
        .btn-edit { display:inline-flex; align-items:center; gap:4px; font-size:.6875rem; font-weight:700; color:#6b7280; text-transform:uppercase; letter-spacing:.06em; background:none; border:none; cursor:pointer; padding:4px 8px; border-radius:6px; transition:all .12s; }
        .btn-edit:hover { background:#f3f4f6; color:#111827; }
        .section-body { padding:20px 22px; }
        .data-grid { display:grid; grid-template-columns:1fr 1fr; gap:20px 32px; }
        @media(max-width:540px){ .data-grid{ grid-template-columns:1fr; gap:14px; } }
        .data-label { font-size:.6875rem; font-weight:600; color:#9ca3af; text-transform:uppercase; letter-spacing:.06em; margin-bottom:4px; }
        .data-value { font-size:.875rem; font-weight:600; color:#111827; }
        .form-input { width:100%; padding:9px 13px; border:1.5px solid #e5e7eb; border-radius:9px; font-size:.875rem; color:#111827; font-family:'Inter',sans-serif; background:#f9fafb; outline:none; transition:border .15s,background .15s; box-sizing:border-box; }
        .form-input:focus { border-color:#111827; background:#fff; }
        .form-label { font-size:.75rem; font-weight:600; color:#6b7280; text-transform:uppercase; letter-spacing:.05em; display:block; margin-bottom:6px; }
        .edit-grid { display:grid; grid-template-columns:1fr 1fr; gap:14px; }
        @media(max-width:540px){ .edit-grid{ grid-template-columns:1fr; } }
        .btn-primary { padding:9px 18px; border-radius:9px; background:#111827; color:#fff; font-size:.8125rem; font-weight:700; border:none; cursor:pointer; transition:background .12s; }
        .btn-primary:hover { background:#000; }
        .btn-secondary { padding:9px 18px; border-radius:9px; background:#fff; color:#374151; font-size:.8125rem; font-weight:600; border:1.5px solid #e5e7eb; cursor:pointer; transition:all .12s; }
        .btn-secondary:hover { background:#f3f4f6; }
        .btn-row { display:flex; gap:10px; margin-top:18px; }
        .orders-wrap { overflow-x:auto; }
        .orders-table { width:100%; border-collapse:collapse; font-size:.8125rem; }
        .orders-table th { padding:10px 14px; text-align:left; font-size:.6875rem; font-weight:700; text-transform:uppercase; letter-spacing:.06em; color:#9ca3af; border-bottom:1px solid #f3f4f6; white-space:nowrap; }
        .orders-table td { padding:13px 14px; border-bottom:1px solid #f9fafb; color:#374151; vertical-align:middle; }
        .orders-table tbody tr:last-child td { border-bottom:none; }
        .orders-table tbody tr:hover td { background:#fafafa; }
        .badge { display:inline-flex; align-items:center; padding:3px 9px; border-radius:20px; font-size:.6875rem; font-weight:700; }
        .badge-ok   { background:#dcfce7; color:#15803d; }
        .badge-pend { background:#fef9c3; color:#a16207; }
        .badge-bad  { background:#fee2e2; color:#b91c1c; }
        .pass-mask { font-size:22px; letter-spacing:3px; color:#d1d5db; line-height:1; }
        .empty-state { text-align:center; padding:52px 24px; }
        .empty-icon { width:56px; height:56px; background:#f3f4f6; border-radius:14px; display:flex; align-items:center; justify-content:center; margin:0 auto 14px; }
        .empty-title { font-size:.9375rem; font-weight:700; color:#374151; margin-bottom:6px; }
        .empty-sub { font-size:.8125rem; color:#9ca3af; margin-bottom:20px; }
        .alert { font-size:.8125rem; font-weight:600; padding:9px 14px; border-radius:9px; margin-bottom:14px; }
        .alert-ok  { background:#f0fdf4; color:#15803d; }
        .alert-err { background:#fef2f2; color:#dc2626; }
        #modalPedido { position:fixed; inset:0; z-index:9999; display:none; align-items:center; justify-content:center; padding:16px; }
        #modalPedido.open { display:flex; }
        #modalOverlay { position:absolute; inset:0; background:rgba(0,0,0,.45); }
        #modalBox { position:relative; background:#fff; border-radius:20px; width:100%; max-width:600px; max-height:90vh; overflow-y:auto; box-shadow:0 24px 48px rgba(0,0,0,.18); }
        #modalBox::-webkit-scrollbar { width:4px; }
        #modalBox::-webkit-scrollbar-thumb { background:#e5e7eb; border-radius:4px; }
        .timeline{
    display:flex;
    justify-content:space-between;
    align-items:flex-start;
    position:relative;
    margin-top:10px;
}

.timeline::before{
    content:'';
    position:absolute;
    top:18px;
    left:0;
    right:0;
    height:3px;
    background:#e5e7eb;
    z-index:1;
}

.tl-item{
    position:relative;
    z-index:2;
    text-align:center;
    flex:1;
}

.tl-dot{
    width:36px;
    height:36px;
    border-radius:50%;
    display:flex;
    align-items:center;
    justify-content:center;
    margin:0 auto 8px;
    background:#f3f4f6;
    border:2px solid #e5e7eb;
}

.tl-dot.done{
    background:#111827;
    border-color:#111827;
}

.tl-dot.active{
    background:#8f8a7a;
    border-color:#8f8a7a;
}

.tl-title{
    font-size:.8rem;
    font-weight:700;
    color:#111827;
}

.tl-sub{
    font-size:.7rem;
    color:#9ca3af;
}
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
            <div class="hidden sm:flex flex-1 mx-4 max-w-md">
                <div class="relative w-full">
                    <span class="material-symbols-outlined absolute left-3 top-2.5 text-slate-400 text-sm pointer-events-none">search</span>
                    <input type="text" placeholder="Buscar acabados premium..."
                        onkeydown="if(event.key==='Enter'){location.href='productos.aspx?q='+this.value}"
                        class="w-full rounded-full border border-slate-200 bg-slate-50 pl-9 pr-4 py-2 text-sm text-slate-700 focus:outline-none" />
                </div>
            </div>
            <nav class="hidden lg:flex items-center gap-8">
                <a class="text-sm font-medium text-slate-600 hover:text-slate-900" href="productos.aspx">Catalogo</a>
                <a class="text-sm font-medium text-slate-600 hover:text-slate-900" href="proyectos.aspx">Proyectos</a>
                <a class="text-sm font-medium text-slate-600 hover:text-slate-900" href="Nosotros.aspx">Nosotros</a>
                <asp:HyperLink ID="lnkAdmin" runat="server" Visible="false"
                    NavigateUrl="admin-pedidos.aspx"
                    CssClass="text-xs font-bold bg-amber-100 text-amber-700 px-3 py-1 rounded-full hover:bg-amber-200 transition-colors">
                    Administrar Pedidos
                </asp:HyperLink>
                <asp:HyperLink ID="lnkSoli" runat="server" Visible="false"
                    NavigateUrl="admin-pedidos.aspx"
                    CssClass="text-xs font-bold bg-amber-100 text-amber-700 px-3 py-1 rounded-full hover:bg-amber-200 transition-colors">
                    Solicitar cotizaciones
                </asp:HyperLink>
            </nav>
            <div class="flex items-center gap-2 shrink-0 ml-auto">
                <asp:Literal ID="litNavUser" runat="server" />
                <a href="carrito.aspx" class="relative w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100">
                    <span class="material-symbols-outlined text-xl">shopping_bag</span>
                    <span class="absolute -top-0.5 -right-0.5 w-4 h-4 bg-slate-900 rounded-full text-white text-xs font-black flex items-center justify-center leading-none">0</span>
                </a>
                <button type="button" onclick="document.getElementById('perfil-mob-menu').classList.toggle('open')"
                    class="lg:hidden w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100">
                    <span class="material-symbols-outlined text-xl">menu</span>
                </button>
            </div>
        </div>
        <div id="perfil-mob-menu" class="lg:hidden border-t border-slate-100 bg-white px-4 py-3 gap-1">
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="productos.aspx">Catalogo</a>
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="proyectos.aspx">Proyectos</a>
            <a class="block px-3 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 rounded-lg" href="Nosotros.aspx">Nosotros</a>
        </div>
    </header>

    <main style="flex:1; padding:2rem 1rem;">
        <div style="max-width:1040px; margin:0 auto;">
            <div style="margin-bottom:1.5rem;">
                <h1 style="font-size:1.375rem; font-weight:800; color:#111827; margin:0 0 2px;">Mi Cuenta</h1>
                <p style="font-size:.8125rem; color:#9ca3af; margin:0;">Administra tu informacion personal y pedidos</p>
            </div>

            <div style="display:flex; gap:20px; align-items:flex-start;" class="flex-col-mobile">

                <!-- SIDEBAR -->
                <aside style="width:220px; flex-shrink:0;">
                    <div style="background:#fff; border:1px solid #e5e7eb; border-radius:14px; padding:10px; position:sticky; top:80px;">
                        <div style="display:flex; align-items:center; gap:10px; padding:10px 10px 12px; border-bottom:1px solid #f3f4f6; margin-bottom:6px;">
                            <div style="width:36px; height:36px; border-radius:50%; background:#111827; display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                                <asp:Label ID="lblAvatarSide" runat="server" Style="color:#fff; font-weight:800; font-size:.9rem; line-height:1;" />
                            </div>
                            <div style="min-width:0;">
                                <asp:Label ID="lblNombreSide" runat="server" Style="font-size:.8125rem; font-weight:700; color:#111827; display:block; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" />
                                <asp:Label ID="lblEmailSide"  runat="server" Style="font-size:.6875rem; color:#9ca3af; display:block; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" />
                            </div>
                        </div>
                        <button type="button" class="nav-item active" id="nav-detalles" onclick="showTab('detalles',this)">
                            <span class="material-symbols-outlined nav-icon">person</span>Detalles de la cuenta
                        </button>
                        <button type="button" class="nav-item" id="nav-pedidos" onclick="showTab('pedidos',this)">
                            <span class="material-symbols-outlined nav-icon">receipt_long</span>Historial de pedidos
                        </button>
                        <button type="button" class="nav-item" id="nav-seguridad" onclick="showTab('seguridad',this)">
                            <span class="material-symbols-outlined nav-icon">lock</span>Seguridad
                        </button>
                        <div style="border-top:1px solid #f3f4f6; margin:8px 0;"></div>
                        <asp:Button ID="btnCerrarSesion" runat="server" Text="Cerrar sesion"
                            OnClick="btnCerrarSesion_Click" CausesValidation="false" CssClass="nav-item danger" />
                    </div>
                </aside>

                <!-- CONTENT -->
                <div style="flex:1; min-width:0;">

                    <!-- TAB DETALLES -->
                    <div id="tab-detalles" class="tab-panel active">

                        <!-- Mi perfil -->
                        <div class="section-card">
                            <div class="section-head">
                                <h2 class="section-title">Mi perfil</h2>
                                <button type="button" class="btn-edit" id="editbtn-perfil"
                                    onclick="toggleEdit('view-perfil','edit-perfil','editbtn-perfil')">
                                    <span class="material-symbols-outlined" style="font-size:14px;">edit</span> Editar
                                </button>
                            </div>
                            <div class="section-body" id="view-perfil">
                                <div class="data-grid">
                                    <div>
                                        <p class="data-label">Nombre completo</p>
                                        <asp:Label ID="lblNombreCompleto" runat="server" CssClass="data-value" />
                                    </div>
                                    <div>
                                        <p class="data-label">Correo electronico</p>
                                        <asp:Label ID="lblEmailPerfil" runat="server" CssClass="data-value" />
                                    </div>
                                    <div>
                                        <p class="data-label">Miembro desde</p>
                                        <asp:Label ID="lblFecha" runat="server" CssClass="data-value" />
                                    </div>
                                </div>
                            </div>
                            <div class="section-body" id="edit-perfil" style="display:none; border-top:1px solid #f3f4f6;">
                                <asp:Label ID="lblMsgPerfil" runat="server" Visible="false" CssClass="alert" />
                                <div class="edit-grid">
                                    <div>
                                        <label class="form-label">Nombre completo</label>
                                        <asp:TextBox ID="txtEditNombre" runat="server" CssClass="form-input" placeholder="Tu nombre" />
                                    </div>
                                    <div>
                                        <label class="form-label">Correo electronico</label>
                                        <asp:TextBox ID="txtEditEmail" runat="server" TextMode="Email" CssClass="form-input" placeholder="correo@ejemplo.com" />
                                    </div>
                                </div>
                                <div class="btn-row">
                                    <asp:Button ID="btnGuardarPerfil" runat="server" Text="Guardar cambios"
                                        OnClick="btnGuardarPerfil_Click" CausesValidation="false" CssClass="btn-primary" />
                                    <button type="button" class="btn-secondary"
                                        onclick="toggleEdit('view-perfil','edit-perfil','editbtn-perfil')">Cancelar</button>
                                </div>
                            </div>
                        </div>

                        <!-- Contrasena -->
                        <div class="section-card">
                            <div class="section-head">
                                <h2 class="section-title">Contrasena</h2>
                                <button type="button" class="btn-edit"
                                    onclick="showTab('seguridad', document.getElementById('nav-seguridad'))">
                                    <span class="material-symbols-outlined" style="font-size:14px;">edit</span> Editar
                                </button>
                            </div>
                            <div class="section-body">
                                <p class="data-label">Contrasena</p>
                                <span class="pass-mask">........</span>
                            </div>
                        </div>

                        <!-- ✅ Direccion de Entrega -->
                        <div class="section-card">
                            <div class="section-head">
                                <h2 class="section-title">Direccion de Entrega</h2>
                                <button type="button" class="btn-edit" id="editbtn-dir"
                                    onclick="toggleEdit('view-dir','edit-dir','editbtn-dir')">
                                    <span class="material-symbols-outlined" style="font-size:14px;">edit</span> Editar
                                </button>
                            </div>
                            <!-- Vista -->
                            <div class="section-body" id="view-dir">
                                <div class="data-grid">
                                    <div>
                                        <p class="data-label">Telefono</p>
                                        <asp:Label ID="lblDirTelefono" runat="server" CssClass="data-value" Text="—" />
                                    </div>
                                    <div>
                                        <p class="data-label">Codigo Postal</p>
                                        <asp:Label ID="lblDirCP" runat="server" CssClass="data-value" Text="—" />
                                    </div>
                                    <div>
                                        <p class="data-label">Ciudad</p>
                                        <asp:Label ID="lblDirCiudad" runat="server" CssClass="data-value" Text="—" />
                                    </div>
                                    <div>
                                        <p class="data-label">Estado</p>
                                        <asp:Label ID="lblDirEstado" runat="server" CssClass="data-value" Text="—" />
                                    </div>
                                    <div style="grid-column:1/-1;">
                                        <p class="data-label">Calle y numero</p>
                                        <asp:Label ID="lblDirCalle" runat="server" CssClass="data-value" Text="—" />
                                    </div>
                                    <div style="grid-column:1/-1;">
                                        <p class="data-label">Referencia</p>
                                        <asp:Label ID="lblDirRef" runat="server" CssClass="data-value" Text="—" />
                                    </div>
                                </div>
                            </div>
                            <!-- Edicion -->
                            <div class="section-body" id="edit-dir" style="display:none; border-top:1px solid #f3f4f6;">
                                <asp:Label ID="lblMsgDir" runat="server" Visible="false" CssClass="alert" />
                                <div class="edit-grid">
                                    <div>
                                        <label class="form-label">Telefono</label>
                                        <asp:TextBox ID="txtDirTelefono" runat="server" CssClass="form-input" placeholder="771 000 0000" />
                                    </div>
                                    <div>
                                        <label class="form-label">Codigo Postal</label>
                                        <asp:TextBox ID="txtDirCP" runat="server" CssClass="form-input" placeholder="00000" />
                                    </div>
                                    <div>
                                        <label class="form-label">Ciudad</label>
                                        <asp:TextBox ID="txtDirCiudad" runat="server" CssClass="form-input" placeholder="Ciudad de Mexico" />
                                    </div>
                                    <div>
                                        <label class="form-label">Estado</label>
                                        <asp:TextBox ID="txtDirEstado" runat="server" CssClass="form-input" placeholder="Hidalgo" />
                                    </div>
                                    <div style="grid-column:1/-1;">
                                        <label class="form-label">Calle, numero y colonia</label>
                                        <asp:TextBox ID="txtDirCalle" runat="server" CssClass="form-input" placeholder="Calle Morelos 8, Col. Centro" />
                                    </div>
                                    <div style="grid-column:1/-1;">
                                        <label class="form-label">Referencia <span style="font-weight:400;text-transform:none;">(Opcional)</span></label>
                                        <asp:TextBox ID="txtDirRef" runat="server" CssClass="form-input" placeholder="Entre calles, color de fachada..." />
                                    </div>
                                </div>
                                <div class="btn-row">
                                    <asp:Button ID="btnGuardarDireccion" runat="server"
                                        Text="Guardar direccion"
                                        OnClick="btnGuardarDireccion_Click"
                                        CausesValidation="false"
                                        CssClass="btn-primary" />
                                    <button type="button" class="btn-secondary"
                                        onclick="toggleEdit('view-dir','edit-dir','editbtn-dir')">Cancelar</button>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- TAB PEDIDOS -->
                    <div id="tab-pedidos" class="tab-panel">
                        <div class="section-card">
                            <div class="section-head">
                                <h2 class="section-title">Historial de pedidos</h2>
                            </div>
                            <div class="section-body" style="padding:0;">
                                <asp:Panel ID="panelPedidos" runat="server" Visible="false">
                                    <div class="orders-wrap">
                                        <table class="orders-table">
                                            <thead>
                                                <tr>
                                                    <th># Pedido</th>
                                                    <th>Fecha</th>
                                                    <th>Productos</th>
                                                    <th>Total</th>
                                                    <th>Estado</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <asp:Repeater ID="rptPedidos" runat="server" OnItemDataBound="rptPedidos_ItemDataBound">
                                                <HeaderTemplate><tbody></HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td style="font-weight:700; color:#111827;">#<%# Eval("IdPedido") %></td>
                                                        <td style="color:#6b7280;"><%# Eval("FechaPedido", "{0:dd/MM/yyyy}") %></td>
                                                        <td style="color:#6b7280;"><%# Eval("NumProductos") %> articulo(s)</td>
                                                        <td style="font-weight:600;">$<%# Eval("Total", "{0:N2}") %> MXN</td>
                                                        <td><asp:Label ID="lblEstado" runat="server" /></td>
                                                        <td>
                                                            <button type="button"
                                                                onclick="verDetalle('<%# Eval("IdPedido") %>','<%# Eval("FechaPedido", "{0:dd/MM/yyyy}") %>','<%# Eval("Total", "{0:N2}") %>','<%# Eval("Estado") %>','<%# Eval("ConektaOrder") %>','<%# Eval("Direccion") %>','<%# Eval("Ciudad") %>','<%# Eval("Nombre") %>','<%# Eval("Telefono") %>')"
                                                                style="display:inline-flex;align-items:center;gap:4px;padding:5px 10px;background:#f3f4f6;border:none;border-radius:7px;font-size:.75rem;font-weight:600;color:#374151;cursor:pointer;">
                                                                <span class="material-symbols-outlined" style="font-size:14px;">visibility</span>
                                                                Ver detalle
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate></tbody></FooterTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="panelSinPedidos" runat="server" Visible="false">
                                    <div class="empty-state">
                                        <div class="empty-icon">
                                            <span class="material-symbols-outlined" style="color:#9ca3af; font-size:26px;">shopping_bag</span>
                                        </div>
                                        <p class="empty-title">Sin pedidos aun</p>
                                        <p class="empty-sub">Cuando realices una compra aparecera aqui.</p>
                                        <a href="productos.aspx" style="display:inline-flex;align-items:center;gap:6px;padding:9px 18px;background:#111827;color:#fff;border-radius:9px;font-size:.8125rem;font-weight:700;text-decoration:none;">
                                            <span class="material-symbols-outlined" style="font-size:16px;">storefront</span>Ver catalogo
                                        </a>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>

                    <!-- TAB SEGURIDAD -->
                    <div id="tab-seguridad" class="tab-panel">
                        <div class="section-card">
                            <div class="section-head">
                                <h2 class="section-title">Cambiar contrasena</h2>
                            </div>
                            <div class="section-body">
                                <asp:Label ID="lblMsgPass" runat="server" Visible="false" CssClass="alert" />
                                <div style="max-width:380px; display:flex; flex-direction:column; gap:14px;">
                                    <div>
                                        <label class="form-label">Contrasena actual</label>
                                        <asp:TextBox ID="txtPassActual" runat="server" TextMode="Password" CssClass="form-input" placeholder="........" />
                                    </div>
                                    <div>
                                        <label class="form-label">Nueva contrasena</label>
                                        <asp:TextBox ID="txtPassNueva" runat="server" TextMode="Password" CssClass="form-input" placeholder="........" />
                                    </div>
                                    <div>
                                        <label class="form-label">Confirmar nueva contrasena</label>
                                        <asp:TextBox ID="txtPassConfirm" runat="server" TextMode="Password" CssClass="form-input" placeholder="........" />
                                    </div>
                                </div>
                                <div class="btn-row">
                                    <asp:Button ID="btnGuardarPass" runat="server" Text="Actualizar contrasena"
                                        OnClick="btnGuardarPass_Click" CausesValidation="false" CssClass="btn-primary" />
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </main>

    <asp:Label ID="lblAvatar" runat="server" Style="display:none;" />
    <asp:Label ID="lblNombre" runat="server" Style="display:none;" />
    <asp:Label ID="lblEmail"  runat="server" Style="display:none;" />

    <footer class="bg-white border-t border-slate-100 py-6 mt-6">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 flex flex-col sm:flex-row justify-between items-center gap-4">
            <asp:Label ID="lblCopyright" runat="server" CssClass="text-xs text-slate-400" />
            <div class="flex gap-4 sm:gap-6 text-xs font-medium text-slate-400">
                <a class="hover:text-slate-700" href="#">Privacidad</a>
                <a class="hover:text-slate-700" href="#">Terminos</a>
                <a class="hover:text-slate-700" href="#">Cookies</a>
            </div>
        </div>
    </footer>

</form>

<!-- MODAL DETALLE PEDIDO -->
<div id="modalPedido">
    <div id="modalOverlay" onclick="cerrarModal()"></div>
    <div id="modalBox">
        <div style="display:flex; align-items:center; justify-content:space-between; padding:20px 24px; border-bottom:1px solid #f3f4f6; position:sticky; top:0; background:#fff; border-radius:20px 20px 0 0; z-index:1;">
            <div>
                <h3 style="font-size:1rem; font-weight:800; color:#111827; margin:0;">Detalle del Pedido</h3>
                <p id="modalSubtitle" style="font-size:.75rem; color:#9ca3af; margin:2px 0 0;"></p>
            </div>
            <button type="button" onclick="cerrarModal()"
                style="width:32px; height:32px; border-radius:50%; background:#f3f4f6; border:none; cursor:pointer; display:flex; align-items:center; justify-content:center;">
                <span class="material-symbols-outlined" style="font-size:18px; color:#6b7280;">close</span>
            </button>
        </div>
        <div style="padding:20px 24px;">
            <div style="display:grid; grid-template-columns:1fr 1fr; gap:14px; margin-bottom:20px;">
                <div style="background:#f9fafb; border-radius:10px; padding:12px 14px;">
                    <p class="data-label">Numero de orden Conekta</p>
                    <p id="modalConekta" style="font-size:.75rem; font-weight:700; color:#111827; font-family:monospace; word-break:break-all;"></p>
                </div>
                <div style="background:#f9fafb; border-radius:10px; padding:12px 14px;">
                    <p class="data-label">Total pagado</p>
                    <p id="modalTotal" style="font-size:1.1rem; font-weight:800; color:#111827;"></p>
                </div>
            </div>
            <div style="background:#eff6ff; border:1px solid #dbeafe; border-radius:12px; padding:14px 16px; margin-bottom:20px;">
                <div style="display:flex; align-items:center; gap:8px; margin-bottom:8px;">
                    <span class="material-symbols-outlined" style="color:#3b82f6; font-size:18px;">location_on</span>
                    <span style="font-size:.8125rem; font-weight:700; color:#1e40af;">Direccion de Entrega</span>
                </div>
                <p id="modalNombre"    style="font-size:.8125rem; font-weight:600; color:#1e3a8a; margin:0 0 2px;"></p>
                <p id="modalDireccion" style="font-size:.8125rem; color:#3b82f6; margin:0 0 2px;"></p>
                <p id="modalTelefono"  style="font-size:.75rem; color:#60a5fa; margin:0;"></p>
            </div>
            <div style="margin-bottom:20px;">
                <p style="font-size:.75rem; font-weight:700; color:#9ca3af; text-transform:uppercase; letter-spacing:.06em; margin-bottom:14px;">Seguimiento del Pedido</p>
                <div class="timeline" id="modalTimeline"></div>
            </div>
            <div>
                <p style="font-size:.75rem; font-weight:700; color:#9ca3af; text-transform:uppercase; letter-spacing:.06em; margin-bottom:12px;">Productos</p>
                <div id="modalProductos" style="border:1px solid #f3f4f6; border-radius:10px; overflow:hidden;">
                    <p style="text-align:center; padding:20px; color:#9ca3af; font-size:.8125rem;">Cargando...</p>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    @media(max-width:768px){
        .flex-col-mobile { flex-direction:column !important; }
        aside { width:100% !important; }
        aside > div { position:static !important; display:flex; flex-wrap:wrap; gap:4px; }
    }
</style>

<script type="text/javascript">
    function showTab(name, btn) {
        document.querySelectorAll('.tab-panel').forEach(function (p) { p.classList.remove('active'); });
        document.querySelectorAll('.nav-item').forEach(function (l) { l.classList.remove('active'); });
        var panel = document.getElementById('tab-' + name);
        if (panel) panel.classList.add('active');
        if (btn) btn.classList.add('active');
    }

    function toggleEdit(viewId, editId, btnId) {
        var view = document.getElementById(viewId);
        var edit = document.getElementById(editId);
        var btn = btnId ? document.getElementById(btnId) : null;
        var isOpen = edit.style.display !== 'none';
        view.style.display = isOpen ? '' : 'none';
        edit.style.display = isOpen ? 'none' : '';
        if (btn) {
            btn.innerHTML = isOpen
                ? '<span class="material-symbols-outlined" style="font-size:14px;">edit</span> Editar'
                : '<span class="material-symbols-outlined" style="font-size:14px;">close</span> Cancelar';
        }
    }

    function verDetalle(id, fecha, total, estado, conekta, dir, ciudad, nombre, tel) {
        document.getElementById('modalSubtitle').textContent = 'Pedido #' + id + ' · ' + fecha;
        document.getElementById('modalConekta').textContent = conekta || '—';
        document.getElementById('modalTotal').textContent = '$' + total + ' MXN';
        document.getElementById('modalNombre').textContent = nombre || '';
        document.getElementById('modalDireccion').textContent = (dir || '') + (ciudad ? ', ' + ciudad : '');
        document.getElementById('modalTelefono').textContent = 'Tel: ' + (tel || '—');
        renderTimeline(estado);
        cargarProductos(id);
        document.getElementById('modalPedido').classList.add('open');
        document.body.style.overflow = 'hidden';
    }

    function cerrarModal() {
        document.getElementById('modalPedido').classList.remove('open');
        document.body.style.overflow = '';
    }

    function renderTimeline(estado) {

        var pasos = [
            { key: 'confirmado', icon: 'check_circle', label: 'Confirmado', sub: 'Pago procesado' },
            { key: 'preparando', icon: 'inventory_2', label: 'Preparando', sub: 'Preparando tu pedido' },
            { key: 'enviado', icon: 'local_shipping', label: 'En camino', sub: 'Pedido enviado' },
            { key: 'entregado', icon: 'home', label: 'Entregado', sub: 'Pedido recibido' }
        ];

        var orden = ['pendiente', 'confirmado', 'preparando', 'enviado', 'entregado'];

        var est = (estado || 'pendiente').toLowerCase();
        var idx = orden.indexOf(est);

        if (idx < 0) idx = 0;

        var html = '';

        pasos.forEach(function (paso) {

            var pasoIdx = orden.indexOf(paso.key);

            var cls = 'pending';
            if (pasoIdx < idx) cls = 'done';
            else if (pasoIdx === idx) cls = 'active';

            var iconColor = cls === 'pending' ? '#9ca3af' : '#fff';

            html += `
        <div class="tl-item">
            <div class="tl-dot ${cls}">
                <span class="material-symbols-outlined" style="font-size:18px;color:${iconColor};">
                    ${paso.icon}
                </span>
            </div>
            <div class="tl-title">${paso.label}</div>
            <div class="tl-sub">${paso.sub}</div>
        </div>
        `;
        });

        document.getElementById('modalTimeline').innerHTML = html;
    }

    function cargarProductos(idPedido) {
        document.getElementById('modalProductos').innerHTML =
            '<p style="text-align:center; padding:20px; color:#9ca3af; font-size:.8125rem;">Cargando productos...</p>';
        fetch('GetDetallesPedido.ashx?id=' + idPedido)
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (!data || data.length === 0) {
                    document.getElementById('modalProductos').innerHTML =
                        '<p style="text-align:center; padding:20px; color:#9ca3af; font-size:.8125rem;">Sin productos registrados.</p>';
                    return;
                }
                var html = '';
                data.forEach(function (item) {
                    html += '<div style="display:flex; gap:12px; padding:12px 14px; border-bottom:1px solid #f9fafb;">' +
                        '<img src="' + (item.ImagenUrl || '') + '" style="width:52px; height:52px; border-radius:10px; object-fit:cover; border:1px solid #f3f4f6; flex-shrink:0;" />' +
                        '<div style="flex:1; min-width:0;">' +
                        '<p style="font-size:.875rem; font-weight:700; color:#111827; margin:0 0 2px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">' + item.NombreProducto + '</p>' +
                        '<p style="font-size:.75rem; color:#9ca3af; margin:0 0 4px;">Color: ' + (item.Color || '—') + ' &nbsp;&middot;&nbsp; Cant: ' + item.Cantidad + '</p>' +
                        '<p style="font-size:.875rem; font-weight:700; color:#111827; margin:0;">$' + parseFloat(item.Subtotal).toFixed(2) + '</p>' +
                        '</div></div>';
                });
                document.getElementById('modalProductos').innerHTML = html;
            })
            .catch(function () {
                document.getElementById('modalProductos').innerHTML =
                    '<p style="text-align:center; padding:20px; color:#9ca3af; font-size:.8125rem;">No se pudieron cargar los productos.</p>';
            });
    }

    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') cerrarModal(); });
</script>
</body>
</html>
