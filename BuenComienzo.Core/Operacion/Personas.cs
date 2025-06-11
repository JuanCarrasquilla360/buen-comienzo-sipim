using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Administracion.To;

namespace BuenComienzo.Core.Operacion
{
    public class Personas
    {
        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public string Error
        {
            get
            {
                return strError;
            }
        }

        public DataTable ConsultarPersonas(string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                //parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = idPerfil, Tipo = typeof(byte) });
                //parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) });


                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_PERSONAS", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerPersonas(string idDocumento)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = (idDocumento), Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_PERSONAS", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerPersonasByTipoDocumentoAndDocumento(int TipoDocumento,string idDocumento)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@TipoDocumento", Valor = (TipoDocumento), Tipo = typeof(int) });
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = (idDocumento), Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_PERSONAS_ByTipoDocumentoAndDocumento", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }


        public bool InsertarArchivoPersona(int IdTipoArchivoPersona, string IdDocumento, byte[] archivo, string nombreArchivo, string extension,string guid, string idUsuario)
        {
            try
            {
                objBd.abrirTransaccion();

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdTipoArchivoPersona", Valor = IdTipoArchivoPersona, Tipo = typeof(int) });
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = IdDocumento, Tipo = typeof(string) });
                if (archivo != null)
                {
                    parametros.Add(new Parametro { NombreParametro = "@Archivo", Valor = archivo, Tipo = typeof(byte[]) });
                    parametros.Add(new Parametro { NombreParametro = "@Extension", Valor = extension, Tipo = typeof(string) });
                    parametros.Add(new Parametro { NombreParametro = "@guid", Valor = guid, Tipo = typeof(string) });
                    parametros.Add(new Parametro { NombreParametro = "@NombreArchivo", Valor = nombreArchivo, Tipo = typeof(string) });
                }
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuario, Tipo = typeof(string) });

                objBd.ejecutarProcedimiento("dbop_AddTBL_ARCHIVOPERSONA", parametros);

                objBd.aceptarTransaccion();
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                objBd.devolerTransaccion();
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ConsultarDocumentosPersona(string IdDocumento)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = IdDocumento, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetAllTBL_ARCHIVOPERSONA", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarArchivoPersona(int IdArchivoPersona)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdArchivoPersona", Valor = IdArchivoPersona, Tipo = typeof(int) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_ARCHIVOPERSONA", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool EliminarDocumentoPersona(int IdArchivoPersona)
        {
            try
            {
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdArchivoPersona", Valor = IdArchivoPersona, Tipo = typeof(int) });

                objBd.ejecutarProcedimiento("dbop_DeleteTBL_ARCHIVOPERSONA", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

    }
}
