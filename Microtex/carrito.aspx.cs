using System;
using System.Collections.Generic;

namespace Microtex
{
    public class CartItem
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ImageUrl { get; set; }
        public decimal Price { get; set; }
        public int Qty { get; set; }
        public string Color { get; set; }
    }

    public partial class carrito : System.Web.UI.Page
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

            RenderCart();
        }

        private void RenderCart()
        {
            var items = Session["Carrito"] as List<CartItem> ?? new List<CartItem>();

            int totalItems = 0;
            foreach (var i in items) totalItems += i.Qty;
            litCartBadge.Text = totalItems.ToString();

            if (items.Count == 0)
            {
                litCartRows.Text = "";
                litEmptyState.Text = @"
                    <div style='display:flex;' class='flex-col items-center justify-center py-20 text-center'>
                        <span class='material-symbols-outlined text-6xl text-slate-200 mb-4'>shopping_bag</span>
                        <h2 class='text-xl font-bold text-slate-700 mb-2'>Tu carrito está vacío</h2>
                        <p class='text-slate-400 text-sm mb-6'>Agrega productos desde nuestro catálogo.</p>
                        <a href='productos.aspx'
                           class='inline-flex items-center gap-2 bg-slate-900 text-white text-sm font-bold px-6 py-3 rounded-xl hover:bg-black transition-colors'>
                            <span class='material-symbols-outlined text-base'>storefront</span>
                            Ver Catálogo
                        </a>
                    </div>";
                litSubtotal.Text = "$0.00";
                litTax.Text = "$0.00";
                litTotal.Text = "$0.00";
                litItemCount.Text = "0 artículos";
                return;
            }

            litEmptyState.Text = "";

            decimal subtotal = 0;
            var sb = new System.Text.StringBuilder();

            foreach (var item in items)
            {
                decimal sub = item.Price * item.Qty;
                subtotal += sub;

                sb.Append($@"
                <tr class='cart-row group hover:bg-slate-50 transition-colors'
                    data-id='{item.Id}'
                    data-color='{System.Web.HttpUtility.HtmlAttributeEncode(item.Color)}'
                    data-price='{item.Price.ToString("0.00", System.Globalization.CultureInfo.InvariantCulture)}'>
                    <td class='px-4 sm:px-6 py-4 sm:py-5'>
                        <div class='flex items-center gap-3 sm:gap-4'>
                            <img src='{item.ImageUrl}'
                                 alt='{System.Web.HttpUtility.HtmlAttributeEncode(item.Name)}'
                                 class='h-14 w-14 sm:h-20 sm:w-20 flex-shrink-0 rounded-lg border border-slate-100 object-cover' />
                            <div class='min-w-0'>
                                <p class='text-slate-900 font-bold text-sm truncate'>{System.Web.HttpUtility.HtmlEncode(item.Name)}</p>
                                <p class='text-slate-400 text-xs mt-0.5'>Color: {System.Web.HttpUtility.HtmlEncode(item.Color)}</p>
                                <p class='text-slate-700 font-semibold text-sm mt-1 sm:hidden'>${item.Price:0.00}</p>
                            </div>
                        </div>
                    </td>
                    <td class='col-precio px-4 sm:px-6 py-4 sm:py-5 text-slate-700 text-sm font-medium'>${item.Price:0.00}</td>
                    <td class='px-4 sm:px-6 py-4 sm:py-5'>
                        <div class='flex items-center border border-slate-200 rounded-lg w-fit overflow-hidden'>
                            <button type='button' onclick='changeQty(this,-1)'
                                class='px-2 py-1.5 hover:bg-slate-100 transition-colors flex items-center'>
                                <span class='material-symbols-outlined text-sm'>remove</span>
                            </button>
                            <span class='qty-value px-3 py-1.5 text-sm font-bold border-x border-slate-200 min-w-[2rem] text-center'>{item.Qty}</span>
                            <button type='button' onclick='changeQty(this,1)'
                                class='px-2 py-1.5 hover:bg-slate-100 transition-colors flex items-center'>
                                <span class='material-symbols-outlined text-sm'>add</span>
                            </button>
                        </div>
                    </td>
                    <td class='col-subtotal px-4 sm:px-6 py-4 sm:py-5 text-slate-900 text-sm font-bold subtotal-cell'>${sub:0.00}</td>
                    <td class='px-4 sm:px-6 py-4 sm:py-5 text-right'>
                        <button type='button' onclick='removeItem(this)'
                            class='text-slate-400 hover:text-red-500 transition-colors p-1.5 sm:p-2 rounded-lg hover:bg-red-50'>
                            <span class='material-symbols-outlined text-lg sm:text-xl'>delete</span>
                        </button>
                    </td>
                </tr>");
            }

            litCartRows.Text = sb.ToString();

            decimal tax = subtotal * 0.16m;
            decimal total = subtotal + tax;

            litSubtotal.Text = $"${subtotal:0.00}";
            litTax.Text = $"${tax:0.00}";
            litTotal.Text = $"${total:0.00}";
            litItemCount.Text = $"{totalItems} artículo{(totalItems != 1 ? "s" : "")}";
        }

        protected void btnAplicarCupon_Click(object sender, EventArgs e)
        {
            string cupon = txtCupon.Text.Trim().ToUpper();
            switch (cupon)
            {
                case "MICROTEX10":
                    lblDescuento.Text = "<span>Descuento (10%)</span><span class='text-green-600 font-bold ml-auto'>-10%</span>";
                    lblDescuento.Visible = true; break;
                case "MICROTEX20":
                    lblDescuento.Text = "<span>Descuento (20%)</span><span class='text-green-600 font-bold ml-auto'>-20%</span>";
                    lblDescuento.Visible = true; break;
                default:
                    lblDescuento.Text = "<span class='text-red-500'>Cupón no válido.</span>";
                    lblDescuento.Visible = true; break;
            }
        }

        protected void btnProcederPago_Click(object sender, EventArgs e)
            => Response.Redirect("pago.aspx");

        protected void btnGetQuote_Click(object sender, EventArgs e)
            => Response.Redirect("~/Default.aspx#contacto");
    }
}