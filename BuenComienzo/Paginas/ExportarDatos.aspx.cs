using BuenComienzo.Core;
using BuenComienzo.Core.Administracion.To;
using BuenComienzo.Core.Reportes;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BuenComienzo.Paginas
{
    public partial class ExportarDatos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                int i;
                string attachment = string.Empty, tab = string.Empty;
                string idNitOperador = string.Empty, idUnidadServicio = string.Empty, idReporte = string.Empty, nombreReporte = string.Empty;
                DateTime? fechaInicio, fechaFin;
                byte? mes = (byte?)null;

                Reportes objReportes;
                DataTable dtDatos = new DataTable();
                UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
                string exportar = Request.QueryString["exportar"];
                switch (exportar)
                {
                    case "ReporteGenerico":
                        nombreReporte = Request.QueryString["nombreReporte"];
                        idReporte = Request.QueryString["idReporte"];
                        idNitOperador = (string.IsNullOrEmpty(Request.QueryString["idNitOperador"].Replace("null", ""))) ? null : Request.QueryString["idNitOperador"];
                        idUnidadServicio = (string.IsNullOrEmpty(Request.QueryString["idUnidadServicio"].Replace("null", ""))) ? null : Request.QueryString["idUnidadServicio"];
                        fechaInicio = (string.IsNullOrEmpty(Request.QueryString["fechaInicio"].Replace("null", ""))) ? (DateTime?)null : DateTime.ParseExact(Request.QueryString["fechaInicio"], "dd/MM/yyyy", System.Globalization.CultureInfo.CurrentCulture);
                        fechaFin = (string.IsNullOrEmpty(Request.QueryString["fechaFin"].Replace("null", ""))) ? (DateTime?)null : DateTime.ParseExact(Request.QueryString["fechaFin"], "dd/MM/yyyy", System.Globalization.CultureInfo.CurrentCulture);
                        mes = (string.IsNullOrEmpty(Request.QueryString["mes"].Replace("null", ""))) ? (byte?)null : byte.Parse(Request.QueryString["mes"]);

                        objReportes = new Reportes();
                        dtDatos = objReportes.ConsultarReporteGenerico(int.Parse(idReporte), idNitOperador, idUnidadServicio, fechaInicio, fechaFin, mes);

                        if (!string.IsNullOrEmpty(objReportes.Error))
                        {
                            Response.Write("Ha ocurrido un error al tratar de generar el reporte. Por favor contacte al administrador del sistema." + objReportes.Error);
                            Response.End();
                            return;
                        }

                        attachment = "attachment; filename=" + nombreReporte + ".xls";
                        Response.ClearContent();
                        Response.AddHeader("content-disposition", attachment);
                        Response.ContentType = "application/vnd.ms-excel";
                        Response.ContentEncoding = System.Text.Encoding.GetEncoding("windows-1252");
                        Response.Charset = "utf-8";
                        tab = "";
                        foreach (DataColumn dc in dtDatos.Columns)
                        {
                            Response.Write(tab + dc.ColumnName);
                            tab = "\t";
                        }
                        Response.Write("\n");

                        foreach (DataRow dr in dtDatos.Rows)
                        {
                            tab = "";
                            for (i = 0; i < dtDatos.Columns.Count; i++)
                            {
                                Response.Write(tab + dr[i].ToString());
                                tab = "\t";
                            }
                            Response.Write("\n");
                        }

                        Response.End();
                        break;

                    case "Planilla":
                        string nombreArchivoGuid = Request.QueryString["nombreArchivoGuid"];
                        string nombreArchivo = Request.QueryString["nombreArchivo"];
                        string path = Path.Combine(Server.MapPath("~/ArchivosPlanillas"), nombreArchivoGuid);

                        byte[] file = File.ReadAllBytes(path);

                        Response.Clear();
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("content-disposition", $"attachment; filename={nombreArchivo}");
                        Response.BinaryWrite(file);
                        Response.End();

                        break;
                    case "PlanillaPaquetes":
                        string nombreArchivoGuid2 = Request.QueryString["nombreArchivoGuid"];
                        string nombreArchivo2 = Request.QueryString["nombreArchivo"];
                        string path2 = Path.Combine(Server.MapPath("~/ArchivosPlanillasPaquetes"), nombreArchivoGuid2);

                        byte[] file2 = File.ReadAllBytes(path2);

                        Response.Clear();
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("content-disposition", $"attachment; filename={nombreArchivo2}");
                        Response.BinaryWrite(file2);
                        Response.End();

                        break;
                    case "OrientacionServicio":
                        string nombreArchivoGuid3 = Request.QueryString["nombreArchivoGuid"];
                        string nombreArchivo3 = Request.QueryString["nombreArchivo"];
                        string path3 = Path.Combine(Server.MapPath("~/ArchivosOrientacionServicio"), nombreArchivoGuid3);

                        byte[] file3 = File.ReadAllBytes(path3);

                        Response.Clear();
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("content-disposition", $"attachment; filename={nombreArchivo3}");
                        Response.BinaryWrite(file3);
                        Response.End();

                        break;
                }
            }


        }
    }
}