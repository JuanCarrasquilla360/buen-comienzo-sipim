using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using BuenComienzo.Core;
using BuenComienzo.Core.Administracion.To;
using System.IO;
using System.Web.Services;
using System.Xml;
using System.Web.UI.HtmlControls;
using BuenComienzo.Core.Administracion;
using System.Data;

namespace BuenComienzo
{
    public partial class Site : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // El código siguiente ayuda a proteger frente a ataques XSRF
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Utilizar el token Anti-XSRF de la cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generar un nuevo token Anti-XSRF y guardarlo en la cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;

            if (Session[BuenComienzo.Core.VariablesSession.DatosUsuario] == null && Path.GetFileName(Request.Url.AbsolutePath) != "InicioSesion")
            {
                this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "InicioSesion", "window.parent.location = '" + ResolveClientUrl("~/InicioSesion.aspx") + "'", true);
            }
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Establecer token Anti-XSRF
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validar el token Anti-XSRF
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Error de validación del token Anti-XSRF.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session[VariablesSession.DatosUsuario] != null)
                {
                    //List<UsuarioConectado> usuariosConectados = (List<UsuarioConectado>)Application["UsuariosConectados"];
                    UsuarioTO objUsuario = (UsuarioTO)Session[VariablesSession.DatosUsuario];
                    ConfigurarMenu(objUsuario);

                    Perfiles objPerfiles = new Perfiles();
                    DataTable dtPerfiles = objPerfiles.ObtenerPerfil(objUsuario.IdPerfil.Value);

                    lblNombre.InnerText = string.Format("{0} {1} {2} {3}", objUsuario.PrimerNombre, objUsuario.SegundoNombre, objUsuario.PrimerApellido, objUsuario.SegundoApellido);
                    spNombrePerfil.InnerHtml = lblNombre.InnerText + ",&nbsp&nbsp&nbsp " + dtPerfiles.Rows[0]["NombrePerfil"].ToString();
                    pNombrePerfil.InnerHtml = lblNombre.InnerText + " - " + dtPerfiles.Rows[0]["NombrePerfil"].ToString();

                    //Operadores objOperadores = new Operadores();
                    //lblOperador.InnerText = objOperadores.ObtenerOperador(objUsuario.IdNitOperador).Rows[0]["NombreOperadorRazonSocial"].ToString();
                    //spOperador.InnerText = objOperadores.ObtenerOperador(objUsuario.IdNitOperador).Rows[0]["NombreOperadorRazonSocial"].ToString();

                    //if (Session[VariablesSession.AnoVigencia] != null)
                    //    lblPerfil.InnerText = dtPerfiles.Rows[0]["Nombre"].ToString() + " (" + Session[VariablesSession.AnoVigencia].ToString() + ")";
                    //else
                    //    lblPerfil.InnerText = dtPerfiles.Rows[0]["Nombre"].ToString();

                    //Municipios objMunicipios = new Municipios();
                    //DataTable dtMunicipios = objMunicipios.ConsultarMunicipios();

                    //if (!string.IsNullOrEmpty(objUsuario.IdMunicipioOperacion))
                    //{
                    //    dtMunicipios = (from datos in dtMunicipios.AsEnumerable()
                    //                    where datos["IdDepartamento"].ToString().Equals("05") &&
                    //                    datos["IdMunicipio"].ToString().Equals(objUsuario.IdMunicipioOperacion)
                    //                    select datos).CopyToDataTable();

                    //    lblMunicipio.InnerText = dtMunicipios.Rows[0]["NombreMunicipio"].ToString();
                    //    spMunicipio.InnerText = dtMunicipios.Rows[0]["NombreMunicipio"].ToString();
                    //}
                    //else
                    //    lblMunicipio.InnerText = "";

                    this.PreRender += Site_PreRender;
                }
            }
        }

        protected void Site_PreRender(object sender, EventArgs e)
        {
            if (Session[VariablesSession.DatosUsuario] != null)
            {
                UsuarioTO objUsuario = (UsuarioTO)Session[VariablesSession.DatosUsuario];
            }
        }

        private void ConfigurarMenu(UsuarioTO objUsuario)
        {
            HtmlGenericControl li = null, ul = null;
            XmlDocument xDoc = new XmlDocument();
            xDoc.Load(Server.MapPath("./App_Data/Menu.xml"));
            XmlNodeList nodoMenu = xDoc.GetElementsByTagName("Menu");

            li = new HtmlGenericControl("li");
            li.Attributes.Add("class", "header");
            li.InnerHtml = "MENÚ";
            menu.Controls.Add(li);

            foreach (XmlElement nodo in nodoMenu.Item(0).ChildNodes)
            {
                string nombre = "";
                string pagina = "";

                ul = new HtmlGenericControl("ul");
                ul.Attributes.Add("class", "treeview-menu");
                foreach (XmlElement submenu in nodo.ChildNodes)
                {
                    string url = Path.GetFileName(submenu.GetAttribute("Pagina"));
                    bool tienePermiso = Utilidades.TienePermiso(objUsuario.IdPerfil.Value, url);
                    
                    // Permitir acceso temporal a páginas de Búsqueda Activa mientras se configuran los permisos
                    if (url == "CronogramaBusquedaActiva.aspx")
                    {
                        tienePermiso = true;
                    }

                    if (tienePermiso)
                    {
                        nombre = submenu.GetAttribute("Nombre");
                        pagina = "./Paginas/" + submenu.GetAttribute("Pagina");
                        ul.Controls.Add(item(pagina, nombre, true, ""));
                    }
                }

                if (ul.Controls.Count > 0)
                {
                    nombre = nodo.GetAttribute("Nombre");
                    pagina = "#";
                    li = item(pagina, nombre, false, nodo.GetAttribute("Clase"));
                    li.Attributes.Add("class", "treeview");

                    li.Controls.Add(ul);
                    menu.Controls.Add(li);
                }
            }

            li = new HtmlGenericControl("li");
            li.InnerHtml = "<a href='#' onclick='cerrarSesion();'><i class='fa fa-power-off'></i><span>Salir</span></a>";
            menu.Controls.Add(li);
        }

        /// <summary>
        /// Metodo para generar un item del menú
        /// </summary>
        /// <param name="icono">El incono que tendrá el item en el menú</param>
        /// <param name="pagina">URL de la página</param>
        /// <param name="nombre">nombre que tendrá el item en el menú</param>
        /// <returns>Retorna el item</returns>
        private HtmlGenericControl item(string pagina, string nombre, bool Submenu, string clase)
        {
            var li = new HtmlGenericControl("li");
            var a = new HtmlGenericControl("a");

            a.Attributes.Add("href", pagina);
            if (Submenu)
            {
                a.Attributes.Add("target", "framePrincipal");
                a.Style.Add("font-size", "12px");
                a.InnerHtml = "<i class='fa fa-circle-notch'></i>" + nombre + "</a>";
            }
            else
                a.InnerHtml = "<i class='" + clase + "'></i><span>" + nombre + "</span> <i class='fa fa-angle-left pull-right'></i>";

            li.Controls.Add(a);

            return li;
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Session.Abandon();
            Response.Redirect("InicioSesion.aspx");
        }
    }

}