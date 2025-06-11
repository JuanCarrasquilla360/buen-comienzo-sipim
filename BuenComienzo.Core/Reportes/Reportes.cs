using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Reportes
{
    public class Reportes
    {
        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public string Error
        {
            get
            {
                if (!string.IsNullOrEmpty(strError)) { return strError.Replace("'", ""); } else { return strError; }
            }

        }

        public DataTable ConsultarReporteGenerico(int idReporte, string idNitOperador, string idUnidadServicio, DateTime? fechaInicio, DateTime? fechaFin, byte? mes)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdReporte", Valor = idReporte, Tipo = typeof(int) });
                parametros.Add(new Parametro { NombreParametro = "@IdNitOperador", Valor = idNitOperador, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@IdUnidadServicio", Valor = idUnidadServicio, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaInicio", Valor = fechaInicio, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@FechaFin", Valor = fechaFin, Tipo = typeof(DateTime?) });
                parametros.Add(new Parametro { NombreParametro = "@Mes", Valor = mes, Tipo = typeof(byte?) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_REPORTEDINAMICO", parametros).Tables[0];
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
