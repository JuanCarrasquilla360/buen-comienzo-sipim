using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Administracion.To;
using System.Security.Cryptography;
using System.Security.Policy;

namespace BuenComienzo.Core.Operacion
{
    public class CaracterizacionBuenComienzo
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

        public DataTable ObtenerCaracterizacionBuenComienzo(string numeroIdentificacion)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IDENTIFICACION", Valor = numeroIdentificacion, Tipo = typeof(string) },
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_CARACTERIZACIONBUENCOMIENZO", parametros).Tables[0];

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
