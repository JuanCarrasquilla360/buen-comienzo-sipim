using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Maestros
{
    public class TipoSeguridadSocial
    {
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable ConsultarTipoSeguridadSocial()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * FROM VIEW_TIPOSEGURIDADSOCIAL ORDER BY idMaeTipoSeguridadSocial ASC").Tables[0];
            return dtDatos;
        }
    }
}
