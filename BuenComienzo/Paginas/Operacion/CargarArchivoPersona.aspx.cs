using System;
using System.Web.Script.Serialization;
using BuenComienzo.Core;
using BuenComienzo.Core.Administracion;
using BuenComienzo.Core.Administracion.To;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BuenComienzo.Core.Operacion;
using BuenComienzo.Core.Operacion.To;

namespace BuenComienzo.Paginas.Operacion
{
    public partial class CargarArchivoPersona : System.Web.UI.Page
    {
        RespuestaTO objRespuesta;
        BuenComienzo.Core.Operacion.Personas objPersonas = new BuenComienzo.Core.Operacion.Personas();
        protected void Page_Load(object sender, EventArgs e)
        {
            string idUsuario = "0";
            try
            {
                idUsuario = ((UsuarioTO)Session[VariablesSession.DatosUsuario]).IdDocumento;

            }
            catch (Exception)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Su sesión ha caducado, cierre la aplicación e ingrese nuevamente.", tipoMensaje = "Error" };

                Response.Write((new JavaScriptSerializer()).Serialize(objRespuesta));
                Response.End();
            }

            string IdDocumento = Request.Form["IdDocumento"];
            string IdTipoArchivoPersona = Request.Form["IdTipoArchivoPersona"];

            if (Request.Form["SubirArchivo"] == null)
            {

            }
            else
            {
                byte[] btArchivo = null;
                string extension = null;
                string FileName = null;
                string strGuid = Guid.NewGuid().ToString();
                if (Request.Files.Count > 0)
                {
                    HttpPostedFile file = Request.Files[0];
                    var archivo = Request.Files[0];
                    //Se toma el archivo en bytes para almacenar en BD
                    btArchivo = new byte[archivo.ContentLength];
                    archivo.InputStream.Read(btArchivo, 0, archivo.ContentLength);
                    extension = Path.GetExtension(archivo.FileName);
                    FileName = Path.GetFileName(archivo.FileName);
                    var path = Path.Combine(Server.MapPath("~/Archivos"), strGuid);
                    if (!Directory.Exists(Server.MapPath("~/Archivos")))
                    {
                        Directory.CreateDirectory(Server.MapPath("~/Archivos"));
                    }
                    file.SaveAs(path);

                    if (objPersonas.InsertarArchivoPersona(int.Parse(IdTipoArchivoPersona), IdDocumento, btArchivo, FileName, extension, strGuid, idUsuario))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se ha cargado exitosamente el archivo.", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Error: " + objPersonas.Error, tipoMensaje = "Error" };

                    Response.Write((new JavaScriptSerializer()).Serialize(objRespuesta));
                    Response.End();
                }
                else
                {
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "No hay nungún archivo seleccionado", tipoMensaje = "Error" };

                    Response.Write((new JavaScriptSerializer()).Serialize(objRespuesta));
                    Response.End();
                }
            }

        }
    }
}