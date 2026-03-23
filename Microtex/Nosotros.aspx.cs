using System;
using System.Web.UI;

namespace Microtex
{
    public partial class Nosotros : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadPage();
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
        }

        protected void btnProcess_Click(object sender, EventArgs e) => Response.Redirect("~/Default.aspx");
        protected void btnGetQuote_Click(object sender, EventArgs e) => Response.Redirect("~/Default.aspx#contacto");

        protected void btnNewsletter_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            if (string.IsNullOrEmpty(email)) { MostrarMensaje("Por favor ingresa tu email.", "text-red-500"); return; }
            if (!EsEmailValido(email)) { MostrarMensaje("El email no tiene un formato válido.", "text-red-500"); return; }
            txtEmail.Text = string.Empty;
            MostrarMensaje("¡Gracias por suscribirte!", "text-green-600");
        }

        private bool EsEmailValido(string email)
        {
            try { var a = new System.Net.Mail.MailAddress(email); return a.Address == email; }
            catch { return false; }
        }

        private void MostrarMensaje(string mensaje, string cssExtra)
        {
            lblNewsletterMsg.Text = mensaje;
            lblNewsletterMsg.CssClass = "text-sm mt-2 block " + cssExtra;
            lblNewsletterMsg.Visible = true;
        }
    }
}
