using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI;

namespace Microtex
{
    public partial class index : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadPage();
        }

        private void LoadPage()
        {
            lblCopyright.Text = $"© {DateTime.Now.Year} MicroTex. Todos los derechos reservados.";
            lblEmail.Text = "dante_ceron@outlook.com";
            lblPhone.Text = "771 567 6119";
            lblAddress.Text = "Ajacuba, Hidalgo";

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
            BindBenefits();
        }

        private void BindProducts()
        {
            var products = new List<ProductItem>
            {
                new ProductItem { Id=1, Title="Pintura Arquitectónica",
                    Description="Resinas vinílicas-acrílicas de alta calidad. Protección duradera y secado rápido.",
                    ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuD4goBGK54VFY2blslpHzbwesQLDtzmDOyqDb4zxkbs7mUBMmGEZtgFvWRTTm8qta2cw1l-TRhuc6Nqr26976yf9V3c6cveX9JSZ2xftQ8DeEY1z_6FIZ0nS6zQxgQqkP49LhJL2U_-WZCIkVuMxmxEojGRFBaHan-FOkYt0IQuNZZRxrDITe-XsJbuyyM8FhTgyTIh8_fgIDEWfqPGmx0ZXE9Mo2Obdy8KN0N6CZRx2i37h7_3Xsdm-FvBrRr4HaUCeSpbQ_kGG18c",
                    AltText="Pintura arquitectónica" },
                new ProductItem { Id=2, Title="Producto Cementicio",
                    Description="Superficies continuas sin juntas. Alta resistencia y amplia gama de colores y texturas.",
                    ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuCkROSz0e6eZAXTauluby4r4CpCnNGb5CbUWrYc3UErMcm3Aaf44ebBHHhhaSOVJiLGU6-nuqCXL0tDIC-kX_OJO2MnZPPnxl-iU9PoofOUQot8g3ZRabD8Fj2Du4ODoJFGdE0Gdje8ivBHZJK-ZEqFjpRzEpMqwAkhBacKSh0OLzynSbJJwzDRf5izQGk_DOI8M6Qtl3G6gLRHuUGZfAdTd1ZMGQ0IVLkJYIuPwztDVUI0jeQGLPXfYVY6Mgfba-J7YZXHPu-XYC2G",
                    AltText="Producto cementicio" },
                new ProductItem { Id=3, Title="Impermeabilizantes y Selladores",
                    Description="Barrera impermeable contra filtraciones. Protege interiores y exteriores.",
                    ImageUrl="https://lh3.googleusercontent.com/aida-public/AB6AXuABex0VEI-d-I_H8eMhn_uvIXUtJ-w74uQUwqF6kIh8uPwjfQfDi-l3xtI_tbpe8E-SZzaaRqkgL3sMjYFq7kjpjZAnuSpln_-RB10L8C2UeuqfJsFetxZAb16MesMBQgt1WoHwi8mouWWOD-nBpuTRDDrHg2iH3QJfDYR-0YmwWKpVTQwPNMa9vvBdyU87xHiIZlTeSlrbLg8SnVJ42JNOTFj4js0A4FScyb42WTM7m0Iwu1_tUg2Fq6Fg5u-CkcWclyg6IOfdZ09k",
                    AltText="Impermeabilizantes" }
            };
            rptProducts.DataSource = products;
            rptProducts.DataBind();
        }

        private void BindBenefits()
        {
            var benefits = new List<BenefitItem>
            {
                new BenefitItem { Icon="format_paint",  Title="Texturas y Efectos",     Description="Fabricamos texturas, efectos y colores únicos para cada proyecto." },
                new BenefitItem { Icon="shield",        Title="Alta Durabilidad",        Description="Fórmulas que resisten condiciones ambientales adversas." },
                new BenefitItem { Icon="lightbulb",     Title="Productos Luminiscentes", Description="Brillan en la oscuridad hasta 12 horas con alta intensidad lumínica." },
                new BenefitItem { Icon="construction",  Title="Fácil Aplicación",        Description="Secado rápido y aplicación sencilla para mayor eficiencia." }
            };
            rptBenefits.DataSource = benefits;
            rptBenefits.DataBind();
        }

        protected void btnExplore_Click(object sender, EventArgs e) => Response.Redirect("productos.aspx");
        protected void btnContact_Click(object sender, EventArgs e) => Response.Redirect("Default.aspx#contacto");
        protected void btnGetQuote_Click(object sender, EventArgs e) => Response.Redirect("Default.aspx#contacto");

        protected void btnSendInquiry_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string tipo = ddlInquiry.SelectedItem.Text;
            string detalle = txtDetails.Text.Trim();

            try
            {
                string conexion = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;
                using (var conn = new SqlConnection(conexion))
                {
                    conn.Open();
                    var cmd = new SqlCommand(@"
                        INSERT INTO Contactos (Nombre, Email, TipoConsulta, Detalle)
                        VALUES (@Nombre, @Email, @Tipo, @Detalle)", conn);
                    cmd.Parameters.AddWithValue("@Nombre", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Tipo", tipo);
                    cmd.Parameters.AddWithValue("@Detalle", detalle);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception exDb)
            {
                System.Diagnostics.Debug.WriteLine($"[Microtex] Error BD: {exDb.Message}");
            }

            try
            {
                var mensaje = new MailMessage
                {
                    From = new MailAddress("microtexmexicohidalgo@gmail.com", "Microtex Web"),
                    Subject = $"[Microtex] Nueva consulta: {tipo} — {name}",
                    IsBodyHtml = true,
                    Body = $@"
                        <div style='font-family:Inter,sans-serif;max-width:600px;margin:0 auto;'>
                            <div style='background:#0f172a;padding:24px 32px;border-radius:12px 12px 0 0;'>
                                <h1 style='color:#fff;font-size:20px;margin:0;'>Microtex — Nueva Consulta</h1>
                            </div>
                            <div style='background:#f8fafc;padding:32px;border:1px solid #e2e8f0;border-top:none;border-radius:0 0 12px 12px;'>
                                <table style='width:100%;border-collapse:collapse;font-size:14px;color:#334155;'>
                                    <tr><td style='padding:8px 0;font-weight:700;width:180px;'>Nombre:</td><td>{name}</td></tr>
                                    <tr><td style='padding:8px 0;font-weight:700;'>Correo:</td><td><a href='mailto:{email}'>{email}</a></td></tr>
                                    <tr><td style='padding:8px 0;font-weight:700;'>Tipo:</td><td>{tipo}</td></tr>
                                    <tr><td style='padding:8px 0;font-weight:700;vertical-align:top;'>Detalles:</td>
                                        <td style='white-space:pre-wrap;'>{System.Web.HttpUtility.HtmlEncode(detalle)}</td></tr>
                                </table>
                                <div style='margin-top:24px;padding:16px;background:#e0f2fe;border-radius:8px;font-size:13px;color:#0369a1;'>
                                    💡 Responde a <strong>{email}</strong> para contactar al cliente.
                                </div>
                            </div>
                        </div>"
                };

                mensaje.To.Add("microtexmexicohidalgo@gmail.com");
                mensaje.ReplyToList.Add(new MailAddress(email, name));

                using (var smtp = new SmtpClient("smtp.gmail.com", 587))
                {
                    smtp.EnableSsl = true;
                    smtp.Credentials = new NetworkCredential("microtexmexicohidalgo@gmail.com", "jrelmgtlhfdtzpij");
                    smtp.Send(mensaje);
                }

                MostrarMensaje(
                    titulo: "¡Mensaje enviado con éxito!",
                    texto: $"Gracias, {name}. Nos pondremos en contacto a {email} a la brevedad.",
                    esError: false
                );

                txtName.Text = txtEmail.Text = txtDetails.Text = string.Empty;
                ddlInquiry.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MostrarMensaje(
                    titulo: "Error al enviar",
                    texto: $"Ocurrió un problema. Por favor intenta de nuevo. ({ex.Message})",
                    esError: true
                );
            }

            Page.ClientScript.RegisterStartupScript(GetType(), "scroll",
                "setTimeout(function(){ window.location.hash='contacto'; }, 50);", true);
        }

        private void MostrarMensaje(string titulo, string texto, bool esError)
        {
            pnlMessage.Visible = true;

            if (esError)
            {
                msgBox.Style["background"] = "#fef2f2";
                msgBox.Style["border"] = "1px solid #fecaca";
                msgIcon.Style["background"] = "#ef4444";
                msgIconSymbol.InnerText = "error";
                msgTitle.Style["color"] = "#b91c1c";
                msgTitle.InnerText = titulo;
                lblMessage.Style["color"] = "#991b1b";
            }
            else
            {
                msgBox.Style["background"] = "#f0fdf4";
                msgBox.Style["border"] = "1px solid #bbf7d0";
                msgIcon.Style["background"] = "#22c55e";
                msgIconSymbol.InnerText = "check";
                msgTitle.Style["color"] = "#15803d";
                msgTitle.InnerText = titulo;
                lblMessage.Style["color"] = "#166534";
            }

            lblMessage.Text = texto;
        }

        public class ProductItem
        {
            public int Id { get; set; }
            public string Title { get; set; }
            public string Description { get; set; }
            public string ImageUrl { get; set; }
            public string AltText { get; set; }
        }

        public class BenefitItem
        {
            public string Icon { get; set; }
            public string Title { get; set; }
            public string Description { get; set; }
        }
    }
}