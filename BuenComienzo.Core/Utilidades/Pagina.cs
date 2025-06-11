using System;
using System.Web.UI;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using BuenComienzo.Core;
using System.IO;
using BuenComienzo.Core.Administracion.To;
using System.Web.Hosting;

namespace BuenComienzo.Core
{
    public class Pagina : Page
    {
        protected override void OnPreRender(EventArgs e)
        {
            //Si hay mensajes a mostrar se registra el script para que lo haga
            if (Session[BuenComienzo.Core.VariablesSession.Mensaje] != null)
            {
                bool habilitarBotones = false;
                string mensaje = HttpContext.Current.Session[BuenComienzo.Core.VariablesSession.Mensaje].ToString();
                TipoMensaje tipoMensaje = (TipoMensaje)HttpContext.Current.Session[VariablesSession.TipoMensaje];
                bool cerrarPopup = (bool)HttpContext.Current.Session[VariablesSession.CerrarPopup];
                
                if(HttpContext.Current.Session[VariablesSession.HabilitarBotones] != null)
                    habilitarBotones = (bool)HttpContext.Current.Session[VariablesSession.HabilitarBotones];
                
                this.Page.ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "MostrarMensaje", ((cerrarPopup) ? "CloseModalBox();" : "") + "alerta('" + mensaje + "','" + tipoMensaje.ToString() + "');", true);

                HttpContext.Current.Session[VariablesSession.Mensaje] = null;
                HttpContext.Current.Session[VariablesSession.TipoMensaje] = null;
                HttpContext.Current.Session[VariablesSession.CerrarPopup] = null;
            }
            base.OnPreRender(e);
        }

        protected override void OnLoad(EventArgs e)
        {
            //Se registra un sript por lo menos para la página para que cree el eventos __dopostback
            ClientScript.GetPostBackEventReference(this, "");

            //Si esta variable de sesión está vacía, es porque aún no se ha logueado el usuario o la sesión expiró. Por lo tanto se redirecciona al inicio de sesión
            if (
                (Session[VariablesSession.DatosUsuario] == null && Path.GetFileName(Request.Url.AbsolutePath).Replace(".aspx", "") != "Login") ||
                (
                    Session[VariablesSession.DatosUsuario] != null && Path.GetFileName(Request.Url.AbsolutePath).Replace(".aspx", "") != "Login" && 
                    ((UsuarioTO)Session[VariablesSession.DatosUsuario]).CambioPassword != null && 
                    ((UsuarioTO)Session[VariablesSession.DatosUsuario]).CambioPassword.Value
                )
                )
            {
                Response.Write("<script> window.parent.location='" + Request.Url.GetLeftPart(UriPartial.Authority) + "/" + HostingEnvironment.ApplicationVirtualPath.Substring(1) + "Login.aspx" + "'; </script>");
                Response.End();
            }

            base.OnLoad(e);
        }
    }
}
