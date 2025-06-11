using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Maestros
{
    public class Escuchaderos
    {
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();
        public DataTable ConsultarEscuchaderosByComuna(int IdComuna)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdComuna", Valor = IdComuna, Tipo = typeof(byte) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_TBL_ESCUCHADEROS_BY_COMUNA", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return null;
            }
        }
    }
}
