using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Microtex
{
    public partial class AdminPedidos : Page
    {
        private const string ADMIN_EMAIL = "microtexmexicohidalgo@gmail.com";

        private static readonly string[] ESTADOS = {
            "Pendiente", "Confirmado", "Preparando", "Enviado", "Entregado", "Cancelado"
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            string usuario = Session["usuario"]?.ToString() ?? "";
            if (usuario != ADMIN_EMAIL) { Response.Redirect("login.aspx"); return; }
            if (!IsPostBack) CargarPedidos();
        }

        private void CargarPedidos()
        {
            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
            try
            {
                using (var conn = new SqlConnection(conexion))
                {
                    conn.Open();
                    string query = @"
                        SELECT p.IdPedido, p.FechaPedido, p.Estado, p.Total,
                               p.ConektaOrder, p.Nombre, p.Email, p.Telefono,
                               p.Direccion, p.Ciudad, p.CodigoPostal,
                               COUNT(d.IdDetalle) AS NumProductos
                        FROM Pedidos p
                        LEFT JOIN DetallesPedido d ON d.IdPedido = p.IdPedido
                        GROUP BY p.IdPedido, p.FechaPedido, p.Estado, p.Total,
                                 p.ConektaOrder, p.Nombre, p.Email, p.Telefono,
                                 p.Direccion, p.Ciudad, p.CodigoPostal
                        ORDER BY p.FechaPedido DESC";

                    var cmd = new SqlCommand(query, conn);
                    var pedidos = new List<object>();
                    int total = 0, pendientes = 0, enviados = 0, entregados = 0;
                    decimal totalVendido = 0;

                    using (var r = cmd.ExecuteReader())
                    {
                        while (r.Read())
                        {
                            string estado = r["Estado"].ToString();
                            decimal monto = Convert.ToDecimal(r["Total"]);
                            total++;
                            totalVendido += monto;
                            if (estado == "Pendiente") pendientes++;
                            if (estado == "Enviado") enviados++;
                            if (estado == "Entregado") entregados++;

                            pedidos.Add(new
                            {
                                IdPedido = r["IdPedido"],
                                FechaPedido = Convert.ToDateTime(r["FechaPedido"]),
                                Estado = estado,
                                Total = monto,
                                ConektaOrder = r["ConektaOrder"].ToString(),
                                Nombre = r["Nombre"].ToString(),
                                Email = r["Email"].ToString(),
                                Telefono = r["Telefono"].ToString(),
                                Direccion = r["Direccion"].ToString(),
                                Ciudad = r["Ciudad"].ToString(),
                                CodigoPostal = r["CodigoPostal"].ToString(),
                                NumProductos = r["NumProductos"]
                            });
                        }
                    }

                    lblTotalPedidos.Text = total.ToString();
                    lblPendientes.Text = pendientes.ToString();
                    lblEnviados.Text = enviados.ToString();
                    lblEntregados.Text = entregados.ToString();
                    lblTotalVendido.Text = $"${totalVendido:N2}";
                    rptPedidos.DataSource = pedidos;
                    rptPedidos.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = $"Error al cargar pedidos: {ex.Message}";
                lblMsg.CssClass = "alert alert-err";
                lblMsg.Visible = true;
            }
        }

        protected void rptPedidos_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item &&
                e.Item.ItemType != ListItemType.AlternatingItem) return;

            dynamic item = e.Item.DataItem;
            string estado = item.Estado?.ToString() ?? "";

            var lbl = (Label)e.Item.FindControl("lblEstado");
            if (lbl != null)
            {
                switch (estado.ToLower())
                {
                    case "entregado": lbl.Text = "Entregado"; lbl.CssClass = "badge badge-ok"; break;
                    case "enviado": lbl.Text = "Enviado"; lbl.CssClass = "badge badge-env"; break;
                    case "preparando": lbl.Text = "Preparando"; lbl.CssClass = "badge badge-prep"; break;
                    case "confirmado": lbl.Text = "Confirmado"; lbl.CssClass = "badge badge-prep"; break;
                    case "cancelado": lbl.Text = "Cancelado"; lbl.CssClass = "badge badge-bad"; break;
                    default: lbl.Text = "Pendiente"; lbl.CssClass = "badge badge-pend"; break;
                }
            }

            var ddl = (DropDownList)e.Item.FindControl("ddlEstado");
            if (ddl != null)
            {
                ddl.Items.Clear();
                foreach (string s in ESTADOS)
                    ddl.Items.Add(new ListItem(s, s));
                var match = ddl.Items.FindByValue(estado);
                if (match != null) match.Selected = true;
                ddl.Attributes["data-id"] = item.IdPedido.ToString();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            string idPedido = btn.CommandArgument;

            var item = (RepeaterItem)btn.NamingContainer;
            var ddl = (DropDownList)item.FindControl("ddlEstado");
            if (ddl == null) return;

            string nuevoEstado = ddl.SelectedValue;

            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
            try
            {
                using (var conn = new SqlConnection(conexion))
                {
                    conn.Open();
                    var cmd = new SqlCommand(
                        "UPDATE Pedidos SET Estado=@Estado WHERE IdPedido=@Id", conn);
                    cmd.Parameters.AddWithValue("@Estado", nuevoEstado);
                    cmd.Parameters.AddWithValue("@Id", idPedido);
                    cmd.ExecuteNonQuery();
                }

                // ✅ Toast notification en lugar de label feo
                string script = $"showToast('Pedido #{idPedido} actualizado a {nuevoEstado}', 'ok');";
                ScriptManager.RegisterStartupScript(this, GetType(), "toast", script, true);

                CargarPedidos();
            }
            catch (Exception ex)
            {
                string script = $"showToast('Error: {ex.Message.Replace("'", "\\'")}', 'err');";
                ScriptManager.RegisterStartupScript(this, GetType(), "toast", script, true);
            }
        }
    }
}
