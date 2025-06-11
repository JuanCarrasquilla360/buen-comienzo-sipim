using BuenComienzo.Core;
using BuenComienzo.Core.Administracion;
using BuenComienzo.Core.Administracion.To;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BuenComienzo
{
    public partial class Login : Pagina
    {
        Usuarios objUsuarios = new Usuarios();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //protected void btnIngresar_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        UsuarioTO objUsuario = objUsuarios.RegistrarIngreso(txtUsuario.Value, txtPassword.Value);

        //        if (objUsuario != null)
        //        {
        //            Session[VariablesSession.DatosUsuario] = objUsuario;
        //            if (objUsuario.Estado.ToUpper() == "INACTIVO")
        //                Utilidades.MostrarMensaje("El usuario no está activo. Por favor comunicarse con el administrador del sistema.", TipoMensaje.Error, false);
        //            else if (objUsuario.CambioPassword != null && objUsuario.CambioPassword.Value)
        //                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "CambiarClave", "CambioClave();", true);
        //            else
        //            {
        //                Session[VariablesSession.DatosUsuario] = objUsuario;
        //                Response.Redirect("Default.aspx", false);
        //            }
        //        }
        //        else
        //        {
        //            Utilidades.MostrarMensaje("Usuario y/o contraseña incorrectos. Asegúrate de ingresar los datos correctamente e inténtalo de nuevo.", TipoMensaje.Error, false);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        string idUsuario = txtUsuario.Value;
        //        Logging.log(idUsuario, ex.Message);
        //        Utilidades.MostrarMensaje("Ha ocurrido un error en el sistema. Por favor contacte al administrador del sistema", TipoMensaje.Error, false);
        //    }
        //}
    }
}