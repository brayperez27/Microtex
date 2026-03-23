using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Microtex
{
    public partial class productos : Page
    {
        private const int PageSize = 6;
        public int CurrentPage { get; private set; } = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CurrentPage = 1;
                LoadPage();
            }
        }

        private void LoadPage()
        {
            lblCopyright.Text = $"© {DateTime.Now.Year} MicroTex. Todos los derechos reservados.";

            // ── Navbar: inicial si hay sesión ──
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

            BindProducts();
            BindPagination();
        }

        private List<ProductItem> GetAllProducts()
        {
            return new List<ProductItem>
            {
                new ProductItem { Id=1, Name="Pintura Arquitectónica",
                    Subtitle="Resinas vinílicas-acrílicas — Alta calidad y durabilidad",
                    Price=0m, Badge="Más Vendido",
                    ImageUrl="https://microtexmexico.com/wp-content/uploads/2024/08/1-1-1.png",
                    AltText="Pintura arquitectónica MicroTex" },
                new ProductItem { Id=2, Name="Producto Cementicio",
                    Subtitle="Superficies continuas sin juntas — Acabado moderno y versátil",
                    Price=0m, Badge="",
                    ImageUrl="https://microtexmexico.com/wp-content/uploads/2024/08/2-1-e1727478954221.png",
                    AltText="Producto cementicio MicroTex" },
                new ProductItem { Id=3, Name="Impermeabilizantes y Selladores",
                    Subtitle="Selladores acrílicos — Barrera impermeable contra filtraciones",
                    Price=0m, Badge="",
                    ImageUrl="https://microtexmexico.com/wp-content/uploads/2024/08/3-1.png",
                    AltText="Impermeabilizantes y selladores MicroTex" },
                new ProductItem { Id=4, Name="Productos Luminiscentes",
                    Subtitle="Brillan en la oscuridad hasta 12 horas — Alta intensidad lumínica",
                    Price=0m, Badge="Nuevo",
                    ImageUrl="https://microtexmexico.com/wp-content/uploads/2024/08/5-1.png",
                    AltText="Productos luminiscentes MicroTex" },
                new ProductItem { Id=5, Name="Esmaltes Alquidales",
                    Subtitle="Superficies metálicas — Acabado brillante y resistente a la corrosión",
                    Price=0m, Badge="",
                    ImageUrl="https://microtexmexico.com/wp-content/uploads/2024/08/4-1.png",
                    AltText="Esmaltes alquidales MicroTex" },
            };
        }

        private void BindProducts()
        {
            var all = GetAllProducts();
            switch (ddlSort.SelectedValue)
            {
                case "newest": all = all.OrderByDescending(p => p.Id).ToList(); break;
            }
            rptProducts.DataSource = all.Skip((CurrentPage - 1) * PageSize).Take(PageSize).ToList();
            rptProducts.DataBind();
        }

        private void BindPagination()
        {
            int total = GetAllProducts().Count;
            int pages = (int)Math.Ceiling((double)total / PageSize);
            rptPages.DataSource = Enumerable.Range(1, pages).Select(p => new { PageNumber = p }).ToList();
            rptPages.DataBind();
        }

        protected string GetBadgeHtml(object badgeObj)
        {
            string badge = badgeObj?.ToString();
            if (string.IsNullOrEmpty(badge)) return string.Empty;
            string css = badge == "Más Vendido" ? "bg-white/90 backdrop-blur-sm text-dark"
                       : badge == "Nuevo" ? "bg-accent text-white"
                                                : "bg-dark text-white";
            return $"<div class=\"absolute top-4 left-4\"><span class=\"{css} text-[10px] font-black uppercase px-2 py-1 rounded\">{badge}</span></div>";
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e) { BindProducts(); BindPagination(); }

        protected void btnQuickAdd_Command(object sender, CommandEventArgs e)
            => Response.Redirect($"detalle.aspx?id={e.CommandArgument}");

        protected void btnGetQuote_Click(object sender, EventArgs e) => Response.Redirect("Default.aspx#contacto");
        protected void btnEcoExplore_Click(object sender, EventArgs e) => Response.Redirect("productos.aspx");

        protected void btnNewsletter_Click(object sender, EventArgs e)
        {
            string email = txtNewsletter.Text.Trim();
            if (!string.IsNullOrEmpty(email))
            {
                lblNewsletterMsg.Text = $"✓ ¡Gracias! {email} ha sido suscrito.";
                lblNewsletterMsg.Visible = true;
                txtNewsletter.Text = string.Empty;
            }
        }

        protected void lbtnPrev_Click(object sender, EventArgs e) { if (CurrentPage > 1) CurrentPage--; BindProducts(); BindPagination(); }

        protected void lbtnNext_Click(object sender, EventArgs e)
        {
            int pages = (int)Math.Ceiling((double)GetAllProducts().Count / PageSize);
            if (CurrentPage < pages) CurrentPage++;
            BindProducts(); BindPagination();
        }

        protected void rptPages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page") { CurrentPage = Convert.ToInt32(e.CommandArgument); BindProducts(); BindPagination(); }
        }

        public class ProductItem
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Subtitle { get; set; }
            public decimal Price { get; set; }
            public string Badge { get; set; }
            public string ImageUrl { get; set; }
            public string AltText { get; set; }
        }
    }
}
