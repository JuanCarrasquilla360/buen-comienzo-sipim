using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Administracion.To;
using BuenComienzo.Core.Maestros;

namespace BuenComienzo.Core.Administracion
{
    public class EAPB
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

        public DataTable ObtenerEAPB(string idTipoAseguramiento)
        {
            try
            {
                DataTable dtDatos;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdTipoAseguramiento", Valor = idTipoAseguramiento, Tipo = typeof(string) },
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_EAPB", parametros).Tables[0];

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

