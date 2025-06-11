using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace BuenComienzo.Core.Administracion
{
    public class ReporteDinamico
    {
        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public string Error
        {
            get
            {
                return strError.Replace("'", "");
            }
        }

        public bool InsertarReporte(string nombre, string descripcion, string query, DataTable campos)
        {
            try
            {
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@Nombre", Valor = nombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Descripcion", Valor = descripcion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Query", Valor = query, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Tbl_CamposReportes", Valor = campos, Tipo = typeof(DataTable) });

                objBd.ejecutarProcedimiento("dbop_Add_REPORTES", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
            catch (Exception ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool ActualizarReporte(int idReporte, string nombre, string descripcion, string query, DataTable campos)
        {
            try
            {
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdReporte", Valor = idReporte, Tipo = typeof(int) });
                parametros.Add(new Parametro { NombreParametro = "@Nombre", Valor = nombre, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Descripcion", Valor = descripcion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Query", Valor = query, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Tbl_CamposReportes", Valor = campos, Tipo = typeof(DataTable) });

                objBd.ejecutarProcedimiento("dbop_Update_REPORTES", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }
        public bool EliminarReporte(int idReporte)
        {
            try
            {
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdReporte", Valor = idReporte, Tipo = typeof(int) });

                objBd.ejecutarProcedimiento("dbop_DeleteTBL_REPORTES", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ObtenerReporte(string idReporte)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdReporte", Valor = idReporte, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_REPORTES", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataSet ObtenerReporteCompleto(string idReporte)
        {
            try
            {
                DataSet dsDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdReporte", Valor = idReporte, Tipo = typeof(string) });

                dsDatos = objBd.ejecutarProcedimientoDS("dbop_Get_REPORTES", parametros);

                return dsDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarReportes()
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetAllTBL_REPORTES", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }
        public DataTable ConsultarReportes(string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetAllTBL_REPORTES", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }


        public DataTable ConsultarReportesPerfiles(int IdPerfil)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = IdPerfil, Tipo = typeof(int) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetAllTBL_REPORTESPERFIL", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

    }
}
