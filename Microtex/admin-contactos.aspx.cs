using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Microtex
{
    public partial class AdminContactos : Page
    {
        private const string ADMIN_EMAIL = "microtexmexicohidalgo@gmail.com";

        protected void Page_Load(object sender, EventArgs e)
        {
            string usuario = Session["usuario"]?.ToString() ?? "";
            if (usuario != ADMIN_EMAIL) { Response.Redirect("login.aspx"); return; }
            if (!IsPostBack) CargarContactos();
        }

        private void CargarContactos()
        {
            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
            try
            {
                using (var conn = new SqlConnection(conexion))
                {
                    conn.Open();
                    var cmd = new SqlCommand(@"
                        SELECT IdContacto, Nombre, Email, TipoConsulta, Detalle, FechaEnvio, Leido
                        FROM Contactos ORDER BY FechaEnvio DESC", conn);

                    var lista = new List<object>();
                    int total = 0, noLeidos = 0, cotizaciones = 0, consultas = 0;

                    using (var r = cmd.ExecuteReader())
                    {
                        while (r.Read())
                        {
                            string tipo = r["TipoConsulta"].ToString();
                            bool leido = Convert.ToBoolean(r["Leido"]);
                            total++;
                            if (!leido) noLeidos++;
                            if (tipo == "Solicitar Cotización") cotizaciones++;
                            if (tipo == "Consulta de Producto") consultas++;

                            lista.Add(new
                            {
                                IdContacto = r["IdContacto"],
                                Nombre = r["Nombre"].ToString(),
                                Email = r["Email"].ToString(),
                                TipoConsulta = tipo,
                                Detalle = r["Detalle"].ToString(),
                                FechaEnvio = Convert.ToDateTime(r["FechaEnvio"]),
                                Leido = leido
                            });
                        }
                    }

                    lblTotal.Text = total.ToString();
                    lblNoLeidos.Text = noLeidos.ToString();
                    lblCotizaciones.Text = cotizaciones.ToString();
                    lblConsultas.Text = consultas.ToString();

                    rptContactos.DataSource = lista;
                    rptContactos.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = $"Error al cargar: {ex.Message}";
                lblMsg.CssClass = "alert alert-err";
                lblMsg.Visible = true;
            }
        }

        protected void rptContactos_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item &&
                e.Item.ItemType != ListItemType.AlternatingItem) return;

            dynamic item = e.Item.DataItem;

            // Badge tipo
            var lblTipo = (Label)e.Item.FindControl("lblTipo");
            if (lblTipo != null)
            {
                switch (item.TipoConsulta?.ToString())
                {
                    case "Solicitar Cotización":
                        lblTipo.Text = "Cotización"; lblTipo.CssClass = "badge badge-quote"; break;
                    case "Soporte Técnico":
                        lblTipo.Text = "Soporte"; lblTipo.CssClass = "badge badge-support"; break;
                    default:
                        lblTipo.Text = "Consulta"; lblTipo.CssClass = "badge badge-prod"; break;
                }
            }

            // Badge leído
            var lblLeido = (Label)e.Item.FindControl("lblLeido");
            if (lblLeido != null)
            {
                bool leido = (bool)item.Leido;
                lblLeido.Text = leido ? "Leído" : "Nuevo";
                lblLeido.CssClass = leido ? "badge badge-read" : "badge badge-new";
            }

            // ✅ Botón Ver como <button type="button"> HTML puro via Literal
            // Pasa parámetros directo a verDetalle() — igual que admin-pedidos.aspx
            var litBtnVer = (Literal)e.Item.FindControl("litBtnVer");
            if (litBtnVer != null)
            {
                string id = item.IdContacto?.ToString() ?? "";
                string nombre = (item.Nombre?.ToString() ?? "").Replace(@"\", @"\\").Replace("'", @"\'");
                string email = (item.Email?.ToString() ?? "").Replace(@"\", @"\\").Replace("'", @"\'");
                string tipo = (item.TipoConsulta?.ToString() ?? "").Replace(@"\", @"\\").Replace("'", @"\'");
                string fecha = ((DateTime)item.FechaEnvio).ToString("dd/MM/yyyy HH:mm");
                string detalle = (item.Detalle?.ToString() ?? "")
                                    .Replace(@"\", @"\\")
                                    .Replace("'", @"\'")
                                    .Replace("\r\n", @"\n")
                                    .Replace("\n", @"\n");

                litBtnVer.Text =
                    $"<button type=\"button\" class=\"btn-ver\" " +
                    $"onclick=\"verDetalle('{id}','{nombre}','{email}','{tipo}','{fecha}','{detalle}')\">" +
                    "<span class=\"material-symbols-outlined\" style=\"font-size:14px;\">visibility</span> Ver" +
                    "</button>";
            }
        }

        protected void btnMarcarLeido_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            string id = btn.CommandArgument;

            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
            try
            {
                using (var conn = new SqlConnection(conexion))
                {
                    conn.Open();
                    var cmd = new SqlCommand("UPDATE Contactos SET Leido=1 WHERE IdContacto=@Id", conn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.ExecuteNonQuery();
                }

                Page.ClientScript.RegisterStartupScript(GetType(), "toast",
                    $"showToast('Mensaje #{id} marcado como leído', 'ok');", true);

                CargarContactos();
            }
            catch (Exception ex)
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "toast",
                    $"showToast('Error: {ex.Message.Replace("'", @"\'")}', 'err');", true);
            }
        }
    }
}
