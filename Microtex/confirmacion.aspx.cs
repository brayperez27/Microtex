using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

namespace Microtex
{
    public partial class confirmacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Navbar
                if (Session["usuarioNombre"] != null)
                {
                    string nombre = Session["usuarioNombre"].ToString();
                    string inicial = nombre.Length > 0 ? nombre.Substring(0, 1).ToUpper() : "U";
                    litNavUser.Text = $@"
                        <a href=""perfil.aspx""
                           class=""w-9 h-9 flex items-center justify-center rounded-full bg-slate-900 text-white font-black text-sm""
                           title=""{nombre}"">
                            {inicial}
                        </a>";
                }
                else
                {
                    litNavUser.Text = @"
                        <a href=""login.aspx""
                           class=""w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100"">
                            <span class=""material-symbols-outlined text-xl"">person</span>
                        </a>";
                }

                string orderId = Request.QueryString["order"] ?? "";
                lblOrderId.Text = string.IsNullOrEmpty(orderId) ? "—" : orderId;

                var items = Session["Carrito"] as List<CartItem> ?? new List<CartItem>();

                if (items.Count > 0)
                {
                    // ✅ Guardar pedido en BD
                    GuardarPedido(orderId, items);

                    // Renderizar resumen
                    decimal subtotal = 0;
                    var sb = new StringBuilder();
                    foreach (var item in items)
                    {
                        decimal sub = item.Price * item.Qty;
                        subtotal += sub;
                        sb.Append($@"
                        <div class='flex gap-4 p-4'>
                            <img src='{item.ImageUrl}' alt='{System.Web.HttpUtility.HtmlAttributeEncode(item.Name)}'
                                 class='w-14 h-14 rounded-xl object-cover border border-slate-100 shrink-0' />
                            <div class='flex flex-col justify-between flex-1 min-w-0'>
                                <p class='text-sm font-bold text-slate-900 truncate'>{System.Web.HttpUtility.HtmlEncode(item.Name)}</p>
                                <p class='text-xs text-slate-400'>Color: {System.Web.HttpUtility.HtmlEncode(item.Color)} · Cant: {item.Qty}</p>
                                <p class='text-sm font-bold text-slate-900'>${sub:0.00}</p>
                            </div>
                        </div>");
                    }
                    litItems.Text = sb.ToString();

                    decimal tax = subtotal * 0.16m;
                    decimal total = subtotal + tax;
                    litTotal.Text = $"${total:0.00} MXN";

                    // Limpiar carrito
                    Session["Carrito"] = null;
                }
                else
                {
                    litItems.Text = "<div class='p-4 text-sm text-slate-400 text-center'>Resumen no disponible</div>";
                }
            }
        }

        private void GuardarPedido(string conektaOrderId, List<CartItem> items)
        {
            string usuarioId = Session["usuarioId"]?.ToString();
            if (string.IsNullOrEmpty(usuarioId)) return;

            decimal subtotal = 0;
            foreach (var item in items) subtotal += item.Price * item.Qty;
            decimal total = subtotal * 1.16m;

            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
            try
            {
                using (var conn = new SqlConnection(conexion))
                {
                    conn.Open();

                    // ── Insertar pedido ──
                    var cmdPedido = new SqlCommand(@"
                        INSERT INTO Pedidos
                            (IdUsuario, ConektaOrder, Estado, Total, Nombre, Email, Telefono, Direccion, Ciudad, CodigoPostal)
                        VALUES
                            (@IdUsuario, @ConektaOrder, 'Pendiente', @Total, @Nombre, @Email, @Telefono, @Direccion, @Ciudad, @CP);
                        SELECT SCOPE_IDENTITY();", conn);

                    cmdPedido.Parameters.AddWithValue("@IdUsuario", usuarioId);
                    cmdPedido.Parameters.AddWithValue("@ConektaOrder", conektaOrderId ?? "");
                    cmdPedido.Parameters.AddWithValue("@Total", total);
                    cmdPedido.Parameters.AddWithValue("@Nombre", Session["usuarioNombre"]?.ToString() ?? "");
                    cmdPedido.Parameters.AddWithValue("@Email", Session["usuario"]?.ToString() ?? "");
                    cmdPedido.Parameters.AddWithValue("@Telefono", Session["PagoTelefono"]?.ToString() ?? "");
                    cmdPedido.Parameters.AddWithValue("@Direccion", Session["PagoDireccion"]?.ToString() ?? "");
                    cmdPedido.Parameters.AddWithValue("@Ciudad", Session["PagoCiudad"]?.ToString() ?? "");
                    cmdPedido.Parameters.AddWithValue("@CP", Session["PagoCP"]?.ToString() ?? "");

                    int idPedido = Convert.ToInt32(cmdPedido.ExecuteScalar());

                    // ── Insertar detalles ──
                    foreach (var item in items)
                    {
                        var cmdDet = new SqlCommand(@"
                            INSERT INTO DetallesPedido
                                (IdPedido, NombreProducto, Color, Cantidad, PrecioUnit, Subtotal, ImagenUrl)
                            VALUES
                                (@IdPedido, @Nombre, @Color, @Qty, @Precio, @Sub, @Img)", conn);

                        cmdDet.Parameters.AddWithValue("@IdPedido", idPedido);
                        cmdDet.Parameters.AddWithValue("@Nombre", item.Name);
                        cmdDet.Parameters.AddWithValue("@Color", item.Color ?? "");
                        cmdDet.Parameters.AddWithValue("@Qty", item.Qty);
                        cmdDet.Parameters.AddWithValue("@Precio", item.Price);
                        cmdDet.Parameters.AddWithValue("@Sub", item.Price * item.Qty);
                        cmdDet.Parameters.AddWithValue("@Img", item.ImageUrl ?? "");
                        cmdDet.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Log silencioso — no romper la pantalla de confirmacion
                System.Diagnostics.Debug.WriteLine("Error guardando pedido: " + ex.Message);
            }
        }
    }
}