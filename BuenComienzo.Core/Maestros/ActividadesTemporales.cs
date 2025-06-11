using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Maestros
{
    public class ActividadesTemporales
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

        public DataTable ConsultarActividadesVista()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM VIEW_ACTIVIDADESTEMPORALES ORDER BY NombreActividad ASC").Tables[0];
            return dtDatos;
        }

        //public DataTable ConsultarActividades()
        //{
        //    try
        //    {
        //        DataTable dtDatos;

        //        dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetAllTBL_ACTIVIDADESTEMPORALES", parametros).Tables[0];
        //        return dtDatos;
        //    }
        //    catch (System.Data.SqlClient.SqlException ex)
        //    {
        //        strError = ex.Message;
        //        return null;
        //    }
        //}
    }
}
