using System;
using System.Collections.Generic;

namespace Microtex
{
    public partial class detalle : System.Web.UI.Page
    {
        private class Producto
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Badge { get; set; }
            public string Subtitle { get; set; }
            public int Stars { get; set; }
            public bool HalfStar { get; set; }
            public int Reviews { get; set; }
            public string MainImage { get; set; }
            public string TabTitle { get; set; }
            public string TabDesc1 { get; set; }
            public string TabDesc2 { get; set; }
            public string ExpertTip { get; set; }
            public List<Thumb> Thumbs { get; set; }
            public string Acabado { get; set; }
            public string Base { get; set; }
            public string Cobertura { get; set; }
            public string Secado { get; set; }
            public string VOC { get; set; }
            public string Usos { get; set; }
            public decimal Precio { get; set; }
        }

        private class Thumb { public string Url { get; set; } public string Alt { get; set; } }

        // ✅ CartItem ya NO se define aquí — vive en carrito.aspx.cs (namespace Microtex)

        private static readonly List<Producto> Catalog = new List<Producto>
        {
            new Producto {
                Id=1, Name="Pintura Arquitectónica", Badge="Más Vendido",
                Subtitle="Resinas vinílicas-acrílicas — Alta calidad y durabilidad",
                Stars=5, HalfStar=false, Reviews=0, Precio=320m,
                MainImage="https://microtexmexico.com/wp-content/uploads/2024/08/1-1-1.png",
                TabTitle="La solución avanzada en recubrimientos arquitectónicos",
                TabDesc1="Nuestra Pintura Arquitectónica utiliza resinas vinílicas-acrílicas que garantizan un acabado de alta calidad y durabilidad.",
                TabDesc2="Son fáciles de aplicar y secan rápidamente, lo que aumenta la eficiencia en cualquier proyecto.",
                ExpertTip="Ideal para interiores y exteriores. Aplica con rodillo de pelo corto. Se recomienda dar dos manos para mejor cobertura.",
                Acabado="Mate / Satinado", Base="Resina vinílica-acrílica", Cobertura="Alta cobertura por m²",
                Secado="Al tacto: 1h · Repintado: 4h", VOC="Baja emisión", Usos="Muros interiores y exteriores",
                Thumbs=new List<Thumb>{
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/1-1-1.png",Alt="Pintura Arquitectónica"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/2-1-e1727478954221.png",Alt="Acabado cementicio"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/3-1.png",Alt="Impermeabilizante"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/4-1.png",Alt="Esmalte alquidal"}}},
            new Producto {
                Id=2, Name="Producto Cementicio", Badge="",
                Subtitle="Superficies continuas sin juntas — Acabado moderno y versátil",
                Stars=5, HalfStar=false, Reviews=0, Precio=480m,
                MainImage="https://microtexmexico.com/wp-content/uploads/2024/08/2-1-e1727478954221.png",
                TabTitle="Vanguardia en soluciones de construcción y renovación",
                TabDesc1="Nuestro Producto Cementicio permite crear superficies continuas y sin juntas que aportan una estética elegante.",
                TabDesc2="Su aplicación es sencilla y rápida. Disponible en una amplia gama de colores y texturas.",
                ExpertTip="Aplica sobre superficies limpias y secas. Usa una llana de acero inoxidable en capas delgadas.",
                Acabado="Continuo sin juntas", Base="Base cementicia", Cobertura="3–5 kg/m² según acabado",
                Secado="Secado: 24h · Uso: 72h", VOC="Sin solventes", Usos="Pisos, paredes, escaleras",
                Thumbs=new List<Thumb>{
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/2-1-e1727478954221.png",Alt="Producto Cementicio"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/1-1-1.png",Alt="Pintura arquitectónica"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/5-1.png",Alt="Luminiscente"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/4-1.png",Alt="Esmalte alquidal"}}},
            new Producto {
                Id=3, Name="Impermeabilizantes y Selladores", Badge="",
                Subtitle="Selladores acrílicos — Barrera impermeable contra filtraciones",
                Stars=5, HalfStar=false, Reviews=0, Precio=290m,
                MainImage="https://microtexmexico.com/wp-content/uploads/2024/08/3-1.png",
                TabTitle="Protección total contra la humedad y el deterioro",
                TabDesc1="Nuestros impermeabilizantes y selladores acrílicos crean una barrera impermeable que evita filtraciones.",
                TabDesc2="Aseguran la integridad de tus espacios, adaptándose a azoteas, terrazas, muros y cimentaciones.",
                ExpertTip="Limpia la superficie antes de aplicar. Se recomienda mínimo 2 manos para garantizar impermeabilidad total.",
                Acabado="Flexible e impermeable", Base="Acrílico elastomérico", Cobertura="1–1.5 kg/m² por mano",
                Secado="Al tacto: 2h · Lluvia: 24h", VOC="Base agua, baja emisión", Usos="Azoteas, terrazas, muros",
                Thumbs=new List<Thumb>{
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/3-1.png",Alt="Impermeabilizante"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/1-1-1.png",Alt="Pintura arquitectónica"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/2-1-e1727478954221.png",Alt="Cementicio"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/4-1.png",Alt="Esmalte alquidal"}}},
            new Producto {
                Id=4, Name="Productos Luminiscentes", Badge="Nuevo",
                Subtitle="Brillan en la oscuridad hasta 12 horas — Alta intensidad lumínica",
                Stars=5, HalfStar=false, Reviews=0, Precio=550m,
                MainImage="https://microtexmexico.com/wp-content/uploads/2024/08/5-1.png",
                TabTitle="Materiales que brillan en la oscuridad hasta 12 horas",
                TabDesc1="Nuestros productos luminiscentes pueden brillar en la oscuridad hasta por 12 horas con alta intensidad lumínica.",
                TabDesc2="Se cargan con cualquier fuente de luz y no requieren electricidad. Perfectos para señalización y decoración.",
                ExpertTip="Expón la superficie a luz directa por al menos 30 minutos antes de usarla en oscuridad.",
                Acabado="Luminiscente / Fluorescente", Base="Pigmento fotoluminiscente", Cobertura="Según aplicación",
                Secado="Al tacto: 1h · Uso: 4h", VOC="Baja emisión", Usos="Señalización, decoración, seguridad",
                Thumbs=new List<Thumb>{
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/5-1.png",Alt="Luminiscente"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/1-1-1.png",Alt="Pintura arquitectónica"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/2-1-e1727478954221.png",Alt="Cementicio"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/3-1.png",Alt="Impermeabilizante"}}},
            new Producto {
                Id=5, Name="Esmaltes Alquidales", Badge="",
                Subtitle="Superficies metálicas — Acabado brillante y resistente a la corrosión",
                Stars=5, HalfStar=false, Reviews=0, Precio=210m,
                MainImage="https://microtexmexico.com/wp-content/uploads/2024/08/4-1.png",
                TabTitle="Adherencia y protección superior sobre metales",
                TabDesc1="Nuestros Esmaltes Alquidales brindan un acabado brillante y duradero que resiste la corrosión y el desgaste.",
                TabDesc2="Compatible con madera, metal y concreto. Disponible en colores estándar y especiales bajo pedido.",
                ExpertTip="Aplica sobre metal limpio y sin óxido. Usa brocha de cerdas naturales a 15–35°C.",
                Acabado="Brillante / Semi-mate", Base="Alquídica (base aceite)", Cobertura="12–14 m² por litro",
                Secado="Al tacto: 4h · Uso: 24h", VOC="Media emisión", Usos="Metal, madera, concreto",
                Thumbs=new List<Thumb>{
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/4-1.png",Alt="Esmalte Alquidal"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/1-1-1.png",Alt="Pintura arquitectónica"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/2-1-e1727478954221.png",Alt="Cementicio"},
                    new Thumb{Url="https://microtexmexico.com/wp-content/uploads/2024/08/3-1.png",Alt="Impermeabilizante"}}},
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            lblCopyright.Text = $"© {DateTime.Now.Year} MicroTex. Todos los derechos reservados.";

            // Navbar
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

            if (!IsPostBack)
            {
                int id = 0;
                int.TryParse(Request.QueryString["id"], out id);
                var producto = Catalog.Find(p => p.Id == id) ?? Catalog[0];
                hfProductoId.Value = producto.Id.ToString();
                CargarProducto(producto);
            }

            // Badge del carrito
            var carrito = Session["Carrito"] as List<CartItem> ?? new List<CartItem>();
            int totalItems = 0;
            foreach (var i in carrito) totalItems += i.Qty;
            litCartBadge.Text = totalItems.ToString();
        }

        private void CargarProducto(Producto p)
        {
            Page.Title = $"MicroTex | {p.Name}";
            lblBreadcrumb.Text = p.Name;
            lblBadge.Text = p.Badge;
            lblName.Text = p.Name;
            lblSubtitle.Text = p.Subtitle;
            lblReviews.Text = p.Reviews > 0 ? $"({p.Reviews} reseñas)" : "Contáctanos para más información";
            lblPrice.Text = $"<span class=\"text-2xl font-black text-slate-900\">${p.Precio:0.00} MXN</span><span class=\"text-sm text-slate-400 ml-2\">/ cubeta</span>";

            var stars = new System.Text.StringBuilder();
            for (int i = 0; i < p.Stars; i++)
                stars.Append("<span class=\"material-symbols-outlined\" style=\"font-variation-settings:'FILL' 1\">star</span>");
            if (p.HalfStar)
                stars.Append("<span class=\"material-symbols-outlined\">star_half</span>");
            starsContainer.InnerHtml = stars.ToString();

            imgMain.ImageUrl = p.MainImage;
            imgMain.AlternateText = p.Name;
            rptThumbs.DataSource = p.Thumbs;
            rptThumbs.DataBind();

            lblTabTitle.Text = p.TabTitle;
            lblTabDesc1.Text = p.TabDesc1;
            lblTabDesc2.Text = p.TabDesc2;
            lblExpertTip.Text = p.ExpertTip;

            lblSpecAcabado.Text = p.Acabado;
            lblSpecBase.Text = p.Base;
            lblSpecCobertura.Text = p.Cobertura;
            lblSpecSecado.Text = p.Secado;
            lblSpecVOC.Text = p.VOC;
            lblSpecUsos.Text = p.Usos;
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int id = 0;
            int.TryParse(hfProductoId.Value, out id);
            var producto = Catalog.Find(p => p.Id == id);
            if (producto == null) return;

            int qty = 1;
            int.TryParse(txtQty.Text, out qty);
            if (qty < 1) qty = 1;

            string color = hfColor.Value;
            if (string.IsNullOrEmpty(color)) color = "Azul Contemporáneo";

            // ✅ Usa CartItem del namespace Microtex (definido en carrito.aspx.cs)
            var carrito = Session["Carrito"] as List<CartItem> ?? new List<CartItem>();

            var existing = carrito.Find(c => c.Id == producto.Id && c.Color == color);
            if (existing != null)
            {
                existing.Qty += qty;
            }
            else
            {
                carrito.Add(new CartItem
                {
                    Id = producto.Id,
                    Name = producto.Name,
                    ImageUrl = producto.MainImage,
                    Price = producto.Precio,
                    Qty = qty,
                    Color = color
                });
            }
            Session["Carrito"] = carrito;

            int totalItems = 0;
            foreach (var i in carrito) totalItems += i.Qty;
            litCartBadge.Text = totalItems.ToString();

            lblFeedback.Text = $"✓ <strong>{producto.Name}</strong> agregado al carrito. <a href='carrito.aspx' style='text-decoration:underline;'>Ver carrito →</a>";
            lblFeedback.Visible = true;
        }

        protected void btnGetQuote_Click(object sender, EventArgs e)
            => Response.Redirect("~/Default.aspx#contacto");
    }
}