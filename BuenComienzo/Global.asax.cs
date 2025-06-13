using BuenComienzo.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using BuenComienzo.Core.Administracion.To;
using System.Configuration;

namespace BuenComienzo
{
    public class Global : HttpApplication
    {
        static object mLockInventarioDescontar = new object();
        static object mLockInventarioSumar = new object();
        public static int TimeLockInterval = 0;
        void Application_Start(object sender, EventArgs e)
        {
            // Código que se ejecuta al iniciar la aplicación
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            Application["UsuariosConectados"] = new List<UsuarioConectado>();
            int timeOut = Server.ScriptTimeout;
            TimeLockInterval = Convert.ToInt32(ConfigurationManager.AppSettings["TimeLockInterval"]);
            if (TimeLockInterval == 0)
            {
                Logging.log("SISTEMA","Error TimeLockInterval no configurado.");
                return;
            }
            //System.Threading.Thread thKeepAliveSolicitud = new System.Threading.Thread(thLiberarSolicitudes);
            //thKeepAliveSolicitud.IsBackground = false;
            //thKeepAliveSolicitud.Start();

            //BundleConfig.RegisterBundles(BundleTable.Bundles);
        }        

        void Application_Error(object sender, EventArgs e)
        {
            // Get the exception object.
            Exception exc = Server.GetLastError();
            // Handle HTTP errors
            if (exc.GetType() == typeof(HttpException))
            {
                if (exc.Message.Contains("NoCatch") || exc.Message.Contains("maxUrlLength"))
                    return;
            }

            try
            {
                string idUsuario = ((UsuarioTO)Session[VariablesSession.DatosUsuario]).IdDocumento;
                Logging.log(idUsuario, exc.Message + ";" + exc.InnerException + ";" + exc.StackTrace.Replace("\n\r", " ").Replace("\n", ""));                
            }
            catch (Exception ex)
            {
                //Logging.log(idUsuario, exc.Message + ";" + exc.InnerException + ";" + exc.StackTrace.Replace("\n\r", " ").Replace("\n", ""));
            }


            Response.Write("<h2>Error</h2>\n");
            Response.Write("<p>Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema</p>\n");
            Response.Write("<h3>Detalles del Error:</h3>\n");
            Response.Write("<p><strong>Mensaje:</strong> " + exc.Message + "</p>\n");
            if (exc.InnerException != null)
            {
                Response.Write("<p><strong>Excepción interna:</strong> " + exc.InnerException.Message + "</p>\n");
            }
            Response.Write("<p><strong>Stack Trace:</strong><br/>" + exc.StackTrace.Replace("\n", "<br/>") + "</p>\n");

            Server.ClearError();
        }

        public void Session_OnStart()
        {
            int sessionTimeOut = Session.Timeout;
        }

        public void Session_OnEnd()
        {
            //List<UsuarioConectado> usuariosConectados = (List<UsuarioConectado>)Application["UsuariosConectados"];
            //if (Session[CincoPasitos.Core.VariablesSession.DatosUsuario] != null && usuariosConectados.Count > 0)
            //{
            //    Usuario objUsuario = (Usuario)Session[CincoPasitos.Core.VariablesSession.DatosUsuario];
            //    var usuario = usuariosConectados.Find(x => x.IdUsuario.Equals(objUsuario.IdUsuario));
            //    if (usuario != null)
            //    {
            //        usuariosConectados.Remove(usuario);
            //        Application.Lock();
            //        Application["UsuariosConectados"] = usuariosConectados;
            //        Application.UnLock();
            //    }
            //}
        }
          
                
    }
}