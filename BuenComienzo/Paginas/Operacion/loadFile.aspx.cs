using BuenComienzo.Core;
using BuenComienzo.Core.Administracion.To;
using BuenComienzo.Core.Operacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BuenComienzo.Paginas.Operacion
{
    public partial class loadFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BuenComienzo.Core.Utilidades2.Archivos objArchivo = new Core.Utilidades2.Archivos();
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;
            string TipoArchivo = Request.Form["TipoArchivo"];
            try
            {
                string extension = null;
                string FileName = null;
                string strGuid;
                if (Request.Files.Count > 0)
                {
                    HttpPostedFile file = Request.Files[0];
                    FileName = Path.GetFileName(file.FileName).ToLower();
                    strGuid = Guid.NewGuid().ToString();
                    string path = "";
                    extension = Path.GetExtension(file.FileName).ToLower();
                    switch (TipoArchivo)
                    {
                        case "TMP_TBL_CARACTERIZACIONBUENCOMIENZO":
                            path = Path.Combine(Server.MapPath("~/ArchivosCarga"), strGuid);
                            if (!Directory.Exists(Server.MapPath("~/ArchivosCarga")))
                            {
                                Directory.CreateDirectory(Server.MapPath("~/ArchivosCarga"));
                            }
                            file.SaveAs(path);

                            path = Path.Combine(ConfigurationManager.AppSettings["RutaArchivoCarga"].ToString(), strGuid);

                            Core.Administracion.CargarArchivoBulk cargarArchivos = new Core.Administracion.CargarArchivoBulk();
                            DataTable R = cargarArchivos.ExecBulkInsert(path, TipoArchivo, ";", "\\n", 1000);
                            if (R != null && R.Rows.Count > 0)
                            {
                                Response.StatusCode = 200;
                            }
                            else
                            {
                                Response.StatusCode = 404;
                            }
                            break;
                        case "Planilla":

                            string NombreArchivo = Request.Form["NombreArchivo"];

                            path = Path.Combine(Server.MapPath("~/ArchivosPlanillas"), (string.IsNullOrEmpty(NombreArchivo)) ? (strGuid + extension) : NombreArchivo);
                            if (!Directory.Exists(Server.MapPath("~/ArchivosPlanillas")))
                                Directory.CreateDirectory(Server.MapPath("~/ArchivosPlanillas"));

                            //Se almacena la planilla en la carpeta con el guid
                            file.SaveAs(path);

                            Response.StatusCode = 200;
                            Response.StatusDescription = strGuid + extension;

                            break;
                        case "PlanillaPaquetes":

                            string NombreArchivo2 = Request.Form["NombreArchivo"];

                            path = Path.Combine(Server.MapPath("~/ArchivosPlanillasPaquetes"), (string.IsNullOrEmpty(NombreArchivo2)) ? (strGuid + extension) : NombreArchivo2);
                            if (!Directory.Exists(Server.MapPath("~/ArchivosPlanillasPaquetes")))
                                Directory.CreateDirectory(Server.MapPath("~/ArchivosPlanillasPaquetes"));

                            //Se almacena la planilla en la carpeta con el guid
                            file.SaveAs(path);

                            Response.StatusCode = 200;
                            Response.StatusDescription = strGuid + extension;

                            break;

                        case "OrientacionServicio":

                            string NombreArchivo3 = Request.Form["NombreArchivo"];

                            path = Path.Combine(Server.MapPath("~/ArchivosOrientacionServicio"), (string.IsNullOrEmpty(NombreArchivo3)) ? (strGuid + extension) : NombreArchivo3);
                            if (!Directory.Exists(Server.MapPath("~/ArchivosOrientacionServicio")))
                                Directory.CreateDirectory(Server.MapPath("~/ArchivosOrientacionServicio"));

                            //Se almacena la planilla en la carpeta con el guid
                            file.SaveAs(path);

                            Response.StatusCode = 200;
                            Response.StatusDescription = strGuid + extension;

                            break;

                        case "SeguimientoDeficitNutricional":

                            string NombreArchivo4 = Request.Form["NombreArchivo"];

                            path = Path.Combine(Server.MapPath("~/ArchivosSeguimientoDeficitNutricional"), (string.IsNullOrEmpty(NombreArchivo4)) ? (strGuid + extension) : NombreArchivo4);
                            if (!Directory.Exists(Server.MapPath("~/ArchivosSeguimientoDeficitNutricional")))
                                Directory.CreateDirectory(Server.MapPath("~/ArchivosSeguimientoDeficitNutricional"));

                            //Se almacena la planilla en la carpeta con el guid
                            file.SaveAs(path);

                            Response.StatusCode = 200;
                            Response.StatusDescription = strGuid + extension;

                            break;
                        
                        default:
                            break;
                    }

                }
            }
            catch (Exception ex)
            {
                BuenComienzo.Loggin.Logger.Error("BuenComienzo.Paginas.Operacion.loadFile.Page_Load Error: " + ex.Message);
                Response.StatusCode = 404;
            }
        }
    }
}