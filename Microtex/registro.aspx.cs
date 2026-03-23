using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Microtex
{
    public partial class registro : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
                Response.Redirect("perfil.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            string nombre = txtNombre.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string confirm = txtConfirm.Text;

            if (string.IsNullOrEmpty(nombre)) { ShowMessage("El nombre es requerido.", true); return; }
            if (string.IsNullOrEmpty(email)) { ShowMessage("El correo es requerido.", true); return; }
            if (string.IsNullOrEmpty(password)) { ShowMessage("La contraseña es requerida.", true); return; }
            if (password != confirm) { ShowMessage("Las contraseñas no coinciden.", true); return; }
            if (!chkTerminos.Checked) { ShowMessage("Debes aceptar los Términos de Servicio.", true); return; }

            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(conexion))
            {
                conn.Open();

                SqlCommand cmdCheck = new SqlCommand("SELECT COUNT(*) FROM Usuarios WHERE Email=@Email", conn);
                cmdCheck.Parameters.AddWithValue("@Email", email);
                if ((int)cmdCheck.ExecuteScalar() > 0)
                {
                    ShowMessage("Este correo ya está registrado.", true);
                    return;
                }

                string queryInsert = @"INSERT INTO Usuarios (Nombre, Email, Password)
                                       OUTPUT INSERTED.IdUsuario, INSERTED.FechaRegistro
                                       VALUES (@Nombre, @Email, @Password)";

                SqlCommand cmdInsert = new SqlCommand(queryInsert, conn);
                cmdInsert.Parameters.AddWithValue("@Nombre", nombre);
                cmdInsert.Parameters.AddWithValue("@Email", email);
                cmdInsert.Parameters.AddWithValue("@Password", password);

                SqlDataReader reader = cmdInsert.ExecuteReader();

                if (reader.Read())
                {
                    Session["usuario"] = email;
                    Session["usuarioNombre"] = nombre;
                    Session["usuarioId"] = reader["IdUsuario"].ToString();
                    Session["usuarioFecha"] = Convert.ToDateTime(reader["FechaRegistro"]).ToString("dd/MM/yyyy");
                    reader.Close();

                    // Limpiar campos
                    txtNombre.Text = "";
                    txtEmail.Text = "";
                    chkTerminos.Checked = false;

                    // Señal para el JS via campo oculto
                    hdnToast.Value = "ok";
                }
                else
                {
                    ShowMessage("Error al crear la cuenta. Intenta de nuevo.", true);
                }
            }
        }

        protected void btnGetQuote_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx#contacto");
        }

        private void ShowMessage(string msg, bool isError)
        {
            lblMessage.Text = msg;
            lblMessage.CssClass = isError
                ? "mx-8 mb-2 block text-sm font-semibold text-center px-4 py-3 rounded-xl bg-red-50 text-red-600"
                : "mx-8 mb-2 block text-sm font-semibold text-center px-4 py-3 rounded-xl bg-green-50 text-green-700";
            lblMessage.Visible = true;
        }
    }
}
