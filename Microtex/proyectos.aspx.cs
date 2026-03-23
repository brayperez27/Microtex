using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Microtex
{
    public partial class proyectos : System.Web.UI.Page
    {
        private const int PageSize = 4;

        private int CurrentPage
        {
            get { return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 1; }
            set { ViewState["CurrentPage"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblCopyright.Text = $"© {DateTime.Now.Year} Microtex. Todos los derechos reservados.";

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

                BindProjects();
            }
        }

        private void BindProjects()
        {
            var allProjects = GetAllProjects();
            int totalPages = (int)Math.Ceiling((double)allProjects.Count / PageSize);
            if (CurrentPage < 1) CurrentPage = 1;
            if (CurrentPage > totalPages) CurrentPage = totalPages;

            int skip = (CurrentPage - 1) * PageSize;
            var page = allProjects.GetRange(skip, Math.Min(PageSize, allProjects.Count - skip));
            rptProjects.DataSource = page;
            rptProjects.DataBind();

            btnPrevPage.Enabled = CurrentPage > 1;
            btnNextPage.Enabled = CurrentPage < totalPages;

            var pages = new List<object>();
            for (int i = 1; i <= totalPages; i++)
                pages.Add(new { PageNumber = i, IsActive = (i == CurrentPage) });
            rptPages.DataSource = pages;
            rptPages.DataBind();
        }

        private List<ProjectItem> GetAllProjects()
        {
            return new List<ProjectItem>
            {
                new ProjectItem { Id=1, Title="Residencia Miraflores",
                    Category="Residencial", CategorySlug="residencial",
                    Description="Un diseño minimalista que utiliza acabados mates para resaltar la volumetría de la fachada.",
                    ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuC7isFw4NmIqZayQftIMc4Ogk55Ho7VpslcEdK36WsrHZ2IGLeeGBwVQ8VpXTxh3b_RLIKXSpeBPEPHgdwaqRTDsAP5QY2PA1-UMpw9XmLcve7cYuw-6ZHVhYGxZw_j0zOkHZ5ZLSzNRTl_oVfAXPa7vkaP4rEPf81Ug6kazltKDSM84vueVZQqxqcPyxyno50QqSWtr-aDHAd6qo6wy-s-d7P4DStiWZ4xWuP9x3uWCmYdEbXHvu0h02SJPNGgtYZFGsFNqs9NqKnM" },
                new ProjectItem { Id=2, Title="Corporativo LX",
                    Category="Comercial", CategorySlug="comercial",
                    Description="Acabados industriales de alta resistencia para ambientes corporativos de alto tráfico.",
                    ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuDAuawOAbVhYi0yM2WdEHQFrR5vhnyRtI9Bd-NX8YY99zjWX6lqISVDI9ob383bi4HIczvSi5j8Ufon2bA5Y4Y_9PtXlpRocavfJsUsJzxz6USDZxgiGfZvMbW1mJsU--bEdr5dJOroKQoBMetdn4ZpvcVv-4NFxQsMAihXonbPpsJfNY0gLYxxTqlHAkbeZQbK7rsAnR1_Mt0XJitdhfQGzvklsBI8H_axxzE7pN6lYw3VsCGAVNFBoNNMNgFz42SqJyWEoObmJnU1" },
                new ProjectItem { Id=3, Title="Centro Histórico",
                    Category="Restauración", CategorySlug="restauracion",
                    Description="Restauración de fachadas coloniales con pigmentos tradicionales y tecnología moderna.",
                    ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuA2BG2Z9aUWqwVJ2FBTqTApxr8XGT401799Nfj64C7N4uoTye_Ir4UwY-IIqAY-w8_N7KCfvJ4efXxH6nRHvLzuA4nrolWPai8eRcEoM3x92vhjg3qKf63tgK1cU5d0UhfV7pJuK0CKTt2PEZZMU7x_2R0opOCRhf7ZV8jMzHX9g-B2DjIrq3F9dr_Wet47QvrCuOFSye9VjgNwvI3Qgj-nNGt0LapdFAAQhV9jSAQ_-n2lRLW0SJ1gY7PnvNsKMR6TqL772Ads6LLg" },
                new ProjectItem { Id=4, Title="Galería de Arte Moderna",
                    Category="Interiorismo", CategorySlug="interiorismo",
                    Description="Espacios interiores diseñados para potenciar la luz natural mediante acabados satinados.",
                    ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuCUHjXTdh3wXg1d-sl6c9AGuH4E2TSjku116d8gdzWPtspRnJEpXdCh_KpIhX_9Revoh4tHep772NqgKyZceArJEOfvPfdSOfEkBYYntuXhVQTCmmKX7TRlTF5KPfnW3G1wAO6m5FrKmaddm3ZhLHHG2nhWcobiJGeqLuxZ0YXt1tbptzOQTUTr60VoNGHjext4nWqEnE7MqoLTvgUY9bhG8E2-b0qTbDHkx08wCCawk6NIwVlcSHSHCFlRtxOYB9eq8dj3UK-5WRkk" },
            };
        }

        protected void btnPrevPage_Click(object sender, EventArgs e) { if (CurrentPage > 1) CurrentPage--; BindProjects(); }
        protected void btnNextPage_Click(object sender, EventArgs e) { CurrentPage++; BindProjects(); }

        protected void rptPages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "GoPage") { CurrentPage = Convert.ToInt32(e.CommandArgument); BindProjects(); }
        }

        protected void rptProjects_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "VerDetalle")
                Response.Redirect($"~/detalle.aspx?proyecto={e.CommandArgument}");
        }

        protected void btnGetQuote_Click(object sender, EventArgs e) => Response.Redirect("~/Default.aspx#contacto");

        protected void btnNewsletter_Click(object sender, EventArgs e)
        {
            string email = txtNewsletterEmail.Text.Trim();
            if (string.IsNullOrEmpty(email) || !EsEmailValido(email))
            {
                lblNewsletterMsg.Text = "Por favor ingresa un email válido.";
                lblNewsletterMsg.CssClass = "text-xs mt-2 block text-red-500";
                lblNewsletterMsg.Visible = true;
                return;
            }
            txtNewsletterEmail.Text = string.Empty;
            lblNewsletterMsg.Text = "¡Gracias por suscribirte!";
            lblNewsletterMsg.CssClass = "text-xs mt-2 block text-green-600";
            lblNewsletterMsg.Visible = true;
        }

        private bool EsEmailValido(string email)
        {
            try { var a = new System.Net.Mail.MailAddress(email); return a.Address == email; }
            catch { return false; }
        }
    }

    public class ProjectItem
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Category { get; set; }
        public string CategorySlug { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get; set; }
    }
}
