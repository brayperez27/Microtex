using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Microtex
{
    public partial class login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
                Response.Redirect("perfil.aspx");

            lblCopyright.Text = $"© {DateTime.Now.Year} Microtex. Todos los derechos reservados.";

            // ✅ Navbar con sesión
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

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ShowError("Por favor, completa todos los campos.");
                return;
            }

            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(conexion))
            {
                string query = @"SELECT IdUsuario, Nombre, Email, FechaRegistro
                                 FROM Usuarios
                                 WHERE Email = @Email AND Password = @Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    Session["usuario"] = reader["Email"].ToString();
                    Session["usuarioNombre"] = reader["Nombre"].ToString();
                    Session["usuarioId"] = reader["IdUsuario"].ToString();
                    Session["usuarioFecha"] = Convert.ToDateTime(reader["FechaRegistro"])
                                                      .ToString("dd/MM/yyyy");
                    Response.Redirect("perfil.aspx");
                }
                else
                {
                    ShowError("Correo o contrasena incorrectos.");
                }
            }
        }

        protected void btnGetQuote_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx#contacto");
        }

        private void ShowError(string msg)
        {
            lblMessage.Text = msg;
            lblMessage.CssClass = "block mb-6 text-sm font-semibold text-center px-4 py-3 rounded-xl bg-red-50 text-red-600";
            lblMessage.Visible = true;
        }
    }
}