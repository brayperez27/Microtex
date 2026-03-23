using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Net.Http;
using System.Text;
using System.Web.Configuration;
using Newtonsoft.Json;

namespace Microtex
{
    public partial class pago : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadPage();
        }

        private void LoadPage()
        {
            if (Session["usuarioNombre"] != null)
            {
                string nombre = Session["usuarioNombre"].ToString();
                string inicial = nombre.Length > 0 ? nombre.Substring(0, 1).ToUpper() : "U";
                litNavUser.Text = $@"
                    <a href=""perfil.aspx""
                       class=""w-9 h-9 flex items-center justify-center rounded-full bg-slate-900 text-white font-black text-sm transition-colors hover:bg-slate-700""
                       title=""{nombre}"">
                        {inicial}
                    </a>";
            }
            else
            {
                litNavUser.Text = @"
                    <a href=""login.aspx""
                       class=""w-9 h-9 flex items-center justify-center rounded-full text-slate-500 hover:text-slate-900 hover:bg-slate-100 transition-colors"">
                        <span class=""material-symbols-outlined text-xl"">person</span>
                    </a>";
            }

            RenderResumen();
            PreLlenarDireccion(); // ✅ pre-llenar con dirección guardada
        }

        // ✅ Pre-llenar campos con la dirección guardada del usuario
        private void PreLlenarDireccion()
        {
            string usuarioId = Session["usuarioId"]?.ToString();
            if (string.IsNullOrEmpty(usuarioId)) return;

            string conexion = WebConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
            try
            {
                using (var conn = new SqlConnection(conexion))
                {
                    conn.Open();
                    var cmd = new SqlCommand(
                        "SELECT Nombre, Telefono, Calle, Ciudad, CodigoPostal, Referencia FROM Usuarios WHERE IdUsuario=@Id", conn);
                    cmd.Parameters.AddWithValue("@Id", usuarioId);

                    using (var r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            string nombre = r["Nombre"]?.ToString() ?? "";
                            string tel = r["Telefono"]?.ToString() ?? "";
                            string calle = r["Calle"]?.ToString() ?? "";
                            string ciudad = r["Ciudad"]?.ToString() ?? "";
                            string cp = r["CodigoPostal"]?.ToString() ?? "";
                            string referen = r["Referencia"]?.ToString() ?? "";

                            if (!string.IsNullOrEmpty(nombre)) txtNombre.Text = nombre;
                            if (!string.IsNullOrEmpty(tel)) txtTelefono.Text = tel;
                            if (!string.IsNullOrEmpty(calle)) txtDireccion.Text = calle;
                            if (!string.IsNullOrEmpty(ciudad)) txtCiudad.Text = ciudad;
                            if (!string.IsNullOrEmpty(cp)) txtCP.Text = cp;
                            if (!string.IsNullOrEmpty(referen)) txtReferencia.Text = referen;
                        }
                    }
                }
            }
            catch { /* Si columnas no existen aun, simplemente no pre-llena */ }

            // Email siempre desde session
            if (string.IsNullOrEmpty(txtEmail.Text))
                txtEmail.Text = Session["usuario"]?.ToString() ?? "";
        }

        private void RenderResumen()
        {
            var items = Session["Carrito"] as List<CartItem> ?? new List<CartItem>();
            if (items.Count == 0) { Response.Redirect("carrito.aspx"); return; }

            int totalItems = 0;
            decimal subtotal = 0;
            var sb = new StringBuilder();

            foreach (var item in items)
            {
                decimal sub = item.Price * item.Qty;
                subtotal += sub;
                totalItems += item.Qty;
                sb.Append($@"
                <div class='flex gap-4 py-4 first:pt-0'>
                    <img src='{item.ImageUrl}' alt='{System.Web.HttpUtility.HtmlAttributeEncode(item.Name)}'
                         class='w-16 h-16 rounded-xl object-cover border border-slate-100 shrink-0' />
                    <div class='flex flex-col justify-between flex-1 min-w-0'>
                        <div>
                            <p class='text-sm font-bold text-slate-900 truncate'>{System.Web.HttpUtility.HtmlEncode(item.Name)}</p>
                            <p class='text-xs text-slate-400 mt-0.5'>Color: {System.Web.HttpUtility.HtmlEncode(item.Color)}</p>
                        </div>
                        <div class='flex items-center justify-between mt-1'>
                            <span class='text-xs text-slate-400'>Cant: {item.Qty}</span>
                            <span class='text-sm font-bold text-slate-900'>${sub:0.00}</span>
                        </div>
                    </div>
                </div>");
            }

            litResumenItems.Text = sb.ToString();
            decimal tax = subtotal * 0.16m;
            decimal total = subtotal + tax;
            litSubtotal.Text = $"${subtotal:0.00}";
            litTax.Text = $"${tax:0.00}";
            litTotal.Text = $"${total:0.00}";
            litItemCount.Text = $"{totalItems} artículo{(totalItems != 1 ? "s" : "")}";
            litCartBadge.Text = totalItems.ToString();
            Session["TotalPago"] = (long)(total * 100);
        }

        protected void btnIrPago_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNombre.Text) ||
                string.IsNullOrWhiteSpace(txtDireccion.Text) ||
                string.IsNullOrWhiteSpace(txtCiudad.Text) ||
                string.IsNullOrWhiteSpace(txtTelefono.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                lblErrorEnvio.Text = "Por favor completa todos los campos obligatorios.";
                lblErrorEnvio.Visible = true;
                return;
            }
            lblErrorEnvio.Visible = false;

            Session["PagoNombre"] = txtNombre.Text.Trim();
            Session["PagoDireccion"] = txtDireccion.Text.Trim();
            Session["PagoCiudad"] = txtCiudad.Text.Trim();
            Session["PagoCP"] = txtCP.Text.Trim();
            Session["PagoTelefono"] = txtTelefono.Text.Trim();
            Session["PagoEmail"] = txtEmail.Text.Trim();

            try
            {
                string errorDetalle = "";
                string checkoutRequestId = CrearOrdenConekta(out errorDetalle);

                if (!string.IsNullOrEmpty(checkoutRequestId))
                {
                    hfConektaCheckoutId.Value = checkoutRequestId;
                }
                else
                {
                    lblErrorPago.Text = $"Error Conekta: {errorDetalle}";
                    lblErrorPago.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblErrorPago.Text = $"Excepcion: {ex.Message}";
                lblErrorPago.Visible = true;
            }
        }

        private string CrearOrdenConekta(out string errorDetalle)
        {
            errorDetalle = "";
            string privateKey = WebConfigurationManager.AppSettings["ConektaPrivateKey"];
            if (string.IsNullOrEmpty(privateKey)) { errorDetalle = "ConektaPrivateKey no encontrada."; return null; }

            var items = Session["Carrito"] as List<CartItem> ?? new List<CartItem>();
            var lineItems = new List<object>();
            foreach (var item in items)
                lineItems.Add(new { name = item.Name, quantity = item.Qty, unit_price = (long)(item.Price * 100) });

            // ✅ Agregar IVA como line_item para que Conekta muestre el total correcto
            decimal subtotalCalc = 0;
            foreach (var item in items) subtotalCalc += item.Price * item.Qty;
            long ivaAmount = (long)(subtotalCalc * 0.16m * 100);
            lineItems.Add(new { name = "IVA (16%)", quantity = 1, unit_price = ivaAmount });

            string telefono = txtTelefono.Text.Trim()
                .Replace(" ", "").Replace("-", "").Replace("(", "").Replace(")", "");
            if (!telefono.StartsWith("+"))
                telefono = "+52" + telefono.TrimStart('0');

            var payload = new
            {
                currency = "MXN",
                customer_info = new { name = txtNombre.Text.Trim(), email = txtEmail.Text.Trim(), phone = telefono },
                line_items = lineItems,
                checkout = new
                {
                    type = "Integration",
                    allowed_payment_methods = new[] { "card", "cash", "bank_transfer" },
                    success_url = $"{Request.Url.Scheme}://{Request.Url.Host}/confirmacion.aspx",
                    failure_url = $"{Request.Url.Scheme}://{Request.Url.Host}/pago.aspx?error=1",
                    on_demand_enabled = false,
                    recurrent = false
                },
                shipping_contact = new
                {
                    address = new { street1 = txtDireccion.Text.Trim(), city = txtCiudad.Text.Trim(), postal_code = txtCP.Text.Trim(), country = "MX", state = "Hidalgo" },
                    phone = telefono,
                    receiver = txtNombre.Text.Trim()
                }
            };

            string json = JsonConvert.SerializeObject(payload, Formatting.None);
            try
            {
                using (var client = new HttpClient())
                {
                    client.Timeout = TimeSpan.FromSeconds(30);
                    string creds = Convert.ToBase64String(Encoding.ASCII.GetBytes(privateKey + ":"));
                    client.DefaultRequestHeaders.Clear();
                    client.DefaultRequestHeaders.Add("Authorization", "Basic " + creds);
                    client.DefaultRequestHeaders.Add("Accept", "application/vnd.conekta-v2.2.0+json");
                    client.DefaultRequestHeaders.Add("Accept-Language", "es");

                    var content = new StringContent(json, Encoding.UTF8, "application/json");
                    var response = client.PostAsync("https://api.conekta.io/orders", content).Result;
                    var body = response.Content.ReadAsStringAsync().Result;

                    if (response.IsSuccessStatusCode)
                    {
                        dynamic result = JsonConvert.DeserializeObject(body);
                        string orderId = result?.id ?? "";
                        string checkoutReqId = result?.checkout?.id ?? "";
                        Session["ConektaOrderId"] = orderId;
                        if (string.IsNullOrEmpty(checkoutReqId)) { errorDetalle = $"checkout.id vacio. Body: {body}"; return null; }
                        return checkoutReqId;
                    }
                    else { errorDetalle = $"HTTP {(int)response.StatusCode} - {body}"; return null; }
                }
            }
            catch (Exception ex) { errorDetalle = $"HttpClient: {ex.Message}"; return null; }
        }
    }
}