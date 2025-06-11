using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Maestros.To;

namespace BuenComienzo.Core.Maestros
{
    public class TipoParentesco
    {
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable Consultar()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM TBL_MAETIPOPARENTESCO").Tables[0];
            return dtDatos;
        }

        public List<TipoParentescoTO> getTipoParentescoById(int idMaeTipoParentesco)
        {
            try
            {
                List<TipoParentescoTO> tOs = new List<TipoParentescoTO>();
                tOs = Utilidades.ToList<TipoParentescoTO>(ObtenerTipoParentescoById(idMaeTipoParentesco));
                return tOs;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return null;
            }
        }

        public DataTable ObtenerTipoParentescoById(int idMaeTipoParentesco)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@idMaeTipoParentesco", Valor = idMaeTipoParentesco, Tipo = typeof(int) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_TBL_MAETIPOPARENTESCO_ById", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return null;
            }
        }

    }
}
