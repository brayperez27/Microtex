<%@ WebHandler Language="C#" Class="GetDetallesPedido" %>
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using Newtonsoft.Json;

public class GetDetallesPedido : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.Headers.Add("Cache-Control", "no-cache");

        if (context.Session["usuario"] == null)
        {
            context.Response.Write("[]");
            return;
        }

        string idStr = context.Request.QueryString["id"];
        if (string.IsNullOrEmpty(idStr) || !int.TryParse(idStr, out int idPedido))
        {
            context.Response.Write("[]");
            return;
        }

        string usuarioId    = context.Session["usuarioId"]?.ToString();
        string emailUsuario = context.Session["usuario"]?.ToString() ?? "";
        bool   esAdmin      = (emailUsuario == "microtexmexicohidalgo@gmail.com");
        string conexion     = ConfigurationManager.ConnectionStrings["MicrotexDB"].ConnectionString;

        try
        {
            using (var conn = new SqlConnection(conexion))
            {
                conn.Open();

                // ✅ Solo verificar pertenencia si NO es admin
                if (!esAdmin)
                {
                    var check = new SqlCommand(
                        "SELECT COUNT(*) FROM Pedidos WHERE IdPedido=@Id AND IdUsuario=@UserId", conn);
                    check.Parameters.AddWithValue("@Id",     idPedido);
                    check.Parameters.AddWithValue("@UserId", usuarioId);
                    if ((int)check.ExecuteScalar() == 0)
                    {
                        context.Response.Write("[]");
                        return;
                    }
                }

                var cmd = new SqlCommand(
                    "SELECT NombreProducto, Color, Cantidad, PrecioUnit, Subtotal, ImagenUrl FROM DetallesPedido WHERE IdPedido=@Id", conn);
                cmd.Parameters.AddWithValue("@Id", idPedido);

                var lista = new List<object>();
                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        lista.Add(new {
                            NombreProducto = r["NombreProducto"].ToString(),
                            Color          = r["Color"].ToString(),
                            Cantidad       = Convert.ToInt32(r["Cantidad"]),
                            PrecioUnit     = Convert.ToDecimal(r["PrecioUnit"]),
                            Subtotal       = Convert.ToDecimal(r["Subtotal"]),
                            ImagenUrl      = r["ImagenUrl"].ToString()
                        });
                    }
                }

                context.Response.Write(JsonConvert.SerializeObject(lista));
            }
        }
        catch (Exception)
        {
            context.Response.Write("[]");
        }
    }

    public bool IsReusable { get { return false; } }
}