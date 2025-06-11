using BuenComienzo.Core.Operacion;
using BuenComienzo.Core.Operacion.To;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BuenComienzo.Paginas.Operacion.Popups
{
    public partial class VerArchivo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString.Count > 0)
            {
                string path = "";
                string extension = Request.QueryString["extension"];
                string tipoArchivo = Request.QueryString["tipoArchivo"];
                string rutaArchivo = HttpUtility.UrlDecode(Request.QueryString["rutaArchivo"]);
                string id = Request.QueryString["id"];
                bool hayArchivo = false;
                Response.Clear();

                switch (extension)
                {
                    case ".pdf":
                        Response.ContentType = "application/pdf";
                        break;
                    case ".doc":
                        Response.ContentType = "application/msword";
                        break;
                    case ".docx":
                        Response.ContentType = "application/msword";
                        break;
                    case ".jpeg":
                        Response.ContentType = "image/jpeg";
                        break;
                    case ".jpg":
                        Response.ContentType = "image/jpeg";
                        break;
                    case ".gif":
                        Response.ContentType = "image/gif";
                        break;
                    case ".png":
                        Response.ContentType = "image/png";
                        break;
                    case ".tiff":
                        Response.ContentType = "image/tiff";
                        break;
                    case ".bmp":
                        Response.ContentType = "image/bmp";
                        break;
                    default:
                        Response.ContentType = "application/octet-stream";
                        break;
                }

                switch (tipoArchivo)
                {
                        case "DocumentoPersona":
                        path = Path.GetTempPath();
                        Core.Operacion.Personas objPersona = new Core.Operacion.Personas();
                        DataTable DtArchivo = objPersona.ConsultarArchivoPersona(int.Parse(id));

                        if (DtArchivo.Rows.Count > 0)
                        {

                            //byte[] btArchivo = (byte[])DtArchivo.Rows[0]["Archivo"];
                            string filePath = Path.Combine(Server.MapPath("~/Archivos"), DtArchivo.Rows[0]["Guid"].ToString());
                            byte[] btArchivo = FileToByteArray(filePath);
                            System.IO.FileStream archivo = new System.IO.FileStream(path + rutaArchivo, System.IO.FileMode.Create, System.IO.FileAccess.Write);
                            archivo.Write(btArchivo, 0, btArchivo.Length);
                            archivo.Close();
                            Response.AddHeader("Content-disposition", "inline; filename=" + Path.GetFileName(path + rutaArchivo));
                            Response.TransmitFile(path + rutaArchivo);
                            Response.Flush();
                        }
                        break;

                    //case "ArchivoRAM":
                    //    path = Path.GetTempPath();
                    //    Core.Administracion.RAMArchivo objArchivoRAM = new Core.Administracion.RAMArchivo();
                    //    DataTable DtArchivoRAM = objArchivoRAM.ObtenerRAMArchivo(int.Parse(id));

                    //    if (DtArchivoRAM.Rows.Count > 0)
                    //    {

                    //        byte[] btArchivo = (byte[])DtArchivoRAM.Rows[0]["Archivo"];
                    //        System.IO.FileStream archivo = new System.IO.FileStream(path + rutaArchivo, System.IO.FileMode.Create, System.IO.FileAccess.Write);
                    //        archivo.Write(btArchivo, 0, btArchivo.Length);
                    //        archivo.Close();
                    //        Response.AddHeader("Content-disposition", "inline; filename=" + Path.GetFileName(path + rutaArchivo));
                    //        Response.TransmitFile(path + rutaArchivo);
                    //        Response.Flush();
                    //    }
                    //    break;
                                        
                }

                if (hayArchivo)
                {
                    Response.AddHeader("Content-disposition", "inline; filename=" + Path.GetFileName(path + extension));
                    Response.TransmitFile(path + extension);
                    Response.Flush();
                }
                else
                {
                    Response.End();
                }

            }
        }

        public byte[] FileToByteArray(string fileName)
        {
            byte[] buff = null;
            FileStream fs = new FileStream(fileName,
                                           FileMode.Open,
                                           FileAccess.Read);
            BinaryReader br = new BinaryReader(fs);
            long numBytes = new FileInfo(fileName).Length;
            buff = br.ReadBytes((int)numBytes);
            return buff;
        }
    }
}