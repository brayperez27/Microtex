using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI;

namespace Microtex
{
    public partial class olvidecontrasena : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblCopyright.Text = $"© {DateTime.Now.Year} Microtex. Todos los derechos reservados.";
        }

        protected void btnRecuperar_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                ShowMessage("Por favor ingresa tu correo electrónico.", isError: true);
                return;
            }

            string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
            string nombre = "";
            string password = "";

            using (SqlConnection conn = new SqlConnection(conexion))
            {
                conn.Open();
                string query = "SELECT Nombre, Password FROM Usuarios WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    nombre = reader["Nombre"].ToString();
                    password = reader["Password"].ToString();
                }
                else
                {
                    // Mensaje genérico por seguridad (no revelar si el correo existe)
                    ShowMessage("Si ese correo está registrado, recibirás las instrucciones en breve.", isError: false);
                    return;
                }
            }

            // Enviar correo con la contraseña
            bool enviado = EnviarCorreo(email, nombre, password);

            if (enviado)
            {
                panelForm.Visible = false;
                panelExito.Visible = true;
                lblEmailEnviado.Text = email;
            }
            else
            {
                ShowMessage("No se pudo enviar el correo. Intenta de nuevo más tarde.", isError: true);
            }
        }

        private bool EnviarCorreo(string destinatario, string nombre, string password)
        {
            try
            {
                string smtpHost = "smtp-relay.brevo.com";
                int smtpPort = 587;
                string smtpUser = "a4ddfb001@smtp-brevo.com";
                string smtpPass = "xsmtpsib-d2712a4aa5f2baf1241519ffc7e3a4bf7a16cf412bdf62f25a9861f8b8ff1b25-AGF8rungN7XvYd8N";
                string remitente = "microtexmexicohidalgo@gmail.com";

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(remitente, "Microtex");
                mail.To.Add(destinatario);
                mail.Subject = "Recuperación de contraseña — Microtex";
                mail.IsBodyHtml = true;
                mail.Body = $@"
                    <!DOCTYPE html>
                    <html lang='es'>
                    <head><meta charset='utf-8'/></head>
                    <body style='margin:0;padding:0;background:#F7F5EC;font-family:Inter,sans-serif;'>
                      <table width='100%' cellpadding='0' cellspacing='0'>
                        <tr><td align='center' style='padding:40px 20px;'>
                          <table width='480' cellpadding='0' cellspacing='0'
                                 style='background:#fff;border-radius:16px;overflow:hidden;
                                        box-shadow:0 4px 24px rgba(0,0,0,0.08);'>

                            <!-- Header -->
                            <tr>
                              <td style='background:#1a1a1a;padding:32px;text-align:center;'>
                                <div style='display:inline-flex;align-items:center;justify-content:center;
                                            width:48px;height:48px;background:#fff;border-radius:12px;
                                            font-weight:900;font-size:20px;color:#1a1a1a;'>M</div>
                                <p style='color:#fff;font-weight:800;font-size:18px;margin:12px 0 0;
                                          letter-spacing:-0.5px;'>MICROTEX</p>
                              </td>
                            </tr>

                            <!-- Body -->
                            <tr>
                              <td style='padding:36px 40px;'>
                                <h2 style='color:#1a1a1a;font-size:22px;font-weight:800;margin:0 0 8px;'>
                                  Hola, {nombre} 👋
                                </h2>
                                <p style='color:#6b7280;font-size:14px;line-height:1.6;margin:0 0 24px;'>
                                  Recibimos una solicitud para recuperar la contraseña de tu cuenta en Microtex.
                                  Aquí está tu contraseña actual:
                                </p>

                                <!-- Contraseña -->
                                <div style='background:#f8fafc;border:2px dashed #e2e8f0;border-radius:12px;
                                            padding:20px;text-align:center;margin-bottom:24px;'>
                                  <p style='color:#94a3b8;font-size:11px;font-weight:700;
                                            text-transform:uppercase;letter-spacing:1px;margin:0 0 8px;'>
                                    Tu contraseña
                                  </p>
                                  <p style='color:#1a1a1a;font-size:28px;font-weight:900;
                                            letter-spacing:4px;margin:0;font-family:monospace;'>
                                    {password}
                                  </p>
                                </div>

                                <p style='color:#6b7280;font-size:13px;line-height:1.6;margin:0 0 28px;'>
                                  Por seguridad, te recomendamos cambiar tu contraseña después de iniciar sesión.
                                  Si no solicitaste esto, ignora este mensaje.
                                </p>

                                <!-- Botón CTA -->
                                <a href='https://microtex-web-f9gfagekfeg9hdb0.mexicocentral-01.azurewebsites.net/login.aspx'
                                   style='display:block;background:#1a1a1a;color:#fff;text-decoration:none;
                                          text-align:center;padding:14px 24px;border-radius:10px;
                                          font-weight:700;font-size:14px;'>
                                  Ir a Iniciar Sesión →
                                </a>
                              </td>
                            </tr>

                            <!-- Footer -->
                            <tr>
                              <td style='background:#f8fafc;border-top:1px solid #e2e8f0;
                                         padding:20px 40px;text-align:center;'>
                                <p style='color:#94a3b8;font-size:12px;margin:0;'>
                                  © {DateTime.Now.Year} Microtex · Ajacuba, Hidalgo, México
                                </p>
                              </td>
                            </tr>

                          </table>
                        </td></tr>
                      </table>
                    </body>
                    </html>";

                SmtpClient smtp = new SmtpClient(smtpHost, smtpPort);
                smtp.EnableSsl = true;
                smtp.Credentials = new NetworkCredential(smtpUser, smtpPass);
                smtp.Send(mail);
                return true;
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, true);
                return false;
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
                ? "block mb-5 text-sm font-semibold text-center px-4 py-3 rounded-xl bg-red-50 text-red-600"
                : "block mb-5 text-sm font-semibold text-center px-4 py-3 rounded-xl bg-green-50 text-green-700";
            lblMessage.Visible = true;
        }
    }
}
