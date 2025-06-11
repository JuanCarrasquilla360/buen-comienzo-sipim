using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Administracion
{
    public class SeguridadReportes
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

        public DataTable ConsultarTablaSeguridad()
        {
            try
            {
                DataTable dtDatos;

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTABLA_PERMISOSREPORTES", null).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ActualizarSeguridad(DataTable dtSeguridad)
        {
            try
            {
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@Tbl_Seguridad", Valor = dtSeguridad, Tipo = typeof(DataTable) });

                objBd.ejecutarProcedimiento("dbop_GuardarSeguridadReportes", parametros);
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
