using System.Collections.Generic;

namespace Microtex
{
    /// <summary>
    /// Clase estática con todas las traducciones EN / ES.
    /// Agrega más claves aquí conforme crece el proyecto.
    /// </summary>
    public static class Lang
    {
        // ── Idioma activo ────────────────────────────────────────
        // Se usa desde cualquier Page con: Lang.Current
        public static string Current
        {
            get { return _current; }
        }
        private static string _current = "ES"; // default

        public static void Set(string lang)
        {
            _current = (lang == "EN") ? "EN" : "ES";
        }

        // ── Diccionario ──────────────────────────────────────────
        private static readonly Dictionary<string, Dictionary<string, string>> _dict =
            new Dictionary<string, Dictionary<string, string>>
        {
            // ── NAVBAR ──────────────────────────────────────────
            { "nav_about",    new Dictionary<string,string>{ {"EN","About Us"}, {"ES","Nosotros"} } },
            { "nav_products", new Dictionary<string,string>{ {"EN","Products"}, {"ES","Productos"} } },
            { "nav_benefits", new Dictionary<string,string>{ {"EN","Benefits"}, {"ES","Beneficios"} } },
            { "nav_projects", new Dictionary<string,string>{ {"EN","Projects"}, {"ES","Proyectos"} } },
            { "nav_contact",  new Dictionary<string,string>{ {"EN","Contact"},  {"ES","Contacto"} } },
            { "btn_quote",    new Dictionary<string,string>{ {"EN","Get a Quote"}, {"ES","Cotizar"} } },

            // ── INDEX — HERO ─────────────────────────────────────
            { "hero_badge",    new Dictionary<string,string>{ {"EN","Premium Architecture"}, {"ES","Arquitectura Premium"} } },
            { "hero_h1",       new Dictionary<string,string>{ {"EN","Architectural Excellence Redefined."}, {"ES","Excelencia Arquitectónica Redefinida."} } },
            { "hero_sub",      new Dictionary<string,string>{ {"EN","Experience the perfect blend of high-end aesthetics and industrial durability."}, {"ES","Experimenta la perfecta combinación de estética premium y durabilidad industrial."} } },
            { "btn_explore",   new Dictionary<string,string>{ {"EN","Explore Products"}, {"ES","Ver Productos"} } },
            { "btn_contact",   new Dictionary<string,string>{ {"EN","Contact Specialist"}, {"ES","Contactar Especialista"} } },

            // ── INDEX — ABOUT ────────────────────────────────────
            { "about_label",   new Dictionary<string,string>{ {"EN","Our Legacy"}, {"ES","Nuestro Legado"} } },
            { "about_h3",      new Dictionary<string,string>{ {"EN","Dedicated to the Art of Building"}, {"ES","Dedicados al Arte de Construir"} } },
            { "about_body",    new Dictionary<string,string>{ {"EN","With over three decades of mastery, Microtex has pioneered the integration of advanced polymers and natural textures."}, {"ES","Con más de tres décadas de experiencia, Microtex ha liderado la integración de polímeros avanzados y texturas naturales."} } },
            { "about_heritage",new Dictionary<string,string>{ {"EN","Heritage"}, {"ES","Trayectoria"} } },
            { "about_her_sub", new Dictionary<string,string>{ {"EN","30+ years of craftsmanship."}, {"ES","Más de 30 años de oficio."} } },
            { "about_quality", new Dictionary<string,string>{ {"EN","Quality"}, {"ES","Calidad"} } },
            { "about_qua_sub", new Dictionary<string,string>{ {"EN","ISO certified standards."}, {"ES","Estándares certificados ISO."} } },

            // ── INDEX — PRODUCTS ─────────────────────────────────
            { "prod_label",    new Dictionary<string,string>{ {"EN","Our Collections"}, {"ES","Nuestras Colecciones"} } },
            { "prod_h3",       new Dictionary<string,string>{ {"EN","Architectural Surfaces"}, {"ES","Superficies Arquitectónicas"} } },
            { "prod_catalog",  new Dictionary<string,string>{ {"EN","View Full Catalog"}, {"ES","Ver Catálogo Completo"} } },

            // ── INDEX — BENEFITS ─────────────────────────────────
            { "ben_label",     new Dictionary<string,string>{ {"EN","Why Microtex"}, {"ES","Por qué Microtex"} } },
            { "ben_h3",        new Dictionary<string,string>{ {"EN","Performance Meets Design"}, {"ES","Rendimiento y Diseño"} } },

            // ── INDEX — PROJECTS ─────────────────────────────────
            { "proj_label",    new Dictionary<string,string>{ {"EN","Portfolio"}, {"ES","Portafolio"} } },
            { "proj_h3",       new Dictionary<string,string>{ {"EN","Iconic Realizations"}, {"ES","Realizaciones Icónicas"} } },

            // ── INDEX — CONTACT ──────────────────────────────────
            { "cont_h3",       new Dictionary<string,string>{ {"EN","Start Your Project"}, {"ES","Inicia Tu Proyecto"} } },
            { "cont_sub",      new Dictionary<string,string>{ {"EN","Connect with our technical consultants to receive a personalized quote."}, {"ES","Conecta con nuestros consultores técnicos para recibir una cotización personalizada."} } },
            { "cont_name",     new Dictionary<string,string>{ {"EN","Your Name"}, {"ES","Tu Nombre"} } },
            { "cont_email",    new Dictionary<string,string>{ {"EN","Email Address"}, {"ES","Correo Electrónico"} } },
            { "cont_details",  new Dictionary<string,string>{ {"EN","Project Details"}, {"ES","Detalles del Proyecto"} } },
            { "cont_send",     new Dictionary<string,string>{ {"EN","Send Inquiry"}, {"ES","Enviar Consulta"} } },
            { "cont_inquiry1", new Dictionary<string,string>{ {"EN","Product Inquiry"}, {"ES","Consulta de Producto"} } },
            { "cont_inquiry2", new Dictionary<string,string>{ {"EN","Request Quote"}, {"ES","Solicitar Cotización"} } },
            { "cont_inquiry3", new Dictionary<string,string>{ {"EN","Technical Support"}, {"ES","Soporte Técnico"} } },

            // ── PRODUCTOS PAGE ───────────────────────────────────
            { "cat_all",       new Dictionary<string,string>{ {"EN","All Products"}, {"ES","Todos los Productos"} } },
            { "cat_int",       new Dictionary<string,string>{ {"EN","Interiors"}, {"ES","Interiores"} } },
            { "cat_ext",       new Dictionary<string,string>{ {"EN","Exteriors"}, {"ES","Exteriores"} } },
            { "cat_spec",      new Dictionary<string,string>{ {"EN","Specialty"}, {"ES","Especialidad"} } },
            { "cat_tools",     new Dictionary<string,string>{ {"EN","Tools"}, {"ES","Herramientas"} } },
            { "filter_finish", new Dictionary<string,string>{ {"EN","Finish"}, {"ES","Acabado"} } },
            { "filter_base",   new Dictionary<string,string>{ {"EN","Base Type"}, {"ES","Tipo de Base"} } },
            { "prod_h1",       new Dictionary<string,string>{ {"EN","Premium Paint Collection"}, {"ES","Colección Premium de Pinturas"} } },
            { "prod_desc",     new Dictionary<string,string>{ {"EN","Discover professional-grade finishes, vibrant pigments, and sustainable solutions."}, {"ES","Descubre acabados profesionales, pigmentos vibrantes y soluciones sostenibles."} } },
            { "btn_quickadd",  new Dictionary<string,string>{ {"EN","Quick Add"}, {"ES","Agregar"} } },
            { "eco_title",     new Dictionary<string,string>{ {"EN","New Collection"}, {"ES","Nueva Colección"} } },
            { "eco_sub",       new Dictionary<string,string>{ {"EN","Eco-Friendly Series"}, {"ES","Serie Ecológica"} } },
            { "btn_explore",   new Dictionary<string,string>{ {"EN","Explore"}, {"ES","Explorar"} } },
            { "news_h4",       new Dictionary<string,string>{ {"EN","Newsletter"}, {"ES","Boletín"} } },
            { "news_sub",      new Dictionary<string,string>{ {"EN","Subscribe to receive color trends and project inspiration."}, {"ES","Suscríbete para recibir tendencias de color e inspiración."} } },
            { "news_join",     new Dictionary<string,string>{ {"EN","Join"}, {"ES","Unirse"} } },
            { "news_ph",       new Dictionary<string,string>{ {"EN","Your email"}, {"ES","Tu correo"} } },

            // ── FOOTER ───────────────────────────────────────────
            { "foot_tagline",  new Dictionary<string,string>{ {"EN","Pioneering the future of architectural surfaces."}, {"ES","Pioneros en el futuro de las superficies arquitectónicas."} } },
            { "foot_privacy",  new Dictionary<string,string>{ {"EN","Privacy Policy"}, {"ES","Política de Privacidad"} } },
            { "foot_terms",    new Dictionary<string,string>{ {"EN","Terms of Service"}, {"ES","Términos de Servicio"} } },
        };

        /// <summary>Obtiene el texto traducido. Si no existe la clave devuelve la clave misma.</summary>
        public static string T(string key)
        {
            if (_dict.TryGetValue(key, out var translations))
                if (translations.TryGetValue(_current, out var text))
                    return text;
            return key;
        }
    }
}
