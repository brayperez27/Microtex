using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Microtex
{
    public partial class perfil : Page
    {
        private const string ADMIN_EMAIL = "microtexmexicohidalgo@gmail.com";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
                Response.Redirect("login.aspx");

            lblCopyright.Text = $"© {DateTime.Now.Year} Microtex. Todos los derechos reservados.";

            if (!IsPostBack)
            {
                CargarPerfil();
                CargarPedidos();
                CargarDireccion();
            }
        }

        private void CargarPerfil()
        {
            string nombre = Session["usuarioNombre"]?.ToString() ?? "Usuario";
            string email = Session["usuario"]?.ToString() ?? "";
            string fecha = Session["usuarioFecha"]?.ToString() ?? "";
            string inicial = nombre.Length > 0 ? nombre.Substring(0, 1).ToUpper() : "U";

            lblAvatarSide.Text = inicial;
            lblNombreSide.Text = nombre;
            lblEmailSide.Text = email;
            lblAvatar.Text = inicial;
            lblNombre.Text = nombre;
            lblEmail.Text = email;
            lblNombreCompleto.Text = nombre;
            lblEmailPerfil.Text = email;
            lblFecha.Text = fecha;
            txtEditNombre.Text = nombre;
            txtEditEmail.Text = email;

            bool esAdmin = (email == ADMIN_EMAIL);

            // ✅ Navbar derecho — links admin al lado del avatar, tono beige
            if (esAdmin)
            {
                litNavUser.Text =
                    $@"<a href=""admin-pedidos.aspx""
                        style=""font-size:.75rem;font-weight:700;padding:5px 12px;border-radius:20px;background:#eceae3;color:#6f6a5d;text-decoration:none;white-space:nowrap;""
                        class=""hover:bg-d6d3c9"">Pedidos</a>
                    <a href=""admin-contactos.aspx""
                        style=""font-size:.75rem;font-weight:700;padding:5px 12px;border-radius:20px;background:#e5e2d9;color:#6f6a5d;text-decoration:none;white-space:nowrap;""
                        class=""hover:bg-d6d3c9"">Solicitudes</a>
                    <a href=""perfil.aspx""
                       class=""w-9 h-9 flex items-center justify-center rounded-full bg-slate-900 text-white font-black text-sm transition-colors hover:bg-slate-700""
                       title=""{nombre}"">
                        {inicial}
                    </a>";
            }
            else
            {
                litNavUser.Text = $@"
                    <a href=""perfil.aspx""
                       class=""w-9 h-9 flex items-center justify-center rounded-full bg-slate-900 text-white font-black text-sm transition-colors hover:bg-slate-700""
                       title=""{nombre}"">
                        {inicial}
                    </a>";
            }

            // ✅ Quitar links del nav central (ya están en el derecho)
            lnkAdmin.Visible = false;
            lnkSoli.Visible = false;
        }

        private void CargarDireccion()
        {
            string usuarioId = Session["usuarioId"]?.ToString();
            if (string.IsNullOrEmpty(usuarioId)) return;

            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
            try
            {
                using (var conn = new SqlConnection(conexion))
                {
                    conn.Open();
                    var cmd = new SqlCommand(
                        "SELECT Telefono, Calle, Ciudad, Estado, CodigoPostal, Referencia FROM Usuarios WHERE IdUsuario=@Id", conn);
                    cmd.Parameters.AddWithValue("@Id", usuarioId);

                    using (var r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            lblDirTelefono.Text = r["Telefono"]?.ToString() ?? "";
                            lblDirCalle.Text = r["Calle"]?.ToString() ?? "";
                            lblDirCiudad.Text = r["Ciudad"]?.ToString() ?? "";
                            lblDirEstado.Text = r["Estado"]?.ToString() ?? "";
                            lblDirCP.Text = r["CodigoPostal"]?.ToString() ?? "";
                            lblDirRef.Text = r["Referencia"]?.ToString() ?? "";

                            if (string.IsNullOrEmpty(lblDirTelefono.Text)) lblDirTelefono.Text = "—";
                            if (string.IsNullOrEmpty(lblDirCalle.Text)) lblDirCalle.Text = "—";
                            if (string.IsNullOrEmpty(lblDirCiudad.Text)) lblDirCiudad.Text = "—";
                            if (string.IsNullOrEmpty(lblDirEstado.Text)) lblDirEstado.Text = "—";
                            if (string.IsNullOrEmpty(lblDirCP.Text)) lblDirCP.Text = "—";
                            if (string.IsNullOrEmpty(lblDirRef.Text)) lblDirRef.Text = "—";

                            txtDirTelefono.Text = lblDirTelefono.Text == "—" ? "" : lblDirTelefono.Text;
                            txtDirCalle.Text = lblDirCalle.Text == "—" ? "" : lblDirCalle.Text;
                            txtDirCiudad.Text = lblDirCiudad.Text == "—" ? "" : lblDirCiudad.Text;
                            txtDirEstado.Text = lblDirEstado.Text == "—" ? "" : lblDirEstado.Text;
                            txtDirCP.Text = lblDirCP.Text == "—" ? "" : lblDirCP.Text;
                            txtDirRef.Text = lblDirRef.Text == "—" ? "" : lblDirRef.Text;
                        }
                    }
                }
            }
            catch { }
        }

        protected void btnGuardarDireccion_Click(object sender, EventArgs e)
        {
            string usuarioId = Session["usuarioId"]?.ToString();
            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
            try
            {
                using (var conn = new SqlConnection(conexion))
                {
                    conn.Open();
                    var cmd = new SqlCommand(@"
                        UPDATE Usuarios SET Telefono=@Tel, Calle=@Calle, Ciudad=@Ciudad,
                            Estado=@Estado, CodigoPostal=@CP, Referencia=@Ref
                        WHERE IdUsuario=@Id", conn);
                    cmd.Parameters.AddWithValue("@Tel", txtDirTelefono.Text.Trim());
                    cmd.Parameters.AddWithValue("@Calle", txtDirCalle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Ciudad", txtDirCiudad.Text.Trim());
                    cmd.Parameters.AddWithValue("@Estado", txtDirEstado.Text.Trim());
                    cmd.Parameters.AddWithValue("@CP", txtDirCP.Text.Trim());
                    cmd.Parameters.AddWithValue("@Ref", txtDirRef.Text.Trim());
                    cmd.Parameters.AddWithValue("@Id", usuarioId);
                    cmd.ExecuteNonQuery();
                }
                lblDirTelefono.Text = string.IsNullOrEmpty(txtDirTelefono.Text.Trim()) ? "—" : txtDirTelefono.Text.Trim();
                lblDirCalle.Text = string.IsNullOrEmpty(txtDirCalle.Text.Trim()) ? "—" : txtDirCalle.Text.Trim();
                lblDirCiudad.Text = string.IsNullOrEmpty(txtDirCiudad.Text.Trim()) ? "—" : txtDirCiudad.Text.Trim();
                lblDirEstado.Text = string.IsNullOrEmpty(txtDirEstado.Text.Trim()) ? "—" : txtDirEstado.Text.Trim();
                lblDirCP.Text = string.IsNullOrEmpty(txtDirCP.Text.Trim()) ? "—" : txtDirCP.Text.Trim();
                lblDirRef.Text = string.IsNullOrEmpty(txtDirRef.Text.Trim()) ? "—" : txtDirRef.Text.Trim();
                ShowMsg(lblMsgDir, "Direccion guardada correctamente.", false);
            }
            catch (Exception ex) { ShowMsg(lblMsgDir, "Error al guardar: " + ex.Message, true); }
        }

        private void CargarPedidos()
        {
            string usuarioId = Session["usuarioId"]?.ToString();
            if (string.IsNullOrEmpty(usuarioId)) { MostrarSinPedidos(); return; }

            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
            try
            {
                using (var conn = new SqlConnection(conexion))
                {
                    conn.Open();
                    string query = @"
                        SELECT p.IdPedido, p.FechaPedido, p.Estado, p.Total,
                               p.ConektaOrder, p.Direccion, p.Ciudad, p.Nombre, p.Telefono,
                               COUNT(d.IdDetalle) AS NumProductos
                        FROM Pedidos p
                        LEFT JOIN DetallesPedido d ON d.IdPedido = p.IdPedido
                        WHERE p.IdUsuario = @IdUsuario
                        GROUP BY p.IdPedido, p.FechaPedido, p.Estado, p.Total,
                                 p.ConektaOrder, p.Direccion, p.Ciudad, p.Nombre, p.Telefono
                        ORDER BY p.FechaPedido DESC";

                    var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@IdUsuario", usuarioId);

                    var pedidos = new List<object>();
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                            pedidos.Add(new
                            {
                                IdPedido = reader["IdPedido"],
                                FechaPedido = Convert.ToDateTime(reader["FechaPedido"]),
                                Estado = reader["Estado"].ToString(),
                                Total = Convert.ToDecimal(reader["Total"]),
                                NumProductos = reader["NumProductos"],
                                ConektaOrder = reader["ConektaOrder"].ToString(),
                                Direccion = reader["Direccion"].ToString(),
                                Ciudad = reader["Ciudad"].ToString(),
                                Nombre = reader["Nombre"].ToString(),
                                Telefono = reader["Telefono"].ToString()
                            });
                    }

                    if (pedidos.Count == 0) { MostrarSinPedidos(); return; }

                    panelPedidos.Visible = true;
                    panelSinPedidos.Visible = false;
                    rptPedidos.DataSource = pedidos;
                    rptPedidos.DataBind();
                }
            }
            catch { MostrarSinPedidos(); }
        }

        private void MostrarSinPedidos()
        {
            panelPedidos.Visible = false;
            panelSinPedidos.Visible = true;
        }

        protected void rptPedidos_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item &&
                e.Item.ItemType != ListItemType.AlternatingItem) return;

            dynamic item = e.Item.DataItem;
            var lbl = (Label)e.Item.FindControl("lblEstado");
            if (lbl == null) return;

            string estado = item.Estado?.ToString() ?? "";
            switch (estado.ToLower())
            {
                case "entregado": lbl.Text = "Entregado"; lbl.CssClass = "badge badge-ok"; break;
                case "enviado": lbl.Text = "Enviado"; lbl.CssClass = "badge badge-pend"; break;
                case "preparando": lbl.Text = "Preparando"; lbl.CssClass = "badge badge-pend"; break;
                case "confirmado": lbl.Text = "Confirmado"; lbl.CssClass = "badge badge-pend"; break;
                case "cancelado": lbl.Text = "Cancelado"; lbl.CssClass = "badge badge-bad"; break;
                default: lbl.Text = "Pendiente"; lbl.CssClass = "badge badge-pend"; break;
            }
        }

        protected void btnGuardarPerfil_Click(object sender, EventArgs e)
        {
            string nuevoNombre = txtEditNombre.Text.Trim();
            string nuevoEmail = txtEditEmail.Text.Trim();
            if (string.IsNullOrEmpty(nuevoNombre) || string.IsNullOrEmpty(nuevoEmail))
            { ShowMsg(lblMsgPerfil, "Todos los campos son requeridos.", true); return; }

            string usuarioId = Session["usuarioId"]?.ToString();
            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;

            using (var conn = new SqlConnection(conexion))
            {
                conn.Open();
                var chk = new SqlCommand("SELECT COUNT(*) FROM Usuarios WHERE Email=@Email AND IdUsuario<>@Id", conn);
                chk.Parameters.AddWithValue("@Email", nuevoEmail);
                chk.Parameters.AddWithValue("@Id", usuarioId);
                if ((int)chk.ExecuteScalar() > 0)
                { ShowMsg(lblMsgPerfil, "Ese correo ya esta en uso.", true); return; }

                var upd = new SqlCommand("UPDATE Usuarios SET Nombre=@Nombre, Email=@Email WHERE IdUsuario=@Id", conn);
                upd.Parameters.AddWithValue("@Nombre", nuevoNombre);
                upd.Parameters.AddWithValue("@Email", nuevoEmail);
                upd.Parameters.AddWithValue("@Id", usuarioId);
                upd.ExecuteNonQuery();
            }

            Session["usuarioNombre"] = nuevoNombre;
            Session["usuario"] = nuevoEmail;
            lblNombreCompleto.Text = nuevoNombre;
            lblEmailPerfil.Text = nuevoEmail;
            lblNombreSide.Text = nuevoNombre;
            lblEmailSide.Text = nuevoEmail;
            lblAvatarSide.Text = nuevoNombre.Substring(0, 1).ToUpper();

            string ini = nuevoNombre.Substring(0, 1).ToUpper();
            litNavUser.Text = $@"
                <a href=""perfil.aspx""
                   class=""w-9 h-9 flex items-center justify-center rounded-full bg-slate-900 text-white font-black text-sm transition-colors hover:bg-slate-700""
                   title=""{nuevoNombre}"">
                    {ini}
                </a>";

            ShowMsg(lblMsgPerfil, "Perfil actualizado correctamente.", false);
        }

        protected void btnGuardarPass_Click(object sender, EventArgs e)
        {
            string actual = txtPassActual.Text;
            string nueva = txtPassNueva.Text;
            string confirma = txtPassConfirm.Text;

            if (string.IsNullOrEmpty(actual) || string.IsNullOrEmpty(nueva))
            { ShowMsg(lblMsgPass, "Completa todos los campos.", true); return; }
            if (nueva != confirma)
            { ShowMsg(lblMsgPass, "Las contrasenas no coinciden.", true); return; }
            if (nueva.Length < 6)
            { ShowMsg(lblMsgPass, "Minimo 6 caracteres.", true); return; }

            string usuarioId = Session["usuarioId"]?.ToString();
            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;

            using (var conn = new SqlConnection(conexion))
            {
                conn.Open();
                var chk = new SqlCommand("SELECT COUNT(*) FROM Usuarios WHERE IdUsuario=@Id AND Password=@Pass", conn);
                chk.Parameters.AddWithValue("@Id", usuarioId);
                chk.Parameters.AddWithValue("@Pass", actual);
                if ((int)chk.ExecuteScalar() == 0)
                { ShowMsg(lblMsgPass, "La contrasena actual es incorrecta.", true); return; }

                var upd = new SqlCommand("UPDATE Usuarios SET Password=@NewPass WHERE IdUsuario=@Id", conn);
                upd.Parameters.AddWithValue("@NewPass", nueva);
                upd.Parameters.AddWithValue("@Id", usuarioId);
                upd.ExecuteNonQuery();
            }

            txtPassActual.Text = "";
            txtPassNueva.Text = "";
            txtPassConfirm.Text = "";
            ShowMsg(lblMsgPass, "Contrasena actualizada correctamente.", false);
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("login.aspx");
        }

        private void ShowMsg(Label lbl, string msg, bool isError)
        {
            lbl.Text = msg;
            lbl.CssClass = isError ? "alert alert-err" : "alert alert-ok";
            lbl.Visible = true;
        }
    }
}