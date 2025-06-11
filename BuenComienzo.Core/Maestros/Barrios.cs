using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Maestros
{
    public class Barrios
    {

        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable ConsultarBarrios()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM VIEW_BARRIOS ORDER BY IdBarrio ASC").Tables[0];
            return dtDatos;
        }

        public DataTable ConsultarBarriosByComuna(string IdComuna)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdComuna", Valor = IdComuna, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_Barrios_By_Comuna", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return null;
            }
        }

    }
}
